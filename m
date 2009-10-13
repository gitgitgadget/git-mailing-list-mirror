From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v2 06/16] remote-curl: Refactor walker initialization
Date: Mon, 12 Oct 2009 19:25:05 -0700
Message-ID: <1255400715-10508-7-git-send-email-spearce@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 04:34:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxXDA-0004cs-MR
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 04:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758841AbZJMC0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 22:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758830AbZJMC0g
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 22:26:36 -0400
Received: from george.spearce.org ([209.20.77.23]:56207 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758811AbZJMC0e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 22:26:34 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 69ACD3826B; Tue, 13 Oct 2009 02:25:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 26AD53821F;
	Tue, 13 Oct 2009 02:25:18 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
In-Reply-To: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130107>

We will need the walker, url and remote in other functions as the
code grows larger to support smart HTTP.  Extract this out into a
set of globals we can easily reference once configured.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Daniel Barkalow <barkalow@iabervon.org>
---
 remote-curl.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index ad6a163..4628ee8 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -4,7 +4,17 @@
 #include "walker.h"
 #include "http.h"
 
-static struct ref *get_refs(struct walker *walker, const char *url)
+static struct remote *remote;
+static const char *url;
+static struct walker *walker;
+
+static void init_walker(void)
+{
+	if (!walker)
+		walker = get_http_walker(url, remote);
+}
+
+static struct ref *get_refs(void)
 {
 	struct strbuf buffer = STRBUF_INIT;
 	char *data, *start, *mid;
@@ -20,6 +30,7 @@ static struct ref *get_refs(struct walker *walker, const char *url)
 	refs_url = xmalloc(strlen(url) + 11);
 	sprintf(refs_url, "%s/info/refs", url);
 
+	init_walker();
 	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
 	switch (http_ret) {
 	case HTTP_OK:
@@ -77,10 +88,7 @@ static struct ref *get_refs(struct walker *walker, const char *url)
 
 int main(int argc, const char **argv)
 {
-	struct remote *remote;
 	struct strbuf buf = STRBUF_INIT;
-	const char *url;
-	struct walker *walker = NULL;
 
 	setup_git_directory();
 	if (argc < 2) {
@@ -101,8 +109,7 @@ int main(int argc, const char **argv)
 			break;
 		if (!prefixcmp(buf.buf, "fetch ")) {
 			char *obj = buf.buf + strlen("fetch ");
-			if (!walker)
-				walker = get_http_walker(url, remote);
+			init_walker();
 			walker->get_all = 1;
 			walker->get_tree = 1;
 			walker->get_history = 1;
@@ -113,11 +120,8 @@ int main(int argc, const char **argv)
 			printf("\n");
 			fflush(stdout);
 		} else if (!strcmp(buf.buf, "list")) {
-			struct ref *refs;
+			struct ref *refs = get_refs();
 			struct ref *posn;
-			if (!walker)
-				walker = get_http_walker(url, remote);
-			refs = get_refs(walker, url);
 			for (posn = refs; posn; posn = posn->next) {
 				if (posn->symref)
 					printf("@%s %s\n", posn->symref, posn->name);
-- 
1.6.5.52.g0ff2e
