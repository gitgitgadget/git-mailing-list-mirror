From: Aleksander Boruch-Gruszecki <aleksander.boruchgruszecki@gmail.com>
Subject: Re: [PATCH v2] merge-file: correctly open files when in a subdir
Date: Wed, 11 Feb 2015 10:58:51 +0100
Message-ID: <CAPHKiG6M9_fOjpx8Pt8UTpUcrS+tmqL3YcT11WyJJu8m6nkJ4A@mail.gmail.com>
References: <CAPHKiG7vzKbtH7=cXD-7Cta=a-iy-ViMustn98z+VEog5ep2sg@mail.gmail.com>
	<xmqqwq3pv60p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 11:10:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLUFn-0004Oe-9I
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 11:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbbBKKK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2015 05:10:27 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:54553 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbbBKKK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2015 05:10:26 -0500
Received: by mail-qa0-f45.google.com with SMTP id j7so1801772qaq.4
        for <git@vger.kernel.org>; Wed, 11 Feb 2015 02:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kcXAGc2FUt750t479zcahgPX8QJDyKgJm/K9vWUg5uI=;
        b=SzD/Q5A41xlr6lGq9OJNEEXoV6WAXtsYJwOm3N6t7PHH9IaBFZroslzFTyms00D8E6
         h+ylUWIxxUxwQyPQX4iTrUIOXWKKkLj8j+yOxR/Mkr18LIXD/hYc8lDkWmCth7VFhBO8
         U/dPD5kxLb4mSaJFQ/vnOS3z+Fq391o+AB6shzNp59jyRVWxRZRLH/unbSejmTRYOlxz
         k5WJdXsTE/kuPSCw7q4Neiq4NAhZrY4J1Uyh+/60T7uPDZMTmFOCX0pAkOT6Gy8FdjIP
         t78R9uff78/7xsg/8Bn37PPUbEvOFM5jF/ZxTKCXIUikgnKUo5/nMz8ZHyvRZA/7cLdM
         /Zmw==
X-Received: by 10.229.175.131 with SMTP id ba3mr17680839qcb.3.1423648731695;
 Wed, 11 Feb 2015 01:58:51 -0800 (PST)
Received: by 10.140.83.166 with HTTP; Wed, 11 Feb 2015 01:58:51 -0800 (PST)
In-Reply-To: <xmqqwq3pv60p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263671>

>>          const char *filename = argv[0];
>> -        FILE *f = to_stdout ? stdout : fopen(filename, "wb");
>> +        const char *fpath = prefix_filename(prefix, prefixlen, argv[0]);
>> +        FILE *f = to_stdout ? stdout : fopen(fpath, "wb");
>>
>>          if (!f)
>>              ret = error("Could not open %s for writing", filename);
>> diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
>> index 3758961..fdd104c 100755
>> --- a/t/t6023-merge-file.sh
>> +++ b/t/t6023-merge-file.sh
>> @@ -72,6 +72,12 @@ test_expect_success 'works in subdirectory' '
>>      ( cd dir && git merge-file a.txt o.txt b.txt )
>>  '
>>
>> +mkdir -p dir/deep
>> +cp new1.txt orig.txt new2.txt dir/deep
>> +test_expect_success 'accounts for subdirectory when writing' '
>> +    (cd dir && git merge-file deep/new1.txt deep/orig.txt deep/new2.txt)
>> +'
>
> Interesting.  Makes us wonder why the one before this new one you
> added did not catch the issue, doesn't it?

The test before the one added by me does work because merge-file
tries to open "a.txt" for writing in repo root directory, which will create
a file if it does not exist. If you add a directory before the file, trying to
open it will fail. I will additionally check of the file's content to make
the test more clear, however it does actually fail with git 2.3.0.

The issue with line-wrapping and tab changing to space is my own
stupidity, I used an older config with my vim and it mangled the file.
It also probably is what caused the patch to not apply properly.
