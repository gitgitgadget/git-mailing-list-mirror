From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git svn: read global+system config for clone+init
Date: Sat, 14 Nov 2009 14:39:30 -0800
Message-ID: <20091114223930.GA10176@dcvr.yhbt.net>
References: <20091110130913.GR19475@poetic.cynic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Curt Sampson <cjs@cynic.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 23:39:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9RHR-0007TD-4q
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 23:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbZKNWjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 17:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbZKNWjZ
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 17:39:25 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:49765 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463AbZKNWjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 17:39:25 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC16D1F5FC;
	Sat, 14 Nov 2009 22:39:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091110130913.GR19475@poetic.cynic.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132892>

Curt Sampson <cjs@cynic.net> wrote:
> When using "git svn fetch" or "git svn clone", the --authors-file
> command line parameter does what it claims in the docs. Additionally,
> for "git svn fetch", an svn.authorsfile configuration parameter in
> ~/.gitconfig is used, if no command line argument is specified. However,
> svn.authorsfile is ignored by "git svn clone", though the documentation
> claims that clone "runs init and fetch."
> 
> I have confirmed this bug is present in git versions 1.6.0.4 and 1.6.5.1.

Hi Curt,

Thanks for the bug report, the following patch should fix
the bug.  Also pullable from git://git.bogomips.org/git-svn

>From 1a30582b43e137e16b3486d83bb86b0eb090e13d Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Sat, 14 Nov 2009 14:25:11 -0800
Subject: [PATCH] git svn: read global+system config for clone+init

Since $GIT_DIR does not exist when initializing new repositories,
we can follow back to the global and system config files for
git.

The logic for this was originally introduced when
$GIT_DIR/config was the only config file git could read (back
when "git config" was "git repo-config"), so the function is
renamed to "read_git_config" instead of "read_repo_config".

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 27fbe30..ea922ac 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -274,7 +274,7 @@ unless ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
 
 my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
 
-read_repo_config(\%opts);
+read_git_config(\%opts);
 if ($cmd && ($cmd eq 'log' || $cmd eq 'blame')) {
 	Getopt::Long::Configure('pass_through');
 }
@@ -1390,8 +1390,7 @@ sub load_authors {
 }
 
 # convert GetOpt::Long specs for use by git-config
-sub read_repo_config {
-	return unless -d $ENV{GIT_DIR};
+sub read_git_config {
 	my $opts = shift;
 	my @config_only;
 	foreach my $o (keys %$opts) {
-- 
Eric Wong
