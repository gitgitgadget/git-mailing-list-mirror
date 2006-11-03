X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git bug? + question
Date: Thu, 02 Nov 2006 18:40:30 -0800
Message-ID: <7v4pthmew1.fsf@assigned-by-dhcp.cox.net>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 02:59:30 +0000 (UTC)
Cc: git@vger.kernel.org,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30773>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfp0A-0003wO-8R for gcvg-git@gmane.org; Fri, 03 Nov
 2006 03:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752973AbWKCCkd convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006 21:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752971AbWKCCkd
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 21:40:33 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:28320 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1752969AbWKCCkb
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006
 21:40:31 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103024031.BUCT2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Thu, 2
 Nov 2006 21:40:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id i2g91V00f1kojtg0000000 Thu, 02 Nov 2006
 21:40:10 -0500
To: Miles Bader <miles@gnu.org>
Sender: git-owner@vger.kernel.org

Miles Bader <miles.bader@necel.com> writes:

> Also, a question:  Is there anyway to make git-clone use
> --use-separate-remote by default?  I'm trying for a "lots of branches=
 in
> a single shared remote repository" style, and use-separate-remote see=
ms
> more sane for this usage.

This was suggested last week on the list, and I think it is a
sensible thing to do.

Karl Hasselstr=F6m <kha@treskal.com> writes:

> On 2006-10-26 10:11:50 -0700, Linus Torvalds wrote:
>
>> But it's a good rule in general, just because it makes a certain
>> common workflow explicit. In fact, we really probably should start
>> to always use the "refs/remote/origin/HEAD" kind of syntax by
>> default, where you can't even _switch_ to the branch maintained in
>> the remote repository, because it's not a real branch locally.
>
> Seconded. I really like having remote branches in their own namespace
> where I can't confuse them with my local branches by mistake -- and
> that the branches of different remotes end up in different separate
> namespaces.
>
>> So normally you should consider the "origin" branch to be a pointer
>> to WHAT YOU FETCHED LAST - and that implies that you shouldn't
>> commit to it, because then it loses that meaning (now it's "what you
>> fetched last and then committed your own work on top of", which is
>> something totally different).
>
> Defaulting to --use-separate-remotes would mean not having to explain
> this to every single confused new user. :-)

The only downside that I can think of is that it affects me or
anybody who works on more than one machine on multiple branches
slightly negatively.

I know I keep "master" checked out on my secondary machines when
I am done working there, so the mapping origin:master,
maint:maint, next:next, and +pu:pu I get by default has been
easy for me to work on.  With the current layout, updating and
building four variants can be done with:

	git pull
        for b in master maint next pu
        do
        	git checkout $b && make || break
	done

which is efficient (guaranteed to do only one fetch from remote)
and convenient.  Also I have Push: mapping set up on my
main machine to do master:origin, next:next, maint:maint, and
+pu:pu so that I can replace the first "git pull" on the
secondary machine with "git push secondary" on my main machine.

With separate remotes, I'd need something like:

	for b in master maint next pu
        do
        	git checkout $b && git pull && make || break
	done

And I also would need to have per-branch configuration to merge
from ". remotes/origin/$b" without re-fetching while on a
non-master branch $b, for the above to work.  I still need to
remember to process "master" first, so all things considered,
this is a regression in usability for my workflow.

But that is probably a minor inconvenience to a minority.  Most
of the world follow others' repositories that have a single
primary head, and defaulting to use separate-remote would help
them a lot.

So I am in favor of the change, but this is not something we can
do in a flag-day fashion.  We would probably need updating the
tutorial and the documentation first.




