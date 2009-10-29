From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v4 21/26] Discover refs via smart HTTP server when available
Date: Wed, 28 Oct 2009 17:00:43 -0700
Message-ID: <1256774448-7625-22-git-send-email-spearce@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 01:02:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ISm-0000kN-4H
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981AbZJ2ABD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755979AbZJ2ABC
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:01:02 -0400
Received: from george.spearce.org ([209.20.77.23]:36264 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755918AbZJ2AA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:00:58 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2CF2E381D3; Thu, 29 Oct 2009 00:01:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3616038265;
	Thu, 29 Oct 2009 00:00:55 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131522>

Instead of loading the cached info/refs, try to use the smart HTTP
version when the server supports it.  Since the smart variant is
actually the pkt-line stream from the start of either upload-pack
or receive-pack we need to parse these through get_remote_heads,
which requires a background thread to feed its pipe.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Daniel Barkalow <barkalow@iabervon.org>
---
 remote-curl.c |  148 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 131 insertions(+), 17 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 5c9dd97..3917d45 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -5,6 +5,7 @@
 #include "http.h"
 #include "exec_cmd.h"
 #include "run-command.h"
+#include "pkt-line.h"
 
 static struct remote *remote;
 static const char *url;
@@ -75,21 +76,46 @@ static int set_option(const char *name, const char *value)
 	}
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
+{
+	if (d) {
+		if (d == last_discovery)
+			last_discovery = NULL;
+		free(d->buf_alloc);
+		free(d);
+	}
+}
+
+static struct discovery* discover_refs(const char *service)
 {
 	struct strbuf buffer = STRBUF_INIT;
-	char *data, *start, *mid;
-	char *ref_name;
+	struct discovery *last = last_discovery;
 	char *refs_url;
-	int i = 0;
-	int http_ret;
+	int http_ret, is_http = 0;
 
-	struct ref *refs = NULL;
-	struct ref *ref = NULL;
-	struct ref *last_ref = NULL;
+	if (last && !strcmp(service, last->service))
+		return last;
+	free_discovery(last);
 
-	refs_url = xmalloc(strlen(url) + 11);
-	sprintf(refs_url, "%s/info/refs", url);
+	strbuf_addf(&buffer, "%s/info/refs", url);
+	if (!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) {
+		is_http = 1;
+		if (!strchr(url, '?'))
+			strbuf_addch(&buffer, '?');
+		else
+			strbuf_addch(&buffer, '&');
+		strbuf_addf(&buffer, "service=%s", service);
+	}
+	refs_url = strbuf_detach(&buffer, NULL);
 
 	init_walker();
 	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
@@ -104,10 +130,86 @@ static struct ref *get_refs(void)
 		die("HTTP request failed");
 	}
 
-	data = buffer.buf;
+	last= xcalloc(1, sizeof(*last_discovery));
+	last->service = service;
+	last->buf_alloc = strbuf_detach(&buffer, &last->len);
+	last->buf = last->buf_alloc;
+
+	if (is_http && 5 <= last->len && last->buf[4] == '#') {
+		/* smart HTTP response; validate that the service
+		 * pkt-line matches our request.
+		 */
+		struct strbuf exp = STRBUF_INIT;
+
+		if (packet_get_line(&buffer, &last->buf, &last->len) <= 0)
+			die("%s has invalid packet header", refs_url);
+		if (buffer.len && buffer.buf[buffer.len - 1] == '\n')
+			strbuf_setlen(&buffer, buffer.len - 1);
+
+		strbuf_addf(&exp, "# service=%s", service);
+		if (strbuf_cmp(&exp, &buffer))
+			die("invalid server response; got '%s'", buffer.buf);
+		strbuf_release(&exp);
+
+		/* The header can include additional metadata lines, up
+		 * until a packet flush marker.  Ignore these now, but
+		 * in the future we might start to scan them.
+		 */
+		strbuf_reset(&buffer);
+		while (packet_get_line(&buffer, &last->buf, &last->len) > 0)
+			strbuf_reset(&buffer);
+
+		last->proto_git = 1;
+	}
+
+	free(refs_url);
+	strbuf_release(&buffer);
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
@@ -131,8 +233,7 @@ static struct ref *get_refs(void)
 		i++;
 	}
 
-	strbuf_release(&buffer);
-
+	init_walker();
 	ref = alloc_ref("HEAD");
 	if (!walker->fetch_ref(walker, ref) &&
 	    !resolve_remote_symref(ref, refs)) {
@@ -142,11 +243,23 @@ static struct ref *get_refs(void)
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
@@ -317,7 +430,8 @@ int main(int argc, const char **argv)
 			parse_fetch(&buf);
 
 		} else if (!strcmp(buf.buf, "list") || !prefixcmp(buf.buf, "list ")) {
-			output_refs(get_refs());
+			int for_push = !!strstr(buf.buf + 4, "for-push");
+			output_refs(get_refs(for_push));
 
 		} else if (!prefixcmp(buf.buf, "push ")) {
 			parse_push(&buf);
-- 
1.6.5.2.181.gd6f41
