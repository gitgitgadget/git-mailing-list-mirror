From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10 04/13] utf8: add function to align a string into given strbuf
Date: Wed, 12 Aug 2015 22:40:23 +0530
Message-ID: <CAOLa=ZSKMfDS=mby1OyNLziF7bX_3kGAhhLTRM6DUL-zn-21eQ@mail.gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
 <1439129506-9989-5-git-send-email-Karthik.188@gmail.com> <xmqq8u9hsn0j.fsf@gitster.dls.corp.google.com>
 <CAOLa=ZRL-WV=9Q+_fo7wcbqT7jZVA02oYo8SfDcLrev=qsUvLg@mail.gmail.com> <xmqq37zompd7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 19:10:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPZYI-0007f3-SW
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 19:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934091AbbHLRKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 13:10:54 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36333 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932153AbbHLRKx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 13:10:53 -0400
Received: by oiev193 with SMTP id v193so12551442oie.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=glZt0q5gx6Aq3Vr2xfweE6/Iin8J3iQp+uz4mMUnNvE=;
        b=E/VKMB1Ofte9PU+dy3YZ4yWb2AjHg3zHei9xHGV8uGRXT3Z7OcrCRmEOMxcQsla0wR
         5Q8PCCAHastkTZxIqkJDI+9M1fMwWc/U+0inusKOQ06KA7+SkcveTXI+Fafs7L72adrG
         gKQhuWl4PerawR1Xyir3QeZM72pVX1eF6pFcbyoyrokvdiKjNeN90SDDEnMyOOQYJDzP
         knsBgpghdDF9llE0bKVb0xkQNDuz5stD3RDRXRbgTbNLbJQIX8wUciwb7EmY83rRD2IS
         Pxp2A6b6NvHrPDfGy+1c/SGmZS3ZCv7fUss9kr+sp1erVelO5boJ3FmgTrSvgoZdqjvD
         Pf5w==
X-Received: by 10.202.200.75 with SMTP id y72mr29977332oif.111.1439399452849;
 Wed, 12 Aug 2015 10:10:52 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 12 Aug 2015 10:10:23 -0700 (PDT)
In-Reply-To: <xmqq37zompd7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275784>

On Wed, Aug 12, 2015 at 10:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Tue, Aug 11, 2015 at 11:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> +void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
>>>> +                    const char *s)
>>>> +{
>>>> +     int display_len = utf8_strnwidth(s, strlen(s), 0);
>>>> +     int utf8_compenstation = strlen(s) - display_len;
>>>
>>> compensation, perhaps?  But notice you are running two strlen and
>>> then also a call to utf8-strnwidth here already, and then
>>>
>>
>> compensation it is.
>> probably have a single strlen() call and set the value to another variable.
>
> That is not what I meant.  If you want to keep the early return of
> "doing nothing for an empty string" (which you should *NOT*, by the
> way), declare these variables upfront, do the early return and then
> call utf8_strnwidth() to compute the value you are going to use,
> only when you know you are going to use them.  That is what I meant.
>

Oh okay, after reading your mail now that makes sense.

>>>> +     if (!strlen(s))
>>>> +             return;
>>>
>>> you return here without doing anything.
>>>
>>> Worse yet, this logic looks very strange.  If you give it a width of
>>> 8 because you want to align like-item on each record at that column,
>>> a record with 1-display-column item will be shown in 8-display-column
>>> with 7 SP padding (either at the beginning, or at the end, or on
>>> both ends to center).  If it happens to be an empty string, the entire
>>> 8-display-column disappears.
>>>
>>> Is that really what you meant to do?  The logic does not make much
>>> sense to me, even though the code may implement that logic correctly
>>> and clearly.
>>
>> Not sure what you meant.
>> But this does not act on empty strings and that was intentional.
>
> If it is truly intentional, then the design is wrong.  You are
> writing a public function that can be called by other people.
>
> Which one makes more sense?  Remember that you are going to have
> many callers over time in the course of project in the future.
>
>  (A) The caller is forced to always check the string that he is
>      merely passing on, i.e.
>
>         struct strbuf buf = STRBUF_INIT;
>         struct strbuf out = STRBUF_INIT;
>
>         fill_some_placeholder(&buf, fmt, args);
>         if (buf.len)
>                 strbuf_utf8_align(&out, ALIGN_LEFT, 8, buf.buf);
>         else
>                 strbuf_addchars(&out, ' ', 8);
>
>      only because the callee strbuf_utf8_align() refuses to do the
>      trivial work.
>
>  (B) The caller does not have to care, i.e.
>
>         struct strbuf buf = STRBUF_INIT;
>         struct strbuf out = STRBUF_INIT;
>
>         fill_some_placeholder(&buf, fmt, args);
>         strbuf_utf8_align(&out, ALIGN_LEFT, 8, buf.buf);
>

Yea, good point here, thanks for putting it out :)

>> It
>> does not make
>> sense to have an alignment on an empty string, where the caller could themselves
>> just do a `strbuf_addchars(&buf, " ", width)`.
>
> It simply does not make sense to force the caller to even care.
> What they want is a series of lines, whose columns are aligned.
>

My ignorance, sorry!

>>>> +     if (display_len >= width) {
>>>> +             strbuf_addstr(buf, s);
>>>> +             return;
>>>> +     }
>>>
>>> Mental note: this function values the information more than
>>> presentation; it refuses to truncate (to lose information) and
>>> instead accepts jaggy output.  OK.
>>
>> With regards to its usage in ref-filter, this is needed, don't you think?
>
> That is exactly why I said "OK".
>
> I was primarily trying to lead other reviewers by example,
> demonstrating that a review will become more credible if it shows
> that the reviewer actually read the patch by explaining the thinking
> behind what the code does in his own words.  I see too many "FWIW,
> reviewed by me" without indicating if it is "from just a cursory
> read it looks nice" or "I fully read and understood it and I agree
> with the design choices it makes", which does not help me very much
> when queuing a patch.
>
>

Ah! okay! was just wondering if you were looking for an explanation :)

-- 
Regards,
Karthik Nayak
