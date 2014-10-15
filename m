From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Wed, 15 Oct 2014 20:57:20 +0200
Message-ID: <543EC390.4000709@web.de>
References: <1413090791-14428-1-git-send-email-max@max630.net> <CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com> <543D58D9.5060606@web.de> <xmqqoatezhnx.fsf@gitster.dls.corp.google.com> <20141014183431.GA8157@wheezy.local> <543D7EBA.4040206@web.de> <20141014221509.GA10580@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Wed Oct 15 20:57:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeTlR-0000Id-FC
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 20:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbaJOS5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 14:57:34 -0400
Received: from mout.web.de ([212.227.15.4]:50560 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbaJOS5d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 14:57:33 -0400
Received: from [192.168.178.41] ([79.211.107.135]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Lwq4m-1YFjLQ0Lm4-016T8v; Wed, 15 Oct 2014 20:57:24
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141014221509.GA10580@wheezy.local>
X-Provags-ID: V03:K0:p2mibICTkmyh1/iU+STq+KV4t4UGcPHaf2NRB2Q9BIl3xHmnQyv
 tSTTmoEkwhnfFaLjtHiCKQAyOgGuVbdqjv+ggnsQby/mmpODWaee6sjRi0UcWCg0rLgca/R
 UakqqUSAkeiNeJjJbsK7zLGg8KP6nVefgvQW9iOvzD4z3yvE1vwx1S7QeccZ2zKl4usCm7i
 FZIqzAaexw5AIz4SYiH+w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.10.2014 um 00:15 schrieb Max Kirillov:
> On Tue, Oct 14, 2014 at 09:51:22PM +0200, Jens Lehmann wrote:
>> Am 14.10.2014 um 20:34 schrieb Max Kirillov:
>>> But here are a lot of nuances. For example, it makes
>>> sense to have a superproject checkout without submodules
>>> being initialized (so that they don't waste space and
>>> machine time for working tree, which often is more than
>>> repository data).
>>
>> Hmm, I'm not sure if this is a problem. If the
>> GIT_COMMON_DIR does have the submodule repo but it isn't
>> initialized locally, we shouldn't have a problem (except
>> for wasting some disk space if not a single checkout-to
>> superproject initializes this submodule).
>
> If initially a repository is clone without submodules, it
> will not have anything in the GIT_COMMON_DIR.

Ok.

>> And if GIT_COMMON_DIR does not have the submodule repo
>> yet, wouldn't it be cloned the moment we init the
>> submodule in the checkout-to? Or would that need extra
>> functionality?
>
> I cannot say I like this. Network operations should be
> caused only by clone and submodules.

Sure (and please add fetch to the list ;-). Maybe I confused
you by saying "init" when I meant the "submodule update" run
after initializing the submodule?

> I think the logic can be simple: it a submodule is not
> checked-out in the repository "checkout --to" is called
> from, then it is not checked-out to the new one also. If it
> is, then checkout calls itself recursively in the submodule
> and works like being run in standalone repository.

But when I later decide to populate the submodule in a
"checkout --to" work tree, should it automagically also
use the central storage, creating the modules/<name>
directory there if it doesn't exist yet? I think that'd
make sense to avoid having the work tree layout depend
on the order commands were ran in. And imagine new
submodules, they should not be handled differently from
those already present.

>>> Then, a checkout copy of a submodule can be standalone
>>> (for example, git and git-html-docs are submodules of
>>> msysgit). Or, it can even belong to some other
>>> superproject. And in that cases they still should be able
>>> to be linked.
>>
>> Maybe such configurations would have to be handled
>> manually to achieve maximum savings. At least I could live
>> with that.
>
> To make manual handling of the cases, and to skip
> checking-out a module.
>
> I would think about the following interface:
>
> $ git checkout --to ... - does not checkout submodules,
> creates empty directory.

This is what checkout should always do (at least until it
learns --recurse-submodules, then it would populate the
submodule directories).

> $ git checkout --recursive --to ... - if a submodule is
> checked-out in source repository, recursed there and run
> "checkout --recursive" again. If a submodule is not
> checked-out, does not checkout it, creates an empty
> directory.

Hmm, I believe that when the user requests recursion
explicitly it should always be checked out, no matter in
what state the GIT_COMMON_DIR is in. Otherwise we'll see
problems when a new submodule shows up and is populated
depending on the point in time the "checkout --to" was
done ... not good.

> By the way, I have found your branch
> recursive_submodule_checkout. Would you like to revive it?
> Then it can be done with the same option.

No need to revive it, I'm currently working on that branch
whenever I find some time (but I'll still need some time
before I can post the next iteration).
