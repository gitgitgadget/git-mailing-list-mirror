From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: --dissociate option to mark that reference is only temporary
Date: Wed, 15 Oct 2014 14:33:37 -0700
Message-ID: <xmqqsiipuifi.fsf@gitster.dls.corp.google.com>
References: <xmqqa94yzap8.fsf@gitster.dls.corp.google.com>
	<543E85FA.6050404@xiplink.com>
	<xmqqwq81w8az.fsf@gitster.dls.corp.google.com>
	<543EDE6A.7040500@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 23:33:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeWCc-0002AR-WA
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 23:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbaJOVdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 17:33:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751059AbaJOVdk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 17:33:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8084215883;
	Wed, 15 Oct 2014 17:33:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S/M4uJpeudjs8UTFC9jgeMDeNfY=; b=WP8i0Z
	a5xr8zjH3TI6EwfvD1VU/R9A5hr6GrhCX6onyIQFdQiuscJyUP/5VB2SLl+m8fSJ
	mPvUVixHlkFIeQEid/qO3X2sxsLiD/0jjWujhvVJBh/kFbFKqAkztOY+5C0aZwz2
	h2XnV0jmC9Q9z37jI0z1UcftfKfFsnx15gQCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cIRiyL9OhiJ3K9TtE/2scQSJdYFbD/cc
	JNsNxd+VKlSmkROyLEvDLcHNOGYPofFd3I4T0hTsEX4D8skjWFAjfXoTXObVjyyB
	YGt8cAPCCaGhYXyjxgRkrvXLE3+B91bpEDjSSHTLcT6YY16n+T9wn0wIoG18RMhD
	R57OJwuy1f8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76F3A15882;
	Wed, 15 Oct 2014 17:33:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D944D15881;
	Wed, 15 Oct 2014 17:33:38 -0400 (EDT)
In-Reply-To: <543EDE6A.7040500@xiplink.com> (Marc Branchaud's message of "Wed,
	15 Oct 2014 16:51:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ED3C2744-54B2-11E4-8BDA-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 14-10-15 01:29 PM, Junio C Hamano wrote:
>
>>     $ git clone \
>>         --reference=/local/pool/linux.git \
>>         --borrow=../my/neighbour/linux-hack.git \
>>         git://git.kernel.org/...../linux.git
>> 
>> With "do the usual --reference thing, but then dissociate the result
>> from referents" option, there is no ambiguity and that is why I did
>> not go with the "--borrow" option suggested in the original thread.
>
> I had not considered this case.  My limited imagination has a hard time
> coming up with a scenario where more than one --reference (or
> In this example, the --borrow seems
> useless.  How would clone decide that it even needed objects from the
> neighbour repo?  None of the refs on gko need any of the neighbour's unique
> objects.

A probable scenario might go like this.

    The company-wide pool is designed for everybody's use and will
    stay, even if it lags behind because it fetches every other day,
    so it is safe to keep referring to via alternates.  My neighbour
    is following the linux-next repository and has changes that are
    meant to land "in the future" to the mainline, but it can
    disappear without notice so I cannot afford to depend on its
    presense forever.

Under that particular scenario, what should happen is fairly clear;
we want to dissociate from neibour's immediately after clone is
done, while being still dependent on the shared pool.  But there is
the question of "how would you implement such a behaviour" (even if
you know that is the single only behaviour you would want to see).

Also I am not confident enough that it is the only plausible way any
user may want to mix reference and borrow together.
