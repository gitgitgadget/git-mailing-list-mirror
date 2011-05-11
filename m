From: Richard Peterson <richard@rcpeterson.com>
Subject: Re: git rebase --interactive commits order
Date: Wed, 11 May 2011 11:43:28 -0400
Message-ID: <BANLkTikV_TSEE1cgr=EOhuD0f8KP2vh-tA@mail.gmail.com>
References: <BANLkTimX2tupqV464+Re8u06TT+qRmqPuw@mail.gmail.com>
	<BANLkTi=PyBfMxCbWNfJEXEP6-MphdeE+_Q@mail.gmail.com>
	<m2d3jr1mev.fsf@Spindle.sehlabs.com>
	<BANLkTim1e=+yoyxd1AAThVYMZ_X3nfz=7Q@mail.gmail.com>
	<BANLkTinRcigdQv2GJN6L+nF3X2+F-5Lf5w@mail.gmail.com>
	<7vwrhygmrp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 17:43:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKBZd-0001hF-Fe
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 17:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289Ab1EKPne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 11:43:34 -0400
Received: from edgy.cirtexhosting.com ([75.126.140.58]:31002 "EHLO
	edgy.cirtexhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab1EKPnc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 11:43:32 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38598)
	by edgy.cirtexhosting.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.69)
	(envelope-from <richard@rcpeterson.com>)
	id 1QKBZd-0005cS-MW
	for git@vger.kernel.org; Wed, 11 May 2011 11:43:41 -0400
Received: by yxs7 with SMTP id 7so206791yxs.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 08:43:28 -0700 (PDT)
Received: by 10.236.182.105 with SMTP id n69mr5748941yhm.199.1305128608908;
 Wed, 11 May 2011 08:43:28 -0700 (PDT)
Received: by 10.147.98.11 with HTTP; Wed, 11 May 2011 08:43:28 -0700 (PDT)
In-Reply-To: <7vwrhygmrp.fsf@alter.siamese.dyndns.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - edgy.cirtexhosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - rcpeterson.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173393>

On Tue, May 10, 2011 at 7:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Devils lie in the details.  For example, should squash/fixup come before
> or after the squashed commit when --reverse is in effect, and why?
>
> Should "rebase --reverse --continue" work after it gets interrupted, if
> not why not?

Yes, it should work, and in that case, "rebase --continue" should
be synonymous, because you are going to continue the current
rebase operation, however the instructions happened to have
been provided.

>
> After all the insn sheet used by "rebase -i" is not like reading logs at
> all.  It is a specification of the steps in the order they should be
> carried out.  If you are to pick A and then pick B and squash C into the
> result and then reword D on top of the base commit, do you really think it
> is sane to list them like this?
>
>        reword D
>        squash C
>        pick B
>        pick A
>        # you can reorder and update commands above
>        # p is for pick, r is for reword, ...

Yes. It's still an instruction sheet - the only difference is the
order in which the notation should be read.

I may be arguing for something other than what Philippe is
advocating, but here's my take nonetheless.

It's simply a matter of parsing and presentation - not at all a
matter of changing what interactive rebase does.

For instance, I'll paste some output from

$ git log --graph --decorate --oneline --all master..

>From my current project. Then alongside the lines from that log
output, I'll write instructions to a coworker who will do a
rebase.

* 156c6be (HEAD, cor...  # Please fixup into previous
* b82955f Map Networ...
* 1d6708a Add equals...  # Reword (need more info)
* e936162 NPLC objec...
* 7fbb581 Create new...  # Please squash into previous
* 89d57a4 Add a "Tot...  # Please squash into previous
* 24849ef Remove "co...
* 98d0840 Change ref...
* 18886bf Uncomment...
*  4a5844e (master)

This is just annotated log output. In the context of the log, I
can easily imagine the rebase proceeding to rebuild the tree from
the bottom up, and it is clear what I want to happen to each
commit.

I want git to understand this same kind of thing.

I think the problem is that some people are used to seeing the
output of git-log and understanding it as a representation of a
tree. The instruction set of interactive rebase *looks* like such
a tree representation, but it isn't. It's a set of instructions.

However, I think it is valid to want to view it as a sort of
annotated tree. Although it may be interpreted under the hood as
a set of instructions, I believe it is synonymous with the tree
view for any practical purpose. So I'd like to view interactive
rebase much like the output of git-log, only annotated with the
kinds of things that I want done to the tree. That seems to me a
harmless abstraction that would help me do what I mean to do more
often.

So for my purposes, simply reversing the lines before displaying
them, and then again before parsing them would do the
trick. Everything else would remain the same. For
instance "squash" would still mean "squash this commit into the
previous commit", where "previous" does not mean "above", but
really "previous".

--continue would work just the same, since you're not really
telling git to do anything different with --reverse - just telling
it what to do in a superficially different way.

My only concern is that the list of commits would look
essentially the same except for the order. As a small mental aid,
I would suggest adding "(HEAD)", like from --decorate.  This
would help lend some clarity. So:

reword D (HEAD)
squash C
pick B
pick A

Richard Peterson
