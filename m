From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] progress.c: replace signal() with sigaction()
Date: Wed, 28 May 2014 10:35:38 -0700
Message-ID: <xmqqvbspdcwl.fsf@gitster.dls.corp.google.com>
References: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
	<1401257655-6043-2-git-send-email-jmmahler@gmail.com>
	<5385994A.5040507@gmail.com> <87sinuiad2.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>,
	Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed May 28 19:36:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WphlX-00034N-Kf
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 19:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbaE1Rfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 13:35:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64407 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413AbaE1Rfn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 13:35:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3AF1C1A6DD;
	Wed, 28 May 2014 13:35:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mF3hJTY0ylUZ/aF+EPF7Ampoylg=; b=HEvRJk
	ZfzusUcZWN4QZ0ML/BK2VdnoVWvdrry21BdOy67RrOC6kXm7Ni8aBLlp2JR0qX8D
	KmezCwuQbkv3Cwp+M4lzcoi3WhhmyiLoDG0BcoOu3DWnKCaaq9C6yuVCVJ8Khlxt
	1IuRbls1+n47fsrJwwjoXKxjeYxIpIPFx5eb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kh04aFlc4E+9OiVyKX7cjy63tX/5oI4l
	Z5HT1iPlNp96YiyNZetp7bnFLXH2DZCfyCIlkoDAgBgFZ4TQPClXtEfx4+ora0pX
	DfHBcODwWe9idXc7p6I+et2YiP0cy7XvjkBtnKD1hB5IyYoH160SmRQIJKxL6Xr4
	mWaQNxx5Mjc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D8961A6DC;
	Wed, 28 May 2014 13:35:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D1E751A6D3;
	Wed, 28 May 2014 13:35:39 -0400 (EDT)
In-Reply-To: <87sinuiad2.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Wed, 28 May 2014 10:19:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7C7079D0-E68E-11E3-AD46-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250301>

David Kastrup <dak@gnu.org> writes:

>>> diff --git a/progress.c b/progress.c
>>> index 261314e..24df263 100644
>>> --- a/progress.c
>>> +++ b/progress.c
>>> @@ -66,8 +66,12 @@ static void set_progress_signal(void)
>>>  static void clear_progress_signal(void)
>>>  {
>>>  	struct itimerval v = {{0,},};
>>> +	struct sigaction sa;
>>> +
>>> +	memset(&sa, 0, sizeof(sa));
>>> +	sa.sa_handler = SIG_IGN;
>>
>> A C99 initialiser here would save the call to memset. Unfortunately
>> Documentation/CodingGuidelines is fairly clear on not using C99
>> initialisers, given the fact we're now at git 2.0 maybe it's time to
>> revisit this policy?
>
> If I look at the initialization of v in the context immediately above
> the new code, it would appear that somebody already revisited this
> policy.

The existing structure initialization that says "the first field of
the structure is set to 0" implying "everything else will also be
set to 0" is not what we avoid.  That is straight C89.

What we avoid is an initializer with a designator, e.g.

	struct sigaction sa = {
        	.sa_handler = NULL,
                .sa_flags = 0,
	};
