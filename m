X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/3] git-svn: correctly handle packed-refs in refs/remotes/
Date: Tue, 12 Dec 2006 18:26:00 -0800
Message-ID: <20061213022600.GB18036@localdomain>
References: <11659636223725-git-send-email-normalperson@yhbt.net> <11659636263755-git-send-email-normalperson@yhbt.net> <20061213004500.GA17811@localdomain> <7vlklcmvoo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 02:26:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vlklcmvoo.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34178>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuJp4-00081R-Li for gcvg-git@gmane.org; Wed, 13 Dec
 2006 03:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964898AbWLMC0M (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 21:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWLMC0M
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 21:26:12 -0500
Received: from hand.yhbt.net ([66.150.188.102]:54684 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S964898AbWLMC0L
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 21:26:11 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 873A47DC02A; Tue, 12 Dec 2006 18:26:09 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 12 Dec 2006
 18:26:00 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > We now use git-rev-parse universally to read refs, instead
> > of our own file_to_s function (which I plan on removing).
> >
> > Signed-off-by: Eric Wong <normalperson@yhbt.net>
> > ---
> >  git-svn.perl |   10 +++++++++-
> >  1 files changed, 9 insertions(+), 1 deletions(-)
> >
> > diff --git a/git-svn.perl b/git-svn.perl
> > index 1f8a3b0..aac8f73 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -2016,9 +2016,17 @@ sub git_commit {
> >  
> >  	# just in case we clobber the existing ref, we still want that ref
> >  	# as our parent:
> > -	if (my $cur = eval { file_to_s("$GIT_DIR/refs/remotes/$GIT_SVN") }) {
> > +	open my $null, '>', '/dev/null' or croak $!;
> > +	open my $stderr, '>&', \*STDERR or croak $!;
> > +	open STDERR, '>&', $null or croak $!;
> > +	if (my $cur = eval { safe_qx('git-rev-parse',
> > +	                             "refs/remotes/$GIT_SVN^0") }) {
> > +		chomp $cur;
> >  		push @tmp_parents, $cur;
> >  	}
> > +	open STDERR, '>&', $stderr or croak $!;
> > +	close $stderr or croak $!;
> > +	close $null or croak $!;
> >  
> >  	if (exists $tree_map{$tree}) {
> >  		foreach my $p (@{$tree_map{$tree}}) {
> 
> It's a neat trick you do to stash away STDERR and redirect to
> /dev/null ;-).  It might be worth doing something like this:

I also did it for libsvn_get_file() with STDOUT :)

> 	sub without_stderr {
>         	my ($cmd, @param) = @_;
>                 # stash away magic
>                 my @return = eval {
>                 	safe_qx($cmd, @param);
>                 };
>                 # restore magic
>                 return @return;
> 	}
> 
> in Git.pm?

Looking at Git.pm for the first time, it seems that _command_common_pipe
(and all it's users) already support closing/redirecting STDERR.

I'll look into revamping git-svn to use Git.pm sometime tonight or
tomorrow.

-- 
