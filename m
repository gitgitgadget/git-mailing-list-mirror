From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [bug][bisected] git-svn with root branches
Date: Thu, 22 Oct 2009 11:55:33 -0700
Message-ID: <20091022185533.GA11771@dcvr.yhbt.net>
References: <20091021144113.GA7440@cumin> <20091022063036.GA8081@dcvr.yhbt.net> <c376da900910220824g2948dc2sa1156bda59b49405@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Cordero <theappleman@gmail.com>, git@vger.kernel.org
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 20:55:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N12p2-00015a-Er
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 20:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756793AbZJVSza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 14:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756785AbZJVSza
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 14:55:30 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49567 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756784AbZJVSz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 14:55:29 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 11B8C1F9B3;
	Thu, 22 Oct 2009 18:55:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <c376da900910220824g2948dc2sa1156bda59b49405@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131040>

Adam Brewster <adambrewster@gmail.com> wrote:
> > > The offending config is:
> > > [svn-remote "svn"]
> > >         url = http://svn.collab.net/repos/svn
> > >         branches = /*:refs/remotes/*
> > >
> >
> > Reverting the left hand side of these two regexps from Adam's commit
> > seems to fix the problem.
> >
> > diff --git a/git-svn.perl b/git-svn.perl
> > index eb4b75a..56af221 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -1765,7 +1765,7 @@ sub read_all_remotes {
> >        my $use_svm_props = eval { command_oneline(qw/config --bool
> >            svn.useSvmProps/) };
> >        $use_svm_props = $use_svm_props eq 'true' if $use_svm_props;
> > -       my $svn_refspec = qr{\s*/?(.*?)\s*:\s*(.+?)\s*};
> > +       my $svn_refspec = qr{\s*(.*?)\s*:\s*(.+?)\s*};
> >        foreach (grep { s/^svn-remote\.// } command(qw/config -l/)) {
> >                if (m!^(.+)\.fetch=$svn_refspec$!) {
> >                        my ($remote, $local_ref, $remote_ref) = ($1, $2,
> > $3);
> > @@ -1979,7 +1979,7 @@ sub find_ref {
> >        my ($ref_id) = @_;
> >        foreach (command(qw/config -l/)) {
> >                next unless m!^svn-remote\.(.+)\.fetch=
> > -                             \s*/?(.*?)\s*:\s*(.+?)\s*$!x;
> > +                             \s*(.*?)\s*:\s*(.+?)\s*$!x;
> >                my ($repo_id, $path, $ref) = ($1, $2, $3);
> >                if ($ref eq $ref_id) {
> >                        $path = '' if ($path =~ m#^\./?#);
> > ---
> >
> > I'm not sure why Adam decided the leading slash needed to be removed for
> > the git refspec.  That said, the globbing/branching code still makes me
> > want to hide under a rock and I'm generally afraid to touch it.
> > I'll wait for Adam to chime in since he's braver than I am :)
> >
> >
> How's this for brave:  I'm not sure why I did that either.
> 
> Looking at it again it seems correct for the leading / to be ignored because
> it has no meaning.  What's the difference between the above config and
> "branches = *:refs/remotes/*" (besides the fact that one works and one
> doesn't)?  In both cases I think I've asked for all of the top-level
> directories to be branches.  But that has nothing to do with the rest of the
> patch, so it shouldn't have been included.
>
> Given all of that I would be more inclined to fix this with something like
> the following:
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index eb4b75a..cd8a93b 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1768,7 +1768,7 @@ sub read_all_remotes {
>      my $svn_refspec = qr{\s*/?(.*?)\s*:\s*(.+?)\s*};
>      foreach (grep { s/^svn-remote\.// } command(qw/config -l/)) {
>          if (m!^(.+)\.fetch=$svn_refspec$!) {
> -            my ($remote, $local_ref, $remote_ref) = ($1, $2, $3);
> +            my ($remote, $local_ref, $remote_ref) = ($1, "/$2", $3);
>              die("svn-remote.$remote: remote ref '$remote_ref' "
>                  . "must start with 'refs/'\n")
>                  unless $remote_ref =~ m{^refs/};
> @@ -1780,7 +1780,7 @@ sub read_all_remotes {
>              $r->{$1}->{url} = $2;
>          } elsif (m!^(.+)\.(branches|tags)=$svn_refspec$!) {
>              my ($remote, $t, $local_ref, $remote_ref) =
> -                                                 ($1, $2, $3, $4);
> +                                                 ($1, $2, "/$3", $4);
>              die("svn-remote.$remote: remote ref '$remote_ref' ($t) "
>                  . "must start with 'refs/'\n")
>                  unless $remote_ref =~ m{^refs/};
> @@ -1980,7 +1980,7 @@ sub find_ref {
>      foreach (command(qw/config -l/)) {
>          next unless m!^svn-remote\.(.+)\.fetch=
>                        \s*/?(.*?)\s*:\s*(.+?)\s*$!x;
> -        my ($repo_id, $path, $ref) = ($1, $2, $3);
> +        my ($repo_id, $path, $ref) = ($1, "/$2", $3);
>          if ($ref eq $ref_id) {
>              $path = '' if ($path =~ m#^\./?#);
>              return ($repo_id, $path);
> -- 
> 1.6.5.1.63.ga9d7.dirty
> 
> That is, continue disregard the / on the actual input because it means
> nothing, and add a / in places where the code will crash if it's not there.
> Even better would be to find out _why_ $path and $local_ref need a leading /
> and fix it that way, but that's more work that I don't have time for right
> now.

Thanks for the feedback Adam,

Yeah, I'm confused by that myself :x  /me kicks himself again

> On the other hand it doesn't really matter because git svn init won't accept
> -b '' (to create the configuration I proposed above), so I have no practical
> objection to Eric's solution.

Meanwhile, your patch looks good to me.  Let me know if you want write
a commit message for it or if you want me to do it.

I actually tried editing my $GIT_CONFIG in $EDITOR to have a bare '*' as
the ref glob:

	[svn-remote "svn"]
		url = http://svn.collab.net/repos/svn
		branches = *:refs/remotes/*

Since I've tried it, I suspect others may try editing $GIT_CONFIG in the
same way as well.

-- 
Eric Wong
