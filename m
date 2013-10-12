From: arnaud.brejeon@gmail.com
Subject: [PATCH 1/2] Add password parameter to git svn commands and use it when provided instead of defaulting to end-user prompt
Date: Sat, 12 Oct 2013 11:23:29 +0200
Message-ID: <1381569810-2167-1-git-send-email-arnaud.brejeon@gmail.com>
Cc: arnaudbrejeon <arnaud.brejeon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 11:23:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUvQK-0006oO-5Z
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 11:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480Ab3JLJXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 05:23:43 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:50488 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720Ab3JLJXm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 05:23:42 -0400
Received: by mail-wi0-f177.google.com with SMTP id hq4so184570wib.16
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 02:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rE8B1O36gSTYJrdufvzQ+y533Uy0M08OojzaeWCsLOw=;
        b=fh823CRcAwB/gs13H3ypMLmCG23L3Gi222Bmke0v2GSrl99zTyMo/GBGs9NOiBltRn
         93e8VHpWYvKBjRoOUaVOo1TfnpsVL2Ne+Gggl36RxgZBWS98UuI7K73Lps+Me0o1zQ5+
         cxSM4cC6i0lG2oInrF8oU8Ar9krFHaCGtJWGvaUzT6NMfgkJHx25kthnB5Vb8fokRurC
         9iZpuu2QPDOft8iS+Eam6bC2YfUfe5zNFtVDWuhnsr3FB/qxMwfurhH9WaD8PPKgrCXd
         6pgwJZQBaLVMydv8Il2rOTEdb0fpMGfQHYDv46MxO1+lcmMFDUJmclZzz9LbN+F8rO12
         rPjQ==
X-Received: by 10.180.73.134 with SMTP id l6mr6749535wiv.16.1381569820890;
        Sat, 12 Oct 2013 02:23:40 -0700 (PDT)
Received: from localhost.localdomain (APuteaux-552-1-53-143.w90-35.abo.wanadoo.fr. [90.35.84.143])
        by mx.google.com with ESMTPSA id ma3sm13466473wic.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 02:23:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2 (Apple Git-33)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236044>

From: arnaudbrejeon <arnaud.brejeon@gmail.com>

Signed-off-by: Arnaud Brejeon <arnaud.brejeon <at> gmail.com>
---
 git-svn.perl           |    3 +++
 perl/Git/SVN/Prompt.pm |   12 +++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ff1ce3d..07f0a6c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -123,6 +123,7 @@ sub opt_prefix { return $_prefix || '' }
 $Git::SVN::Fetcher::_placeholder_filename = ".gitignore";
 $_q ||= 0;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
+                    'password=s' => \$Git::SVN::Prompt::_password,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
                     'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache,
                     'ignore-paths=s' => \$Git::SVN::Fetcher::_ignore_regex,
@@ -206,6 +207,7 @@ my %cmd = (
 	              'parents' => \$_parents,
 	              'tag|t' => \$_tag,
 	              'username=s' => \$Git::SVN::Prompt::_username,
+	              'password=s' => \$Git::SVN::Prompt::_password,
 	              'commit-url=s' => \$_commit_url } ],
 	tag => [ sub { $_tag = 1; cmd_branch(@_) },
 	         'Create a tag in the SVN repository',
@@ -214,6 +216,7 @@ my %cmd = (
 	           'dry-run|n' => \$_dry_run,
 	           'parents' => \$_parents,
 	           'username=s' => \$Git::SVN::Prompt::_username,
+	           'password=s' => \$Git::SVN::Prompt::_password,
 	           'commit-url=s' => \$_commit_url } ],
 	'set-tree' => [ \&cmd_set_tree,
 	                "Set an SVN repository to a git tree-ish",
diff --git a/perl/Git/SVN/Prompt.pm b/perl/Git/SVN/Prompt.pm
index e940b08..a94a847 100644
--- a/perl/Git/SVN/Prompt.pm
+++ b/perl/Git/SVN/Prompt.pm
@@ -2,7 +2,7 @@ package Git::SVN::Prompt;
 use strict;
 use warnings;
 require SVN::Core;
-use vars qw/$_no_auth_cache $_username/;
+use vars qw/$_no_auth_cache $_username $_password/;
 
 sub simple {
 	my ($cred, $realm, $default_username, $may_save, $pool) = @_;
@@ -17,8 +17,14 @@ sub simple {
 	} else {
 		username($cred, $realm, $may_save, $pool);
 	}
-	$cred->password(_read_password("Password for '" .
-	                               $cred->username . "': ", $realm));
+
+	if (defined $_password && length $_password) {
+		$cred->password($_password);
+	} else {
+		$cred->password(_read_password("Password for '" .
+		                               $cred->username . "': ", $realm));
+	}
+
 	$cred->may_save($may_save);
 	$SVN::_Core::SVN_NO_ERROR;
 }
-- 
1.7.10.2 (Apple Git-33)
