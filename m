From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] dir.c: allow re-include after a dir is excluded in some cases
Date: Thu, 20 Nov 2014 07:27:06 +0700
Message-ID: <CACsJy8DyPoXwAKF4h1sj2QOevN96QSUcJqOBmm1FSim8MKT4_A@mail.gmail.com>
References: <CACsJy8BHvucnEAW065OXOe5NBQkxp7+8HJb7XCGYgOa=pkxLVA@mail.gmail.com>
 <1416393058-5497-1-git-send-email-pclouds@gmail.com> <xmqqmw7nrpqh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: phil-gitml@phil.spodhuis.org,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 01:27:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrFb5-0006Mw-4v
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 01:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756211AbaKTA1i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Nov 2014 19:27:38 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:45438 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755487AbaKTA1h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Nov 2014 19:27:37 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so1747116ieb.12
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 16:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HRDvJbxamDdlU2ga02cIoPVxRH+g93I7cwMhWHiAXYU=;
        b=KfsCMqX+OYpHLnv1ZDwiFHz7YImNQml+WmbEHphizMi7/c55pgyaCJ8I/75gHboiIv
         MhOt9jUTjkxG4MgFeEwlFm8NtdSMRXv2yeg4+FjU6Hv6zwNKLCUSrvSH1B2f+dkVYSN6
         UzCDPT9nGWMrbx+i9/ONzUFVx71nGRMC2tnkbtT6BOqk/6yEgnYRpB4P24j3nsnJJdKf
         X4zBZswXs2HKK+lknmOZxsPKPOB0S1AZIRvI46MqxQg8Z8HP/rrJbGqVo91nYgQ3NGMW
         ocW4MzQ8IvCbAsTNPEIi+Mt+oXaymiY+ciwgBQ0b+LZLfqVqN1ur2jNMxykZnpBvoP4M
         xsbA==
X-Received: by 10.42.88.2 with SMTP id a2mr5377897icm.11.1416443256455; Wed,
 19 Nov 2014 16:27:36 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Wed, 19 Nov 2014 16:27:06 -0800 (PST)
In-Reply-To: <xmqqmw7nrpqh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 20, 2014 at 1:48 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.t=
xt
>> index 09e82c3..0340c44 100644
>> --- a/Documentation/gitignore.txt
>> +++ b/Documentation/gitignore.txt
>> @@ -82,10 +82,9 @@ PATTERN FORMAT
>>
>>   - An optional prefix "`!`" which negates the pattern; any
>>     matching file excluded by a previous pattern will become
>> -   included again. It is not possible to re-include a file if a par=
ent
>> -   directory of that file is excluded. Git doesn't list excluded
>> -   directories for performance reasons, so any patterns on containe=
d
>> -   files have no effect, no matter where they are defined.
>> +   included again.
>> +   It is usually not possible to re-include a file if a parent
>> +   directory of that file is excluded. See NOTES for details.
>>     Put a backslash ("`\`") in front of the first "`!`" for patterns
>>     that begin with a literal "`!`", for example, "`\!important!.txt=
`".
>>
>> @@ -144,6 +143,12 @@ use 'git update-index {litdd}assume-unchanged'.
>>  To stop tracking a file that is currently tracked, use
>>  'git rm --cached'.
>>
>> +It is usually not possible to re-include a file if a parent directo=
ry
>> +of that file is excluded because of performance reasons. However, i=
f
>> +there are negative rules in the same .gitignore file that contains =
the
>> +rule to ignore a specific directory, and those negative rules conta=
in
>> +a slash, then re-inclusion is possible.
>
> Does that mean "performance reasons" goes out the window???
>
> What trade-off are the users making by choosing to do so?  Is it
> explained in the documentation well enough to allow them to make an
> informed decision?

If they put "!**/foo" there, I think it's obvious for users that all
dirs must be looked at. "!a*/**/foo" may be expected to only look at a
subset of dirs recursively, instead of everything. "!*/def" may be
expected that only one more level of directories are looked at. I
didn't cover the last two cases well and I don't think it'll be easy
to do. Which makes this patch less appealing. (so much for a
not-thoroughly-thought-through quick prototype)

Perhaps I look at it from a wrong angle. If we have a way to say
"these patterns do not apply to directories", then the user can
selectively exclude certain directories and let others through. It
would give the user more control and make the travelling cost more
apparent (assuming we mention somewhere that the more dirs we examine,
the longer it will take).
--=20
Duy
