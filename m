From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCHv2 GSOC 03/11] gitweb: Create Gitweb::Git module
Date: Thu, 15 Jul 2010 12:59:03 +0530
Message-ID: <1279178951-23712-4-git-send-email-pavan.sss1991@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Thu Jul 15 09:29:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZIt3-00035s-Fi
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 09:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525Ab0GOH3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 03:29:32 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49847 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655Ab0GOH3b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 03:29:31 -0400
Received: by pzk26 with SMTP id 26so136519pzk.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 00:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=EfRJUm9DnPiRQGjMHX+71ITe9kAG6p0fRR68LbAgqlA=;
        b=blNoPfTY59NdkyVvDQtE/wJJir29bywxSopft37hIybQft1gfEw3Ba928uRNJ8phNU
         2I8KchPbyrSeF4upGrb5R4yFHOfI+YuHIUpy9c5xmyOsmJgSi7D3OkU0UHBs7GtV65pV
         68oecLe0IOCYa5qFJ4D2AfgG8IxrHb/z6UgMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qXswSW3tdeyphWS2NCrgKkN2R391tSJwG40sfmmFcYouyZK1NrEzA6Ag/pFRQh4oBV
         3R3ZaFf8vT8VT1IAg7I+GoGtp08j4WZj5ihK8+5ls6M28MN7WXjb1ClsRkJpwxvV80rA
         6tRIuHvZNxt7YS7RvoHd/86YTXEYl15fg5aMg=
Received: by 10.142.171.9 with SMTP id t9mr3416905wfe.118.1279178970807;
        Thu, 15 Jul 2010 00:29:30 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id l29sm8484428rvb.7.2010.07.15.00.29.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 00:29:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.455.g8f441
In-Reply-To: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151051>

Create a Gitweb::Git module in  'gitweb/lib/Gitweb/Git.pm'
to deal with running git commands (and also processing output
of git commands with external programs) from gitweb.

This module is intended as standalone module, which does not require
(include) other gitweb' modules to avoid circular dependencies.  That
is why it includes $GIT variable, even though this variable is
configured during building gitweb.  On the other hand $GIT is more
about git configuration, than gitweb configuration.

Subroutines moved:
	evaluate_git_version
	git_cmd
	quote_command

Update gitweb/Makefile to install Gitweb::Git module alongside gitweb

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/Makefile          |    3 ++
 gitweb/gitweb.perl       |   35 ++++----------------------------
 gitweb/lib/Gitweb/Git.pm |   48 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 30 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/Git.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index c7610b3..5035c2e 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -111,6 +111,9 @@ endif
 
 GITWEB_FILES += static/git-logo.png static/git-favicon.png
 
+# Modules: Gitweb::*
+GITWEB_MODULES += lib/Gitweb/Git.pm
+
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bda7da3..778ac13 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -27,11 +27,12 @@ use File::Basename qw(basename);
 
 binmode STDOUT, ':utf8';
 
+use Gitweb::Git;
+
 our $t0;
 if (eval { require Time::HiRes; 1; }) {
 	$t0 = [Time::HiRes::gettimeofday()];
 }
-our $number_of_git_cmds = 0;
 
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
@@ -75,9 +76,8 @@ sub evaluate_uri {
 	our $home_link = $my_uri || "/";
 }
 
-# core git executable to use
-# this can just be "git" if your webserver has a sensible PATH
-our $GIT = "++GIT_BINDIR++/git";
+# $GIT is from Gitweb::Git
+$GIT = "++GIT_BINDIR++/git";
 
 # absolute fs-path which will be prepended to the project path
 #our $projectroot = "/pub/scm";
@@ -482,7 +482,6 @@ sub gitweb_get_feature {
 		$feature{$name}{'override'},
 		@{$feature{$name}{'default'}});
 	# project specific override is possible only if we have project
-	our $git_dir; # global variable, declared later
 	if (!$override || !defined $git_dir) {
 		return @defaults;
 	}
@@ -616,13 +615,6 @@ sub get_loadavg {
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
@@ -972,10 +964,8 @@ sub evaluate_and_validate_params {
 	}
 }
 
-# path to the current git repository
-our $git_dir;
 sub evaluate_git_dir {
-	our $git_dir = "$projectroot/$project" if $project;
+	$git_dir = "$projectroot/$project" if $project;
 }
 
 our (@snapshot_fmts, $git_avatar);
@@ -2230,21 +2220,6 @@ sub get_feed_info {
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
index 0000000..467497c
--- /dev/null
+++ b/gitweb/lib/Gitweb/Git.pm
@@ -0,0 +1,48 @@
+#!/usr/bin/perl
+#
+# Gitweb::Git -- gitweb's package dealing with running git commands
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
1.7.1.455.g8f441
