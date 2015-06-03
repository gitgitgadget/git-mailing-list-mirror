From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP 6/8] am: extract patch, message and authorship with git-mailinfo
Date: Wed, 3 Jun 2015 15:56:46 +0800
Message-ID: <CACRoPnQA9SyNzudEdw60UWsMFNQt90AGoi=ge3Oh-LQB02=cFg@mail.gmail.com>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
	<1432733618-25629-7-git-send-email-pyokagan@gmail.com>
	<xmqqtwuxkaxh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 09:57:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z03Xh-0002Gg-TU
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 09:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713AbbFCH4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 03:56:48 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35072 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672AbbFCH4r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 03:56:47 -0400
Received: by lbbuc2 with SMTP id uc2so1479989lbb.2
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 00:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=m86sAY/hnLUc3S/da3RMZ+hn9guUno2T2T47oCnDA7M=;
        b=oV1gW90bh44hiAGiHBrBtYNfClBSRKx7dcwTU5OnSo18cMWp7TqVrs22QmivzqUaJq
         OvVF14z+bCq7TVcUNPaKCEgQRYKMhFGGkd7skiXnFFot5Z6W8gOoyMBh0iqRnr52DNQr
         1P4nYiPfJyTrQG4eXZ22PdEAMW7U8I6zeQpXVVUO2nFn62kN6SSAEkITbQEKqvLXfr7Y
         85kAKaAA1gI1+ilDMDf4zwBfl8D1Jg3o0MTVm+aF1g/mKdTmLxI4WWrSmYTu7xrVrH1I
         c3QpLkeYitTg+fQrpN5Iz7eZ6OiplZX7QMkJkmNxNrZbDvFMRg5HUGiLp3HKVEO46yCF
         4Rsg==
X-Received: by 10.152.87.13 with SMTP id t13mr31136032laz.66.1433318206343;
 Wed, 03 Jun 2015 00:56:46 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 3 Jun 2015 00:56:46 -0700 (PDT)
In-Reply-To: <xmqqtwuxkaxh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270661>

On Thu, May 28, 2015 at 4:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> @@ -17,6 +34,10 @@ struct am_state {
>>       struct strbuf dir;            /* state directory path */
>>       int cur;                      /* current patch number */
>>       int last;                     /* last patch number */
>> +     struct strbuf msg;            /* commit message */
>> +     struct strbuf author_name;    /* commit author's name */
>> +     struct strbuf author_email;   /* commit author's email */
>> +     struct strbuf author_date;    /* commit author's date */
>>       int prec;                     /* number of digits in patch filename */
>>  };
>
> I always get suspicious when structure fields are overly commented,
> wondering if it is a sign of naming fields poorly.  All of the above
> fields look quite self-explanatory and I am not sure if it is worth
> having these comments, spending efforts to type SP many times to
> align them and all.

Okay, I'll take Jeff's suggestion to organize them into blocks.

>> +static int read_author_script(struct am_state *state)
>> +{
>> +     char *value;
>> +     struct strbuf sb = STRBUF_INIT;
>> +     const char *filename = am_path(state, "author-script");
>> +     FILE *fp = fopen(filename, "r");
>> +     if (!fp) {
>> +             if (errno == ENOENT)
>> +                     return 0;
>> +             die(_("could not open '%s' for reading"), filename);
>
> Hmph, do we want to report with die_errno()?

Yes, we do.

>> +     }
>> +
>> +     if (strbuf_getline(&sb, fp, '\n'))
>> +             return -1;
>> +     if (!skip_prefix(sb.buf, "GIT_AUTHOR_NAME=", (const char**) &value))
>
> This cast is unfortunate; can't "value" be of "const char *" type?

We can't, because sq_dequote() modifies the string directly. I would
think casting from non-const to const is safer than the other way
around.

Thanks,
Paul
