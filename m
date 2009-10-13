From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v2 13/16] Discover refs via smart HTTP server when available
Date: Mon, 12 Oct 2009 19:25:12 -0700
Message-ID: <1255400715-10508-14-git-send-email-spearce@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 04:34:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxXDC-0004cs-9w
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 04:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758849AbZJMC0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 22:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758830AbZJMC0l
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 22:26:41 -0400
Received: from george.spearce.org ([209.20.77.23]:56216 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758835AbZJMC0g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 22:26:36 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 365E538200; Tue, 13 Oct 2009 02:25:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4E8E638267;
	Tue, 13 Oct 2009 02:25:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
In-Reply-To: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130115>

Instead of loading the cached info/refs, try to use the smart HTTP
version when the server supports it.  Since the smart variant is
actually the pkt-line stream from the start of either upload-pack
or receive-pack we need to parse these through get_remote_heads,
which requires a background thread to feed its pipe.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Daniel Barkalow <barkalow@iabervon.org>
---
 remote-curl.c |  135 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 116 insertions(+), 19 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 000bb52..42fd06c 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -4,6 +4,7 @@
 #include "strbuf.h"
 #include "walker.h"
 #include "http.h"
+#include "pkt-line.h"
 #include "run-command.h"
 
 
@@ -17,24 +18,41 @@ static void init_walker(void)
 		walker = get_http_walker(url, remote);
 }
 
-static struct ref *get_refs(void)
+struct discovery {
+	const char *service;
+	char *buf_alloc;
+	char *buf;
+	size_t len;
+	unsigned proto_git : 1;
+};
+static struct discovery *last_discovery;
+
+static void free_discovery(struct discovery *d)
 {
-	struct strbuf buffer = STRBUF_INIT;
-	char *data, *start, *mid;
-	char *ref_name;
+	if (d) {
+		if (d == last_discovery)
+			last_discovery = NULL;
+		free(d->buf_alloc);
+		free(d);
+	}
+}
+
+static struct discovery* discover_refs(const char *service)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct discovery *last = last_discovery;
 	char *refs_url;
-	int i = 0;
 	int http_ret;
 
-	struct ref *refs = NULL;
-	struct ref *ref = NULL;
-	struct ref *last_ref = NULL;
+	if (last && !strcmp(service, last->service))
+		return last;
+	free_discovery(last);
 
-	refs_url = xmalloc(strlen(url) + 11);
-	sprintf(refs_url, "%s/info/refs", url);
+	strbuf_addf(&buf, "%s/info/refs?service=%s", url, service);
+	refs_url = strbuf_detach(&buf, NULL);
 
 	init_walker();
-	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
+	http_ret = http_get_strbuf(refs_url, &buf, HTTP_NO_CACHE);
 	switch (http_ret) {
 	case HTTP_OK:
 		break;
@@ -46,10 +64,78 @@ static struct ref *get_refs(void)
 		die("HTTP request failed");
 	}
 
-	data = buffer.buf;
+	last= xcalloc(1, sizeof(*last_discovery));
+	last->service = service;
+	last->buf_alloc = strbuf_detach(&buf, &last->len);
+	last->buf = last->buf_alloc;
+
+	if (5 <= last->len && last->buf[4] == '#') {
+		/* smart HTTP response; validate that the service
+		 * pkt-line matches our request.
+		 */
+		struct strbuf exp = STRBUF_INIT;
+
+		if (packet_get_line(&buf, &last->buf, &last->len) <= 0)
+			die("%s has invalid packet header", refs_url);
+		if (buf.len && buf.buf[buf.len - 1] == '\n')
+			strbuf_setlen(&buf, buf.len - 1);
+
+		strbuf_addf(&exp, "# service=%s", service);
+		if (strbuf_cmp(&exp, &buf))
+			die("invalid server response; got '%s'", buf.buf);
+		strbuf_release(&exp);
+
+		last->proto_git = 1;
+	}
+
+	free(refs_url);
+	strbuf_release(&buf);
+	last_discovery = last;
+	return last;
+}
+
+static int write_discovery(int fd, void *data)
+{
+	struct discovery *heads = data;
+	int err = 0;
+	if (write_in_full(fd, heads->buf, heads->len) != heads->len)
+		err = 1;
+	close(fd);
+	return err;
+}
+
+static struct ref *parse_git_refs(struct discovery *heads)
+{
+	struct ref *list = NULL;
+	struct async async;
+
+	memset(&async, 0, sizeof(async));
+	async.proc = write_discovery;
+	async.data = heads;
+
+	if (start_async(&async))
+		die("cannot start thread to parse advertised refs");
+	get_remote_heads(async.out, &list, 0, NULL, 0, NULL);
+	close(async.out);
+	if (finish_async(&async))
+		die("ref parsing thread failed");
+	return list;
+}
+
+static struct ref *parse_info_refs(struct discovery *heads)
+{
+	char *data, *start, *mid;
+	char *ref_name;
+	int i = 0;
+
+	struct ref *refs = NULL;
+	struct ref *ref = NULL;
+	struct ref *last_ref = NULL;
+
+	data = heads->buf;
 	start = NULL;
 	mid = data;
-	while (i < buffer.len) {
+	while (i < heads->len) {
 		if (!start) {
 			start = &data[i];
 		}
@@ -73,8 +159,7 @@ static struct ref *get_refs(void)
 		i++;
 	}
 
-	strbuf_release(&buffer);
-
+	init_walker();
 	ref = alloc_ref("HEAD");
 	if (!walker->fetch_ref(walker, ref) &&
 	    !resolve_remote_symref(ref, refs)) {
@@ -84,11 +169,23 @@ static struct ref *get_refs(void)
 		free(ref);
 	}
 
-	strbuf_release(&buffer);
-	free(refs_url);
 	return refs;
 }
 
+static struct ref *get_refs(int for_push)
+{
+	struct discovery *heads;
+
+	if (for_push)
+		heads = discover_refs("git-receive-pack");
+	else
+		heads = discover_refs("git-upload-pack");
+
+	if (heads->proto_git)
+		return parse_git_refs(heads);
+	return parse_info_refs(heads);
+}
+
 static void output_refs(struct ref *refs)
 {
 	struct ref *posn;
@@ -285,10 +382,10 @@ int main(int argc, const char **argv)
 			parse_fetch(&buf, 1);
 
 		} else if (!strcmp(buf.buf, "list")) {
-			output_refs(get_refs());
+			output_refs(get_refs(0));
 
 		} else if (!strcmp(buf.buf, "list for-push")) {
-			output_refs(get_refs());
+			output_refs(get_refs(1));
 
 		} else if (!prefixcmp(buf.buf, "push ")) {
 			parse_push(&buf);
-- 
1.6.5.52.g0ff2e
