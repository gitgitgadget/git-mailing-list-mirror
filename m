From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pager: turn on "cat" optimization for DEFAULT_PAGER
Date: Wed, 20 Nov 2013 09:33:16 -0800
Message-ID: <xmqqob5f6krn.fsf@gitster.dls.corp.google.com>
References: <201308261957.r7QJvfjF028935@freeze.ariadne.com>
	<xmqqd2ozhhob.fsf@gitster.dls.corp.google.com>
	<201308281819.r7SIJmnh025977@freeze.ariadne.com>
	<xmqqr4dd8suz.fsf@gitster.dls.corp.google.com>
	<201308291541.r7TFfuJr023110@freeze.ariadne.com>
	<vpqsixsv6dq.fsf@anie.imag.fr>
	<201309030227.r832RmBd013888@freeze.ariadne.com>
	<20130903074150.GE3608@sigill.intra.peff.net>
	<CABPQNSb6PD+oSw_LT6KaUYd8BTeN-WHJFodcuiLe=u76rFYFJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Dale R. Worley" <worley@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 20 18:33:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjBeW-000418-P7
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 18:33:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515Ab3KTRdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 12:33:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55977 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753375Ab3KTRdU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 12:33:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 667DC533CF;
	Wed, 20 Nov 2013 12:33:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9TxiVNg+A+jtwCa+WmNGEoGRMDk=; b=xHcOo0
	mdDhW7kKWm5h6+pg9yrLDFwdOk2iz0LEMQjWTS16n51ERWXom2HEXk3JsaNoCrEW
	eUrT8TF8vcRECL63O3sZoEKS7Mje7Vk/W0R3IyLWmLj/yJ1/joBI02xWXrxFEQ6R
	sN/bB3286eE5zcE9jK7/QVYOq2TSiJhQlkcds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p34uU7A9sElZAx6Tztw4LJShm02sP7dE
	6/MyS4dJZULkVzSSB1xr46cRvT+eYq5AN9jpLTkeZKVkgZuZHnOQ9P912zoGgSeP
	ZHJmXfimjmvsot3ipXBoeBKNCvYP4eTubZeYAR1N/MJpyoOaiWSOx1o31OGnJpGm
	e+nqPKyUx7I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C1DE533CE;
	Wed, 20 Nov 2013 12:33:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AB9A533CD;
	Wed, 20 Nov 2013 12:33:18 -0500 (EST)
In-Reply-To: <CABPQNSb6PD+oSw_LT6KaUYd8BTeN-WHJFodcuiLe=u76rFYFJw@mail.gmail.com>
	(Erik Faye-Lund's message of "Wed, 20 Nov 2013 18:24:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D8258226-5209-11E3-884B-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238086>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>> ...
>> is set to empty., 2006-04-16). At that time, the line
>> directly above used:
>>
>>    if (!pager)
>>            pager = "less";
>>
>> as a fallback, meaning that it could not possibly trigger
>> the optimization. Later, a3d023d (Provide a build time
>> default-pager setting, 2009-10-30) turned that constant into
>> a build-time setting which could be anything, but didn't
>> loosen the "else" to let DEFAULT_PAGER use the optimization.
>>
>> Noticed-by: Dale R. Worley <worley@alum.mit.edu>
>> Suggested-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>>  pager.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/pager.c b/pager.c
>> index c1ecf65..fa19765 100644
>> --- a/pager.c
>> +++ b/pager.c
>> @@ -54,7 +54,7 @@ const char *git_pager(int stdout_is_tty)
>>                 pager = getenv("PAGER");
>>         if (!pager)
>>                 pager = DEFAULT_PAGER;
>> -       else if (!*pager || !strcmp(pager, "cat"))
>> +       if (!*pager || !strcmp(pager, "cat"))
>
> Hmmpf. It's sometimes useful to actually pipe through cat rather than
> disabling the pager, as this changes the return-code from isatty. I
> sometimes use this for debugging-purposes. Does this patch break that?

If you have been running "GIT_PAGER=cat git whatever" and the like,
we did not pipe the output through "cat" and this has been the case
for a long time.  The only thing the patch in question changed is
for those who build with

	make DEFAULT_PAGER=cat

and I doubt that you have been debugging git by rebuilding it with
such a setting, so....
