From: Paul Walmsley <pjwhams@gmail.com>
Subject: [PATCH] git-svn: added an --include-path flag (resent fixing mail format)
Date: Wed, 24 Apr 2013 23:33:10 +0100
Message-ID: <1366842790-18877-1-git-send-email-pjwhams@gmail.com>
References: <20130424212856.GA23696@dcvr.yhbt.net>
Cc: Paul Walmsley <pjwhams@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 00:33:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV8G9-00080J-BB
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 00:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758459Ab3DXWds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 18:33:48 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:39514 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078Ab3DXWdr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 18:33:47 -0400
Received: by mail-we0-f171.google.com with SMTP id t57so127368wey.30
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=zlBaQ6qpq9Cu71s/f7F7pUNPDgaykbhPTDjKRDJ+1dY=;
        b=qG1Ni5qGiuhQFMV0sy45HmkwMuVNBvtW2a8TedAlDZMrksEoQN5eei9ZW15MaAA2ok
         /0ggYKjcui5iEdXg4diMotZX1uyStqdzy7wK1b2lbf5XObbm9VdHVv2KmB9IqcvmEhCt
         XmfcMGpqyhH/7N/QOgGbMT5Doz7mrf+/TJVsezGiZYCrizQyIxg//wP5o2JtaA2JaX/1
         XwCSA/StBwDRQjZQlCdIglZluuVfPCyHVCg8TCy5NFM7IvWxYlfdZi5oe7RTyKBJe6xY
         SpgN9Oex2TCSmnJ/4MpmQYSai9OOjtozdK4bt9ylI36J9SMU0DqCud8huKXM5fJ2AE/j
         6BrQ==
X-Received: by 10.181.12.5 with SMTP id em5mr70281913wid.24.1366842825707;
        Wed, 24 Apr 2013 15:33:45 -0700 (PDT)
Received: from helix.localdomain ([149.241.136.217])
        by mx.google.com with ESMTPSA id ej8sm35110271wib.9.2013.04.24.15.33.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 15:33:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <20130424212856.GA23696@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222332>

The SVN::Fetcher module is now able to filter for inclusion as well
as exclusion (as used by --ignore-path). Also added tests, documentation
changes and git completion script.

If you have an SVN repository with many top level directories and you
only want a git-svn clone of some of them then using --ignore-path is
difficult as it requires a very long regexp. In this case it's much
easier to filter for inclusion.
---
 Documentation/git-svn.txt              |   12 +++
 contrib/completion/git-completion.bash |    2 +-
 git-svn.perl                           |    4 +
 perl/Git/SVN/Fetcher.pm                |   13 ++-
 t/t9147-git-svn-include-paths.sh       |  150 ++++++++++++++++++++++++++++++++
 5 files changed, 179 insertions(+), 2 deletions(-)
 create mode 100755 t/t9147-git-svn-include-paths.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 69decb1..df1f40c 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -85,6 +85,10 @@ COMMANDS
 	When passed to 'init' or 'clone' this regular expression will
 	be preserved as a config key.  See 'fetch' for a description
 	of '--ignore-paths'.
+--include-paths=<regex>;;
+	When passed to 'init' or 'clone' this regular expression will
+	be preserved as a config key.  See 'fetch' for a description
+	of '--include-paths'.
 --no-minimize-url;;
 	When tracking multiple directories (using --stdlayout,
 	--branches, or --tags options), git svn will attempt to connect
@@ -146,6 +150,14 @@ Skip "branches" and "tags" of first level directories;;
 ------------------------------------------------------------------------
 --
 
+--include-paths=<regex>;;
+	This allows one to specify a Perl regular expression that will
+	cause the inclusion of only matching paths from checkout from SVN.
+	The '--include-paths' option should match for every 'fetch'
+	(including automatic fetches due to 'clone', 'dcommit',
+	'rebase', etc) on a given repository. '--ignore-paths' takes 
+	precedence over '--include-paths'.
+
 --log-window-size=<n>;;
     Fetch <n> log entries per request when scanning Subversion history.
     The default is 100. For very large Subversion repositories, larger
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 39c7ff8..8b75d01 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2222,7 +2222,7 @@ _git_svn ()
 			--no-metadata --use-svm-props --use-svnsync-props
 			--log-window-size= --no-checkout --quiet
 			--repack-flags --use-log-author --localtime
