From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 0/2] Teach rm to better handle submodules
Date: Thu, 05 Jul 2012 21:06:14 +0200
Message-ID: <4FF5E5A6.7000506@web.de>
References: <4FF4AAE7.40604@web.de> <7vpq8brq7y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 21:06:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmrNg-0000Es-Hp
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 21:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870Ab2GETGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 15:06:19 -0400
Received: from mout.web.de ([212.227.17.12]:61176 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628Ab2GETGS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 15:06:18 -0400
Received: from [192.168.178.48] ([91.3.174.47]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MgfBj-1SPywS0jqB-00Nt44; Thu, 05 Jul 2012 21:06:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <7vpq8brq7y.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:voJrW+1jnZm751n2013hzPoL7VL3baZeS1o6NUZZ6+2
 s6cBgfkinbJSewqegNcDIfHy581IFEmajT5o3VTb8pYxWbYBFg
 Y4xCEARLKXLpkiIftXmr1ZB+CfBd6TmjQqFsr1oA1/iSsDTW2P
 ZdTEq9r11Zc12pTVegS3KTuSeCSrfiiQAsMlPzwhRHUzx9Wxqw
 qXICL50nPtTiwi58ZPu+g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201060>

Am 05.07.2012 02:44, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> This is a follow-up to gmane thread 200564 about teaching "git
>> submodule" the "rm" command. It has the intention to only having
>> to add a small amount of new code to the submodule script while
>> handling the heavy lifting in core git.
>>
>> With this series I also intend to make submodule handling a bit
>> easier for users by teaching "git rm" to remove the submodule
>> section from the .gitmodules file, no matter if the submodule is
>> populated or not. Not being able to do that because the section
>> is not found there or the .gitmodules file is already deleted
>> will only issue a warning (with the intent to make the user aware
>> that "git rm" would do that for him in case he did that himself).
> 
> I wouldn't claim that I have thought things through yet, but in
> general my instinct tells me that it is a bad idea to try pushing
> down "submodule management" related bits to the core.

Am I right assuming you are only talking about 2/2 here and not
about the bugfix in 1/2?

> Let me think aloud about removing a directory, in a checkout of a
> superproject, that has a submodule checkout.  There are at least two
> majorly different reasons a user wants to do this:
> 
>  (1) The project used to bind a submodule as a part of the
>      superproject there, but it no longer wants to do so (e.g. we
>      used to ship compiler toolchain as part of our embedded
>      appliance superproject, but from this release on, we expect
>      developers to install the toolchain on their own).  We want to
>      remove the submodule directory, we want to remove the submodule
>      entry in the superproject's tree, and we want to remove the
>      submodule entry from .gitmodules file.
> 
>  (2) One particular project participant has been working on one part
>      of the superproject, say "the documentation submodule", hence
>      "submodule init" was used for that submodule part to populate
>      it.  Since the participant has done with the work, there is no
>      longer need to keep the submodule checkout (submodule uninit?),
>      and getting rid of it makes the working tree leaner and "git
>      pull" faster (as there is no longer need to fetch updated
>      history in the uninteresting submodule).  We just want to
>      remove the contents of the submodule directory.  We do want to
>      keep the index entry for the submodule in the superproject.  We
>      do want to keep the .gitmodules intact.
> 
> This kind (1) of reorganization hopefully is rare (in other words,
> you wouldn't drop a submodule today and turn around to add it again
> tomorrow), done by one person and the result is propagated to all
> other project participants.  On the other hand, (2) can be done by
> any and all participants of the project at any time.
> 
> Which audience should "git rm $path" serve?  My gut feeling is that
> the "project structure change" part that goes beyond the core
> (e.g. what is in ".gitmodules") and should be a rare flag-day event
> deserves a separate command, if only to make the user aware that the
> user is invoking a heavy-weight (from the point-of-view of the
> workflow) operation.

Yes, "git rm" is for case (1) where someone wants to remove a
submodule from the project with the commit he prepares. Case (2)
is not addressed at all by this series (but I like the "uninit"
idea, makes lots of sense to me).

> I am not convinced that "git rm $path" is a good interface for (2),
> though.  For one thing, you would need to keep an empty directory at
> the submodule path for the purpose of (2), so it is not really "rm".

I totally agree here.

> Perhaps "git submodule uninit" might be needed to support (2), in
> addition to "git submodule rm" to support (1).

I think we should, as doing a simple "rm -rf $path" won't do the
job as you already pointed out. First git status will complain
that $path has been deleted, so you'll have to manually recreate
an empty directory there. And then you'll also have to revoke
your interest in having that submodule populated by removing the
submodule.name entry from .git/config, or the next "git submodule
update" will happily re-populate the submodule. All that should
be handled by a "git submodule uninit" (including the tests for
submodule modifications that could be lost). I don't see any
core git command where such a functionality could sanely live.

But that is subject to another patch. Here I wanted to get some
feedback if submodule users would agree with me that a "git rm"
should remove a submodule from index *and* .gitmodules (because
they want to remove it from future versions of the repo, and
then the removal from .gitmodules should happen at the same
point in time, so rm could just do it for you).

I don't have strong feelings about the decision if only the
submodule script should do any modifications to .gitmodules or
if it belongs into git core as part of the rm command, though
for me the latter feels more natural.
