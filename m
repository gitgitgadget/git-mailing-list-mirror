From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v5 07/28] remote-curl: Refactor walker initialization
Date: Fri, 30 Oct 2009 17:47:26 -0700
Message-ID: <1256950067-27938-9-git-send-email-spearce@spearce.org>
References: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 01:48:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N428c-0001cH-KG
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 01:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757586AbZJaAsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 20:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757598AbZJaAr5
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 20:47:57 -0400
Received: from george.spearce.org ([209.20.77.23]:36916 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757573AbZJaArs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 20:47:48 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5F9CB38260; Sat, 31 Oct 2009 00:47:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8E561381FF;
	Sat, 31 Oct 2009 00:47:50 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131789>

We will need the walker, url and remote in other functions as the
code grows larger to support smart HTTP.  Extract this out into a
set of globals we can easily reference once configured.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Daniel Barkalow <barkalow@iabervon.org>
---
 remote-curl.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 2faf1c6..478f3ea 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -5,7 +5,17 @@
 #include "http.h"
 #include "exec_cmd.h"
 
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
@@ -21,6 +31,7 @@ static struct ref *get_refs(struct walker *walker, const char *url)
 	refs_url = xmalloc(strlen(url) + 11);
 	sprintf(refs_url, "%s/info/refs", url);
 
+	init_walker();
 	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
 	switch (http_ret) {
 	case HTTP_OK:
@@ -78,10 +89,7 @@ static struct ref *get_refs(struct walker *walker, const char *url)
 
 int main(int argc, const char **argv)
 {
-	struct remote *remote;
 	struct strbuf buf = STRBUF_INIT;
-	const char *url;
-	struct walker *walker = NULL;
 
 	git_extract_argv0_path(argv[0]);
 	setup_git_directory();
@@ -103,8 +111,7 @@ int main(int argc, const char **argv)
 			break;
 		if (!prefixcmp(buf.buf, "fetch ")) {
 			char *obj = buf.buf + strlen("fetch ");
-			if (!walker)
-				walker = get_http_walker(url, remote);
+			init_walker();
 			walker->get_all = 1;
 			walker->get_tree = 1;
 			walker->get_history = 1;
@@ -115,11 +122,8 @@ int main(int argc, const char **argv)
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
1.6.5.2.181.gd6f41
