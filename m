From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/14] lockfile: introduce flag for locks outside .git
Date: Wed, 03 Dec 2014 15:25:32 -0800
Message-ID: <xmqqr3wguxhv.fsf@gitster.dls.corp.google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
	<CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
	<20141118004841.GE4336@google.com>
	<CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
	<20141203050217.GJ6527@google.com> <20141203051911.GP6527@google.com>
	<xmqqvblsuy2e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 00:25:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwJIh-0000cM-6e
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 00:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbaLCXZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 18:25:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752067AbaLCXZe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 18:25:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D8FCC23376;
	Wed,  3 Dec 2014 18:25:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J0mTjuarbdRRC3TD3WWCVWHPXE8=; b=fBW/Au
	BlCGwvD1swY/JLopIADdcaevXsu36oEVkfKqB3kBI8n4/X5PW9WttwxVwYUerPKd
	xncu/u+Rh28a2s1LhnSVj334mren1bS7b4z2o8LHedFijKrJFdvD9gOCEdHl197L
	lBbqoboTXNGwbkwqBow0TU3BCBPlhNJWimEqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EgF2AQniftLjL0aYnFxhlARR6Yhbp4TA
	N4OeAqY1vIXEwCg61vvcGC5bHxtDVY2VtBWBY+7qRUlZpa+E14J/2lxaABzva5cc
	rPcQ1p9f5LST2rG2UepEkSBctnXwb4bToPbwWqQ3Pkd2FYSIJa35r99S5hSodRly
	PEIGG+KR7yE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF74C23375;
	Wed,  3 Dec 2014 18:25:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 252DC23374;
	Wed,  3 Dec 2014 18:25:33 -0500 (EST)
In-Reply-To: <xmqqvblsuy2e.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 03 Dec 2014 15:13:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD88CF64-7B43-11E4-8830-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260709>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> diff --git a/refs.c b/refs.c
>> index 917f8fc..39e43cf 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2326,7 +2326,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>>  			 */
>>  			goto retry;
>>  		else
>> -			unable_to_lock_die(ref_file, errno);
>> +			unable_to_lock_die(ref_file, lflags, errno);
>>  	}
>
> This has unfortunate interaction with 06839515 (lock_ref_sha1_basic:
> do not die on locking errors, 2014-11-19).  The fact that the helper
> unable-to-lock-message() is now hidden inside lockfile.c does not
> help, either.

I tried to merge the 14-patch series with obvious fix-ups after
dropping the rerere abortion change you sent separately and in
duplicate and also dropping sb/copy-fd, but I've ran out of patience
with this step, at least for today's integration cycle.  Should we
also drop jk/lock-ref-sha1-basec-return-errors topic as well?

The 14-patch series may have been internally consistent and its
individual patches, when each of them was taken alone by itself, may
have made sense, but it appears that the aggregated whole these
separate topics took their root from is inconsistent with itself
in minor ways like this here and there X-<.
