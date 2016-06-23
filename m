Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0DB92018A
	for <e@80x24.org>; Thu, 23 Jun 2016 17:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbcFWRha (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 13:37:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751762AbcFWRh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 13:37:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 269FF24BF9;
	Thu, 23 Jun 2016 13:37:20 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mbRETzY6MPhh2UFuwj+nrzXYQZc=; b=XpQDvJ
	WqEMBM+hEIceqv/q+H7WPJc6MvP//j+VusIqO2iUiuxPZh2Lkk0PhoEyPE9kaX7r
	tCTRNrWqcibi6JGNJE1rWl1HmYtVHXTVv8GJUR7ZtkzSUEMlddO3H47lxrXgk1K0
	F6G+jbLeLQ/0C/C7SGxZm35VNYpP8ogoGULes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vRhRjQSxcctMjzXH9rNHzMXFwrss7Hup
	e+N5TjA3Ourc0cADo1tfLH6ua6+y/PimlMJKt29U/L3IcwF8eCGvW98mF/2ZlY3l
	K1atuDS6LkEwYu3XS/DnF2T4et4uKwRmwgTFAygNUZqtWtOyLoP87vgJywkQcQ7H
	ovdUnMLPKMw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E15B24BF8;
	Thu, 23 Jun 2016 13:37:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 80F1D24BF6;
	Thu, 23 Jun 2016 13:37:19 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] diff compaction heuristic: favor shortest neighboring blank lines
References: <20160616174620.1011-1-sbeller@google.com>
	<20160617153637.GA9314@sigill.intra.peff.net>
	<CAGZ79kZgdbqnWW9uqeBHNDbyGVfc0x5gTJbyD0Nyi1i3SNvENQ@mail.gmail.com>
	<576C1803.5050905@alum.mit.edu>
Date:	Thu, 23 Jun 2016 10:37:17 -0700
In-Reply-To: <576C1803.5050905@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 23 Jun 2016 19:10:27 +0200")
Message-ID: <xmqq1t3nkdrm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 228D4CEC-3969-11E6-87A2-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Scoring heuristic:
>
>>     # A place to accumulate bonus factors (positive makes this
>>     # index more favored):
>>     bonus = 0
>> 
>>     # Bonuses based on the location of blank lines:
>>     if pre_blank and not blank:
>>         bonus += 3
>>     elif blank and not pre_blank:
>>         bonus += 2
>>     elif blank and pre_blank:
>>         bonus += 1
>> 
>>     # Now fill in missing indent values:
>>     if pre_indent is None:
>>         pre_indent = 0
>> 
>>     if post_indent is None:
>>         post_indent = 0

These "missing" are to handle the lines at the boundary of shiftable
block, or do you have pre_indent if a line is the earliest possible
one that could be included in the hunk by shifting, as long as it is
not at the beginning of the file?

I think "this is indented deeper than the previous, and it wants to
stay with the previous if possible" is an excellent heuristic, which
you have below.  I wonder if "however, the previous cannot be
included in the hunk by shifting, hence we try to keep this together
with it by favouring its exclusion from the hunk" could be part of
the same heuristics, if you do have pre_indent value for a line at
the boundary of shiftable block.

Also I am wondering if 0 is a sensible thing to use as the fallback
value.  When pre_indent is not definable, turning it to 0 and
declaring that our indented line is indented deeper than the
previous line and penalizing with "bonus -= 4" (which you do) feels
just as fishy as turning the undefined pre_indent to maxint and
declaring that our indented line is indented shallower than the
previous line (which you don't, but is just as justifiable, I would
think).

Thanks.

>>     if blank:
>>         indent = post_indent
>> 
>>     if indent > pre_indent:
>>         # The line is indented more than its predecessor. It is
>>         # preferable to keep these lines together, so we score it
>>         # based on the larger indent:
>>         score = indent
>>         bonus -= 4
>> 
>>     elif indent < pre_indent:
>>         # The line is indented less than its predecessor. It could
>>         # be that this line is the start of a new block (e.g., of
>>         # an "else" block, or of a block without a block
>>         # terminator) or it could be the end of the previous
>>         # block.
>>         if indent < post_indent:
>>             # The following line is indented more. So it is likely
>>             # that this line is the start of a block. It's a
>>             # pretty good place to split, so score it based on the
>>             # smaller indent:
>>             score = indent
>>             bonus += 2
>>         else:
>>             # This was probably the end of a block. We score based
>>             # on the line's own indent:
>>             score = indent
>> 
>>     else:
>>         # The line has the same indentation level as its
>>         # predecessor. We score it based on its own indent:
>>         score = indent
>> 
>>     return 10 * score - bonus
