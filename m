From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Tue, 14 Oct 2014 21:51:22 +0200
Message-ID: <543D7EBA.4040206@web.de>
References: <1413090791-14428-1-git-send-email-max@max630.net> <CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com> <543D58D9.5060606@web.de> <xmqqoatezhnx.fsf@gitster.dls.corp.google.com> <20141014183431.GA8157@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 21:51:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe88D-0000sM-IH
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 21:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384AbaJNTvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 15:51:33 -0400
Received: from mout.web.de ([212.227.17.11]:53296 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754278AbaJNTvd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 15:51:33 -0400
Received: from [192.168.178.41] ([79.193.79.239]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MXYS2-1XhqxM2xuA-00WThW; Tue, 14 Oct 2014 21:51:26
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141014183431.GA8157@wheezy.local>
X-Provags-ID: V03:K0:+/povHj1sIcU4CqHe+aiq6i2Cf5gbYp1YfGx/hjbZkYQaCYbBHZ
 4ysuuPigEiqvpM0R4KHR5vYHaWCRnWmOEEuKyAS0DbvtF2g6AdUSuyW0tq0DEWV6xgA+Mc3
 lxaIPiDNuyPldkTLOk+5Xns4XL1WMeRhTEn2oJbGI5x9UiAx4AFbxtU2Zh9pgnJtkUujGv9
 s8j4a/ZitLnTg186iB2oA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.10.2014 um 20:34 schrieb Max Kirillov:
> On Tue, Oct 14, 2014 at 10:26:42AM -0700, Junio C Hamano wrote:
>> And multiple-worktree _is_ about keeping the same repository and
>> history data (i.e. object database, refs, rerere database, reflogs for
>> refs/*) only once, while allowing multiple working trees attached to
>> that single copy.
>>
>> So it appears to me that to create a checkout-to copy of a
>> superproject with a submodule, a checkout-to copy of the superproject
>> would have a submodule, which is a checkout-to copy of the submodule
>> in the superproject.
>
> That's right, this linking should be more implicit.

Yep. And for the submodule of a submodule too ... ;-)

> But here are a lot of nuances. For example, it makes sense to have a
> superproject checkout without submodules being initialized (so that they
> don't waste space and machine time for working tree, which often is more
> than repository data).

Hmm, I'm not sure if this is a problem. If the GIT_COMMON_DIR does have
the submodule repo but it isn't initialized locally, we shouldn't have a
problem (except for wasting some disk space if not a single checkout-to
superproject initializes this submodule). And if GIT_COMMON_DIR does not
have the submodule repo yet, wouldn't it be cloned the moment we init
the submodule in the checkout-to? Or would that need extra functionality?

 > And it may happen so that this checkout is the
> master repository for superproject checkouts. But this should not
> prevent users from using initialized submodules in other checkouts.

I could live with the restriction that submodule's GIT_COMMON_DIRs always
live in their checkout-to superproject's GIT_COMMON_DIR. This would still
be an improvement for CI servers that have multiple clones of a super-
project, as they would all share their submodule common dirs at least
per superproject.

> Then, a checkout copy of a submodule can be standalone (for example, git
> and git-html-docs are submodules of msysgit). Or, it can even belong to
> some other superproject. And in that cases they still should be able to
> be linked.

Maybe such configurations would have to be handled manually to achieve
maximum savings. At least I could live with that.

> Considering all above, and also the thing that I am quite new to
> submodules (but have to use them currently), I did not intend to create
> any new UI, only to make backend handle the already existing linked
> checkouts, which can be made manually.

Maybe the way to go is to restrict GIT_COMMON_DIR to superprojects and
have a distinct GIT_COMMON_MODULES_DIR? We could even set that to the
same location for all submodules of different superprojects to achieve
minimum disk footprint (assuming they all have different names across
all superprojects and recursion levels).

Hmm, so I tend towards adding GIT_COMMON_DIR to local_repo_env until
we figured out how to handle this. Without that I fear bad things will
happen, at least for a superproject with multiple checkout-to work trees
where the same submodule is initialized more than once ...
