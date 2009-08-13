From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v3 3/8] Read .gitignore from index if it is 
	assume-unchanged
Date: Thu, 13 Aug 2009 13:37:21 +0700
Message-ID: <fcaeb9bf0908122337j7d783f59l8ce7a125bf0dbc7e@mail.gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> 
	<1250005446-12047-2-git-send-email-pclouds@gmail.com> <1250005446-12047-3-git-send-email-pclouds@gmail.com> 
	<1250005446-12047-4-git-send-email-pclouds@gmail.com> <7vocqlbv7a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 08:37:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbTwd-00081i-JE
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 08:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbZHMGhl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2009 02:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752348AbZHMGhl
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 02:37:41 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:35437 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbZHMGhk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2009 02:37:40 -0400
Received: by yxe5 with SMTP id 5so736901yxe.33
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 23:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=72lanWD+MnL0XZ9ueOgZ8Iiw/xwYO7aXtLIQuIqhKIs=;
        b=C7dWXbhpeH1/gP/IIesPokm6ZdIueBpBTfiNfj6PlbAoeR++pUCQYbqKZQ67zWuVgI
         DUqcv7Yt6p3RzOM6yxBayikpny8/TZWVkGAc3KEovv5IC1OMONavhLUl+4hMSKwIh77x
         MsjwaiEmxWYIpCtG8jo1ZXpdGv+hzLuym7dGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oepQwfAMlRzS6Lgdq7opIxi2gclVWecIQECI0vTX3poY9DsRpDQIUjnfSiRX+8yI/s
         33QWvcWJjv86LUhfqf4/dvKr/2N1yXw5imrqXGcYqRWcUjAMhjFtXPtf89az7o3bG6SV
         MVpgn2rUTOJUlN7AJLTkca+4UsiD7oZRMTu6s=
Received: by 10.100.93.17 with SMTP id q17mr681349anb.184.1250145461122; Wed, 
	12 Aug 2009 23:37:41 -0700 (PDT)
In-Reply-To: <7vocqlbv7a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125786>

2009/8/12 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> diff --git a/Documentation/technical/api-directory-listing.txt b/Doc=
umentation/technical/api-directory-listing.txt
>> index 5bbd18f..7d0e282 100644
>> --- a/Documentation/technical/api-directory-listing.txt
>> +++ b/Documentation/technical/api-directory-listing.txt
>> @@ -58,6 +58,9 @@ The result of the enumeration is left in these fie=
lds::
>> =C2=A0Calling sequence
>> =C2=A0----------------
>>
>> +* Ensure the_index is populated as it may have CE_VALID entries tha=
t
>> + =C2=A0affect directory listing.
>> +
>
> When you want to enumerate all paths in the work tree, instead of not=
 just
> the untracked ones, it used to be possible to first run read_director=
y()
> before calling read_cache(). =C2=A0You are now forbidding this.

Either I phrased it badly, or I don't follow you. If you don't call
read_cache() before read_directory(), the_index should be empty and
read_assume_unchanged_from_index() will be no-op. So read_directory()
behavior does not change in this case.

> I do not think it is hard to resurrect the feature if it is necessary=
 (add
> an option to dir_struct and teach dir_add_name() not to ignore paths =
the
> index knows about), and I do not think none of the existing code reli=
es on
> it anymore (I think "git add" used to), but there may be some codepat=
h I
> forgot about, which is a concern.

Hmm.. "git add" loaded index early since the first version of
builtin-add.c. I have checked all code path that can lead to
read_directory_recursively(). In all cases, index is loaded before
read_dir..() is called.

>> diff --git a/builtin-clean.c b/builtin-clean.c
>> index 2d8c735..d917472 100644
>> --- a/builtin-clean.c
>> +++ b/builtin-clean.c
>> @@ -71,8 +71,11 @@ int cmd_clean(int argc, const char **argv, const =
char *prefix)
>>
>> =C2=A0 =C2=A0 =C2=A0 dir.flags |=3D DIR_SHOW_OTHER_DIRECTORIES;
>>
>> - =C2=A0 =C2=A0 if (!ignored)
>> + =C2=A0 =C2=A0 if (!ignored) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (read_cache() < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die("index file corrupt");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setup_standard_excl=
udes(&dir);
>> + =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 pathspec =3D get_pathspec(prefix, argv);
>> =C2=A0 =C2=A0 =C2=A0 read_cache();
>
> Wouldn't it be much cleaner to move the existing read_cache() up, lik=
e you
> did for ls-files, instead of conditionally reading the index at a ran=
dom
> place in the program sequence depending on the combinations of option=
s?

Agreed. read_cache() is called right below anyway.
--=20
Duy
