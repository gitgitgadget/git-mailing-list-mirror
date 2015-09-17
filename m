From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] dir.c: don't exclude whole dir prematurely if neg
 pattern may match
Date: Thu, 17 Sep 2015 20:21:51 +0700
Message-ID: <CACsJy8BjyQj0ccmRFSQ5fsYpRtL909828Qv_cauhMpF9nbGU7g@mail.gmail.com>
References: <1440334214-32131-1-git-send-email-pclouds@gmail.com>
 <1442107141-24265-1-git-send-email-pclouds@gmail.com> <1442107141-24265-3-git-send-email-pclouds@gmail.com>
 <xmqqd1xkylb4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 15:22:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcZ8x-0002Zc-9c
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 15:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbbIQNWW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2015 09:22:22 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37041 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbbIQNWV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2015 09:22:21 -0400
Received: by igbni9 with SMTP id ni9so13673609igb.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 06:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HIWjHISPjptpbbflJRNyMejgTRdbSnG0dv3UTyWcJ0I=;
        b=Mz7Katt4QhjGunv4Pv2IO+prJAjnLRg9c5CF6bRN5cs1jf2MGK8JBn/z8ZYGKmiNmr
         rhX285mpwIqCxqpmj5LC2l+ANkLo8vaU7UJQUu352vKbGfKpyd2TtENAY9hYr/2A2zRw
         JmsWBg8VXZ578lsoIIa0H3oG8bv3hj8J/I8Nf/l9nqxCJnH60AkJsRhZkT/zFM0aAlBf
         PNkKLEOwVasBd5Ya2W0it9Bjs0OMXOnHO718z94VyI8MbR8h4PnKbbeFt2UQXMucOUJn
         7Z8HiyfflDrG4MN1Z/LUrjNlulvfLyjEphWoMTiQI/ijRSV/xALvvEI4VKHktWw5uQU/
         2cQA==
X-Received: by 10.50.59.211 with SMTP id b19mr24897467igr.42.1442496141024;
 Thu, 17 Sep 2015 06:22:21 -0700 (PDT)
Received: by 10.107.19.227 with HTTP; Thu, 17 Sep 2015 06:21:51 -0700 (PDT)
In-Reply-To: <xmqqd1xkylb4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278114>

On Tue, Sep 15, 2015 at 12:15 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.t=
xt
>> index 473623d..889a72a 100644
>> --- a/Documentation/gitignore.txt
>> +++ b/Documentation/gitignore.txt
>> @@ -82,12 +82,9 @@ PATTERN FORMAT
>>
>>   - An optional prefix "`!`" which negates the pattern; any
>>     matching file excluded by a previous pattern will become
>> +   included again. It is possible to re-include a file if a parent
>> +   directory of that file is excluded, with restrictions. See secti=
on
>> +   NOTES for detail.
>
> Sounds like a very useful thing.
>
>>   - If the pattern ends with a slash, it is removed for the
>>     purpose of the following description, but it would only find
>> @@ -141,6 +138,18 @@ not tracked by Git remain untracked.
>>  To stop tracking a file that is currently tracked, use
>>  'git rm --cached'.
>>
>> +To re-include a file when its parent directory is excluded, the
>> +following conditions must be met:
>> +
>> + - The directory part in the re-include rules must be literal (i.e.=
 no
>> +   wildcards)
>> +
>> + - The rules to exclude the parent directory must not end with a
>> +   trailing slash.
>> +
>> + - The rules to exclude the parent directory must have at least one
>> +   slash.
>> +
>
> In this bulletted list, don't the readers also need to be told that
> having "/abc" in .gitignore (but not "!/abc/anything" in .gitignore)
> and "!foo" in abc/.gitignore would not cause us to descend into
> "/abc" just to examine "abc/.gitignore" with pessimistic assumption
> that there might be some exclusion in there?

Yeah I thought it was already mentioned. I guess it's just in my mind.
Will update.

>> diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-o=
thers-exclude.sh
>> index 3fc484e..9de49a6 100755
>> --- a/t/t3001-ls-files-others-exclude.sh
>> +++ b/t/t3001-ls-files-others-exclude.sh
>> @@ -305,4 +305,24 @@ test_expect_success 'ls-files with "**" pattern=
s and no slashes' '
>>       test_cmp expect actual
>>  '
>>
>> +test_expect_success 'negative patterns' '
>> +     git init reinclude &&
>> +     (
>> +             cd reinclude &&
>> +             cat >.gitignore <<-\EOF &&
>> +             /foo
>> +             !foo/bar/bar
>> +             EOF
>> +             mkdir -p foo/bar &&
>> +             touch abc foo/def foo/bar/ghi foo/bar/bar &&
>> +             git ls-files -o --exclude-standard >../actual &&
>> +             cat >../expected <<-\EOF &&
>> +             .gitignore
>> +             abc
>> +             foo/bar/bar
>> +             EOF
>> +             test_cmp ../expected ../actual
>> +     )
>> +'
>
> And another test here may want to explicitly ensure that we are not
> overly pessimising the ignore processing, so that later changes will
> not break it, I think.

Yep. Will do.
--=20
Duy
