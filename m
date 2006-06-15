From: Alexander Litvinov <lan@academsoft.ru>
Subject: [PATCH for cvsps] Handle cvs repo with modules
Date: Thu, 15 Jun 2006 12:49:17 +0700
Organization: AcademSoft Ltd.
Message-ID: <200606151249.17518.lan@academsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 15 07:49:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqkje-0002GK-K5
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 07:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWFOFti (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 01:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWFOFti
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 01:49:38 -0400
Received: from gw.ac-sw.com ([81.1.223.2]:45697 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S932438AbWFOFth (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 01:49:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by gw.ac-sw.com (Postfix) with ESMTP
	id 5BC93BDE9; Thu, 15 Jun 2006 12:49:35 +0700 (NOVST)
Received: from gw.ac-sw.com ([127.0.0.1])
 by localhost (gw.ac-sw.com [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14533-01; Thu, 15 Jun 2006 12:49:24 +0700 (NOVST)
Received: from lan.ac-sw.lcl (lan.ac-sw.lcl [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP
	id 1FAC4BDE2; Thu, 15 Jun 2006 12:49:24 +0700 (NOVST)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id 0ACF88D98161; Thu, 15 Jun 2006 12:49:23 +0700 (NOVST)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 348E98D98160;
	Thu, 15 Jun 2006 12:49:18 +0700 (NOVST)
To: git@vger.kernel.org, Yann Dirson <ydirson@altern.org>,
	cvsps@dm.cobite.com
User-Agent: KMail/1.8
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at gw.ac-sw.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21880>

Parse 'Working file' lines from cvs log output. This alow to work with cvs repos 
with modules. To enable this you need to add --no-rlog to cvsps command line args.

This patch was made to import such repo into git. But git-cvsimport can't load such data.

---
 cvsps.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/cvsps.c b/cvsps.c
index 2695a0f..62d6e08 100644
--- a/cvsps.c
+++ b/cvsps.c
@@ -39,7 +39,8 @@ #define CVS_FILE_BOUNDARY "=============
 
 enum
 {
-    NEED_FILE,
+    NEED_RCS_FILE,
+    NEED_WORKING_FILE,
     NEED_SYMS,
     NEED_EOS,
     NEED_START_LOG,
@@ -117,7 +118,9 @@ static int parse_args(int, char *[]);
 static int parse_rc();
 static void load_from_cvs();
 static void init_paths();
-static CvsFile * parse_file(const char *);
+static CvsFile * build_file_by_name(const char *);
+static CvsFile * parse_rcs_file(const char *);
+static CvsFile * parse_working_file(const char *);
 static CvsFileRevision * parse_revision(CvsFile * file, char * rev_str);
 static void assign_pre_revision(PatchSetMember *, CvsFileRevision * rev);
 static void check_print_patch_set(PatchSet *);
@@ -260,7 +263,7 @@ static void load_from_cvs()
 {
     FILE * cvsfp;
     char buff[BUFSIZ];
-    int state = NEED_FILE;
+    int state = NEED_RCS_FILE;
     CvsFile * file = NULL;
     PatchSetMember * psm = NULL;
     char datebuff[20];
@@ -339,10 +342,26 @@ static void load_from_cvs()
 
 	switch(state)
 	{
-	case NEED_FILE:
-	    if (strncmp(buff, "RCS file", 8) == 0 && (file = parse_file(buff)))
+	case NEED_RCS_FILE:
+	    if (strncmp(buff, "RCS file", 8) == 0) {
+              if ((file = parse_rcs_file(buff)) != NULL)
 		state = NEED_SYMS;
+              else 
+                state = NEED_WORKING_FILE;
+            }
 	    break;
+	case NEED_WORKING_FILE:
+	    if (strncmp(buff, "Working file", 12) == 0) {
+              if ((file = parse_working_file(buff))) 
+		state = NEED_SYMS;
+              else
+                state = NEED_RCS_FILE;
+		break;
+	    } else {
+              // Working file come just after RCS file. So reset state if it was not found
+              state = NEED_RCS_FILE;
+            }
+            break;
 	case NEED_SYMS:
 	    if (strncmp(buff, "symbolic names:", 15) == 0)
 		state = NEED_EOS;
@@ -471,7 +490,7 @@ static void load_from_cvs()
 		have_log = 0;
 		psm = NULL;
 		file = NULL;
-		state = NEED_FILE;
+		state = NEED_RCS_FILE;
 	    }
 	    else
 	    {
@@ -524,7 +543,7 @@ static void load_from_cvs()
 	exit(1);
     }
 
-    if (state != NEED_FILE)
+    if (state != NEED_RCS_FILE)
     {
 	debug(DEBUG_APPERROR, "Error: Log file parsing error. (%d)  Use -v to debug", state);
 	exit(1);
@@ -1039,7 +1058,7 @@ static void init_paths()
      * NOTE: because of some bizarre 'feature' in cvs, when 'rlog' is used
      * (instead of log) it gives the 'real' RCS file path, which can be different
      * from the 'nominal' repository path because of symlinks in the server and 
-     * the like.  See also the 'parse_file' routine
+     * the like.  See also the 'parse_rcs_file' routine
      */
     strip_path_len = snprintf(strip_path, PATH_MAX, "%s/%s/", p, repository_path);
 
@@ -1052,9 +1071,8 @@ static void init_paths()
     debug(DEBUG_STATUS, "strip_path: %s", strip_path);
 }
 
-static CvsFile * parse_file(const char * buff)
+static CvsFile * parse_rcs_file(const char * buff)
 {
-    CvsFile * retval;
     char fn[PATH_MAX];
     int len = strlen(buff + 10);
     char * p;
@@ -1129,6 +1147,28 @@ static CvsFile * parse_file(const char *
 
     debug(DEBUG_STATUS, "stripped filename %s", fn);
 
+    return build_file_by_name(fn);
+}
+
+static CvsFile * parse_working_file(const char * buff)
+{
+    char fn[PATH_MAX];
+    int len = strlen(buff + 14);
+
+    /* chop the "LF" */
+    len -= 1;
+    memcpy(fn, buff + 14, len);
+    fn[len] = 0;
+    
+    debug(DEBUG_STATUS, "working filename %s", fn);
+
+    return build_file_by_name(fn);
+}
+
+static CvsFile * build_file_by_name(const char * fn)
+{
+    CvsFile * retval;
+
     retval = (CvsFile*)get_hash_object(file_hash, fn);
 
     if (!retval)
-- 
1.4.0
