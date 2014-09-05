From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCHv3 1/4] am: avoid re-directing stdin twice
Date: Fri, 05 Sep 2014 15:00:43 -0700
Message-ID: <xmqqoautpw1g.fsf@gitster.dls.corp.google.com>
References: <1409911611-20370-1-git-send-email-judge.packham@gmail.com>
	<1409911611-20370-2-git-send-email-judge.packham@gmail.com>
	<540A1C7B.80109@kdbg.org>
	<CAFOYHZBct1CRA+NumVMvbbuELWTRoGL5FkhBfHD2Wk7QZVe1fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, GIT <git@vger.kernel.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 00:01:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ1Yv-000052-FZ
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 00:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbaIEWAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 18:00:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52176 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbaIEWAq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 18:00:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 09CA836627;
	Fri,  5 Sep 2014 18:00:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DcG2UwSVs/sY++3/F7T8XMzdwfY=; b=c59GHF
	o6U+KOJh0h6qNl2Q4yglVnRAcb0Iupl/hpVOrtNWs7kPLa3dFQceaW9TtRz0D5k8
	rwu4HpuumwTgWaseMsmLjpv+20OIvi617yv1QgL9LZSMGfg+QmEvcZRVQIWIIML3
	vU+R4QwAC13jiKalhRV5Rb/NYPdaJ7egWk/LU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WXQqITlHuGaECvxUjnQQ2Gyq+GiWAKYA
	Rerzi9UhpYcV2wfiSamICvxFbb66eFdfFpAHUJCB7fJWzFiZW+vZRVu0lkPPLyJh
	jQJJnoZV+pfdxzKxSoWf6QlsJOPzjQ9MbHTrv6e9MV1niKYS8Pl4R4f1LBXqhItt
	rJePPlbZ8c0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F258236626;
	Fri,  5 Sep 2014 18:00:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6267136621;
	Fri,  5 Sep 2014 18:00:45 -0400 (EDT)
In-Reply-To: <CAFOYHZBct1CRA+NumVMvbbuELWTRoGL5FkhBfHD2Wk7QZVe1fA@mail.gmail.com>
	(Chris Packham's message of "Sat, 6 Sep 2014 09:31:06 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 16300696-3548-11E4-907B-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256544>

Chris Packham <judge.packham@gmail.com> writes:

> On Sat, Sep 6, 2014 at 8:26 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 05.09.2014 12:06, schrieb Chris Packham:
>>> In check_patch_format we feed $1 to a block that attempts to determine
>>> the patch format. Since we've already redirected $1 to stdin there is no
>>> need to redirect it again when we invoke tr. This prevents the following
>>> errors when invoking git am
>>>
>>>   $ git am patch.patch
>>>   tr: write error: Broken pipe
>>>   tr: write error
>>>   Patch format detection failed.
>>> ...
>>
>> I wonder why tr (assuming it is *this* instance of tr) dies with a write
>> error instead of from a SIGPIPE. Is SIGPIPE ignored somewhere and then
>> the tr invocation inherits this "ignore SIGPIPE" setting?
>> ...
> Perhaps putting the tr outside the whole block would be a better solution?

Perhaps fixing the root cause of your (but not other people's) "tr"
failing is the right solution, no?

Also,

>>> -                     tr -d '\015' <"$1" |
>>>                       sed -n -e '/^$/q' -e '/^[       ]/d' -e p |
>>>                       sane_egrep -v '^[!-9;-~]+:' >/dev/null ||
>>>                       patch_format=mbox

as the tr is at an upsteam of this pipeline, it does not really
matter to the outcome if it gives a write-error error message or not
(the downstream sane_egrep would have decided, based on the data it
was given, if the payload was mbox format), so...

An easier workaround may be to update the sed script downstream of
tr.  It stops reading as soon as it finished to save cycles, and tr
should know that it does not have to produce any more output.  For a
broken tr installation, the sed script could be taught to slurp
everything in the message body (without passing it to downstream
sane_egrep, of course), and your "tr" would not see a broken pipe.

But that is still a workaround, not a fix, and an expensive one at
that.
