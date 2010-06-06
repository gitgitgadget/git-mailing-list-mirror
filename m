From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH/RFC] gitweb: Create Gitweb::Git module
Date: Mon,  7 Jun 2010 02:54:11 +0530
Message-ID: <1275859451-21787-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Sun Jun 06 23:24:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLNKc-0008EE-A0
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 23:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650Ab0FFVYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 17:24:25 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:54998 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab0FFVYY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 17:24:24 -0400
Received: by pxi8 with SMTP id 8so886519pxi.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 14:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=4hhhp4c93oagDh7s7SaeeQazSFWM6LwwbNEHaCq1ZZY=;
        b=GSbTvKmAd8MProPhwYViNFtNTF6QZF3vWqGvkD9aLl+WDhzCyXcDVEA5QAw5EKFsKe
         VA0xCRPz6oG9sj1S66ZKuloiHUF6cC6tcV9ULn880/dseYG5sUgHmmTlLoUygYC1IfFO
         q6rEJoSWZPkVgMFBek5ZVf2r/LkCkqyl1euTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JxLWg1/M5rHBVMS3TC9buLosgawTr2Aze00U6kJ2YDO2xVhxPHugfhg9pcdjcuu9fd
         PGT+1JaMbBoxly+KsefUO6C7u6POcp5Ocb0EczdX0sismEmkRiS00ynxAt1tjc87Evu3
         ya0et9RiFkWVzTO8N5LWS+hh/0ImBKsxbvG3U=
Received: by 10.114.54.28 with SMTP id c28mr10891346waa.169.1275859463394;
        Sun, 06 Jun 2010 14:24:23 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id a23sm32273801wam.2.2010.06.06.14.24.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jun 2010 14:24:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.450.g21d56
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148544>

Create a Gitweb::Git module in 'gitweb/lib/Gitweb/Git.pm'
to store essential git variables and subs regarding the
gitweb.perl script

Subroutines moved:
	evaluate_git_version
	git_cmd
	quote_command

Subroutines yet to move: (Contains not yet packaged subs & vars)
	None

Update gitweb/Makefile to install gitweb modules alongside gitweb

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/Makefile          |    1 +
 gitweb/gitweb.perl       |   35 +++-----------------------------
 gitweb/lib/Gitweb/Git.pm |   48 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 31 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/Git.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 4343396..fcd4042 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -115,6 +115,7 @@ GITWEB_FILES += static/git-logo.png static/git-favicon.png
 GITWEB_LIB_GITWEB += lib/Gitweb/Config.pm
 GITWEB_LIB_GITWEB += lib/Gitweb/Request.pm
 GITWEB_LIB_GITWEB += lib/Gitweb/Escape.pm
+GITWEB_LIB_GITWEB += lib/Gitweb/Git.pm
 
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e95aaf7..59a65a8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -24,12 +24,11 @@ sub __DIR__ () {
 }
 use lib __DIR__ . "/lib";
 
+use Gitweb::Git;
 use Gitweb::Config;
 use Gitweb::Request;
 use Gitweb::Escape;
 
-our $number_of_git_cmds = 0;
-
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
 }
@@ -39,9 +38,8 @@ BEGIN {
 # with their descriptions is listed in Gitweb::Config.
 $version = "++GIT_VERSION++";
 
-# core git executable to use
-# this can just be "git" if your webserver has a sensible PATH
-our $GIT = "++GIT_BINDIR++/git";
+#only this variable has it's root in Gitweb::Git
+$GIT = "++GIT_BINDIR++/git";
 
 $projectroot = "++GITWEB_PROJECTROOT++";
 $project_maxdepth = "++GITWEB_PROJECT_MAXDEPTH++";
@@ -77,7 +75,6 @@ sub gitweb_get_feature {
 		$feature{$name}{'override'},
 		@{$feature{$name}{'default'}});
 	# project specific override is possible only if we have project
-	our $git_dir; # global variable, declared later
 	if (!$override || !defined $git_dir) {
 		return @defaults;
 	}
@@ -197,13 +194,6 @@ sub get_loadavg {
 	return 0;
 }
 
-# version of the core git binary
-our $git_version;
-sub evaluate_git_version {
-	our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
-	$number_of_git_cmds++;
-}
-
 sub check_loadavg {
 	if (defined $maxload && get_loadavg() > $maxload) {
 		die_error(503, "The load average on the server is too high");
@@ -492,10 +482,8 @@ sub evaluate_and_validate_params {
 	}
 }
 
-# path to the current git repository
-our $git_dir;
 sub evaluate_git_dir {
-	our $git_dir = "$projectroot/$project" if $project;
+	$git_dir = "$projectroot/$project" if $project;
 }
 
 our (@snapshot_fmts, $git_avatar);
@@ -1548,21 +1536,6 @@ sub get_feed_info {
 ## ----------------------------------------------------------------------
 ## git utility subroutines, invoking git commands
 
-# returns path to the core git executable and the --git-dir parameter as list
-sub git_cmd {
-	$number_of_git_cmds++;
-	return $GIT, '--git-dir='.$git_dir;
-}
-
-# quote the given arguments for passing them to the shell
-# quote_command("command", "arg 1", "arg with ' and ! characters")
-# => "'command' 'arg 1' 'arg with '\'' and '\!' characters'"
-# Try to avoid using this function wherever possible.
-sub quote_command {
-	return join(' ',
-		map { my $a = $_; $a =~ s/(['!])/'\\$1'/g; "'$a'" } @_ );
-}
-
 # get HEAD ref of given project as hash
 sub git_get_head_hash {
 	return git_get_full_hash(shift, 'HEAD');
diff --git a/gitweb/lib/Gitweb/Git.pm b/gitweb/lib/Gitweb/Git.pm
new file mode 100644
index 0000000..9961e6d
--- /dev/null
+++ b/gitweb/lib/Gitweb/Git.pm
@@ -0,0 +1,48 @@
+#!/usr/bin/perl
+#
+# Gitweb::Git -- gitweb git package
+#
+# This program is licensed under the GPLv2
+
+package Gitweb::Git;
+
+use strict;
+use warnings;
+use Exporter qw(import);
+
+our @EXPORT = qw($GIT $number_of_git_cmds $git_version $git_dir
+                 git_cmd quote_command evaluate_git_version);
+
+# core git executable to use
+# this can just be "git" if your webserver has a sensible PATH
+our $GIT;
+
+our $number_of_git_cmds = 0;
+
+# version of the core git binary
+our $git_version;
+
+# path to the current git repository
+our $git_dir;
+
+# returns path to the core git executable and the --git-dir parameter as list
+sub git_cmd {
+	$number_of_git_cmds++;
+	return $GIT, '--git-dir='.$git_dir;
+}
+
+# quote the given arguments for passing them to the shell
+# quote_command("command", "arg 1", "arg with ' and ! characters")
+# => "'command' 'arg 1' 'arg with '\'' and '\!' characters'"
+# Try to avoid using this function wherever possible.
+sub quote_command {
+	return join(' ',
+		map { my $a = $_; $a =~ s/(['!])/'\\$1'/g; "'$a'" } @_ );
+}
+
+sub evaluate_git_version {
+	$git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
+	$number_of_git_cmds++;
+}
+
+1;
-- 
1.7.1.450.g21d56
