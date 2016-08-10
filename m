Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D4FF1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 21:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbcHJVUl (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 17:20:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60953 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932638AbcHJSFR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:05:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EE7330D1A;
	Wed, 10 Aug 2016 13:10:05 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sEn0Iio4Ti9bMh2G3PuQnc32fGo=; b=YwCRcf
	lY//S2BRjsP1RsDt95BjH8BqhRfrDlnAJf0yVEjTc6UZvAd0DcXmO9kEXe6Ocvuj
	G+B1N+8FU15MBWOyn5q9XaUzT87nHdeguTEe02s6ORCGqNOybNmXQjVmomHSz2PY
	x+LPEDhIcWKp3TeUnV+XLFRsWOtn8+BxGOLPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ozju7HTlD96nXS6Sje/jLER3mErfUL9o
	F5I+94C9ou29tOriL9cbl+UqvbxWMus5t6tLiF0VF5OzKjSHB/Lel8RCmbOWelIT
	tIIpZl3GEH92gLJyQxmRwNWC7eEdJhUPcm7wlcmHafKSVwC0vsOQb786aBqbIrqc
	VxQ7WTIo9Ng=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F063130D18;
	Wed, 10 Aug 2016 13:10:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 740CB30D14;
	Wed, 10 Aug 2016 13:10:04 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jacob Keller <jacob.keller@gmail.com>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH RFC v2] diff: add SUBMODULE_DIFF format to display submodule diff
References: <20160810002315.25236-1-jacob.e.keller@intel.com>
	<xmqqtwet70ra.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xpGGqNC8B-fQiQXZcXWha2BBQa96sFvj+_MBVHWakMh_Q@mail.gmail.com>
Date:	Wed, 10 Aug 2016 10:10:02 -0700
In-Reply-To: <CA+P7+xpGGqNC8B-fQiQXZcXWha2BBQa96sFvj+_MBVHWakMh_Q@mail.gmail.com>
	(Jacob Keller's message of "Tue, 9 Aug 2016 23:52:01 -0700")
Message-ID: <xmqqy4445z4l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47D00434-5F1D-11E6-8EE1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>>> +     diff = fdopen(cp.out, "r");
>>> +
>>> +     c = fgetc(diff);
>>> +     while (c != EOF) {
>>> +             fputc(c, f);
>>> +             c = fgetc(diff);
>>> +     }
>>> +
>>> +     fclose(diff);
>>> +     finish_command(&cp);
>>
>> I do not think you need to do this.  If "f" is already a FILE * to
>> which the output must go, then instead of reading from the pipe and
>> writing it, you can just let the "diff" spit out its output to the
>> same file descriptor, by doing something like:
>>
>>         fflush(f);
>>         cp.out = dup(fileno(f));
>>         ... other setup ...
>>         run_command(&cp);
>>
>> no?  I do not offhand recall run_command() closes cp.out after done,
>> and if it doesn't you may have to close it yourself after the above
>> sequence.
>
> That makes a lot more sense, yes. I hadn't thought of dup, (long time
> since I've had to use file descriptors).
>
> the child_process api does close the descriptor itself. That's a much
> better way to get the result we want, and it is less code, so I'll try
> this out.

One caveat.  If the superproject is doing "log -p --graph", the
output will be broken with this "splice in 'git -C submodule diff'
output in place" approach.  I personally do not care if it is broken
as I do not use "-p" and "--graph" together (for that matter, I do
not think I'll use the "splice in 'git -C submodule diff'" feature
added by this patch, either, so I do not think I'd deeply care ;-),
but I am reasonably sure those who would use these would.

The way to solve it is to capture diff output and send out with the
current graph prefix (i.e. the set of vertial lines), and the
easiest and most expensive (probably too expensive to be practical)
way to do so would be to capture the whole thing into a strbuf, but
I think it is OK to teach a new option to "git diff" that tells to
prefix a fixed string given as its argument to each and every line
of its output, and that would be a more practical solution, which
can also be reused if you choose to later run "diff" internally
without spawning it as a separate process.

The graph machinery may have to be taught a way to tell what the
current graph prefix is if you go that route.

> I looked at trying to call diff for this, but I think it's not worth
> it. Using the child process API makes more sense and is a cleaner
> method. I'll go this route as it appears to work pretty well. The only
> major concern I have is that options may not get forwarded
> correctly...

You'd need to deal with options either way.  You do not want to
assume all options should be passed down.  You now know you need to
tweak the prefix, but you do not know if that is all that is
required.

