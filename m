From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] merge-base: "--reflog" mode finds fork point from reflog entries
Date: Thu, 24 Oct 2013 15:13:24 -0700
Message-ID: <xmqqwql2l3ln.fsf@gitster.dls.corp.google.com>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
	<1382641884-14756-1-git-send-email-gitster@pobox.com>
	<1382641884-14756-3-git-send-email-gitster@pobox.com>
	<CAPig+cQrBMMqSmOk0GSZJ9PTHNt-t+vuOG2Aq=7VTR1EZSeLsw@mail.gmail.com>
	<xmqq61smmkc0.fsf@gitster.dls.corp.google.com>
	<CAPig+cQ2tWFXX-RYnUrHEZCaqaPV6ZwgoPfiNPv9P1jFNTGEYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 00:13:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZT9p-0002x7-44
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 00:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844Ab3JXWN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 18:13:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553Ab3JXWN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 18:13:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F57E4D9EF;
	Thu, 24 Oct 2013 22:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZHlx7JF2Co7y9fTte+sGGy4R78Q=; b=JCEnMX
	xKeGb7GiO2aYKuHwsi/s6MltGUMDK52mKzLABwnWYQtNLm/vA6xpFhIiNBDebvbA
	oYgAElaqLDqgxRGA6Ruy+8Hkzg8NLVCDppPUJVEL16HlIP22r/5IaTL91jXPj6Vc
	22L80Hqp0X+Y4g49wS0EuxRhMm7rPXqwGtWwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GBRslKQTFCUN/353TVfwIUmqnqYYyB77
	ymvSLTs+T+UMh1GQ2dBrj2TE1CtKb5x2BMNDPzG3M3gMNXAsLXt5LM4nHSMJeDGB
	rvMQMy73LKigzox9XHM25G/3imyFUO7Hlht5iHG4VWtngbKuv99QDUj52u/yDV5L
	ERL65860dmA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 903164D9ED;
	Thu, 24 Oct 2013 22:13:27 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDA3E4D9E8;
	Thu, 24 Oct 2013 22:13:26 +0000 (UTC)
In-Reply-To: <CAPig+cQ2tWFXX-RYnUrHEZCaqaPV6ZwgoPfiNPv9P1jFNTGEYg@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 24 Oct 2013 17:43:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8181F74E-3CF9-11E3-A21C-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236633>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Oct 24, 2013 at 5:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> On Thu, Oct 24, 2013 at 3:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
>>>> index f80bba8..3a1abee 100755
>>>> --- a/t/t6010-merge-base.sh
>>>> +++ b/t/t6010-merge-base.sh
>>>> @@ -230,4 +230,31 @@ test_expect_success 'criss-cross merge-base for octopus-step' '
>>>>         test_cmp expected.sorted actual.sorted
>>>>  '
>>>>
>>>> +test_expect_success 'using reflog to find the fork point' '
>>>> +       git reset --hard &&
>>>> +       git checkout -b base $E &&
>>>> +       (
>>>> +               for count in 1 2 3 4 5
>>>> +               do
>>>> +                       git commit --allow-empty -m "Base commit #$count" &&
>>>> +                       git rev-parse HEAD >expect$count &&
>>>> +                       git checkout -B derived &&
>>>> +                       git commit --allow-empty -m "Derived #$count" &&
>>>> +                       git rev-parse HEAD >derived$count &&
>>>> +                       git checkout base &&
>>>> +                       count=$(( $count + 1 )) || exit 1
>>>> +               done
>>>
>>> Did you want && here?
>>
>> No, I did not.  Can't you tell from the fact that I didn't put one
>> there ;-)?
>>
>> It does not hurt to have one there, but it is not necessary.
>>
>> Because the loop itself does not &&-cascade from anything else, the
>> only case anything after "done &&" would be skipped and making the
>> whole thing fail would be when anything inside the loop fails, but
>> we already "exit 1" to terminate the whole subprocess in that case,
>> so we will not continue past the loop.
>
> I didn't read inside the loop closely enough to see that. Sorry
> for the noise.

Heh, you helped me realize that the above was suboptimal, and it
wasn't a noise ;-)

We could do it this way without the subshell and the exit, I would
think.

test_expect_success 'using reflog to find the fork point' '
	git reset --hard &&
	git checkout -b base $E &&
	for count in 1 2 3 4 5
	do
		git commit --allow-empty -m "Base commit #$count" &&
		git rev-parse HEAD >expect$count &&
		git checkout -B derived &&
		git commit --allow-empty -m "Derived #$count" &&
		git rev-parse HEAD >derived$count &&
		git checkout base &&
		count=$(( $count + 1 )) || break
	done &&

	for count in 1 2 3 4 5
	do
		git merge-base --reflog base $(cat derived$count) >actual &&
		test_cmp expect$count actual || break
	done &&

	# check defaulting to HEAD
	git merge-base --reflog base >actual &&
	test_cmp expect5 actual
'

To the earlier code, somebody could add

                (
        +               more setup code &&
        +               yet more setup code &&
                        for count in 1 2 3 4 5

inside the subshell and we would fail to notice fairlure from the
new setup code if we didn't have && after the first "done".  There
is much less risk of that kind of breakage if we did the loop
without subshell and exit and instead with the usual &&-cascade.

Thanks.
