From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 07 Jan 2014 11:21:28 -0800
Message-ID: <xmqqtxdfd2dj.fsf@gitster.dls.corp.google.com>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
	<d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
	<xmqqlhyrek02.fsf@gitster.dls.corp.google.com>
	<20140107184659.GF11060@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Francesco Pretto <ceztko@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Jan 07 20:21:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0cDZ-0002qu-K2
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 20:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbaAGTVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 14:21:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51748 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbaAGTVd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 14:21:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A018A61C31;
	Tue,  7 Jan 2014 14:21:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VVaPVzn1oOw2KXIMAAjzfDm8liU=; b=BsOlY1
	GIfXMnghPVTpwXNFIJG9mT8OjbK5nSXG0ohghb27muWSSLka2MprPY/ccsMY5+ti
	1Y5G5RLRfR9xqmJ1Mwm82fCGtCd7sMkuyCCNn33H+wF9wno5Iof7sHB/FRRSxZGF
	wkF/0GykQ1vtYkY2kTiBj0Ktb/LCakGlnisCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aFvme+mSdOGDSAYzH1BjDehfh6rbndNe
	Ea3W2w1WIENq57goTZJkQUcN41id5wR032zWDMpL01Z7MhOde0eiJ1D9uJdb1nJ5
	TjOYEiltNgt4OAWnBhQzs8UKH3Lp9xrv8msseRaKH3fYBKNnYd9sIqu8Dp7vl7cW
	hleXloDqGnE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A36261C30;
	Tue,  7 Jan 2014 14:21:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3105961C2F;
	Tue,  7 Jan 2014 14:21:31 -0500 (EST)
In-Reply-To: <20140107184659.GF11060@odin.tremily.us> (W. Trevor King's
	message of "Tue, 7 Jan 2014 10:47:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E9E2AD58-77D0-11E3-BA1A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240131>

"W. Trevor King" <wking@tremily.us> writes:

> On Tue, Jan 07, 2014 at 10:15:25AM -0800, Junio C Hamano wrote:
>>     submodule: respect requested branch on all clones
>> 
>>     The previous code only checked out the requested branch in cmd_add
>>     but not in cmd_update; this left the user on a detached HEAD after
>>     an update initially cloned, and subsequent updates using rebase or
>>     merge mode will kept the HEAD detached, unless the user moved to the
>>     desired branch himself.
>> 
>>     Move the branch-checkout logic into module_clone, where it can be
>>     shared by cmd_add and cmd_update.  Also update the initial checkout
>>     command to use 'rebase' to preserve branches setup during
>>     module_clone.  This way, unless the user explicitly asks to work on
>>     a detached HEAD, subsequent updates all happen on the specified
>>     branch, which matches the end-user expectation much better.
>
> This looks reasonable to me, but there are still changes I'd like to
> make for a v3 (e.g. using submodule.<name>.update to trigger local
> branch checkout).  However, I'm currently leaning towards a new 'git
> submodule checkout' command with explicit preferred local submodule
> branches (see [1]).  Maybe this should all wait until Jens rolls out
> his update implementation [2]?

Sounds good.  I'll backburner this one, then.

>> Having writing all the above and then looking at the patch again, it
>> is not immediately obvious to me where you use "rebase" when doing
>> the initial checkout, though.
>
> It's used to shift the local branch reference from from the
> (arbitrary) cloned remote branch tip to the explicit submodule $sha1.

The objective is not what I was questioning. In the patch I see

	git checkout -f -q -B "$branch" "origin/$branch"

used in the module_clone (which I think makes sense), and then
cmd_update uses "git reset --hard -q" to make sure that the working
tree matches the commit $sha1 obtained from the superproject's
gitlink (which may make $branch diverged from origin/$branch, but
still I think it makes sense).

But there is no 'rebase' I can see in the codepath, which was what I
was puzzled about.
