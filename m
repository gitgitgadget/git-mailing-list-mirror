X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: extra error check to ensure we open a file correctly
Date: Fri, 8 Dec 2006 01:55:19 -0800
Message-ID: <20061208095519.GA27272@soma>
References: <863b7wnwcw.fsf@blue.stonehenge.com> <20061204070021.GG1369@localdomain> <86hcwbnb0o.fsf@blue.stonehenge.com> <20061204181241.GA27342@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 09:55:33 +0000 (UTC)
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061204181241.GA27342@soma>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33676>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GscRx-0005Ba-K6 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 10:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425307AbWLHJzW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 04:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425306AbWLHJzW
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 04:55:22 -0500
Received: from hand.yhbt.net ([66.150.188.102]:46996 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1425307AbWLHJzW
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 04:55:22 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 1F3202DC034; Fri,  8 Dec 2006 01:55:20 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri,  8 Dec 2006
 01:55:19 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This may be an issue with repositories imported with commit
27a1a8014b842c0d70fdc91c68dd361ca2dfb34c or later, but before
commit dad73c0bb9f33323ec1aacf560a6263f1d85f81a.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

Eric Wong <normalperson@yhbt.net> wrote:
> "Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> > >>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:
> > 
> > Eric> "Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> > >> 
> > >> Does this ring a bell?
> > 
> > Eric> Nope.
> > 
> > Eric> This is on r15941 of  https://svn.perl.org/parrot/trunk ?  I can't seem
> > Eric> to reproduce this with git svn fetch -r15940:15941
> > 
> > No, and that worked for me as well.  Apparently, I might have corrupted my
> > metadata because I updated git-svn while I was using it.  Is there any way to
> > reset the metadata without having to re-fetch 15000 revisions?

I fear I may have been looking in the wrong place while trying to
diagnose merlyn's problem.  He did mention he was on a flaky connection
and that may have caused the corruption if he had one of those bad
versions.

 git-svn.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 747daf0..ff61b92 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3438,6 +3438,9 @@ sub open_file {
 	my ($self, $path, $pb, $rev) = @_;
 	my ($mode, $blob) = (safe_qx('git-ls-tree',$self->{c},'--',$path)
 	                     =~ /^(\d{6}) blob ([a-f\d]{40})\t/);
+	unless (defined $mode && defined $blob) {
+		die "$path was not found in commit $self->{c} (r$rev)\n";
+	}
 	{ path => $path, mode_a => $mode, mode_b => $mode, blob => $blob,
 	  pool => SVN::Pool->new, action => 'M' };
 }
-- 
1.4.4.1.g9c35e-dirty
