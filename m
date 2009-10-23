From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: fix fetch where glob is on the top-level URL
Date: Thu, 22 Oct 2009 23:50:56 -0700
Message-ID: <20091023065056.GA25187@dcvr.yhbt.net>
References: <20091021144113.GA7440@cumin> <20091023044843.GA16169@dcvr.yhbt.net> <20091023060751.GA14477@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Brewster <adambrewster@gmail.com>,
	Daniel Cordero <theappleman@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 08:51:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1DzZ-0007KF-MU
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 08:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbZJWGux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 02:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbZJWGux
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 02:50:53 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44879 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941AbZJWGuw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 02:50:52 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 4F93A1F7A1;
	Fri, 23 Oct 2009 06:50:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091023060751.GA14477@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131093>

Eric Wong <normalperson@yhbt.net> wrote:
> Eric Wong <normalperson@yhbt.net> wrote:
> > From 3abaf9fdf216fd0307bb9e9f03772bd80a64177c Mon Sep 17 00:00:00 2001
> > From: Adam Brewster <adambrewster@gmail.com>
> > Date: Thu, 22 Oct 2009 21:26:32 -0700
> > Subject: [PATCH] git svn: fix fetch where glob is on the top-level URL
> 
> Actually, no, something is broken here it seems...  Ugh, falling asleep :x

Oops, I was running the tests from the wrong machine that didn't have
the patch on that one.

As noted in my previous email, the leading slashes cause
SVN::Ra::get_log to fail with an assertion if the path passed to it
has a leading slash but is not a standalone slash.

Here's my original patch which seems to work fine (but doesn't allow the
more flexible, bare "*" in "branches = *:refs/remotes/*" Adam's one did.

>From 42079a567bef745996b6272ad546d682dfcf57d6 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Thu, 22 Oct 2009 23:39:04 -0700
Subject: [PATCH] git svn: fix fetch where glob is on the top-level URL

In cases where the top-level URL we're tracking is the path we
glob against, we can once again track odd repositories that keep
branches/tags at the top level.  This regression was introduced
in commit 6f5748e14cc5bb0a836b649fb8e2d6a5eb166f1d.

Thanks to Daniel Cordero for the original bug report and
bisection.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index eb4b75a..56af221 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1765,7 +1765,7 @@ sub read_all_remotes {
 	my $use_svm_props = eval { command_oneline(qw/config --bool
 	    svn.useSvmProps/) };
 	$use_svm_props = $use_svm_props eq 'true' if $use_svm_props;
-	my $svn_refspec = qr{\s*/?(.*?)\s*:\s*(.+?)\s*};
+	my $svn_refspec = qr{\s*(.*?)\s*:\s*(.+?)\s*};
 	foreach (grep { s/^svn-remote\.// } command(qw/config -l/)) {
 		if (m!^(.+)\.fetch=$svn_refspec$!) {
 			my ($remote, $local_ref, $remote_ref) = ($1, $2, $3);
@@ -1979,7 +1979,7 @@ sub find_ref {
 	my ($ref_id) = @_;
 	foreach (command(qw/config -l/)) {
 		next unless m!^svn-remote\.(.+)\.fetch=
-		              \s*/?(.*?)\s*:\s*(.+?)\s*$!x;
+		              \s*(.*?)\s*:\s*(.+?)\s*$!x;
 		my ($repo_id, $path, $ref) = ($1, $2, $3);
 		if ($ref eq $ref_id) {
 			$path = '' if ($path =~ m#^\./?#);
-- 
Eric Wong
