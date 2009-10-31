From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v5 09/28] remote-helpers: Fetch more than one ref in a batch
Date: Fri, 30 Oct 2009 17:47:28 -0700
Message-ID: <1256950067-27938-11-git-send-email-spearce@spearce.org>
References: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 01:49:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N429l-0001yQ-VE
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 01:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933132AbZJaAsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 20:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757601AbZJaAsH
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 20:48:07 -0400
Received: from george.spearce.org ([209.20.77.23]:36921 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757547AbZJaArt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 20:47:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9E47F38265; Sat, 31 Oct 2009 00:47:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 26F0D38215;
	Sat, 31 Oct 2009 00:47:51 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131793>

Some network protocols (e.g. native git://) are able to fetch more
than one ref at a time and reduce the overall transfer cost by
combining the requests into a single exchange.  Instead of feeding
each fetch request one at a time to the helper, feed all of them
at once so the helper can decide whether or not it should batch them.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/git-remote-helpers.txt |   14 ++++--
 remote-curl.c                        |   88 +++++++++++++++++++++++++++++----
 transport-helper.c                   |   39 +++++++++++----
 3 files changed, 115 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 173ee23..e44d821 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -36,10 +36,16 @@ Commands are given by the caller on the helper's standard input, one per line.
 	complete list, outputs a blank line.
 
 'fetch' <sha1> <name>::
-	Fetches the given object, writing the necessary objects to the
-	database. Outputs a blank line when the fetch is
-	complete. Only objects which were reported in the ref list
-	with a sha1 may be fetched this way.
+	Fetches the given object, writing the necessary objects
+	to the database.  Fetch commands are sent in a batch, one
+	per line, and the batch is terminated with a blank line.
+	Outputs a single blank line when all fetch commands in the
+	same batch are complete. Only objects which were reported
+	in the ref list with a sha1 may be fetched this way.
++
+Optionally may output a 'lock <file>' line indicating a file under
+GIT_DIR/objects/pack which is keeping a pack until refs can be
+suitably updated.
 +
 Supported if the helper has the "fetch" capability.
 
diff --git a/remote-curl.c b/remote-curl.c
index 478f3ea..22cd5c5 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -87,6 +87,81 @@ static struct ref *get_refs(void)
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
+static void parse_fetch(struct strbuf *buf)
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
@@ -110,17 +185,8 @@ int main(int argc, const char **argv)
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
+			parse_fetch(&buf);
+
 		} else if (!strcmp(buf.buf, "list")) {
 			struct ref *refs = get_refs();
 			struct ref *posn;
diff --git a/transport-helper.c b/transport-helper.c
index f57e84c..9de3408 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -10,6 +10,7 @@ struct helper_data
 {
 	const char *name;
 	struct child_process *helper;
+	FILE *out;
 	unsigned fetch : 1;
 };
 
@@ -18,7 +19,6 @@ static struct child_process *get_helper(struct transport *transport)
 	struct helper_data *data = transport->data;
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process *helper;
-	FILE *file;
 
 	if (data->helper)
 		return data->helper;
@@ -39,9 +39,9 @@ static struct child_process *get_helper(struct transport *transport)
 
 	write_str_in_full(helper->in, "capabilities\n");
 
-	file = xfdopen(helper->out, "r");
+	data->out = xfdopen(helper->out, "r");
 	while (1) {
-		if (strbuf_getline(&buf, file, '\n') == EOF)
+		if (strbuf_getline(&buf, data->out, '\n') == EOF)
 			exit(128); /* child died, message supplied already */
 
 		if (!*buf.buf)
@@ -58,6 +58,7 @@ static int disconnect_helper(struct transport *transport)
 	if (data->helper) {
 		write_str_in_full(data->helper->in, "\n");
 		close(data->helper->in);
+		fclose(data->out);
 		finish_command(data->helper);
 		free((char *)data->helper->argv[0]);
 		free(data->helper->argv);
@@ -70,8 +71,7 @@ static int disconnect_helper(struct transport *transport)
 static int fetch_with_fetch(struct transport *transport,
 			    int nr_heads, const struct ref **to_fetch)
 {
-	struct child_process *helper = get_helper(transport);
-	FILE *file = xfdopen(helper->out, "r");
+	struct helper_data *data = transport->data;
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 
@@ -82,12 +82,30 @@ static int fetch_with_fetch(struct transport *transport,
 
 		strbuf_addf(&buf, "fetch %s %s\n",
 			    sha1_to_hex(posn->old_sha1), posn->name);
-		write_in_full(helper->in, buf.buf, buf.len);
-		strbuf_reset(&buf);
+	}
 
-		if (strbuf_getline(&buf, file, '\n') == EOF)
+	strbuf_addch(&buf, '\n');
+	if (write_in_full(data->helper->in, buf.buf, buf.len) != buf.len)
+		die_errno("cannot send fetch to %s", data->name);
+
+	while (1) {
+		strbuf_reset(&buf);
+		if (strbuf_getline(&buf, data->out, '\n') == EOF)
 			exit(128); /* child died, message supplied already */
+
+		if (!prefixcmp(buf.buf, "lock ")) {
+			const char *name = buf.buf + 5;
+			if (transport->pack_lockfile)
+				warning("%s also locked %s", data->name, name);
+			else
+				transport->pack_lockfile = xstrdup(name);
+		}
+		else if (!buf.len)
+			break;
+		else
+			warning("%s unexpectedly said: '%s'", data->name, buf.buf);
 	}
+	strbuf_release(&buf);
 	return 0;
 }
 
@@ -113,21 +131,20 @@ static int fetch(struct transport *transport,
 
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
1.6.5.2.181.gd6f41
