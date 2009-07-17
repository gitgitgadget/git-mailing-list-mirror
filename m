From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv2 2/2] pull: support rebased upstream + fetch + pull 
 --rebase
Date: Fri, 17 Jul 2009 12:13:35 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907171211430.4495@intel-tinevez-2-302>
References: <adf1fd3d0907152329v7f49999u42b0d0fc4d39f5e9@mail.gmail.com>  <1247731921-2290-1-git-send-email-santi@agolina.net>  <alpine.DEB.1.00.0907161035060.3155@pacific.mpi-cbg.de> <adf1fd3d0907160932r313de6e8lec23e4f3409b8c05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1414350704-1247825617=:4495"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jul 17 12:13:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRkRn-0004O6-LE
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 12:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934362AbZGQKNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 06:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934360AbZGQKNk
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 06:13:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:33435 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934348AbZGQKNk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 06:13:40 -0400
Received: (qmail invoked by alias); 17 Jul 2009 10:13:38 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 17 Jul 2009 12:13:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+IqxY3WRqIc+Y8trPS2KyPopi7jFDXCeWtn8johk
	Q58WuJ3RaqYH6m
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <adf1fd3d0907160932r313de6e8lec23e4f3409b8c05@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123459>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1414350704-1247825617=:4495
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 16 Jul 2009, Santi Béjar wrote:

> 2009/7/16 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
> > On Thu, 16 Jul 2009, Santi Béjar wrote:
> >
> >> Use the fork commit of the current branch (where
> >> the tip of upstream branch used to be) as the upstream parameter of
> >> "git rebase". Compute it walking the reflog to find the first commit
> >> which is an ancestor of the current branch.
> >
> > I finally understand what this patch is about.  Thanks.
> 
> Thanks, it was hard (at least for me) to provide a short and good
> commit message.

It is the thing I found quite hard when I started contributing to Git, and 
it is still not exactly easy for me.

> >> diff --git a/git-pull.sh b/git-pull.sh
> >> index 4b78a0c..31d3945 100755
> >> --- a/git-pull.sh
> >> +++ b/git-pull.sh
> >> @@ -125,9 +125,14 @@ test true = "$rebase" && {
> >>       die "refusing to pull with rebase: your working tree is not up-to-date"
> >>
> >>       . git-parse-remote &&
> >> -     reflist="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
> >> -     oldremoteref="$(git rev-parse -q --verify \
> >> -             "$reflist")"
> >> +     remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
> >> +     num=0 &&
> >> +     while oldremoteref="$(git rev-parse -q --verify "$remoteref@{$num}")"
> >> +     do
> >
> > How about
> >
> >        oldremoteref="$(git rev-list --boundary HEAD --not \
> >                        $(git rev-list -g $remoteref | sed 's/$/^@/') |
> >                sed -e '/^[^-]/d' -e q)"
> >
> > Explanation: the "git rev-list -g $remoteref" lists the previous commits
> > the remote ref pointed to, and the ^@ appended to them means all their
> > parents.  Now, the outer rev-list says to take everything in HEAD but
> > _not_ in those parents, showing the boundary commits.  The "sed" call
> > lists the first such boundary commit (which must, by construction, be one
> > of the commits shown by the first rev-list).
> 
> It almost works, thanks. In fact this is how I represent it in my
> head, but I couldn't find a working command (hint, hint, the
> --boundaries trick). Based on yours here it is the one I am using
> right now:
> 
> 	oldremoteref="$(git rev-list --boundary HEAD --not \
> 		$(git rev-list -g $remoteref 2>/dev/null) |
> 		sed -e '/^[^-]/d' -e 's/^-//;q' )"
> 
> i.e. without the ^@ as you want the commits in the reflog as boundary
> commits, and also remove the - in front of the commit.

Thanks for fixing it.  I should have mentioned that I did not test it (and 
usually stuff I do not test has blatant bugs in it, such as was the case 
here).

> Your version performs equally than mine for the normal case but much 
> better if it has to walk many reflog entries. Also mine has the problem, 
> at least currently, that it does not give up as "git rev-parse -q 
> --verify $branch@{n}" does not return an error when n is too large:
> 
>   $ git rev-parse -q --verify origin/next@{18} ; echo $?
> warning: Log for 'origin/next' only has 17 entries.
> 37eb784cfce07ba0048d64e352c5137454396d87
> 0
> 
> even with "-q --verify"!
> 
> So, I'll take yours and will send an updated patch (saying that is is
> based on a command by you). With your Signed-off-by?

Maybe an ACK instead?

Thanks,
Dscho

--8323329-1414350704-1247825617=:4495--
