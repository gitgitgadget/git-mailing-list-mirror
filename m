From: "Todd T. Fries" <todd@fries.net>
Subject: git on afs
Date: Thu, 18 Oct 2007 15:31:08 -0500
Message-ID: <20071018203106.GA13518@fries.net>
Reply-To: todd@fries.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 22:36:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iic6e-0001Jw-CX
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 22:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757558AbXJRUgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 16:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754900AbXJRUgZ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 16:36:25 -0400
Received: from pf.FreeDaemonHosting.com ([66.210.104.252]:3934 "EHLO
	FreeDaemonHosting.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754775AbXJRUgY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 16:36:24 -0400
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Oct 2007 16:36:24 EDT
Received: from ispdesk.fries.net ([IPv6:2001:240:58a:100::41])
	by FreeDaemonHosting.com (8.13.8/8.13.8) with ESMTP id l9IKV8I2023389
	for <git@vger.kernel.org>; Thu, 18 Oct 2007 15:31:08 -0500 (CDT)
Received: from ispdesk.fries.net (todd@localhost.fries.net [127.0.0.1])
	by ispdesk.fries.net (8.14.1/8.14.1) with ESMTP id l9IKV8k7004344
	for <git@vger.kernel.org>; Thu, 18 Oct 2007 15:31:08 -0500 (CDT)
Received: (from todd@localhost)
	by ispdesk.fries.net (8.14.1/8.14.1/Submit) id l9IKV8xT023676
	for git@vger.kernel.org; Thu, 18 Oct 2007 15:31:08 -0500 (CDT)
X-Authentication-Warning: ispdesk.fries.net: todd set sender to todd@fries.net using -f
Content-Disposition: inline
X-Operating-System: OpenBSD ispdesk.fries.net 4.2 GENERIC
X-PGP-Fingerprint: B6 3B 70 46 BC 0F 8C DD  14 D4 C7 D1 47 F6 23 FA
X-URL: http://todd.fries.net
X-tra-email: todd@{fries.net,OpenBSD.org} toddfries@gmail.com
X-IM: toddfries:AIM 115268457:ICQ todd@fries.net:MSN
X-Jabber: toddfries@gmail.com
User-Agent: Mutt/1.5.16 (2007-06-09)
X-FDH-MailScanner-Information: http://FreeDaemonHosting.com/MailScanner.html
X-FDH-MailScanner: clean
X-FDH-MailScanner-From: todd@fries.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61558>

I have always been frustrated by trying git on afs.

The other day I finally decided to look into why.

Looks like two reasons caused my frustrations.

1) git presumes that link() works fine across subdirs; in afs land,
   hardlinks do not succeed ever

2) git presumes that DTYPE(de) != DT_DIR .. means the dirent is not a dir
   this is not true for afs

I have been using this to sync several git trees, including linux-2.6 for the
past week without issues writing to a local afs server.

What do you guys think?

diff --git a/dir.c b/dir.c
index eb6c3ab..a3e53a5 100644
--- a/dir.c
+++ b/dir.c
@@ -487,9 +487,19 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			    && in_pathspec(fullname, baselen + len, simplify))
 				dir_add_ignored(dir, fullname, baselen + len);
 			if (exclude != dir->show_ignored) {
-				if (!dir->show_ignored || DTYPE(de) != DT_DIR) {
+				if (!dir->show_ignored)
 					continue;
 				}
+				if (DTYPE(de) == DT_UNKNOWN) {
+					struct stat st;
+					if (lstat(fullname, &st))
+						continue;
+					if (!S_ISDIR(st.st_mode))
+						continue;
+				} else {
+					if (DTYPE(de) != DT_DIR)
+						continue;
+				}
 			}
 
 			switch (DTYPE(de)) {
diff --git a/sha1_file.c b/sha1_file.c
index 83a06a7..1b93322 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1961,7 +1961,7 @@ static int link_temp_to_file(const char *tmpfile, const char *filename)
 	int ret;
 	char *dir;
 
-	if (!link(tmpfile, filename))
+	if (!rename(tmpfile, filename))
 		return 0;
 
 	/*
@@ -1980,7 +1980,7 @@ static int link_temp_to_file(const char *tmpfile, const char *filename)
 			return -2;
 		}
 		*dir = '/';
-		if (!link(tmpfile, filename))
+		if (!rename(tmpfile, filename))
 			return 0;
 		ret = errno;
 	}
-- 
Todd Fries .. todd@fries.net

 _____________________________________________
|                                             \  1.636.410.0632 (voice)
| Free Daemon Consulting, LLC                 \  1.405.227.9094 (voice)
| http://FreeDaemonConsulting.com             \  1.866.792.3418 (FAX)
| "..in support of free software solutions."  \          250797 (FWD)
|                                             \
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                                                 
              37E7 D3EB 74D0 8D66 A68D  B866 0326 204E 3F42 004A
                        http://todd.fries.net/pgp.txt
