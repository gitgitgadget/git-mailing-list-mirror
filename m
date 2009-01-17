From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] http-push: fix off-by-path_len
Date: Sat, 17 Jan 2009 16:36:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901171632330.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, Ray Chuan <rctay89@gmail.com>,
	Nick Hengeveld <nickh@reactrix.com>
To: "Kirill A. Korinskiy" <catap@catap.ru>, git@vger.kernel.org,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 17 16:37:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LODEk-000729-4V
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 16:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759458AbZAQPft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 10:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759376AbZAQPfs
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 10:35:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:42490 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759366AbZAQPfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 10:35:47 -0500
Received: (qmail invoked by alias); 17 Jan 2009 15:35:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 17 Jan 2009 16:35:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19bdDBN7zxbwD5I79GNF65bTyxNv1Hq9VwoCqV4KB
	ynXJfqV96RmWWm
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106060>


When getting the result of remote_ls(), we were advancing the variable
"path" to the relative path inside the repository.

However, then we went on to malloc a bogus amount of memory: we were
subtracting the prefix length _again_, quite possibly getting something
negative, which xmalloc() interprets as really, really much.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Note that the push in t5540 is still broken, as http-push does
	not handle packed-refs (when looking what branches are on the 
	remote side).

	It should not even try to access the directory structure under
	refs/ to begin with, but read info/refs instead.

	However, that is just one example of the ugliness that is 
	http-push.c; it also seems to be a perfect example of a copy-pasting 
	hell; just look at the output of "git grep
	curl_easy_setopt http-push.c".

	There _has_ to be lot of room for improvement.

 http-push.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/http-push.c b/http-push.c
index 9fcccee..cb5bf95 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1435,10 +1435,8 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
 			}
 			if (path) {
 				path += remote->path_len;
+				ls->dentry_name = xstrdup(path);
 			}
-			ls->dentry_name = xmalloc(strlen(path) -
-						  remote->path_len + 1);
-			strcpy(ls->dentry_name, path + remote->path_len);
 		} else if (!strcmp(ctx->name, DAV_PROPFIND_COLLECTION)) {
 			ls->dentry_flags |= IS_DIR;
 		}
@@ -1449,6 +1447,12 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
 	}
 }
 
+/*
+ * NEEDSWORK: remote_ls() ignores info/refs on the remote side.  But it
+ * should _only_ heed the information from that file, instead of trying to
+ * determine the refs from the remote file system (badly: it does not even
+ * know about packed-refs).
+ */
 static void remote_ls(const char *path, int flags,
 		      void (*userFunc)(struct remote_ls_ctx *ls),
 		      void *userData)
-- 
1.6.1.325.g062d4
