From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] http-fetch: remove path_len from struct alt_base, it was computed but never used
Date: Wed, 28 Mar 2007 09:47:35 +0000
Message-ID: <20070328094735.32395.qmail@f0b3463ad4d11a.315fe32.mid.smarden.org>
References: <20070328094615.32277.qmail@47bcc7bfa0b709.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 11:47:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWUkS-0000cY-Ad
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 11:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933780AbXC1JrR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 05:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933779AbXC1JrQ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 05:47:16 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:51204 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933780AbXC1JrP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 05:47:15 -0400
Received: (qmail 32396 invoked by uid 1000); 28 Mar 2007 09:47:35 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070328094615.32277.qmail@47bcc7bfa0b709.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43366>

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 http-fetch.c |   20 +++-----------------
 1 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 58b77a7..557b403 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -17,7 +17,6 @@ static struct curl_slist *no_pragma_header;
 struct alt_base
 {
 	char *base;
-	int path_len;
 	int got_indices;
 	struct packed_git *packs;
 	struct alt_base *next;
@@ -515,7 +514,6 @@ static void process_alternates_response(void *callback_data)
 			int serverlen = 0;
 			struct alt_base *newalt;
 			char *target = NULL;
-			char *path;
 			if (data[i] == '/') {
 				/* This counts
 				 * http://git.host/pub/scm/linux.git/
@@ -583,12 +581,6 @@ static void process_alternates_response(void *callback_data)
 				newalt->base = target;
 				newalt->got_indices = 0;
 				newalt->packs = NULL;
-				path = strstr(target, "//");
-				if (path) {
-					path = strchr(path+2, '/');
-					if (path)
-						newalt->path_len = strlen(path);
-				}
 
 				while (tail->next != NULL)
 					tail = tail->next;
@@ -999,7 +991,7 @@ int main(int argc, const char **argv)
 	const char **write_ref = NULL;
 	char **commit_id;
 	const char *url;
-	char *path;
+	char *s;
 	int arg = 1;
 	int rc = 0;
 
@@ -1046,17 +1038,11 @@ int main(int argc, const char **argv)
 	alt = xmalloc(sizeof(*alt));
 	alt->base = xmalloc(strlen(url) + 1);
 	strcpy(alt->base, url);
-	for (path = alt->base + strlen(alt->base) - 1; *path == '/'; --path)
-		*path = 0;
+	for (s = alt->base + strlen(alt->base) - 1; *s == '/'; --s)
+		*s = 0;
 	alt->got_indices = 0;
 	alt->packs = NULL;
 	alt->next = NULL;
-	path = strstr(url, "//");
-	if (path) {
-		path = strchr(path+2, '/');
-		if (path)
-			alt->path_len = strlen(path);
-	}
 
 	if (pull(commits, commit_id, write_ref, url))
 		rc = 1;
-- 
1.5.1-rc2.GIT
