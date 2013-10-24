From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] merge-base: "--reflog" mode finds fork point from reflog entries
Date: Thu, 24 Oct 2013 14:26:39 -0700
Message-ID: <xmqq61smmkc0.fsf@gitster.dls.corp.google.com>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
	<1382641884-14756-1-git-send-email-gitster@pobox.com>
	<1382641884-14756-3-git-send-email-gitster@pobox.com>
	<CAPig+cQrBMMqSmOk0GSZJ9PTHNt-t+vuOG2Aq=7VTR1EZSeLsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Oct 24 23:26:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZSQa-0000KK-U3
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 23:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab3JXV0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 17:26:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38351 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791Ab3JXV0o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 17:26:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 990AD4DD9C;
	Thu, 24 Oct 2013 21:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cA9VPsBWarc/NlAg3dcMR/I3K1c=; b=jaEOHZ
	ecaCHX99w5X5Ev9/qOA5eLyCGbyboKUiDmHyweEh7rX0I3EKccfrGf+vKSvcamLx
	a0l1aK1oFQkQMB+MhSCjLf+3B0uljng9bY47sNwMG5u2LGDWzQjqnPi0C+VkcyC6
	wqg0ImW5YTs1eRTq4PCAck4FSwc44oDIq2jsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uiVpuLfRrnbPvuKWXnfwS0wM0uYCb1sd
	XfDuKSjgwvGfur3ihp1RjCfUsiEII3iX3fUlgW+qykzlA492zuaPMGXLxvLx1eTs
	w6syuP4b/c8vw7QHMTITH87OAZzdL3i/keGANyaJ9fSPULD6KsAO3Wr75k3c2skF
	Azqd/1TGllU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C7174DD98;
	Thu, 24 Oct 2013 21:26:43 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F39794DD8C;
	Thu, 24 Oct 2013 21:26:42 +0000 (UTC)
In-Reply-To: <CAPig+cQrBMMqSmOk0GSZJ9PTHNt-t+vuOG2Aq=7VTR1EZSeLsw@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 24 Oct 2013 17:01:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FA48F68E-3CF2-11E3-B20B-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236626>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Oct 24, 2013 at 3:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
>> index f80bba8..3a1abee 100755
>> --- a/t/t6010-merge-base.sh
>> +++ b/t/t6010-merge-base.sh
>> @@ -230,4 +230,31 @@ test_expect_success 'criss-cross merge-base for octopus-step' '
>>         test_cmp expected.sorted actual.sorted
>>  '
>>
>> +test_expect_success 'using reflog to find the fork point' '
>> +       git reset --hard &&
>> +       git checkout -b base $E &&
>> +       (
>> +               for count in 1 2 3 4 5
>> +               do
>> +                       git commit --allow-empty -m "Base commit #$count" &&
>> +                       git rev-parse HEAD >expect$count &&
>> +                       git checkout -B derived &&
>> +                       git commit --allow-empty -m "Derived #$count" &&
>> +                       git rev-parse HEAD >derived$count &&
>> +                       git checkout base &&
>> +                       count=$(( $count + 1 )) || exit 1
>> +               done
>
> Did you want && here?

No, I did not.  Can't you tell from the fact that I didn't put one
there ;-)?

It does not hurt to have one there, but it is not necessary.

Because the loop itself does not &&-cascade from anything else, the
only case anything after "done &&" would be skipped and making the
whole thing fail would be when anything inside the loop fails, but
we already "exit 1" to terminate the whole subprocess in that case,
so we will not continue past the loop.

>> +
>> +               for count in 1 2 3 4 5
>> +               do
>> +                       git merge-base --reflog base $(cat derived$count) >actual &&
>> +                       test_cmp expect$count actual || exit 1
>> +               done
>
> And here?

Likewise.

Thanks.

>> +
>> +               # check defaulting to HEAD
>> +               git merge-base --reflog base >actual &&
>> +               test_cmp expect5 actual
>> +       )
>> +'
>> +
>>  test_done
