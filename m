From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not make trace.c/getnanotime an inlined function
Date: Mon, 29 Sep 2014 10:48:28 -0700
Message-ID: <xmqqa95iuxlf.fsf@gitster.dls.corp.google.com>
References: <1411890626-28237-1-git-send-email-bdwalton@gmail.com>
	<CACsJy8ArOU7WF4fiy5vn8zq5y6Vm5JxgTf+Tiai_WOeMSj--Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ben Walton <bdwalton@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 19:48:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYf3r-0000PV-P4
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 19:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbaI2Rsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 13:48:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51667 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbaI2Rsb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 13:48:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 49B933D025;
	Mon, 29 Sep 2014 13:48:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=JxaFcey12XgIU7cJfsJ6C1EdWWU=; b=QciG6jdHMbgZ7zRXYhP5
	Quhg1M426ZWAx0uNGUwshTrVXAqNmTnIhHVx4i0CvTo2tjNltL0X2C5bNuZ7AaD6
	qe320OZLpVTXc0riOThwWcEyfL85WOllelOTRoHZOyxk2YBBHxrJhbiu6RCl74gn
	BioklpNomPRU+NUeKcJkMRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=QCNSs9AWjTq0wdhcDxyYeqP5EIAUNHuc4RLQUb9PE1Xi8g
	aYixTy4zn8qdEsz/65c4KdqIG+j1Q6dElCu4eJBNC6UaC7xNdpY3GsCteIPeU61C
	GO5LbPscqJjzO3hSS6+Vdb6YbOhkRoJmqh4Gw9CTvGL2z12ohAEOHxuoTLQkE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4043B3D024;
	Mon, 29 Sep 2014 13:48:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B51E03D023;
	Mon, 29 Sep 2014 13:48:29 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D28C05CC-4800-11E4-AEA4-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257632>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Sep 28, 2014 at 2:50 PM, Ben Walton <bdwalton@gmail.com> wrote:
>> Oracle Studio compilers don't allow for static variables in functions
>> that are defined to be inline. GNU C does permit this. Let's reference
>> the C99 standard though, which doesn't allow for inline functions to
>> contain modifiable static variables.
>>
>> Signed-off-by: Ben Walton <bdwalton@gmail.com>
>> ---
>>  trace.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/trace.c b/trace.c
>> index b6f25a2..4778608 100644
>> --- a/trace.c
>> +++ b/trace.c
>> @@ -385,7 +385,7 @@ static inline uint64_t gettimeofday_nanos(void)
>>   * Returns nanoseconds since the epoch (01/01/1970), for performance tracing
>>   * (i.e. favoring high precision over wall clock time accuracy).
>>   */
>> -inline uint64_t getnanotime(void)
>> +uint64_t getnanotime(void)
>>  {
>>         static uint64_t offset;
>
> Would moving this offset outside getnanotime() work?

I am not sure what the definition of "work" is.

The function computes the difference between the returned value from
gettimeofday(2) and a custom highres_nanos() just once and returns
the value it got from gettimeofday the first time, and then for
subsequent calls massages the returned value from highres_nanos() to
be consistent with the value returned from gettimeofday using the
offset it computed in the first call.

If we have two copies of this function, two independent probes to
these pair of underlying functions will be made to compute their
offsets.  With perfect pair of clocks that may not matter, but it
just feels wrong to me.

Besides, I wonder what happens if the computed offset happen to be
1, which is used as a sentinel.
