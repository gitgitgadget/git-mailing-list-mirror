From: Michael G Schwern <schwern@pobox.com>
Subject: Extract Git classes from git-svn (4/10) (was Re: Fix git-svn tests
 for SVN 1.7.5.)
Date: Tue, 17 Jul 2012 16:13:51 -0700
Message-ID: <5005F1AF.1050609@pobox.com>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
 <5005B5EE.3050704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 01:14:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrGxq-0003QH-OW
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 01:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196Ab2GQXNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 19:13:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46809 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021Ab2GQXNx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 19:13:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7400849D;
	Tue, 17 Jul 2012 19:13:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=7daXChPM0H2w
	ZsFjsbPIopL3GAo=; b=QECo4PUOvay+E6wSVXEoRPoq9qV35uOx9wZm5J6DBFNb
	nJj4A9+ngjKAEvIYI1GIPvOoXvOz1wNI7dvotLIrpHnmPi2tIZHkiDT65zCwmS/x
	lRCWw0TomKykkx6Lc8uyPerqf1Q7Gebqh0nSniAPYxJZzw2W2G+OV2fLWYTNWgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QMCajc
	b47cB1E/PNCIZ2BryLQJu2czDFWElAS7MFwcxP+wuXKEC6YK97VmHI7weweoaC0P
	Jb8vRvNEPOcYjb+fW3Rqx6I4gG1ndVZKZsOsvBWPsR/iZ/nWc8ll0zCpdXy7zhel
	nRcPzLamNqlEpRHi1En1cAsfsAmcv2TRpU1Yw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5083849B;
	Tue, 17 Jul 2012 19:13:52 -0400 (EDT)
Received: from windhund.local (unknown [67.23.204.5]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAE53849A; Tue, 17 Jul
 2012 19:13:51 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:13.0)
 Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <5005B5EE.3050704@pobox.com>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 12D66052-D065-11E1-A991-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201629>

>From 8f70be0424a770c299b6a0c5bf99e4030e5e4d92 Mon Sep 17 00:00:00 2001
From: "Michael G. Schwern" <schwern@pobox.com>
Date: Thu, 12 Jul 2012 16:58:53 -0700
Subject: [PATCH 05/11] Make Git::SVN::Log work.

Changes to Git::SVN::Log to make it compile....
* Change the $_git_format lexical only used by Git::SVN::Log into a
Git::SVN::Log global
* Have it load the Git command functions itself
---
 git-svn.perl          |  8 +++++---
 perl/Git/SVN/Log.pm   | 10 +++++++++-
 perl/Makefile         |  1 +
 t/Git-SVN/00compile.t |  4 +++-
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 5e6e3b5..7c8ca49 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -11,6 +11,8 @@ $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '@@GIT_VERSION@@';

 use Git::SVN;
+use Git::SVN::Log;
+
 use Git::SVN::Utils qw(fatal can_compress);

 # From which subdir have we been invoked?
@@ -88,7 +90,7 @@ BEGIN {
 	foreach (qw/command command_oneline command_noisy command_output_pipe
 	            command_input_pipe command_close_pipe
 	            command_bidi_pipe command_close_bidi_pipe/) {
-		for my $package ( qw(Git::SVN::Migration Git::SVN::Log),
+		for my $package ( qw(Git::SVN::Migration),
 			__PACKAGE__) {
 			*{"${package}::$_"} = \&{"Git::$_"};
 		}
@@ -107,7 +109,7 @@ my ($_stdin, $_help, $_edit,
 	$_version, $_fetch_all, $_no_rebase, $_fetch_parent,
 	$_merge, $_strategy, $_preserve_merges, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
-	$_git_format, $_commit_url, $_tag, $_merge_info, $_interactive);
+	$_commit_url, $_tag, $_merge_info, $_interactive);

 # This is a refactoring artifact so Git::SVN can get at this variable.
 sub opt_prefix { return $_prefix || '' }
@@ -271,7 +273,7 @@ my %cmd = (
 		    { 'url' => \$_url, } ],
 	'blame' => [ \&Git::SVN::Log::cmd_blame,
 	            "Show what revision and author last modified each line of a file",
-		    { 'git-format' => \$_git_format } ],
+		    { 'git-format' => \$Git::SVN::Log::_git_format } ],
 	'reset' => [ \&cmd_reset,
 		     "Undo fetches back to the specified SVN revision",
 		     { 'revision|r=s' => \$_revision,
diff --git a/perl/Git/SVN/Log.pm b/perl/Git/SVN/Log.pm
index bbec3b0..7f3cb87 100644
--- a/perl/Git/SVN/Log.pm
+++ b/perl/Git/SVN/Log.pm
@@ -1,12 +1,17 @@
 package Git::SVN::Log;
+
 use strict;
 use warnings;
+
+use Git qw(command command_oneline command_output_pipe command_close_pipe);
 use Git::SVN::Utils qw(fatal);
 use POSIX qw/strftime/;
 use constant commit_log_separator => ('-' x 72) . "\n";
 use vars qw/$TZ $limit $color $pager $non_recursive $verbose $oneline
             %rusers $show_commit $incremental/;
-my $l_fmt;
+
+# Options set in git-svn
+our $_git_format;

 sub cmt_showable {
 	my ($c) = @_;
@@ -52,6 +57,7 @@ sub git_svn_log_cmd {
 	}

 	my ($url, $rev, $uuid, $gs) = ::working_head_info($head);
+	require Git::SVN;
 	$gs ||= Git::SVN->_new;
 	my @cmd = (qw/log --abbrev-commit --pretty=raw --default/,
 	           $gs->refname);
@@ -113,6 +119,7 @@ sub run_pager {

 sub format_svn_date {
 	my $t = shift || time;
+	require Git::SVN;
 	my $gmoff = Git::SVN::get_tz($t);
 	return strftime("%Y-%m-%d %H:%M:%S $gmoff (%a, %d %b %Y)", localtime($t));
 }
@@ -183,6 +190,7 @@ sub process_commit {
 	return 1;
 }

+my $l_fmt;
 sub show_commit {
 	my $c = shift;
 	if ($oneline) {
diff --git a/perl/Makefile b/perl/Makefile
index d0a0c5c..2a4ca57 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -30,6 +30,7 @@ modules += Git/SVN
 modules += Git/SVN/Memoize/YAML
 modules += Git/SVN/Fetcher
 modules += Git/SVN/Editor
+modules += Git/SVN/Log
 modules += Git/SVN/Prompt
 modules += Git/SVN/Ra
 modules += Git/SVN/Utils
diff --git a/t/Git-SVN/00compile.t b/t/Git-SVN/00compile.t
index c32ee4b..37626f4 100644
--- a/t/Git-SVN/00compile.t
+++ b/t/Git-SVN/00compile.t
@@ -3,7 +3,9 @@
 use strict;
 use warnings;

-use Test::More tests => 2;
+use Test::More tests => 4;

 require_ok 'Git::SVN';
 require_ok 'Git::SVN::Utils';
+require_ok 'Git::SVN::Ra';
+require_ok 'Git::SVN::Log';
-- 
1.7.11.1
