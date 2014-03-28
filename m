From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4212: handle systems with post-apocalyptic gmtime
Date: Fri, 28 Mar 2014 12:02:46 -0700
Message-ID: <xmqqppl69meh.fsf@gitster.dls.corp.google.com>
References: <20140326182103.GB7087@sigill.intra.peff.net>
	<20140326185153.GA12912@sigill.intra.peff.net>
	<xmqqr45oixa6.fsf@gitster.dls.corp.google.com>
	<20140326192536.GA13989@sigill.intra.peff.net>
	<20140326193359.GA14105@sigill.intra.peff.net>
	<20140326212227.GC6991@hashpling.org>
	<20140326215741.GA17716@sigill.intra.peff.net>
	<20140326224616.GA9454@hashpling.org>
	<20140327224837.GB32434@sigill.intra.peff.net>
	<xmqqd2h6cm26.fsf@gitster.dls.corp.google.com>
	<20140328184710.GA29987@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 28 20:02:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTc3L-0004bk-Nt
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 20:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbaC1TCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 15:02:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43412 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149AbaC1TCt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 15:02:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04C29786E6;
	Fri, 28 Mar 2014 15:02:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wbZvZxgOzOvwhkAQgmV4XxndVNg=; b=hvRyX8
	Szcoa0Qkba/S9VS0zGehgZrgoJtUI2fruTpMlKTsz2dhKSCZBx02wqfGcdEyKNhA
	D9bzpnveJUqWfvKPUDjl66hWxrPT36ZM0EV/dfHVewpwOODN3qZBAAOkTuw/wsjO
	untvWEBcspETpPZoOyDiWaQ47+y7IE39c28hM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=elHuchFmBlb/cYBJdV6Sj3La93Z8oc1L
	JEQ+qohzP0uCShXnwxJsa2kmGyBphiQbHn/VddBMUQAkyGR8I1TpBuZDkGc50OYr
	xBHWz/XJC/eTKG2v7b6jC+IFxUmplk8SS/msghEGTuW/q4JOOSZfVei290mkOKgW
	Lkuplwc1pOI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3A9F786E4;
	Fri, 28 Mar 2014 15:02:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F41BF786E2;
	Fri, 28 Mar 2014 15:02:47 -0400 (EDT)
In-Reply-To: <20140328184710.GA29987@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 28 Mar 2014 14:47:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8D74372A-B6AB-11E3-A381-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245415>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 28, 2014 at 09:41:53AM -0700, Junio C Hamano wrote:
>
>> Offhand, the three possible failure modes this thread identified
>> sounds to me like the only plausible ones, and I think the best way
>> forward might be to
>> 
>>  - teach the "is the result sane, even though we may have got a
>>    non-NULL from gmtime?  otherwise let's signal a failure by
>>    replacing it with a known sentinel value" codepath the new
>>    failure mode Charles's report suggests---if we feed a positive
>>    timestamp and gmtime gave us back a tm_year+1900 < 0, that is
>>    certainly an overflow; and
>
> I don't think we can analyze the output from gmtime. If it wraps the
> year at N, then won't N+2014 look like a valid value?

Yes, but I was hoping that there are small number of possible N's
;-)

> If we are going to do something trustworthy I think it has to be before
> we hand off to gmtime. Like:
>
> diff --git a/date.c b/date.c
> index e1a2cee..e0c43c4 100644
> --- a/date.c
> +++ b/date.c
> @@ -57,6 +57,8 @@ static time_t gm_time_t(unsigned long time, int tz)
>  static struct tm *time_to_tm(unsigned long time, int tz)
>  {
>  	time_t t = gm_time_t(time, tz);
> +	if (t > 9999999999999999)
> +		return NULL;
>  	return gmtime(&t);
>  }
>
> I suspect that would handle the FreeBSD case, as well.
>
> By the way, I have a suspicion that the gm_time_t above can overflow if
> you specially craft a value at the edge of what time_t can handle (we
> check that our value will not overflow time_t earlier, but now we might
> be adding up to 86400 seconds to it). <sigh>

Yuck.  Let's not go there.

Thanks.
