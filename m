From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] rebase: use peel_committish() where appropriate
Date: Sun, 16 Jun 2013 19:52:49 -0700
Message-ID: <7vy5a9ih32.fsf@alter.siamese.dyndns.org>
References: <1371215872-9796-1-git-send-email-artagnon@gmail.com>
	<1371215872-9796-4-git-send-email-artagnon@gmail.com>
	<7vmwqspr52.fsf@alter.siamese.dyndns.org>
	<CALkWK0k5jgafQa6b5=_d2vTT1zzdc4rCgzuoFhOCA1Xtm8v19w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 04:53:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoPZ4-0005N9-IJ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 04:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423Ab3FQCwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 22:52:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48651 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755103Ab3FQCww (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 22:52:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16EE21DDDC;
	Mon, 17 Jun 2013 02:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q0gIP8csNQ2HxAUW/hfEhM61P08=; b=sOhoWr
	M7/reRC7H9WhfCcYC6ZJbP3BtLPRvxt13v3EiLQsHTISqgklj0MrZ9WrpVCa5kt2
	UprWboW79O1k0cDiqi5V8qSXtldZ71wyg9d5ANwsXBL56aEyzPiwmbjteGdRFu8G
	3izqrcl52HVVk0CHKnw0ZvOv5ITVFtDLHMuvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wg4olt8L74u5G0mdheq/XJhF3C+m6Ovb
	PbY34Oo9PxVJFX2GO1IEEMvKTrybOl1Dwwo03TdRPH8Bbz6tzBs72pT/3x4jkEbE
	65evE9E8seepCnYwmsjp72ddRJCcEfCfEdmyrheB/fHfuo6kju5SdnDSTQzaFc/v
	8gGAUX3mPZc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DEE11DDDB;
	Mon, 17 Jun 2013 02:52:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B4151DDD6;
	Mon, 17 Jun 2013 02:52:51 +0000 (UTC)
In-Reply-To: <CALkWK0k5jgafQa6b5=_d2vTT1zzdc4rCgzuoFhOCA1Xtm8v19w@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sat, 15 Jun 2013 19:17:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 003E79DE-D6F9-11E2-BC04-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228034>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> You can also specify the commit at the end of the history to be
>> rebased (very useful while trial runs to see where a series should
>> apply):
>>
>>     git rebase foo ":/Add B"
>>
>> This is already handled properly because it first gets turned into
>> an object name $orig_head and then we use it (without ^0) to update
>> the ORIG_HEAD.
>
> Correct, but what sense does it make unless <branch> is a ref to update?

It often is necessary, after applying a patch series that was
prepared against commit that is unnecessarily new (e.g. a bugfix
that should apply to 'maint' prepared against 'next'), to see if the
result rebases on older codebase.  Giving a commit (not branch) to
the command to force rebasing the commit on a detached HEAD is a
very handy technique to do so without damaging the original branch.

    $ git checkout mater^0
    $ git am -s mbox
    Applying A
    Applying B
    Applying C
    $ git rebase --onto maint master ":/B"

would see if the earlier two commits that are pure bugfix cleanly
applies to 'maint' (and then I can rebuild the topic by forking a
branch from 'maint', queue A and B, and if C is not needed for that
fix, fork another from that point, possibly merge 'master' to it and
then queue C).

>> What would happen when you are given "--onto :/f...o" is somewhat
>> interesting, but that may be a separate topic, I think.  At that
>> point, it is probably in the realm of "don't do it then" ;-)
>
> The utility of this very series can be questioned.  I've rarely wanted
> to use the :/fommery with rebase, so this mostly an exercise in
> "theoretical correctness" (something I usually stay away from).

We are saying the same thing: "don't do it then".
