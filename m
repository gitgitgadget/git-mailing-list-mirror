From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 3/3] Teach Girocco to mirror http:// style SVN repos
Date: Mon, 22 Mar 2010 14:08:01 +0300
Message-ID: <b7d25a4325c26bed2351257521878109b71ad771.1269255835.git.kirr@mns.spb.ru>
References: <20100222085029.GA28744@landau.phys.spbu.ru>
Cc: Miklos Vajna <vmiklos@frugalware.org>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org, Kirill Smelkov <kirr@landau.phys.spbu.ru>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Mar 22 12:13:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtfZb-0008AN-KM
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 12:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891Ab0CVLNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 07:13:13 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:39986 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753656Ab0CVLNL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 07:13:11 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1NtfZE-0000iA-Qp; Mon, 22 Mar 2010 14:13:08 +0300
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1NtfVC-0002uZ-SV; Mon, 22 Mar 2010 14:08:58 +0300
X-Mailer: git-send-email 1.7.0.2.284.gafe27d
In-Reply-To: <20100222085029.GA28744@landau.phys.spbu.ru>
In-Reply-To: <cover.1269255835.git.kirr@mns.spb.ru>
References: <cover.1269255835.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142920>

From: Kirill Smelkov <kirr@landau.phys.spbu.ru>

Currently we can mirror svn:// repos, but http:// is assumed to be used
for Git. Teach the tool to use svn+http:// style urls for http:// svn
repositories.

This is very needed, because most SVN hosting services only provide
http:// style access to their services. e.g. google code, python.org,
etc...

This has not been tested on full Girocco installation - just partly. But
if it works, let's also add svn+https later.
---
 Girocco/Util.pm |    2 +-
 jobd/update.sh  |    2 +-
 taskd/clone.sh  |    6 ++++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Girocco/Util.pm b/Girocco/Util.pm
index e2f7854..969cb3c 100644
--- a/Girocco/Util.pm
+++ b/Girocco/Util.pm
@@ -111,7 +111,7 @@ sub valid_web_url {
 }
 sub valid_repo_url {
 	$_ = $_[0];
-	/^(http|git|svn|darcs|bzr):\/\/[a-zA-Z0-9-.:]+(\/[_\%a-zA-Z0-9.\/~-]*)?$/;
+	/^(http|git|svn(\+http)?|darcs|bzr):\/\/[a-zA-Z0-9-.:]+(\/[_\%a-zA-Z0-9.\/~-]*)?$/;
 }
 
 
diff --git a/jobd/update.sh b/jobd/update.sh
index e09ef95..65e0455 100755
--- a/jobd/update.sh
+++ b/jobd/update.sh
@@ -38,7 +38,7 @@ mail="$(config_get owner)"
 bang git for-each-ref --format '%(refname)	%(objectname)' >.refs-before
 
 case "$url" in
-	svn://*)
+	svn://* | svn+http://*)
 		GIT_DIR=. bang git svn fetch
 		GIT_DIR=. bang git fetch
 		;;
diff --git a/taskd/clone.sh b/taskd/clone.sh
index cfcb3b1..e634388 100755
--- a/taskd/clone.sh
+++ b/taskd/clone.sh
@@ -22,8 +22,10 @@ mail="$(config_get owner)"
 # Initial mirror
 echo "Initiating mirroring..."
 case "$url" in
-	svn://*)
-		GIT_DIR=. git svn init -s "$url"
+	svn://* | svn+http://*)
+		# we just remote svn+ here, so svn+http://... becomes http://...
+		svnurl="${url#svn+}"
+		GIT_DIR=. git svn init -s "$svnurl"
 		GIT_DIR=. git svn fetch
 		# Neat Trick suggested by Miklos Vajna
 		GIT_DIR=. git config remote.origin.url .
-- 
1.7.0.2.284.gafe27d