-			--ignore-paths= $remote_opts
+			--ignore-paths= --include-paths= $remote_opts
 			"
 		local init_opts="
 			--template= --shared= --trunk= --tags=
diff --git a/git-svn.perl b/git-svn.perl
index bd5266c..6d713e1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -127,6 +127,7 @@ my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
                     'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache,
                     'ignore-paths=s' => \$Git::SVN::Fetcher::_ignore_regex,
+                    'include-paths=s' => \$Git::SVN::Fetcher::_include_regex,
                     'ignore-refs=s' => \$Git::SVN::Ra::_ignore_refs_regex );
 my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'authors-file|A=s' => \$_authors,
@@ -477,6 +478,9 @@ sub do_git_init_db {
 	my $ignore_paths_regex = \$Git::SVN::Fetcher::_ignore_regex;
 	command_noisy('config', "$pfx.ignore-paths", $$ignore_paths_regex)
 		if defined $$ignore_paths_regex;
+	my $include_paths_regex = \$Git::SVN::Fetcher::_include_regex;
+	command_noisy('config', "$pfx.include-paths", $$include_paths_regex)
+		if defined $$include_paths_regex;
 	my $ignore_refs_regex = \$Git::SVN::Ra::_ignore_refs_regex;
 	command_noisy('config', "$pfx.ignore-refs", $$ignore_refs_regex)
 		if defined $$ignore_refs_regex;
diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 046a7a2..27824e7 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -1,5 +1,5 @@
 package Git::SVN::Fetcher;
-use vars qw/@ISA $_ignore_regex $_preserve_empty_dirs $_placeholder_filename
+use vars qw/@ISA $_ignore_regex $_include_regex $_preserve_empty_dirs $_placeholder_filename
             @deleted_gpath %added_placeholder $repo_id/;
 use strict;
 use warnings;
@@ -33,6 +33,10 @@ sub new {
 	my $v = eval { command_oneline('config', '--get', $k) };
 	$self->{ignore_regex} = $v;
 
+	$k = "svn-remote.$repo_id.include-paths";
+	$v = eval { command_oneline('config', '--get', $k) };
+	$self->{include_regex} = $v;
+
 	$k = "svn-remote.$repo_id.preserve-empty-dirs";
 	$v = eval { command_oneline('config', '--get', '--bool', $k) };
 	if ($v && $v eq 'true') {
@@ -117,11 +121,18 @@ sub in_dot_git {
 }
 
 # return value: 0 -- don't ignore, 1 -- ignore
+# This will also check whether the path is explicitly included
 sub is_path_ignored {
 	my ($self, $path) = @_;
 	return 1 if in_dot_git($path);
 	return 1 if defined($self->{ignore_regex}) &&
 	            $path =~ m!$self->{ignore_regex}!;
+	return 0 if defined($self->{include_regex}) &&
+	            $path =~ m!$self->{include_regex}!;
+	return 0 if defined($_include_regex) &&
+	            $path =~ m!$_include_regex!;
+	return 1 if defined($self->{include_regex});
+	return 1 if defined($_include_regex);
 	return 0 unless defined($_ignore_regex);
 	return 1 if $path =~ m!$_ignore_regex!o;
 	return 0;
diff --git a/t/t9147-git-svn-include-paths.sh b/t/t9147-git-svn-include-paths.sh
new file mode 100755
index 0000000..e2e9812
--- /dev/null
+++ b/t/t9147-git-svn-include-paths.sh
@@ -0,0 +1,150 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Vitaly Shukela
+# Copyright (c) 2009 Eric Wong
+#
+
+test_description='git svn property tests'
+. ./lib-git-svn.sh
+
+test_expect_success 'setup test repository' '
+	svn_cmd co "$svnrepo" s &&
+	(
+		cd s &&
+		mkdir qqq www xxx &&
+		echo test_qqq > qqq/test_qqq.txt &&
+		echo test_www > www/test_www.txt &&
+		echo test_xxx > xxx/test_xxx.txt &&
+		svn_cmd add qqq &&
+		svn_cmd add www &&
+		svn_cmd add xxx &&
+		svn_cmd commit -m "create some files" &&
+		svn_cmd up &&
+		echo hi >> www/test_www.txt &&
+		svn_cmd commit -m "modify www/test_www.txt" &&
+		svn_cmd up
+	)
+'
+
+test_expect_success 'clone an SVN repository with filter to include qqq directory' '
+	git svn clone --include-paths="qqq" "$svnrepo" g &&
+	echo test_qqq > expect &&
+	for i in g/*/*.txt; do cat $i >> expect2; done &&
+	test_cmp expect expect2
+'
+
+
+test_expect_success 'init+fetch an SVN repository with included qqq directory' '
+	git svn init "$svnrepo" c &&
+ 	( cd c && git svn fetch --include-paths="qqq" ) &&
+ 	rm expect2 &&
+ 	echo test_qqq > expect &&
+ 	for i in c/*/*.txt; do cat $i >> expect2; done &&
+ 	test_cmp expect expect2
+'
+
+test_expect_success 'verify include-paths config saved by clone' '
+	(
+	    cd g &&
+	    git config --get svn-remote.svn.include-paths | fgrep "qqq"
+	)
+'
+
+test_expect_success 'SVN-side change outside of www' '
+	(
+		cd s &&
+		echo b >> qqq/test_qqq.txt &&
+		svn_cmd commit -m "SVN-side change outside of www" &&
+		svn_cmd up &&
+		svn_cmd log -v | fgrep "SVN-side change outside of www"
+	)
+'
+
+test_expect_success 'update git svn-cloned repo (config include)' '
+	(
+		cd g &&
+		git svn rebase &&
+		printf "test_qqq\nb\n" > expect &&
+		for i in */*.txt; do cat $i >> expect2; done &&
+		test_cmp expect2 expect &&
+		rm expect expect2
+	)
+'
+
+test_expect_success 'update git svn-cloned repo (option include)' '
+	(
+		cd c &&
+		git svn rebase --include-paths="qqq" &&
+		printf "test_qqq\nb\n" > expect &&
+		for i in */*.txt; do cat $i >> expect2; done &&
+		test_cmp expect2 expect &&
+		rm expect expect2
+	)
+'
+
+test_expect_success 'SVN-side change inside of ignored www' '
+	(
+		cd s &&
+		echo zaq >> www/test_www.txt
+		svn_cmd commit -m "SVN-side change inside of www/test_www.txt" &&
+		svn_cmd up &&
+		svn_cmd log -v | fgrep "SVN-side change inside of www/test_www.txt"
+	)
+'
+
+test_expect_success 'update git svn-cloned repo (config include)' '
+	(
+		cd g &&
+		git svn rebase &&
+		printf "test_qqq\nb\n" > expect &&
+		for i in */*.txt; do cat $i >> expect2; done &&
+		test_cmp expect2 expect &&
+		rm expect expect2
+	)
+'
+
+test_expect_success 'update git svn-cloned repo (option include)' '
+	(
+		cd c &&
+		git svn rebase --include-paths="qqq" &&
+		printf "test_qqq\nb\n" > expect &&
+		for i in */*.txt; do cat $i >> expect2; done &&
+		test_cmp expect2 expect &&
+		rm expect expect2
+	)
+'
+
+test_expect_success 'SVN-side change in and out of included qqq' '
+	(
+		cd s &&
+		echo cvf >> www/test_www.txt
+		echo ygg >> qqq/test_qqq.txt
+		svn_cmd commit -m "SVN-side change in and out of ignored www" &&
+		svn_cmd up &&
+		svn_cmd log -v | fgrep "SVN-side change in and out of ignored www"
+	)
+'
+
+test_expect_success 'update git svn-cloned repo again (config include)' '
+	(
+		cd g &&
+		git svn rebase &&
+		printf "test_qqq\nb\nygg\n" > expect &&
+		for i in */*.txt; do cat $i >> expect2; done &&
+		test_cmp expect2 expect &&
+		rm expect expect2
+	)
+'
+
+test_expect_success 'update git svn-cloned repo again (option include)' '
+	(
+		cd c &&
+		git svn rebase --include-paths="qqq" &&
+		printf "test_qqq\nb\nygg\n" > expect &&
+		for i in */*.txt; do cat $i >> expect2; done &&
+		test_cmp expect2 expect &&
+		rm expect expect2
+	)
+'
+
+test_done
-- 
1.7.10.4
