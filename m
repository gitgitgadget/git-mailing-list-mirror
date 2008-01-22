From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Let "git svn" run "git gc --auto" occasionally
Date: Mon, 21 Jan 2008 16:39:11 -0800
Message-ID: <20080122003911.GA16453@hand.yhbt.net>
References: <20080119123557.GA30778@diana.vm.bytemark.co.uk> <20080119223249.8227.31460.stgit@yoghurt> <1200783050.5724.196.camel@brick> <20080120033737.GA7767@soma> <20080120093436.GA10924@diana.vm.bytemark.co.uk> <7vlk6k8fyp.fsf@gitster.siamese.dyndns.org> <20080121224818.GA8872@untitled> <7vr6gawvkt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Harvey Harrison <harvey.harrison@gmail.com>,
	git@vger.kernel.org, Kevin Ballard <kevin@sb.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 01:39:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH7B0-0003zW-Kq
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 01:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864AbYAVAjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 19:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755505AbYAVAjN
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 19:39:13 -0500
Received: from hand.yhbt.net ([66.150.188.102]:51185 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755688AbYAVAjM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 19:39:12 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 200142DC08B;
	Mon, 21 Jan 2008 16:39:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vr6gawvkt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71379>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Here's a conservative change for 1.5.4 (not at all tested):
> >
> > From dbccd8081c6422569a9ca1211e27f56a24fdf3f3 Mon Sep 17 00:00:00 2001
> > From: Eric Wong <normalperson@yhbt.net>
> > Date: Mon, 21 Jan 2008 14:37:41 -0800
> > Subject: [PATCH] git-svn: default to repacking every 1000 commits
> >
> > This should reduce disk space usage when doing large imports.
> > We'll be switching to "gc --auto" post-1.5.4 to handle
> > repacking for us.
> >
> > Signed-off-by: Eric Wong <normalperson@yhbt.net>
> > ---
> >  git-svn.perl |    8 +++-----
> >  1 files changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/git-svn.perl b/git-svn.perl
> > index 9f2b587..12745d5 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -1408,11 +1408,9 @@ sub read_all_remotes {
> >  }
> >  
> >  sub init_vars {
> > -	if (defined $_repack) {
> > -		$_repack = 1000 if ($_repack <= 0);
> > -		$_repack_nr = $_repack;
> > -		$_repack_flags ||= '-d';
> > -	}
> > +	$_repack = 1000 unless (defined $_repack && $_repack > 0);
> > +	$_repack_nr = $_repack;
> > +	$_repack_flags ||= '-d';
> >  }
> >  
> >  sub verify_remotes_sanity {
> 
> Thanks, but I think you need to do something about this part:
> 
> 2154:	if (defined $_repack && (--$_repack_nr == 0)) {
> 
> I'd say 
> 
> 	if ($_repack && (--$_repack_nr == 0)) {

init_vars() is called unconditionally, and always defines $_repack.
It could actually just be:

	if (--$_repack_nr == 0) {

-- 
Eric Wong
