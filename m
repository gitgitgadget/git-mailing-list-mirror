From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/2] enable HEAD@{...} and make it independent from the current
 branch
Date: Sat, 03 Feb 2007 21:49:16 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702032144010.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 03:49:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDXRQ-0007Wj-97
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 03:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbXBDCtS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 21:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbXBDCtS
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 21:49:18 -0500
Received: from relais.videotron.ca ([24.201.245.36]:41891 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbXBDCtR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 21:49:17 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCX0065O3U4RBA0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 03 Feb 2007 21:49:17 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38638>


Signed-off-by: Nicolas Pitre <nico@cam.org>
---

 sha1_name.c |   60 +++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index de8caf8..9841b05 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -235,22 +235,23 @@ static int ambiguous_path(const char *path, int len)
 	return slash;
 }
 
+static const char *ref_fmt[] = {
+	"%.*s",
+	"refs/%.*s",
+	"refs/tags/%.*s",
+	"refs/heads/%.*s",
+	"refs/remotes/%.*s",
+	"refs/remotes/%.*s/HEAD",
+	NULL
+};
+
 int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 {
-	static const char *fmt[] = {
-		"%.*s",
-		"refs/%.*s",
-		"refs/tags/%.*s",
-		"refs/heads/%.*s",
-		"refs/remotes/%.*s",
-		"refs/remotes/%.*s/HEAD",
-		NULL
-	};
 	const char **p, *r;
 	int refs_found = 0;
 
 	*ref = NULL;
-	for (p = fmt; *p; p++) {
+	for (p = ref_fmt; *p; p++) {
 		unsigned char sha1_from_ref[20];
 		unsigned char *this_result;
 
@@ -266,6 +267,26 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 	return refs_found;
 }
 
+static int dwim_log(const char *str, int len, char **log)
+{
+	const char **p;
+	int logs_found = 0;
+
+	*log = NULL;
+	for (p = ref_fmt; *p; p++) {
+		struct stat st;
+		char *path = mkpath(*p, len, str);
+		if (!stat(git_path("logs/%s", path), &st) &&
+		    S_ISREG(st.st_mode)) {
+			if (!logs_found++)
+				*log = xstrdup(path);
+			if (!warn_ambiguous_refs)
+				break;
+		}
+	}
+	return logs_found;
+}
+
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 {
 	static const char *warning = "warning: refname '%.*s' is ambiguous.\n";
@@ -295,7 +316,9 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	if (!len && reflog_len) {
 		/* allow "@{...}" to mean the current branch reflog */
 		refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
-	} else
+	} else if (reflog_len)
+		refs_found = dwim_log(str, len, &real_ref);
+	else
 		refs_found = dwim_ref(str, len, sha1, &real_ref);
 
 	if (!refs_found)
@@ -310,21 +333,6 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		unsigned long co_time;
 		int co_tz, co_cnt;
 
-		/*
-		 * We'll have an independent reflog for "HEAD" eventually
-		 * which won't be a synonym for the current branch reflog.
-		 * In the mean time prevent people from getting used to
-		 * such a synonym until the work is completed.
-		 */
-		if (len && !strncmp("HEAD", str, len) &&
-		    !strncmp(real_ref, "refs/", 5)) {
-			error("reflog for HEAD has not been implemented yet\n"
-			      "Maybe you could try %s%s instead, "
-			      "or just %s for current branch..",
-			      strchr(real_ref+5, '/')+1, str+len, str+len);
-			exit(-1);
-		}
-
 		/* Is it asking for N-th entry, or approxidate? */
 		for (i = nth = 0; 0 <= nth && i < reflog_len; i++) {
 			char ch = str[at+2+i];
-- 
1.5.0.rc2.651.g3924-dirty
