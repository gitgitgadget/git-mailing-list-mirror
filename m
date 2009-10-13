From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v2 07/16] remote-helpers: Fetch more than one ref in a batch
Date: Mon, 12 Oct 2009 19:25:06 -0700
Message-ID: <1255400715-10508-8-git-send-email-spearce@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 04:34:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxXDB-0004cs-PI
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 04:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758847AbZJMC0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 22:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758830AbZJMC0j
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 22:26:39 -0400
Received: from george.spearce.org ([209.20.77.23]:56209 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758827AbZJMC0f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 22:26:35 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 227E5382A1; Tue, 13 Oct 2009 02:25:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6BF0938222;
	Tue, 13 Oct 2009 02:25:18 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
In-Reply-To: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130109>

Some network protocols (e.g. native git://) are able to fetch more
than one ref at a time and reduce the overall transfer cost by
combining the requests into a single exchange.  Instead of feeding
each fetch request one at a time to the helper, feed all of them
at once so the helper can decide whether or not it should batch them.

Because 'fetch' was already released in 1.6.5 we introduce the new
fetch-multiple capability/command to signal that the helper wants
to use batch oriented approach to fetching refs.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/git-remote-helpers.txt |   18 ++++++
 remote-curl.c                        |   98 ++++++++++++++++++++++++++++++----
 transport-helper.c                   |   58 +++++++++++++++-----
 3 files changed, 149 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 173ee23..e10ce99 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -43,6 +43,15 @@ Commands are given by the caller on the helper's standard input, one per line.
 +
 Supported if the helper has the "fetch" capability.
 
+'fetch-multiple'::
+	Fetches multiple objects at once.  The fetch-multiple
+	command is followed by one or more 'fetch' lines as above,
+	and then a blank line to terminate the batch.  Outputs a
+	single blank line when the entire batch is complete.
+	Optionally may output a 'lock <file>' line indicating a
+	file under GIT_DIR/objects/pack which is keeping a pack
+	until refs can be suitably updated.
+
 If a fatal error occurs, the program writes the error message to
 stderr and exits. The caller should expect that a suitable error
 message has been printed if the child closes the connection without
@@ -57,11 +66,20 @@ CAPABILITIES
 'fetch'::
 	This helper supports the 'fetch' command.
 
+'fetch-multiple'::
+	This helper supports the 'fetch-multiple' command.
+
 REF LIST ATTRIBUTES
 -------------------
 
 None are defined yet, but the caller must accept any which are supplied.
 
+FETCH OPTIONS
+-------------
+
+'option verbose'::
+	Print more verbose activity messages to stderr.
+
 Documentation
 -------------
 Documentation by Daniel Barkalow.
diff --git a/remote-curl.c b/remote-curl.c
index 4628ee8..34ca4e7 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -86,6 +86,84 @@ static struct ref *get_refs(void)
 	return refs;
 }
 
+static int fetch_dumb(int nr_heads, struct ref **to_fetch)
+{
+	char **targets = xmalloc(nr_heads * sizeof(char*));
+	int ret, i;
+
+	for (i = 0; i < nr_heads; i++)
+		targets[i] = xstrdup(sha1_to_hex(to_fetch[i]->old_sha1));
+
+	init_walker();
+	walker->get_all = 1;
+	walker->get_tree = 1;
+	walker->get_history = 1;
+	walker->get_verbosely = 0;
+	walker->get_recover = 0;
+	ret = walker_fetch(walker, nr_heads, targets, NULL, NULL);
+
+	for (i = 0; i < nr_heads; i++)
+		free(targets[i]);
+	free(targets);
+
+	return ret ? error("Fetch failed.") : 0;
+}
+
+static void parse_fetch(struct strbuf *buf, int multiple)
+{
+	struct ref **to_fetch = NULL;
+	struct ref *list_head = NULL;
+	struct ref **list = &list_head;
+	int alloc_heads = 0, nr_heads = 0;
+
+	do {
+		if (!prefixcmp(buf->buf, "fetch ")) {
+			char *p = buf->buf + strlen("fetch ");
+			char *name;
+			struct ref *ref;
+			unsigned char old_sha1[20];
+
+			if (strlen(p) < 40 || get_sha1_hex(p, old_sha1))
+				die("protocol error: expected sha/ref, got %s'", p);
+			if (p[40] == ' ')
+				name = p + 41;
+			else if (!p[40])
+				name = "";
+			else
+				die("protocol error: expected sha/ref, got %s'", p);
+
+			ref = alloc_ref(name);
+			hashcpy(ref->old_sha1, old_sha1);
+
+			*list = ref;
+			list = &ref->next;
+
+			ALLOC_GROW(to_fetch, nr_heads + 1, alloc_heads);
+			to_fetch[nr_heads++] = ref;
+
+			if (!multiple)
+				break;
+		}
+		else
+			die("http transport does not support %s", buf->buf);
+
+		strbuf_reset(buf);
+		if (strbuf_getline(buf, stdin, '\n') == EOF)
+			return;
+		if (!*buf->buf)
+			break;
+	} while (1);
+
+	if (fetch_dumb(nr_heads, to_fetch))
+		exit(128); /* error already reported */
+	free_refs(list_head);
+	free(to_fetch);
+
+	printf("\n");
+	fflush(stdout);
+	strbuf_reset(buf);
+}
+
 int main(int argc, const char **argv)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -108,17 +186,14 @@ int main(int argc, const char **argv)
 		if (strbuf_getline(&buf, stdin, '\n') == EOF)
 			break;
 		if (!prefixcmp(buf.buf, "fetch ")) {
-			char *obj = buf.buf + strlen("fetch ");
-			init_walker();
-			walker->get_all = 1;
-			walker->get_tree = 1;
-			walker->get_history = 1;
-			walker->get_verbosely = 0;
-			walker->get_recover = 0;
-			if (walker_fetch(walker, 1, &obj, NULL, NULL))
-				die("Fetch failed.");
-			printf("\n");
-			fflush(stdout);
+			parse_fetch(&buf, 0);
+
+		} else if (!strcmp(buf.buf, "fetch-multiple")) {
+			strbuf_reset(&buf);
+			if (strbuf_getline(&buf, stdin, '\n') == EOF)
+				break;
+			parse_fetch(&buf, 1);
+
 		} else if (!strcmp(buf.buf, "list")) {
 			struct ref *refs = get_refs();
 			struct ref *posn;
@@ -132,6 +207,7 @@ int main(int argc, const char **argv)
 			fflush(stdout);
 		} else if (!strcmp(buf.buf, "capabilities")) {
 			printf("fetch\n");
+			printf("fetch-multiple\n");
 			printf("\n");
 			fflush(stdout);
 		} else {
diff --git a/transport-helper.c b/transport-helper.c
index f57e84c..eb66e0c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -10,7 +10,9 @@ struct helper_data
 {
 	const char *name;
 	struct child_process *helper;
-	unsigned fetch : 1;
+	FILE *out;
+	unsigned fetch : 1,
+		fetch_multiple : 1;
 };
 
 static struct child_process *get_helper(struct transport *transport)
@@ -18,7 +20,6 @@ static struct child_process *get_helper(struct transport *transport)
 	struct helper_data *data = transport->data;
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process *helper;
-	FILE *file;
 
 	if (data->helper)
 		return data->helper;
@@ -39,15 +40,17 @@ static struct child_process *get_helper(struct transport *transport)
 
 	write_str_in_full(helper->in, "capabilities\n");
 
-	file = xfdopen(helper->out, "r");
+	data->out = xfdopen(helper->out, "r");
 	while (1) {
-		if (strbuf_getline(&buf, file, '\n') == EOF)
+		if (strbuf_getline(&buf, data->out, '\n') == EOF)
 			exit(128); /* child died, message supplied already */
 
 		if (!*buf.buf)
 			break;
 		if (!strcmp(buf.buf, "fetch"))
 			data->fetch = 1;
+		if (!strcmp(buf.buf, "fetch-multiple"))
+			data->fetch_multiple = 1;
 	}
 	return data->helper;
 }
@@ -58,6 +61,7 @@ static int disconnect_helper(struct transport *transport)
 	if (data->helper) {
 		write_str_in_full(data->helper->in, "\n");
 		close(data->helper->in);
+		fclose(data->out);
 		finish_command(data->helper);
 		free((char *)data->helper->argv[0]);
 		free(data->helper->argv);
@@ -67,14 +71,37 @@ static int disconnect_helper(struct transport *transport)
 	return 0;
 }
 
+static void perform_fetch_command(struct transport *transport,
+	struct strbuf *buf)
+{
+	struct helper_data *data = transport->data;
+	size_t n = buf->len;
+
+	if (write_in_full(data->helper->in, buf->buf, n) != n)
+		exit(128);
+
+	while (1) {
+		strbuf_reset(buf);
+		if (strbuf_getline(buf, data->out, '\n') == EOF)
+			exit(128); /* child died, message supplied already */
+		if (!prefixcmp(buf->buf, "lock "))
+			transport->pack_lockfile = xstrdup(buf->buf + 5);
+		else if (!buf->len)
+			break;
+	}
+	strbuf_reset(buf);
+}
+
 static int fetch_with_fetch(struct transport *transport,
 			    int nr_heads, const struct ref **to_fetch)
 {
-	struct child_process *helper = get_helper(transport);
-	FILE *file = xfdopen(helper->out, "r");
+	struct helper_data *data = transport->data;
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 
+	if (data->fetch_multiple)
+		strbuf_addstr(&buf, "fetch-multiple\n");
+
 	for (i = 0; i < nr_heads; i++) {
 		const struct ref *posn = to_fetch[i];
 		if (posn->status & REF_STATUS_UPTODATE)
@@ -82,12 +109,16 @@ static int fetch_with_fetch(struct transport *transport,
 
 		strbuf_addf(&buf, "fetch %s %s\n",
 			    sha1_to_hex(posn->old_sha1), posn->name);
-		write_in_full(helper->in, buf.buf, buf.len);
-		strbuf_reset(&buf);
+		if (!data->fetch_multiple)
+			perform_fetch_command(transport, &buf);
+	}
 
-		if (strbuf_getline(&buf, file, '\n') == EOF)
-			exit(128); /* child died, message supplied already */
+	if (data->fetch_multiple) {
+		strbuf_addch(&buf, '\n');
+		perform_fetch_command(transport, &buf);
 	}
+
+	strbuf_release(&buf);
 	return 0;
 }
 
@@ -105,7 +136,7 @@ static int fetch(struct transport *transport,
 	if (!count)
 		return 0;
 
-	if (data->fetch)
+	if (data->fetch || data->fetch_multiple)
 		return fetch_with_fetch(transport, nr_heads, to_fetch);
 
 	return -1;
@@ -113,21 +144,20 @@ static int fetch(struct transport *transport,
 
 static struct ref *get_refs_list(struct transport *transport, int for_push)
 {
+	struct helper_data *data = transport->data;
 	struct child_process *helper;
 	struct ref *ret = NULL;
 	struct ref **tail = &ret;
 	struct ref *posn;
 	struct strbuf buf = STRBUF_INIT;
-	FILE *file;
 
 	helper = get_helper(transport);
 
 	write_str_in_full(helper->in, "list\n");
 
-	file = xfdopen(helper->out, "r");
 	while (1) {
 		char *eov, *eon;
-		if (strbuf_getline(&buf, file, '\n') == EOF)
+		if (strbuf_getline(&buf, data->out, '\n') == EOF)
 			exit(128); /* child died, message supplied already */
 
 		if (!*buf.buf)
-- 
1.6.5.52.g0ff2e
