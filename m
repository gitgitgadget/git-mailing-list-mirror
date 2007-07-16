From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix commiting renames over DAV with funky file names
Date: Sun, 15 Jul 2007 21:53:50 -0700
Message-ID: <20070716045350.GA15307@mayonaise>
References: <46938594.2010607@dawes.za.net> <20070711082000.GA29371@muzzle> <20070712090635.GA18155@mayonaise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 06:54:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAIb5-0004fe-EA
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 06:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbXGPExy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 00:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbXGPExx
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 00:53:53 -0400
Received: from hand.yhbt.net ([66.150.188.102]:42478 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826AbXGPExw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 00:53:52 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id D73492DC08D;
	Sun, 15 Jul 2007 21:53:50 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 15 Jul 2007 21:53:50 -0700
Content-Disposition: inline
In-Reply-To: <20070712090635.GA18155@mayonaise>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52635>

Renaming files with non-URI friendly characters caused
breakage when committing to DAV repositories (over http(s)).

Even if I try leaving out the $self->{url} from the return value
of url_path(), a partial (without host), unescaped path name
does not work.

Filenames for DAV repos need to be URI-encoded before being
passed to the library.  Since this bug did not affect file://
and svn:// repos, the git-svn test library needed to be expanded
to include support for starting Apache with mod_dav_svn enabled.

This new test is not enabled by default, but can be enabled by
setting SVN_HTTPD_PORT to any available TCP/IP port on
127.0.0.1.

Additionally, for running this test, the following variables
(with defaults shown) can be changed for the suitable system.
The default values are set for Debian systems:

  SVN_HTTPD_MODULE_PATH=/usr/lib/apache2/modules
  SVN_HTTPD_PATH=/usr/sbin/apache2

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 Rogan: the patch should help, a single space anywhere in the
 path causes SVN to screw up the file names.  Of course I'm at a
 loss as to why only DAV repositories need it and why the SVN
 libraries don't abstract that away from me.

 git-svn.perl                             |    3 +
 t/lib-git-svn.sh                         |   34 ++++++++++
 t/t9115-git-svn-dcommit-funky-renames.sh |   54 +++++++++++++++
 t/t9115/funky-names.dump                 |  105 ++++++++++++++++++++++++++++++
 4 files changed, 196 insertions(+), 0 deletions(-)
 create mode 100755 t/t9115-git-svn-dcommit-funky-renames.sh
 create mode 100644 t/t9115/funky-names.dump

diff --git a/git-svn.perl b/git-svn.perl
index 299b40f..01c3904 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2724,6 +2724,9 @@ sub repo_path {
 
 sub url_path {
 	my ($self, $path) = @_;
+	if ($self->{url} =~ m#^https?://#) {
+		$path =~ s/([^a-zA-Z0-9_.-])/uc sprintf("%%%02x",ord($1))/eg;
+	}
 	$self->{url} . '/' . $self->repo_path($path);
 }
 
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index f6fe78c..8d4a447 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -48,3 +48,37 @@ svnrepo="file://$svnrepo"
 poke() {
 	test-chmtime +1 "$1"
 }
+
+SVN_HTTPD_MODULE_PATH=${SVN_HTTPD_MODULE_PATH-'/usr/lib/apache2/modules'}
+SVN_HTTPD_PATH=${SVN_HTTPD_PATH-'/usr/sbin/apache2'}
+
+start_httpd () {
+	if test -z "$SVN_HTTPD_PORT"
+	then
+		echo >&2 'SVN_HTTPD_PORT is not defined!'
+		return
+	fi
+
+	mkdir "$GIT_DIR"/logs
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
+	"$SVN_HTTPD_PATH" -f "$GIT_DIR"/httpd.conf -k start
+	svnrepo=http://127.0.0.1:$SVN_HTTPD_PORT/svn
+}
+
+stop_httpd () {
+	test -z "$SVN_HTTPD_PORT" && return
+	"$SVN_HTTPD_PATH" -f "$GIT_DIR"/httpd.conf -k stop
+}
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
new file mode 100755
index 0000000..182299c
--- /dev/null
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -0,0 +1,54 @@
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
+	"
+
+test_expect_success 'init and fetch repository' "
+	git svn init $svnrepo &&
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
+	git svn dcommit
+	'
+
+test_expect_success 'rename pretty file' '
+	echo :x > pretty &&
+	git update-index --add pretty &&
+	git commit -m "pretty :x" &&
+	git svn dcommit &&
+	mkdir regular_dir_name &&
+	git mv pretty regular_dir_name/pretty &&
+	git commit -m "moved pretty file" &&
+	git svn dcommit
+	'
+
+test_expect_success 'rename pretty file into ugly one' '
+	git mv regular_dir_name/pretty "#{bad_directory_name}/ booboo" &&
+	git commit -m booboo &&
+	git svn dcommit
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
1.5.3.rc2.1.g4e223

-- 
Eric Wong
