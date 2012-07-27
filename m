From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 1/8] Prepare Git::SVN::Log for extraction from git-svn.
Date: Thu, 26 Jul 2012 17:26:00 -0700
Message-ID: <1343348767-86446-2-git-send-email-schwern@pobox.com>
References: <1343348767-86446-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 27 02:26:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuYOG-0004JO-C0
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 02:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab2G0A0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 20:26:41 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41590 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390Ab2G0A0k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 20:26:40 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4044857pbb.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 17:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=kR6Z2tiR0Z+ILVfLI07lHpp75bUs2yYdYTpXr35a2pc=;
        b=t7TSi1pHuiKvZpGn4TK7tlTmeKTAFYcW6WIECjnAUyPU7mMV3H2rSUo7mHwHlfgq1y
         H80qgUhmeCMJIu/k1KudoWHAAM5b5gttl0NxGpSxYvo2lph0TDTRei6K0JkrdLRI0gnE
         ANWKufkrogDfToArU3QXnx3bjEPGGZehw6LwNDlYR61WyTVUgrNzyT9TvbUI8kRpDC4z
         LYiScqxBneL/0YaoRbunOUmfpGY/8aXk1EYkc8wavB3saavEEYS4ITD4RlRoELlbdKEJ
         06DWCeTQ9GmOz4Q/WA1CpiTe2hd40uKCnQg/08/Nrl5NIlxLt7+skKmlccqgj4hIL8D/
         fDyQ==
Received: by 10.68.132.166 with SMTP id ov6mr9461821pbb.24.1343348800392;
        Thu, 26 Jul 2012 17:26:40 -0700 (PDT)
Received: from localhost.localdomain (c-76-105-239-160.hsd1.or.comcast.net. [76.105.239.160])
        by mx.google.com with ESMTPS id jz4sm692556pbc.17.2012.07.26.17.26.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 17:26:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1343348767-86446-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202322>

From: "Michael G. Schwern" <schwern@pobox.com>

* Load Git command functions itself.

* Can't access the git-svn switch lexical any more, but its only used by
  Git::SVN::Log so turn it into a Git::SVN::Log global.

* Load Git::SVN as needed.  No need to load it always, its only used twice.

* Moved a state variable to the routine it's used for. (Drive by refactoring)
---
 git-svn.perl | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ef10f6f..e16475b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -87,7 +87,7 @@ BEGIN {
 	foreach (qw/command command_oneline command_noisy command_output_pipe
 	            command_input_pipe command_close_pipe
 	            command_bidi_pipe command_close_bidi_pipe/) {
-		for my $package ( qw(Git::SVN::Migration Git::SVN::Log),
+		for my $package ( qw(Git::SVN::Migration),
 			__PACKAGE__) {
 			*{"${package}::$_"} = \&{"Git::$_"};
 		}
@@ -106,7 +106,7 @@ my ($_stdin, $_help, $_edit,
 	$_version, $_fetch_all, $_no_rebase, $_fetch_parent,
 	$_merge, $_strategy, $_preserve_merges, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
-	$_git_format, $_commit_url, $_tag, $_merge_info, $_interactive);
+	$_commit_url, $_tag, $_merge_info, $_interactive);
 
 # This is a refactoring artifact so Git::SVN can get at this git-svn switch.
 sub opt_prefix { return $_prefix || '' }
@@ -270,7 +270,7 @@ my %cmd = (
 		    { 'url' => \$_url, } ],
 	'blame' => [ \&Git::SVN::Log::cmd_blame,
 	            "Show what revision and author last modified each line of a file",
-		    { 'git-format' => \$_git_format } ],
+		    { 'git-format' => \$Git::SVN::Log::_git_format } ],
 	'reset' => [ \&cmd_reset,
 		     "Undo fetches back to the specified SVN revision",
 		     { 'revision|r=s' => \$_revision,
@@ -2044,11 +2044,14 @@ package Git::SVN::Log;
 use strict;
 use warnings;
 use Git::SVN::Utils qw(fatal);
+use Git qw(command command_oneline command_output_pipe command_close_pipe);
 use POSIX qw/strftime/;
 use constant commit_log_separator => ('-' x 72) . "\n";
 use vars qw/$TZ $limit $color $pager $non_recursive $verbose $oneline
             %rusers $show_commit $incremental/;
-my $l_fmt;
+
+# Option set in git-svn
+our $_git_format;
 
 sub cmt_showable {
 	my ($c) = @_;
@@ -2094,6 +2097,8 @@ sub git_svn_log_cmd {
 	}
 
 	my ($url, $rev, $uuid, $gs) = ::working_head_info($head);
+
+	require Git::SVN;
 	$gs ||= Git::SVN->_new;
 	my @cmd = (qw/log --abbrev-commit --pretty=raw --default/,
 	           $gs->refname);
@@ -2155,6 +2160,7 @@ sub run_pager {
 
 sub format_svn_date {
 	my $t = shift || time;
+	require Git::SVN;
 	my $gmoff = Git::SVN::get_tz($t);
 	return strftime("%Y-%m-%d %H:%M:%S $gmoff (%a, %d %b %Y)", localtime($t));
 }
@@ -2225,6 +2231,7 @@ sub process_commit {
 	return 1;
 }
 
+my $l_fmt;
 sub show_commit {
 	my $c = shift;
 	if ($oneline) {
-- 
1.7.11.1
