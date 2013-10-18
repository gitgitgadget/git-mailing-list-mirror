From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] sha1_file.c:create_tmpfile(): Fix race when creating
 loose object dirs
Date: Fri, 18 Oct 2013 17:41:54 +0200
Message-ID: <CALKQrgcc6gXcthgZgrGS6YA0b8KmnaG=WO=Eu_YQc9pgjRRj6Q@mail.gmail.com>
References: <1382102267-18151-1-git-send-email-johan@herland.net>
	<CACsJy8C=kaa2OgdxOrefP+Ck_sSA00tHs9UqMXwkh9v4K3Mdvg@mail.gmail.com>
	<CACsJy8ChkKQJJfV1G6DUQgq1Pwy7Hki1qkD8V4FsLC0bN362PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 17:42:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXCC3-0008NW-7D
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 17:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154Ab3JRPmC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 11:42:02 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:50284 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755938Ab3JRPmA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 11:42:00 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VXCBa-0008Ef-UZ
	for git@vger.kernel.org; Fri, 18 Oct 2013 17:41:58 +0200
Received: from mail-pb0-f45.google.com ([209.85.160.45])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VXCBa-0009Nu-MQ
	for git@vger.kernel.org; Fri, 18 Oct 2013 17:41:58 +0200
Received: by mail-pb0-f45.google.com with SMTP id mc17so3995996pbc.4
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 08:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MsK61nl+Yb1s16kpwSTGOAk9E0XDkpAf3xBjhIFywJQ=;
        b=G3rleOl94G6tGFVCTNwN76qlLcEAiRbLYJrSHUYzrhGQBFtMzo+nb8T5GYoOTfugnK
         A62PvwuyJr7F4kgVj4MFiSZIIqYCmHC0NY/95brpuS25nOolq8henlTVeJsEdTJvchMu
         m8DdjxOohE/sF7aYKQvjP9jVHiSdoRl8NTNUIMttTdXLq8USFaQa9us8w32LZyS/ywP+
         YlIlwXb2rq7voEpdl3Xx/n4q84PVTvburamFUbDd8ejFv5QBMIXbbJ3tOorCBl6h/4be
         7y4udsyPnhLgp2eq74TLAihmmbbgOXxrkqsFKXxHXdzb9O1fNBrYkwAGBTAmlxDmQG1X
         6S0A==
X-Received: by 10.66.129.169 with SMTP id nx9mr3967270pab.161.1382110914530;
 Fri, 18 Oct 2013 08:41:54 -0700 (PDT)
Received: by 10.70.24.226 with HTTP; Fri, 18 Oct 2013 08:41:54 -0700 (PDT)
In-Reply-To: <CACsJy8ChkKQJJfV1G6DUQgq1Pwy7Hki1qkD8V4FsLC0bN362PA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236355>

On Fri, Oct 18, 2013 at 4:00 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Oct 18, 2013 at 8:55 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Fri, Oct 18, 2013 at 8:17 PM, Johan Herland <johan@herland.net> wrote:
>>> diff --git a/sha1_file.c b/sha1_file.c
>>> index f80bbe4..00ffffe 100644
>>> --- a/sha1_file.c
>>> +++ b/sha1_file.c
>>> @@ -2857,7 +2857,9 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
>>>                 /* Make sure the directory exists */
>>>                 memcpy(buffer, filename, dirlen);
>>>                 buffer[dirlen-1] = 0;
>>> -               if (mkdir(buffer, 0777) || adjust_shared_perm(buffer))
>>> +               if (mkdir(buffer, 0777) && errno != EEXIST)
>>> +                       return -1;
>>> +               if (adjust_shared_perm(buffer))
>>>                         return -1;
>>
>> I was going to ask what if the created directory does not have
>> permission 0777. But adjust_shared_perm follows immediately after, so
>> we're good.
>
> And I sent too early. adjust_shared_perm() does rely on current dir's
> permission. So if the creator does "mkdir(buffer, 0)", we still have a
> bad permission in the end. And adjust_shared_perm() is only active
> when the repository is configured to be shared.

I'm not sure where you're going with this... Whatever happens in
another process between the first call git_mkstemp_mode() and our
mkdir() call, one of three things will happen in this code:

 (a) mkdir() succeeds, i.e. we won the race. This case is unchanged by my patch.

 (b) mkdir() fails with errno != EEXIST. This results in us returning
-1 to our caller. This case is also unchanged by my patch.

 (c) mkdir() fails with EEXIST, i.e. we lost the race. We do the
adjust_shared_perms() which might fail (-> abort) or succeed, and we
then _retry_ the git_mkstemp_mode(). There is no case where the
"whatever" that happened between the first git_mkstemp_mode() and
mkdir() will have a different outcome (create_tmpfile() failing or
suceeding) than if it had happened _before_ the first
git_mkstemp_mode(). And it is not our responsibility to control what
other/unrelated processes might end up doing with directories inside
.git/objects/...

What am I missing?

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
