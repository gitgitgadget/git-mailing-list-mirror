From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v9 01/11] ref-filter: print output to strbuf for formatting
Date: Fri, 7 Aug 2015 08:54:51 +0530
Message-ID: <CAOLa=ZT541+4say3jrqJVK7QgFFwYg3jVJ00nBtGAVzwMTU3CA@mail.gmail.com>
References: <CAOLa=ZSBMk9y1VGTVKSVsGMdYuPtjhPADciVUaEVwESRdSvWZg@mail.gmail.com>
 <1438692188-14367-1-git-send-email-Karthik.188@gmail.com> <CAPig+cT6uu3DqUB+5gR35JS2eigPBizo_Y48rAzFYkbyCm+=OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 05:25:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNYHf-000518-4s
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 05:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbbHGDZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 23:25:22 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35762 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbbHGDZV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 23:25:21 -0400
Received: by oihn130 with SMTP id n130so50268977oih.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 20:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XaHNKr2kGcsM2PWudNYqTdIomaSjEuLdXYuQTPbUySg=;
        b=LryPywTlZ8w0gqERf7MBDxFFy05J8TvLrPzy0D3QvpKIW2SGNYc7WHkwCRyG/Vb9Q7
         Avqm2caN6OT6i9/rirv/z6vBjgG6utQwdqoMaY3wkP+lIX2z1dBd/cpf3UfYDCU5wJdL
         OS9qjcjiznvRaUJDCOBRxscSK8FuXy6uLU55OhMEY7/hszq4gr9lPunRzMq6gd4N+0rr
         wRhu/Amd8+/E241EDwN6BSiw8zwYCyWZJhA2viowy1uwsZv5+oC5W0YXoJWkhbNbBOoL
         JwHp6om8BrbHoUpmZqBGCc7kkFDO2URS2KCkhVNjYhPGsZQNjtsmdU+8TPhuw1zUBApR
         HDRQ==
X-Received: by 10.202.200.75 with SMTP id y72mr4438103oif.111.1438917920428;
 Thu, 06 Aug 2015 20:25:20 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Thu, 6 Aug 2015 20:24:51 -0700 (PDT)
In-Reply-To: <CAPig+cT6uu3DqUB+5gR35JS2eigPBizo_Y48rAzFYkbyCm+=OQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275455>

On Fri, Aug 7, 2015 at 3:51 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Aug 4, 2015 at 8:42 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce a strbuf `output` which will act as a substitute rather than
>> printing directly to stdout. This will be used for formatting
>> eventually.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 46963a5..91482c9 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1278,9 +1275,12 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>>                 if (color_parse("reset", color) < 0)
>>                         die("BUG: couldn't parse 'reset' as a color");
>>                 resetv.s = color;
>> -               print_value(&resetv, quote_style);
>> +               print_value(&resetv, quote_style, &output);
>>         }
>> +       for (i = 0; i < output.len; i++)
>> +               printf("%c", output.buf[i]);
>
> Everything up to this point seems straightforward, however, it's not
> clear why you need to emit 'output' one character at a time. Is it
> because it might contain a NUL '\0' character and therefore you can't
> use the simpler printf("%s", output.buf)?
>
> If that's the case, then why not just use fwrite() to emit it all at once?
>
>     fwrite(output.buf, output.len, 1, stdout);
>

It was to avoid the printing to stop at '\0' as you mentioned.
I've never come across such a situation before, so I looked for
similar implementations online, and found the individual character printing.
Thanks `fwrite` seems neater.


-- 
Regards,
Karthik Nayak
