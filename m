From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Added hook in git-receive-pack
Date: Mon, 1 Aug 2005 01:17:41 +0200
Message-ID: <200508010117.41848.Josef.Weidendorfer@gmx.de>
References: <200507312117.43957.Josef.Weidendorfer@gmx.de> <7v3bpuenpi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 01:19:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzN4i-0004kU-P4
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 01:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVGaXSX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 19:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVGaXST
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 19:18:19 -0400
Received: from pop.gmx.net ([213.165.64.20]:39837 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262057AbVGaXSQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 19:18:16 -0400
Received: (qmail invoked by alias); 31 Jul 2005 23:18:15 -0000
Received: from p5496AE80.dip0.t-ipconnect.de (EHLO linux) [84.150.174.128]
  by mail.gmx.net (mp023) with SMTP; 01 Aug 2005 01:18:15 +0200
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8.2
In-Reply-To: <7v3bpuenpi.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sunday 31 July 2005 22:15, Junio C Hamano wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
> > +It is assured that sha1-old is an ancestor of sha1-new (otherwise,
> > +the update would have not been allowed). refname is relative to
> > +$GIT_DIR; e.g. for the master head this is "refs/heads/master".
>
> I think this description is inaccurate;

Thanks for the constructive comments; that patch was only a draft, and 
tailored for my needs. I thought it would be better to provide a patch than 
requesting for a feature.

I am trying to convert a CVS project with a few developers to GIT; the idea is 
that each developer has his public branch in *the* central repository, and 
(s)he is allowed to merge to master him/herself; when pushing new features 
into the branches or merging to master, there should be send out a mail to a 
mailing list.

> the send-pack can be run 
> with the --force flag and it is my understanding that receiver
> would happily rewind the branch.

I didn't know this...

> One possibility, if we wanted 
> to enforce it on the receiver end,

I actually thought that the ancestor relationship always is given; perhaps we 
don't need to enforce this; but before sending out a mail, the hook script 
probably would like to check if there is any ancestor relationship; this 
would be a potential long lasting task, wouldn't it?

> would be to add another hook 
> that is called before the rename happens and tell the
> receive-pack to refuse that update, but that should be done with
> a separate patch, I suppose.

Sorry, I do not understand this.

> > +Using this hook, it is easy to generate mails on updates to
> > +the local repository. This example script sends a mail with
> > +the commits pushed to the repository:
> > +
> > +       #!/bin/sh
> > +       git-rev-list --pretty "$3" "^$2" |
> > +        mail -r $USER -s "New commits on $1" commit-list@mydomain
>
> What is the environment the hook runs in?  For example, who
> defines $USER used here?

Good question. I thought it is UNIX/POSIX behavior to set this environemt in 
shells (same as "id -u -n"). At least, ssh sets it to "the user logging 
in" (see man ssh).
And I supposed "git-receive-pack" to be called in a users SSH environment.
Hmmm... could this be called via CGI script by a web server?

You are right: we should be careful here. Is there any other hook mechanism in 
GIT at the moment? Originally, I thought this should be a task for a 
porcelain, but this thing is buried too deep in GIT itself...

All the issues about documenting the environment of the hooks, time out 
behavior and so on, are general issues for every kind of hook.

> I am not saying this from the security standpoint (the fact that
> you can invoke receive-pack and that you can write into the
> update hooks means you already have control over that
> repository), but to help hook writers to avoid making mistakes.
> For example, I offhand cannot tell what happens if the hook
> tries to read from its standard input.  Also what happens if the
> hook does not return but sleeps forever in a loop?  Do we want
> to somehow time it out?  I think "It is hooks' responsibility to
> time itself out" is an acceptable answer here, but if that is 
> the case it had better be documented.

I think that a time out is not needed here: as the hook is called synchronous, 
git-receive-pack won't return without until the hook terminated. And that is 
visible to the user, i.e. he would see that there is something wrong.

> I think I've seen this "fork -- exec -- for loop with waitpid"
> pattern repeated number of times in the code.

This is no coincidence ;-) I copied it from inside the same file.
But the behavior is another: If the hook goes wrong, I do not want for 
git-receive-pack to die.

> Would it be 
> feasible to make them into a single library-ish function and
> call it from here and other existing places?

Probably.

> Another thing you may want to consider is to do this hook
> processing before and/or after processing all the refs.  A hook
> might want to know what the entire set of refs are that are
> being updated, and may not have enough information if it is
> invoked once per ref.

Do you have a use case? At least, it would make things more complex.

Josef
