From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH] refs.c: change read_ref_at to use the reflog iterators
Date: Tue, 3 Jun 2014 09:08:04 -0700
Message-ID: <CAL=YDWne5G-yePprNm5vdpThmmehEKqAxQQ=J6WWUf+eG34xUg@mail.gmail.com>
References: <1401732941-6498-1-git-send-email-sahlberg@google.com>
	<xmqq4n033t3n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 18:08:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrrFz-0003Nk-Pa
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 18:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbaFCQIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 12:08:07 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:62180 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbaFCQIG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 12:08:06 -0400
Received: by mail-vc0-f182.google.com with SMTP id id10so7092187vcb.13
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 09:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=thFHGkr4M7oeq58TrWPwRFLkK6QuljgBWYMHhT9uuy8=;
        b=ZMNbgOdFtHldTDbxFdGv9AZtCVoJ0jgpHla5y883cBgw8JSTdgEo9WOcDHwQW/m3Gm
         1Y6zdRGA86gdStXbKe8HQ7uloplPvh5C4FMzxhes2D3b5RcBfLzfccuXt/yVhixHsFkd
         5AaVm7gz1eA3LsVXqXJdHSS8ptMqpOycGdjLidtM85DVKDo5m1d1PEXc4yBPpOnllSS0
         tIFsmdsd8+FlxDFUBDSwz6xPBFBq/7C19YRummT70eZDL5uckw/6gsxg7R8Kwuv8K2CF
         bEXWjBwIe9NTa/t6J51bYHhEtsmf4YI/iDplSm41yUroVlinMxNd62MIqPAH5ZdXBZRq
         5KAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=thFHGkr4M7oeq58TrWPwRFLkK6QuljgBWYMHhT9uuy8=;
        b=Jro8dhPLUuzoWHkNBk2UNOTGeqiiKwS7FrKBCEWSD7K1A+7zWPKoDutlWWc1wumJrd
         mpyM3J5rMsd6T9PQRnotQKDeIddV07HUnib1ks1qeJJGbwt/BB/gE6rUZZvDwXYt+Gj6
         0l8j1J7R560w0MTk+PHrjcmUMZvYkvBGMHstvHv4/kfAYcuTZ3yo+J3VxxzO8scmLMRk
         AIX+Iv3ZC0kyTeRj3k+pygJGR4cZsIqaKv4siGbU1zwfB5A/1pzLVtkeLr15k4T28Zj3
         8/hqYOUsmgEWjIcgH4jbr1qFe17ktzn62lCGiFUkre7Lm6NvyFubdeBm6ySWOFwC6D6K
         O6Vw==
X-Gm-Message-State: ALoCoQnlbLIwuL1RMaaHKh40sh11h085kZWsVU2CO7mkVzeWsLRA9G6tha0Omi6BA+vYjUCamMM4
X-Received: by 10.58.82.106 with SMTP id h10mr2879109vey.60.1401811684576;
 Tue, 03 Jun 2014 09:08:04 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Tue, 3 Jun 2014 09:08:04 -0700 (PDT)
In-Reply-To: <xmqq4n033t3n.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250627>

Thanks.

On Mon, Jun 2, 2014 at 2:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> read_ref_at has its own parsing of the reflog file for no really good reason
>> so lets change this to use the existing reflog iterators. This removes one
>> instance where we manually unmarshall the reflog file format.
>>
>> Log messages for errors are changed slightly. We no longer print the file
>> name for the reflog, instead we refer to it as 'Log for ref <refname>'.
>> This might be a minor useability regression, but I don't really think so, since
>> experienced users would know where the log is anyway and inexperienced users
>> would not know what to do about/how to repair 'Log ... has gap ...' anyway.
>>
>> Adapt the t1400 test to handle the change in log messages.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  refs.c                | 202 ++++++++++++++++++++++++++------------------------
>>  t/t1400-update-ref.sh |   4 +-
>>  2 files changed, 107 insertions(+), 99 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 6898263..b45bb2f 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2936,109 +2936,117 @@ static char *ref_msg(const char *line, const char *endp)
>>       return xmemdupz(line, ep - line);
>>  }
>
> If I am not mistaken, this function will become unused with this
> rewrite.  Let's drop it and justify it in the log message.

Done.

>
>> +struct read_ref_at_cb {
>> +     const char *refname;
>> +     unsigned long at_time;
>> +     int cnt;
>> +     int reccnt;
>> +     unsigned char *sha1;
>> +     int found_it;
>> +
>> +     char osha1[20];
>> +     char nsha1[20];
>
> These should be unsigned char, shouldn't they?

Done.

>
>> +     for_each_reflog_ent_reverse(refname, read_ref_at_ent, &cb);
>> +
>> +     if (!cb.reccnt)
>> +             die("Log for %s is empty.", refname);
>> +     if (cb.found_it)
>> +             return 0;
>> +
>> +     for_each_reflog_ent(refname, read_ref_at_ent_oldest, &cb);
>
> Hmph.
>
> We have already scanned the same reflog in the backward direction in
> full.  Do we need to make another call just to pick up the entry at
> the beginning?  Is this because the callback is not told that it is
> fed the last entry (in other words, if there is some clue that this
> is the last call from for-each-reflog-ent-reverse to the callback,
> the callback could record the value it received in its cb-data)?
>

It is mainly because the callback does not provide the information
"this is the last entry".
We could add a flag for that to the callback arguments but I don't
know if it is worth it for this special case
since read_ref_at() for a timestamp that is outside the reflog horizon
should be uncommon.


regards
ronnie sahlberg
