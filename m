From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] log --reflog: use dwim_log
Date: Fri, 9 Feb 2007 01:28:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702090127510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8aa486160702071721s401ea38fxa8eb71bb694a6915@mail.gmail.com>
 <Pine.LNX.4.63.0702082021210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <eqfu36$lb3$1@sea.gmane.org> <Pine.LNX.4.63.0702082040390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vveicw850.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 09 01:28:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFJcr-0005tC-Ke
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 01:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423057AbXBIA20 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 19:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965730AbXBIA20
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 19:28:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:53164 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965596AbXBIA2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 19:28:25 -0500
Received: (qmail invoked by alias); 09 Feb 2007 00:28:23 -0000
X-Provags-ID: V01U2FsdGVkX186zGIXcqc69NvIqg8maf7/KcyNNUPDUOTce0Y0Bs
	vNhg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vveicw850.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39140>


Since "git log origin/master" uses dwim_log() to match
"refs/remotes/origin/master", it makes sense to do that for
"git log --reflog", too.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	I changed dwim_ref() to dwim_log() as per Nico's request.

 cache.h       |    1 +
 reflog-walk.c |   13 +++++++++++++
 sha1_name.c   |    2 +-
 3 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 6f55fdc..44941c0 100644
--- a/cache.h
+++ b/cache.h
@@ -304,6 +304,7 @@ extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
 extern const char *resolve_ref(const char *path, unsigned char *sha1, int, int *);
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
+extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
 
 extern int create_symref(const char *ref, const char *refs_heads_master, const char *logmsg);
 extern int validate_headref(const char *ref);
diff --git a/reflog-walk.c b/reflog-walk.c
index 653ec95..e0f1332 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -174,6 +174,19 @@ void add_reflog_for_walk(struct reflog_walk_info *info,
 			branch = xstrdup(head);
 		}
 		reflogs = read_complete_reflog(branch);
+		if (!reflogs || reflogs->nr == 0) {
+			unsigned char sha1[20];
+			char *b;
+			if (dwim_log(branch, strlen(branch), sha1, &b) == 1) {
+				if (reflogs) {
+					free(reflogs->ref);
+					free(reflogs);
+				}
+				free(branch);
+				branch = b;
+				reflogs = read_complete_reflog(branch);
+			}
+		}
 		if (!reflogs || reflogs->nr == 0)
 			die("No reflogs found for '%s'", branch);
 		path_list_insert(branch, &info->complete_reflogs)->util
diff --git a/sha1_name.c b/sha1_name.c
index d0d9536..c50a378 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -268,7 +268,7 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 	return refs_found;
 }
 
-static int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
+int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 {
 	const char **p;
 	int logs_found = 0;
-- 
1.5.0.rc4.2051.g679c-dirty
