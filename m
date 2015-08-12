From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 04/13] utf8: add function to align a string into given strbuf
Date: Wed, 12 Aug 2015 09:40:52 -0700
Message-ID: <xmqq37zompd7.fsf@gitster.dls.corp.google.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
	<1439129506-9989-5-git-send-email-Karthik.188@gmail.com>
	<xmqq8u9hsn0j.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZRL-WV=9Q+_fo7wcbqT7jZVA02oYo8SfDcLrev=qsUvLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 18:41:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPZ5M-0005Qq-GD
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 18:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934440AbbHLQk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 12:40:56 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35106 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933317AbbHLQky (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 12:40:54 -0400
Received: by pacgr6 with SMTP id gr6so17922536pac.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 09:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oPL9EsWc8kzScWl0yQkf0d/5gSt4PNf9TJGGw5ZIlg8=;
        b=D9gLOKjlMNn3lLZUll/5n18JYUp3KhBrvg1yK2CLZ0XGQE11nVZ0NNEc5hZd0J3Bd9
         LM4ThX1lDxUSzsOuKKjxcWOn0TaRgYFUDY29b6FDsjrsSCyGAf3b3+YatWgvUiq2/AwY
         xGDBxXW6zsBl6N8lSVHwBENPkOZB4mLwR+jmBY0exGQA9m5d2MHt4MWZbfhhojWFeTVz
         vJYO3TcDo+bhHj4VIEcmvrjrlInCW5XY13sOSMJZhz1LMflI0PBmbQYznjV5DKqjlVOF
         3uoKNqhYWXCbt1hNId7W4G26/LJyKoVN+7OajDOj3x7YVs8LUT2b3oIPi4YbXO23OAvb
         9G/A==
X-Received: by 10.66.157.195 with SMTP id wo3mr69162893pab.17.1439397654468;
        Wed, 12 Aug 2015 09:40:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id d5sm7024341pdn.74.2015.08.12.09.40.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 09:40:53 -0700 (PDT)
In-Reply-To: <CAOLa=ZRL-WV=9Q+_fo7wcbqT7jZVA02oYo8SfDcLrev=qsUvLg@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 12 Aug 2015 19:11:05 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275781>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Tue, Aug 11, 2015 at 11:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> +void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
>>> +                    const char *s)
>>> +{
>>> +     int display_len = utf8_strnwidth(s, strlen(s), 0);
>>> +     int utf8_compenstation = strlen(s) - display_len;
>>
>> compensation, perhaps?  But notice you are running two strlen and
>> then also a call to utf8-strnwidth here already, and then
>>
>
> compensation it is.
> probably have a single strlen() call and set the value to another variable.

That is not what I meant.  If you want to keep the early return of
"doing nothing for an empty string" (which you should *NOT*, by the
way), declare these variables upfront, do the early return and then
call utf8_strnwidth() to compute the value you are going to use,
only when you know you are going to use them.  That is what I meant.

>>> +     if (!strlen(s))
>>> +             return;
>>
>> you return here without doing anything.
>>
>> Worse yet, this logic looks very strange.  If you give it a width of
>> 8 because you want to align like-item on each record at that column,
>> a record with 1-display-column item will be shown in 8-display-column
>> with 7 SP padding (either at the beginning, or at the end, or on
>> both ends to center).  If it happens to be an empty string, the entire
>> 8-display-column disappears.
>>
>> Is that really what you meant to do?  The logic does not make much
>> sense to me, even though the code may implement that logic correctly
>> and clearly.
>
> Not sure what you meant.
> But this does not act on empty strings and that was intentional.

If it is truly intentional, then the design is wrong.  You are
writing a public function that can be called by other people.

Which one makes more sense?  Remember that you are going to have
many callers over time in the course of project in the future.

 (A) The caller is forced to always check the string that he is
     merely passing on, i.e.

	struct strbuf buf = STRBUF_INIT;
        struct strbuf out = STRBUF_INIT;

	fill_some_placeholder(&buf, fmt, args);
        if (buf.len)
        	strbuf_utf8_align(&out, ALIGN_LEFT, 8, buf.buf);
        else
        	strbuf_addchars(&out, ' ', 8);

     only because the callee strbuf_utf8_align() refuses to do the
     trivial work.

 (B) The caller does not have to care, i.e.

	struct strbuf buf = STRBUF_INIT;
        struct strbuf out = STRBUF_INIT;

	fill_some_placeholder(&buf, fmt, args);
       	strbuf_utf8_align(&out, ALIGN_LEFT, 8, buf.buf);

> It
> does not make
> sense to have an alignment on an empty string, where the caller could themselves
> just do a `strbuf_addchars(&buf, " ", width)`.

It simply does not make sense to force the caller to even care.
What they want is a series of lines, whose columns are aligned.

>>> +     if (display_len >= width) {
>>> +             strbuf_addstr(buf, s);
>>> +             return;
>>> +     }
>>
>> Mental note: this function values the information more than
>> presentation; it refuses to truncate (to lose information) and
>> instead accepts jaggy output.  OK.
>
> With regards to its usage in ref-filter, this is needed, don't you think?

That is exactly why I said "OK".

I was primarily trying to lead other reviewers by example,
demonstrating that a review will become more credible if it shows
that the reviewer actually read the patch by explaining the thinking
behind what the code does in his own words.  I see too many "FWIW,
reviewed by me" without indicating if it is "from just a cursory
read it looks nice" or "I fully read and understood it and I agree
with the design choices it makes", which does not help me very much
when queuing a patch.
