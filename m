From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and renames
Date: Thu, 12 Jul 2007 02:06:35 -0700
Message-ID: <20070712090635.GA18155@mayonaise>
References: <46938594.2010607@dawes.za.net> <20070711082000.GA29371@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 11:06:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8udH-0001WH-S9
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 11:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbXGLJGi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 05:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753105AbXGLJGi
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 05:06:38 -0400
Received: from hand.yhbt.net ([66.150.188.102]:40578 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155AbXGLJGh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 05:06:37 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 8B1022DC032;
	Thu, 12 Jul 2007 02:06:35 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 12 Jul 2007 02:06:35 -0700
Content-Disposition: inline
In-Reply-To: <20070711082000.GA29371@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52260>

Eric Wong <normalperson@yhbt.net> wrote:
> Rogan Dawes <lists@dawes.za.net> wrote:
> > Hi folks,
> > 
> > I am trying to push my local changes to an imported SVN project back to 
> > the SVN repo. For anyone who cares, this is the WebGoat repository which 
> > you can find at http://dawes.za.net/rogan/webgoat/webgoat.git/
> > 
> > I am trying to push it back to the primary GoogleCode repo. I have 
> > successfully managed to push 20 or so commits, but I am now running up 
> > against a problem with a renamed/moved file.
> > 
> > I moved a file from a directory to a subdirectory, and made minimal 
> > changes to this file so that it remained a valid Java class. i.e. I 
> > changed the package, and a few other minor things. As can be seen at 
> > <http://dawes.za.net/gitweb.cgi?p=rogan/webgoat/webgoat.git;a=commitdiff;h=486416188a3e49d60e1510166ac197e5e66cc4d2>, 
> >  git detects the rename with 93% similarity.
> > 
> > However, when I try to push this change to the Google repo, git-svn dies 
> > with the following error:
> > 
> > $ git svn dcommit
> > RA layer request failed: PROPFIND request failed on '/svn/trunk/ 
> > webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/DefaultLessonAction.java': 
> > PROPFIND of '/svn/trunk/ 
> > webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/DefaultLessonAction.java': 
> > 400 Bad Request (https://webgoat.googlecode.com) at 
> > /home/rdawes/bin/git-svn line 400
> > 
> > [Yes, those paths have a space in them, however this does not seem to 
> > have prevented me from committing the previous 20 or so changes.]
> > 
> > I noted the following in the git-svn documentation, with regards to 
> > handling renames. However, I am not renaming a directory, only a couple 
> > of files.
> 
> I've personally noted a rename issue with committing funky characters
> "#{}" in filenames (I was renaming to get rid of those funky characters of
> course).   Haven't had proper time to look into it.
> 
> Did any previous successful commits have renames in them?  You may want
> to set similarity to 100% to disable rename detection.

SVN over HTTP is most definitely behaves differently from svn:// and
file:// wrt strange file names.  I'll see if I can work on this again in
day or two, or if anybody wants to pick up where I left off, my
work-in-progress test case is below (it's currently failing, of course).

I'll have to look into how (if) svk handles it and also at the svn
command-line client.  I'm fairly sure the command-line svn client
handles it somehow...

Right now I'm getting sleepy, my vision is blurring and I'm seeing
"SVN" as "S/M" through my tired eyes...

>From 4c0165488390ad0cafb3eea700d8c873576131c2 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Thu, 12 Jul 2007 01:48:14 -0700
Subject: [PATCH] git-svn: WIP test for commiting renames over DAV with funky file names

---
 t/lib-git-svn.sh                         |   26 +++++++
 t/t9115-git-svn-dcommit-funky-renames.sh |   37 +++++++++++
 t/t9115/funky-names.dump                 |  105 ++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+), 0 deletions(-)
 create mode 100755 t/t9115-git-svn-dcommit-funky-renames.sh
 create mode 100644 t/t9115/funky-names.dump

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index f6fe78c..60b26d4 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -48,3 +48,29 @@ svnrepo="file://$svnrepo"
 poke() {
 	test-chmtime +1 "$1"
 }
+
+SVN_HTTPD_MODULE_PATH=/usr/lib/apache2/modules
+SVN_HTTPD_PATH=/usr/sbin/apache2
+SVN_HTTPD_PORT=3443
+start_httpd () {
+mkdir $GIT_DIR/logs
+
+	cat > "$GIT_DIR/httpd.conf" <<EOF
+ServerName "git-svn test"
+ServerRoot "$GIT_DIR"
+DocumentRoot "$GIT_DIR"
+PidFile "$GIT_DIR/httpd.pid"
+Listen 127.0.0.1:$SVN_HTTPD_PORT
+LoadModule dav_module $SVN_HTTPD_MODULE_PATH/mod_dav.so
+LoadModule dav_svn_module $SVN_HTTPD_MODULE_PATH/mod_dav_svn.so
+<Location /svn>
+	DAV svn
+	SVNPath $rawsvnrepo
+</Location>
+EOF
+	$SVN_HTTPD_PATH -f $GIT_DIR/httpd.conf -k start
+}
+
+stop_httpd () {
+	$SVN_HTTPD_PATH -f $GIT_DIR/httpd.conf -k stop
+}
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
new file mode 100755
index 0000000..b451ca2
--- /dev/null
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Eric Wong
+
+
+test_description='git-svn dcommit can commit renames of files with ugly names'
+
+. ./lib-git-svn.sh
+
+test_expect_success 'load repository with strange names' "
+	svnadmin load -q $rawsvnrepo < ../t9115/funky-names.dump &&
+	start_httpd
+"
+
+test_expect_success 'init and fetch repository' "
+	git svn init http://127.0.0.1:$SVN_HTTPD_PORT/svn &&
+	git svn fetch &&
+	git reset --hard git-svn
+	"
+
+test_expect_success 'create file in existing ugly and empty dir' '
+	mkdir "#{bad_directory_name}" &&
+	echo hi > "#{bad_directory_name}/ foo" &&
+	git update-index --add "#{bad_directory_name}/ foo" &&
+	git commit -m "new file in ugly parent" &&
+	git svn dcommit
+	'
+
+test_expect_success 'rename ugly file' '
+	git mv "#{bad_directory_name}/ foo" "file name with feces" &&
+	git commit -m "rename ugly file" &&
+	git svn dcommit --rmdir
+	'
+
+stop_httpd
+
+test_done
diff --git a/t/t9115/funky-names.dump b/t/t9115/funky-names.dump
new file mode 100644
index 0000000..da0440a
--- /dev/null
+++ b/t/t9115/funky-names.dump
@@ -0,0 +1,105 @@
+SVN-fs-dump-format-version: 2
+
+UUID: 819c44fe-2bcc-4066-88e4-985e2bc0b418
+
+Revision-number: 0
+Prop-content-length: 56
+Content-length: 56
+
+K 8
+svn:date
+V 27
+2007-07-12T07:54:26.062914Z
+PROPS-END
+
+Revision-number: 1
+Prop-content-length: 152
+Content-length: 152
+
+K 7
+svn:log
+V 44
+what will those wacky people think of next?
+
+K 10
+svn:author
+V 12
+normalperson
+K 8
+svn:date
+V 27
+2007-07-12T08:00:05.011573Z
+PROPS-END
+
+Node-path:  leading space
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Node-path:  leading space file
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 5
+Text-content-md5: e4fa20c67542cdc21271e08d329397ab
+Content-length: 15
+
+PROPS-END
+ugly
+
+
+Node-path: #{bad_directory_name}
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Node-path: #{cool_name}
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 18
+Text-content-md5: 87dac40ca337dfa3dcc8911388c3ddda
+Content-length: 28
+
+PROPS-END
+strange name here
+
+
+Node-path: dir name with spaces
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Node-path: file name with spaces
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 7
+Text-content-md5: c1f10cfd640618484a2a475c11410fd3
+Content-length: 17
+
+PROPS-END
+spaces
+
+
+Node-path: regular_dir_name
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
-- 
Eric Wong
