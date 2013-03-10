From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/6] match_basename: use strncmp instead of strcmp
Date: Sun, 10 Mar 2013 17:38:37 +0700
Message-ID: <CACsJy8A_4SqLu5L6P0PJ78Lwy12fjL7T2p-KbVEVLJmKNqhyRw@mail.gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-1-git-send-email-pclouds@gmail.com> <1362896070-17456-4-git-send-email-pclouds@gmail.com>
 <7vy5dvd7yq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 11:39:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEdfN-000240-9U
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 11:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191Ab3CJKjK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Mar 2013 06:39:10 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:51319 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab3CJKjJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Mar 2013 06:39:09 -0400
Received: by mail-ob0-f169.google.com with SMTP id ta14so2536778obb.0
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 03:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=UcAOV5DVrRBT1QfCmVFBWND13NjSfDZaS4mvIgX+8B8=;
        b=0YkE+C4wlmDQiXbsxg8vxs5omrSnJGuQ+M/ZJfL8jsaxVZh7Mm2xoNi46l42KOKIrQ
         9TbSOwtQ7iGVX1pY8VkzZ5Z+BO6ECmV/78NVu3GZbAzgoapLewwMYBYpWk81QJYLCUAk
         /67AJIQRu6B5vU8fhnARJr9P71kkvXfashwbTHOqGpA51Rzwm0fs7N/ual51Nil9CF9Z
         CsbsMKOmU6us09mJHrz7acscaSgPAom6GSncZvQ+O/QAc0YUhD9iGGey5S58yveTQmJr
         jjKHi07jf1oJMz8vd9BkpXVF9h5ujDEsqeaZ1/1PmDESpv4jj7hNxnFgiObwSb7Pq/gn
         671Q==
X-Received: by 10.60.30.231 with SMTP id v7mr6163448oeh.118.1362911948907;
 Sun, 10 Mar 2013 03:39:08 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Sun, 10 Mar 2013 03:38:37 -0700 (PDT)
In-Reply-To: <7vy5dvd7yq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217795>

On Sun, Mar 10, 2013 at 2:34 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> strncmp is provided length information which could be taken advantag=
e
>> by the underlying implementation.
>
> I may be missing something fundamental, but I somehow find the above
> does not make any sense.
>
> strcmp(a, b) has to pay attention to NUL in these strings and stop
> comparison.  strncmp(a, b, n) not only has to pay the same attention
> to NUL in the strings, but also needs to stop comparing at n bytes.
>
> In what situation can the latter take advantage of that extra thing
> that it needs to keep track of and operate faster, when n is the
> length of shorter of the two strings?

glibc's C strncmp version does 4-byte comparison at a time when n >=3D4=
,
then fall back to 1-byte for the rest. I don't know if it's faster
than a plain always 1-byte comparison though. There's also the hand
written assembly version that compares n from 1..16, not exactly sure
how this version works yet.

>> diff --git a/dir.c b/dir.c
>> index 9960a37..46b24db 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -610,12 +610,14 @@ int match_basename(const char *basename, int b=
asenamelen,
>>                  int flags)
>>  {
>>       if (prefix =3D=3D patternlen) {
>> -             if (!strcmp_icase(pattern, basename))
>> +             if (patternlen =3D=3D basenamelen &&
>> +                 !strncmp_icase(pattern, basename, patternlen))
>>                       return 1;
>
> What happens if you replace this with
>
>                 if (patternlen =3D=3D baselen &&
>                     !strcmp_icase(pattern, basename, patternlen))
>
> and drop the other hunk and run the benchmark again?
>

        before      after
user    0m0.533s    0m0.522s
user    0m0.549s    0m0.530s
user    0m0.550s    0m0.534s
user    0m0.551s    0m0.545s
user    0m0.556s    0m0.550s
user    0m0.557s    0m0.552s
user    0m0.559s    0m0.554s
user    0m0.564s    0m0.561s
user    0m0.567s    0m0.565s
user    0m0.567s    0m0.565s
--=20
Duy
