From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v11 04/13] utf8: add function to align a string into given strbuf
Date: Mon, 17 Aug 2015 18:38:08 +0530
Message-ID: <CAOLa=ZRR8Ytmtj5uo3bPBnkYcGr-vgu-n4hbb4CvKndwc3JeLA@mail.gmail.com>
References: <1439661643-16094-5-git-send-email-Karthik.188@gmail.com> <CAPig+cSV_cfF8y0HVKSU1yBgOxJ0qrejc-7bQPvt-UkUNAtxKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 15:08:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRK9b-0003qn-MU
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 15:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbbHQNIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 09:08:39 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35677 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbbHQNIi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 09:08:38 -0400
Received: by oiew67 with SMTP id w67so60819764oie.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 06:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uvlfodptRvJ8S8S+SaNcTtAOWRhq9ISfHSTCySJg1Iw=;
        b=N6vpntrNLD12alYG9OvP0uKYegt6zfwDnNGYuCkpggxiRjIksPJhPGTMWD+jOGQmlG
         os0xgOC/Ardj3siyc23MiWtEJMvv+MFcWxs1BErJHJveC3ip0kG7oTQiNddRVMlLSBlC
         14eqYszrUNbeXnXQakKKpYkeIMg5YIlLeZNFF7+UzUmbp9ZdwP2gOw+r5KnGYxEoKZSe
         ZYMfBjMWsbme2qRDFD4P/3nQBfczsB3gFtCk17o7kzNlnrTM9ov3K+7ENfaZ7yLQpOzt
         gcSChT6KJGKObvUq7ZhR5BeK6ZvHGI5YbhsRl8W11dGC9NFyI/sDmvRrK8dmg2w95UTn
         UNSA==
X-Received: by 10.202.92.6 with SMTP id q6mr1061022oib.11.1439816917628; Mon,
 17 Aug 2015 06:08:37 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 17 Aug 2015 06:08:08 -0700 (PDT)
In-Reply-To: <CAPig+cSV_cfF8y0HVKSU1yBgOxJ0qrejc-7bQPvt-UkUNAtxKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276050>

On Mon, Aug 17, 2015 at 5:18 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Aug 15, 2015 at 2:00 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Add strbuf_utf8_align() which will align a given string into a strbuf
>> as per given align_type and width. If the width is greater than the
>> string length then no alignment is performed.
>
> A couple minor comments below...
>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/utf8.c b/utf8.c
>> index 28e6d76..0fb8e9d 100644
>> --- a/utf8.c
>> +++ b/utf8.c
>> @@ -644,3 +644,24 @@ int skip_utf8_bom(char **text, size_t len)
>>         *text += strlen(utf8_bom);
>>         return 1;
>>  }
>> +
>> +void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
>> +                      const char *s)
>> +{
>> +       int slen = strlen(s);
>> +       int display_len = utf8_strnwidth(s, slen, 0);
>> +       int utf8_compensation = slen - display_len;
>
> Based upon the previous round review, I think you had intended to name
> this merely 'compensation'.
>

In the last patch it was suggested because I spelled 'compensation' wrong.
I think the "utf8_" makes a good addition to the variable name.

>> +       if (display_len >= width) {
>> +               strbuf_addstr(buf, s);
>> +               return;
>> +       }
>> +
>> +       if (position == ALIGN_LEFT)
>> +               strbuf_addf(buf, "%-*s", width + utf8_compensation, s);
>> +       else if (position == ALIGN_MIDDLE) {
>> +               int left = (width - display_len)/2;
>
> Style: spaces around '/'
>

will add.

>> +               strbuf_addf(buf, "%*s%-*s", left, "", width - left + utf8_compensation, s);
>> +       } else if (position == ALIGN_RIGHT)
>> +               strbuf_addf(buf, "%*s", width + utf8_compensation, s);
>> +}
>> diff --git a/utf8.h b/utf8.h
>> index 5a9e94b..7930b44 100644
>> --- a/utf8.h
>> +++ b/utf8.h
>> @@ -55,4 +55,19 @@ int mbs_chrlen(const char **text, size_t *remainder_p, const char *encoding);
>>   */
>>  int is_hfs_dotgit(const char *path);
>>
>> +typedef enum {
>> +       ALIGN_LEFT,
>> +       ALIGN_MIDDLE,
>> +       ALIGN_RIGHT
>> +} align_type;
>> +
>> +/*
>> + * Align the string given and store it into a strbuf as per the
>> + * 'position' and 'width'. If the given string length is larger than
>> + * 'width' than then the input string is not truncated and no
>> + * alignment is done.
>> + */
>> +void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
>> +                      const char *s);
>> +
>>  #endif
>> --
>> 2.5.0

Thanks for the review.

-- 
Regards,
Karthik Nayak
