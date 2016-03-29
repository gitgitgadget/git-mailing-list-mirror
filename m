From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH v3] path.c enter_repo(): fix unproper strbuf unwrapping
 and memory leakage
Date: Tue, 29 Mar 2016 10:38:41 +0800
Message-ID: <CAKqreux6XLMGN151fn6xN5PeNURLLWjdBVNjKHLzWOjAm45YOg@mail.gmail.com>
References: <20160325175947.GC10563@sigill.intra.peff.net>
	<1459180638-6034-1-git-send-email-huiyiqun@gmail.com>
	<xmqqwpomxz4v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Your friend <pickfire@riseup.net>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 04:38:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akjYO-0005Kf-3u
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 04:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbcC2Cio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 22:38:44 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33104 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbcC2Cim (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 22:38:42 -0400
Received: by mail-oi0-f65.google.com with SMTP id z7so373223oig.0
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 19:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=7lLyC8VNwH+ChWv2Jg39YkEhDxQM1i1vH2EryQ83NKI=;
        b=MkzqKrMImAkmqMKFTGpbXS6NwuiQvrqYEE9VcwvNbdGq6NtJyBv9K/aTX4LIWtceHa
         jjM9UdAdAf4ICpttQEbBYc9GFWiYdsiEHOHEw5d4ss8c/3cqOvTzSO2uRqfO++0vfuL0
         P4apcCo55cHnaigPpEcbrWIdhn2jISeBmLNajswSs7OD6CdXRwTr60OxQqShBuQ2QlxB
         23FgnVIgZcaqbZ4yqf7oSAB4gMppTk+eD42wCsaUnOpr2G5mVQH3y+4cINFlps5yIb/y
         b034XpBWzqHUmdC5e0CzJimIVvO5K7wB03zK/iL/OHftkDS931cwxSP9ED9Vybgyj2Hb
         SQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=7lLyC8VNwH+ChWv2Jg39YkEhDxQM1i1vH2EryQ83NKI=;
        b=CoAxY3izmeuZyjtDWWflSvnk0jjIVUdBbM0Bsc8Q4RaII3Ga4h0Py8rIg166qZEp+S
         C8K1XYT7Nd1IoVnk99/sBLd3UttLK5XsZAbP1+vtfmlfsnvNs4vMxF7cs9UfWg9EGuMa
         TRYq3FBn/CQxzi3jagyY4iCJG4iUrUyxxDbWVMgnZZ2xE8aSyAl+woAqCHBvZaoCNdSx
         LBxv6y9u6KTcgqhygqel0EhBQIuISU3HegvPobcnNvVbcx9c3pTvgBPd6yaec0LF/4Zc
         6gbWvbUCfqVksqZfTE42k/+JC6eOVkF9HmkJgW4Wa38frGHkgUF2x4Ffmet4+KGJmiFq
         /kHg==
X-Gm-Message-State: AD7BkJI++m2kYMYl0wuWLWayiZlvyjWbT6qkmNajzR4VnrAFwV4DYdI2Vp6LOKNSrGV+9FiPhC8dZa/pwFx+xA==
X-Received: by 10.157.49.116 with SMTP id v49mr13958273otd.97.1459219121984;
 Mon, 28 Mar 2016 19:38:41 -0700 (PDT)
Received: by 10.157.12.170 with HTTP; Mon, 28 Mar 2016 19:38:41 -0700 (PDT)
In-Reply-To: <xmqqwpomxz4v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290097>

2016-03-29 1:58 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Hui Yiqun <huiyiqun@gmail.com> writes:
>
>> According to strbuf.h, strbuf_detach is the sole supported method
>> to unwrap a memory buffer from its strbuf shell.
>> ...
>> diff --git a/path.c b/path.c
>> index 969b494..9801617 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -625,6 +625,7 @@ const char *enter_repo(const char *path, int strict)
>>  {
>>       static struct strbuf validated_path = STRBUF_INIT;
>>       static struct strbuf used_path = STRBUF_INIT;
>> ...
>> +return_null:
>> +     free(dbuf);
>> +     strbuf_release(&used_path);
>> +     strbuf_release(&validated_path);
>>       return NULL;
>>  }
>
> I see these strbuf's are "static" storage class, so that they do not
> have to get freed.

I see, thanks.
