From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty: Provide a strict ISO8601 date format
Date: Fri, 29 Aug 2014 11:41:39 -0700
Message-ID: <xmqq1trz6sv0.fsf@gitster.dls.corp.google.com>
References: <1409248189-31409-1-git-send-email-bbolli@ewanet.ch>
	<xmqq61hc8bvq.fsf@gitster.dls.corp.google.com>
	<20140829174439.GA10274@odin.ulthar.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Beat Bolli <bbolli@ewanet.ch>, git@vger.kernel.org
To: Scott Schmit <i.grok@comcast.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 20:41:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNR7S-00023A-Ra
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 20:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbaH2Slu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 14:41:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54443 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753215AbaH2Slt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 14:41:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 657B0345F0;
	Fri, 29 Aug 2014 14:41:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lzEXE3+JHG3qgs1M2h707vOFkm0=; b=ASeO6P
	uRoO9LkxFNsUPwq0xngOitxHhz2tS7hRpzJIHMylFzAtSexJAQVM2TAxaWJszS4U
	8eNDtPZbPvX5mEz/trJDjdXcWPDNu++d6PwcVH7TC3/7vIXhEgz+FskkuFFcKpHW
	nvLa+27GsPvzbG/9ZkelIPoeTgnAXiYsW5yFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XBSRusQoFc2oRjr7eVMb5wApzNVI2So4
	WOHKnJumki/o9mFlzVz/8/UWo0ry4yU2yikQ9UtXGs3EQ4NxgvXa1Y7vm+A0sK15
	0SxqHFXaVgs2md8BEgdPdezNqevBaFdLdLNyvrQ75Ncrh4P7vE1PK1LTqAy18/AK
	vABkbrYwE0w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 58AD3345EF;
	Fri, 29 Aug 2014 14:41:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 607C0345ED;
	Fri, 29 Aug 2014 14:41:41 -0400 (EDT)
In-Reply-To: <20140829174439.GA10274@odin.ulthar.us> (Scott Schmit's message
	of "Fri, 29 Aug 2014 13:44:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1E1CF3E2-2FAC-11E4-959F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256174>

Scott Schmit <i.grok@comcast.net> writes:

> On Thu, Aug 28, 2014 at 03:53:13PM -0700, Junio C Hamano wrote:
>> Beat Bolli writes:
>> > +	else if (mode == DATE_ISO8601_STRICT)
>> > +		strbuf_addf(&timebuf, "%04d-%02d-%02dT%02d:%02d:%02d%+03d:%02d",
>> > +				tm->tm_year + 1900,
>> > +				tm->tm_mon + 1,
>> > +				tm->tm_mday,
>> > +				tm->tm_hour, tm->tm_min, tm->tm_sec,
>> > +				tz / 100, abs(tz % 100));
>> 
>> Wouldn't this misidentify a zone that is 30 minutes off of GMT,
>> i.e. tz == -30?  tz/100 would not be negative and "%+03d:" would
>> happily show "+00:", no?
>
> No.  strbuf_addf uses strbuf_vaddf which uses vsnprintf(3).  From man
> vsnprintf(3):
>>   The flag characters
>>       The character % is followed by zero or more of the following
>>       flags:
>>
>>       +      A sign (+ or -) should always be placed before a number
>>              produced by a signed conversion.  By default a sign is
>>              used only for negative numbers.  A + overrides a space if
>>              both are used.
>
> Perhaps you misread "%+03d:" as "+%02d:"?

I do not think 03 vs 02 makes any difference wrt what I was
wondering.

You feed tz/100 to "%+03d:" (the "sign and hour" part of the
timezone).  What if tz is -30, i.e. less than an hour but still a
negative offset?  tz/100 would be zero and tz % 100 would be -30.

    tz = -30;
    printf("%+03d:%02d", tz / 100, abs(tz % 100));

would show what?
