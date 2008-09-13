From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation: new upstream rebase recovery section
 in git-rebase
Date: Fri, 12 Sep 2008 22:08:46 -0700
Message-ID: <7v8wtwk4yp.fsf@gitster.siamese.dyndns.org>
References: <200809030738.09589.trast@student.ethz.ch>
 <1221147525-5589-1-git-send-email-trast@student.ethz.ch>
 <1221147525-5589-2-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Sep 13 07:10:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeNOU-0005jI-VI
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 07:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbYIMFIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 01:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbYIMFIy
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 01:08:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbYIMFIx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 01:08:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9E27F602FA;
	Sat, 13 Sep 2008 01:08:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 866A5602F7; Sat, 13 Sep 2008 01:08:49 -0400 (EDT)
In-Reply-To: <1221147525-5589-2-git-send-email-trast@student.ethz.ch> (Thomas
 Rast's message of "Thu, 11 Sep 2008 17:38:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0EC93E6E-8152-11DD-9439-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95792>

Thomas Rast <trast@student.ethz.ch> writes:

> +RECOVERING FROM UPSTREAM REBASE
> +-------------------------------
> +
> +This section briefly explains the problems that arise from rebasing or
> +rewriting published branches, and shows how to recover.

The largest issue of "The problem" is that the person who rebases causes
this problem to others, _forcing_ his downstream to recover.  This intro
needs to make it clear the distinction between the person who rebases, who
suffers is forced to recover as the consequence.

> +    o---o---o---o---o  master
> +         \
> +          o---o---o---o---o  subsystem
> +                           \
> +                            *---*---*  topic
>...
> +If 'subsystem' is rebased against master, the following happens:
>...
> +    o---o---o---o---o  master
> +        |            \
> +        |             o'--o'--o'--o'--o'  subsystem
> +        \
> +         o---o---o---o---o---*---*---*  topic

Make the original upstream a bit longer in the "after" picture, explaining
that "your upstream subsystem rebased on top of its own upstream after it
gets updated", so that the part that are unchanged in two pictures are not
drawn differently like you did above.

In other words, draw it like this.  It is much easier to see what's
changed and what's unchanged, if the part that hasn't changed stayed
unchanged in the picture:

       o---o---o---o---o  master
            \
             o---o---o---o---o  subsystem
                              \
                               *---*---*  topic


       o---o---o---o---o---o---o---o  master
            \                       \ 
             o---o---o---o---o       o'--o'--o'--o'--o' subsystem
                              \
                               *---*---*  topic

> +Note that while we have marked your own commits with a '*', there is
> +nothing that distinguishes them from the commits that previously were
> +on 'subsystem'.  Luckily, 'git-rebase' knows to skip commits that are
> +textually the same as commits in the upstream.  So if you say
> +(assuming you're on 'topic')

There is no luck involved in "git rebase" knowing how to do this -- this
is by design.

But more importantly, at this point, there is a break in the flow of
thought in this section.  Step back and read what you wrote, pretending as
if you are reading the section for the first time, and notice:

 * The readers were shown how the topology before and after the
   subsystem's rebase looked like;

 * The readers haven't been told what you are trying teach them now.  Yes,
   I know that you are going to tell them how to transplant their own
   commits on top of updated subsystem, but they don't know that yet;

 * Some of the readers may not even understand why it is a bad idea to
   keep building on top of the old subsystem without rebasing on top of
   the rebased subsystem at this point.

Only when the readers know that the objective is to transplant these three
top commits, they would start appreciating the difficulty (i.e. you cannot
tell the commits apart by looking at the topology alone) of rebase the
reader has to do, and the smart (i.e. if you are lucky, the rebase your
upstream did may have been a simple one) git-rebase uses to help them.

It would suffice to insert something like this before "Note that...".

        To continue working from here, you need to transplant your own
        commits (marked as '*') on top of the "subsystem", which is now
        rebased.

But see footnote below.

> +This becomes a ripple effect to anyone downstream of the first rebase:
> +anyone downstream from 'topic' now needs to rebase too, and so on.

This calls for a stronger wording than "needs to", perhaps "forced to".

> +Things get more complicated if your upstream used `git rebase
> +--interactive` (or `commit --amend` or `reset --hard HEAD^`).

I do not think this section is absolutely necessary.  The upstream may
have done a simple rebase, which may have conflicted with the changes in
its own upstream.

> +To fix this, you have to manually transplant your own part of the
> +history to the new branch head.  Looking at `git log`, you should be
> +able to determine that three commits on 'topic' are yours.  Again
> +assuming you are already on 'topic', you can do
> +------------
> +    git rebase --onto subsystem HEAD~3
> +------------
> +to put things right.

HEAD~3 would _work_, but it often is easier to visualize this (perhaps in
your head, or in "gitk HEAD origin origin@{1}"):

       o---o---o---o---o---o---o---o  master
            \                       \ 
             o---o---o---o---o       o'--o'--o'--o'--o' subsystem
                              \
                               *---*---*  topic

and say:

    $ git rebase --onto subsystem subsystem@{1}

The reflog reference "1" may be larger depending on the number of times
you fetched from them without rebasing, though.


[Footnote]

You did not cover why midstream rebase _forces_ downstream to rebase.  If
the leaf-level person did not know better, or did not care, starting from
this topology:

       o---o---o---o---o---o---o---o  master
            \                       \ 
             o---o---o---o---o       o'--o'--o'--o'--o' subsystem
                              \
                               *---*---*  topic

the leaf person can keep building on top of the old topic, and later when
the topic is mature, have subsystem merge the result.  If the rebase the
subsystem did was simple enough, the merge will be easy to resolve (both
sides modifying the same way).

       o---o---o---o---o---o---o---o  master
            \                       \ 
             o---o---o---o---o       o'--o'--o'--o'--o'--M subsystem
                              \                         /
                               *---*---*---*---*---*---*

The problem is that the resulting history will keep two copies of the
morally equivalent commits from the subsystem.  You know that, and I know
that, but the purpose of the document is to explain it to people who do
not know it yet.
