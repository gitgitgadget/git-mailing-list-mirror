From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10 04/13] utf8: add function to align a string into given strbuf
Date: Wed, 12 Aug 2015 19:11:05 +0530
Message-ID: <CAOLa=ZRL-WV=9Q+_fo7wcbqT7jZVA02oYo8SfDcLrev=qsUvLg@mail.gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
 <1439129506-9989-5-git-send-email-Karthik.188@gmail.com> <xmqq8u9hsn0j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 15:41:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPWHl-0008JE-DM
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 15:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934263AbbHLNlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 09:41:37 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:32838 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934252AbbHLNlf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 09:41:35 -0400
Received: by oio137 with SMTP id 137so9116612oio.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=c8kimEJiph9lkZWXVui4oREGiUFivDxNu9bpaqcUnmo=;
        b=RWA3zRzT25Fa+K6X4U0zXYWEeqHFLZe4h8CRHvnAX8AlT6Z5CzHrIowG2A0FwudCdy
         mGAoMTIXgmNWwOqSxCetBfTF8cLEDDLuz0QWUEs31H+JNfM4Cye7+YH7HHHQbyh/NYB8
         qFuqzJfm+QSjRH7kLIAyrJVRx9d4SArN7AJysR0JfK8IZZQF4L/L32MMGkZtkQwHfMGf
         +ONPMrnaOv9qmKvVlgj/bZqV/YN4nCPV0juEdvzv7/1VmLGWgBvCHi2SIiiinBIHHdCu
         EDoBJP8D/49J5SMwtZgoX8MyNcwb1yOIESFI5mdotE2xb54I9awpl/bsPxvJ7fZQhu3g
         0W1A==
X-Received: by 10.202.225.130 with SMTP id y124mr29103781oig.102.1439386895023;
 Wed, 12 Aug 2015 06:41:35 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 12 Aug 2015 06:41:05 -0700 (PDT)
In-Reply-To: <xmqq8u9hsn0j.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275767>

On Tue, Aug 11, 2015 at 11:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
>> +                    const char *s)
>> +{
>> +     int display_len = utf8_strnwidth(s, strlen(s), 0);
>> +     int utf8_compenstation = strlen(s) - display_len;
>
> compensation, perhaps?  But notice you are running two strlen and
> then also a call to utf8-strnwidth here already, and then
>

compensation it is.
probably have a single strlen() call and set the value to another variable.

>> +     if (!strlen(s))
>> +             return;
>
> you return here without doing anything.
>
> Worse yet, this logic looks very strange.  If you give it a width of
> 8 because you want to align like-item on each record at that column,
> a record with 1-display-column item will be shown in 8-display-column
> with 7 SP padding (either at the beginning, or at the end, or on
> both ends to center).  If it happens to be an empty string, the entire
> 8-display-column disappears.
>
> Is that really what you meant to do?  The logic does not make much
> sense to me, even though the code may implement that logic correctly
> and clearly.
>

Not sure what you meant.
But this does not act on empty strings and that was intentional. It
does not make
sense to have an alignment on an empty string, where the caller could themselves
just do a `strbuf_addchars(&buf, " ", width)`.

>> +     if (display_len >= width) {
>> +             strbuf_addstr(buf, s);
>> +             return;
>> +     }
>
> Mental note: this function values the information more than
> presentation; it refuses to truncate (to lose information) and
> instead accepts jaggy output.  OK.
>

With regards to its usage in ref-filter, this is needed, don't you think?

>> +     if (position == ALIGN_LEFT)
>> +             strbuf_addf(buf, "%-*s", width + utf8_compenstation, s);
>> +     else if (position == ALIGN_MIDDLE) {
>> +             int left = (width - display_len)/2;
>> +             strbuf_addf(buf, "%*s%-*s", left, "", width - left + utf8_compenstation, s);
>> +     } else if (position == ALIGN_RIGHT)
>> +             strbuf_addf(buf, "%*s", width + utf8_compenstation, s);
>> +}

Thanks!

-- 
Regards,
Karthik Nayak
