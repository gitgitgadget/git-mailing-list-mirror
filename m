From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH] Teach Girocco to mirror http:// style SVN repos
Date: Mon, 22 Feb 2010 11:50:29 +0300
Organization: St.Petersburg State University
Message-ID: <20100222085029.GA28744@landau.phys.spbu.ru>
References: <20100219132206.GA13734@tugrik.mns.mnsspb.ru> <20100220234200.GS12429@genesis.frugalware.org> <20100221171939.GA10166@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@mns.spb.ru>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Feb 22 10:35:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjU05-0002t4-FI
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 09:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564Ab0BVIuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 03:50:32 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:55976 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab0BVIub (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 03:50:31 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id D79C517B663; Mon, 22 Feb 2010 11:50:29 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <20100221171939.GA10166@landau.phys.spbu.ru>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140651>

On Sun, Feb 21, 2010 at 08:19:39PM +0300, Kirill Smelkov wrote:
> ... I think I've found the problem -- it's that we need to use
> `git config --add` in order to setup multivars. Please find patches below.
> Petr, if everything is ok with them, could you please apply it? Thanks.

And also, while at it, I was always dreaming about http:// style svn
mirroring support at repo.or.cz . Petr, they say dreams always come
true. Could you please apply it?


>From 7cb7218b23c7ab89609a812137e1d621603aabc6 Mon Sep 17 00:00:00 2001
From: Kirill Smelkov <kirr@mns.spb.ru>
Date: Mon, 22 Feb 2010 11:37:35 +0300
Subject: [PATCH] Teach Girocco to mirror http:// style SVN repos

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
1.7.0.50.g50c1
