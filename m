From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git svn: always reuse existing remotes on fetch
Date: Sun, 22 Nov 2009 15:39:54 -0800
Message-ID: <20091122233954.GA23448@dcvr.yhbt.net>
References: <20091117025945.GE17964@onerussian.com> <4B03B7D3.8050905@drmicha.warpmail.net> <20091118133205.GB17964@onerussian.com> <4B03FD29.3090001@drmicha.warpmail.net> <20091118142332.GC17964@onerussian.com> <4B040D95.9040901@drmicha.warpmail.net> <20091119095307.GA30423@dcvr.yhbt.net> <20091120204723.GB30423@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 00:40:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCM2I-0007yy-Tm
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 00:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861AbZKVXjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 18:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755742AbZKVXjs
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 18:39:48 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:39732 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755767AbZKVXjr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 18:39:47 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CCD71F605;
	Sun, 22 Nov 2009 23:39:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091120204723.GB30423@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133464>

Eric Wong <normalperson@yhbt.net> wrote:
> so there's apparently a bug in our handling of
> svn-remote != "svn" somewhere...

>From 4d0157d6995925ea55ff181ea94d058583333f90 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Sun, 22 Nov 2009 12:37:06 -0800
Subject: [PATCH] git svn: always reuse existing remotes on fetch

The internal no_reuse_existing flag is set to allow initializing
multiple remotes with the same URL, common with SVM users.

Unfortunately, this flag caused misbehavior when used
with the -R command-line flag for fetching.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 2746895..7f7a56f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -428,6 +428,7 @@ sub cmd_fetch {
 	if (@_ > 1) {
 		die "Usage: $0 fetch [--all] [--parent] [svn-remote]\n";
 	}
+	$Git::SVN::no_reuse_existing = undef;
 	if ($_fetch_parent) {
 		my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
 		unless ($gs) {
@@ -956,6 +957,7 @@ sub cmd_multi_init {
 }
 
 sub cmd_multi_fetch {
+	$Git::SVN::no_reuse_existing = undef;
 	my $remotes = Git::SVN::read_all_remotes();
 	foreach my $repo_id (sort keys %$remotes) {
 		if ($remotes->{$repo_id}->{url}) {
-- 
Eric Wong
