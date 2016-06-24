Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2F992018A
	for <e@80x24.org>; Fri, 24 Jun 2016 19:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbcFXToJ (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 15:44:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751082AbcFXToI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 15:44:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF1EB25B91;
	Fri, 24 Jun 2016 15:44:06 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/zfBbFJIMMqKM2xMjkORJJS8Muo=; b=h0U+Bl
	dqb47xVag2Tg91CieHK/PHwrlcNoKOKfAW/1OC3/sSINkuS3/XSjkooaRKVGnNto
	qCZPNxi/+0IghIK59P7vr9YGSsDX7I3/XWHlCqGIAjPrbPhpH5Sn16EzzpMbAWT2
	z80bAXaJVY0Yj+lUyJyNHyk2vl5zoJ3L6VYkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LDiE3BrOWgoY3m1jkJQVT7pVPNnGKj5E
	Zsj6M+siPliyRviwNEzpMN/7fdYUjOusppU/8rWUSpr8hTLQazueDtC+NFDkhpxq
	mmSgWfiMnxRyMwr94U/Tqt9xgBd/zxYm3onm4tFu7K1fpvffYUiSgvh/WJG6AGdN
	n3JSS6M4LTw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A7B9425B8F;
	Fri, 24 Jun 2016 15:44:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FEDF25B8D;
	Fri, 24 Jun 2016 15:44:06 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v3 1/4] t5000: test tar files that overflow ustar headers
References: <20160623231512.GA27683@sigill.intra.peff.net>
	<20160623232041.GA3668@sigill.intra.peff.net>
	<xmqq1t3mh0vg.fsf@gitster.mtv.corp.google.com>
	<20160624190744.GA32118@sigill.intra.peff.net>
Date:	Fri, 24 Jun 2016 12:44:04 -0700
In-Reply-To: <20160624190744.GA32118@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 24 Jun 2016 15:07:44 -0400")
Message-ID: <xmqqk2hefk3f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02E4540E-3A44-11E6-8AE3-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > +# When parsing, we'll pull out only the year from the date; that
>> > +# avoids any question of timezones impacting the result. 
>> 
>> ... as long as the month-day part is not close to the year boundary.
>> So this explanation is insuffucient to convince the reader that
>> "that avoids any question" is correct, without saying that it is in
>> August of year 4147.
>
> I thought that part didn't need to be said, but I can say it
> (technically we can include the month, too, but I don't think that level
> of accuracy is really important for these tests).

Oh, I wasn't suggesting to include the month in the comparison.  But
to understand why it is safe from TZ jitters to test only year, the
reader needs to know (or do the math herself) that the timestamp is
away from the year boundary, so mentioning August in the justifying
comment is needed.

>> Seeing an awk piped into cut always makes me want to suggest a
>> single sed/awk/perl invocation.
>
> I want the auto-splitting of awk, but then to auto-split the result
> using a different delimiter. Is there a not-painful way to do that in
> awk?
>
> I could certainly come up with a regex to do it in sed, but I wanted to
> keep the parsing as liberal and generic as possible.
>
> Certainly I could do it in perl, but I had the general impression that
> we prefer to keep the dependency on perl to a minimum. Maybe it doesn't
> matter.

Heh.  It was merely "makes me want to suggest", not "I suggest".  If
I were doing this myself, I would have done a single sed but it does
not matter.

> I think we would want something more like:
>
>   test_signal_match 13 $(cat exit-code)

I like that.
