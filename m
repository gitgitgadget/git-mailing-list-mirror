From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 02/25] Convert git_snpath() to strbuf_git_path()
Date: Thu, 20 Feb 2014 06:54:39 +0700
Message-ID: <CACsJy8BJ=OKzGDFwWQF_k_Gp9XeNwf7pe7c6_ebduJXN=xeOxw@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1392730814-19656-3-git-send-email-pclouds@gmail.com> <xmqqeh2y7jff.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 00:55:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGGzQ-0001Ip-G9
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 00:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbaBSXzL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 18:55:11 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:59450 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbaBSXzK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 18:55:10 -0500
Received: by mail-qa0-f46.google.com with SMTP id k15so1831899qaq.5
        for <git@vger.kernel.org>; Wed, 19 Feb 2014 15:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MlYo4qi+PeK75aSui7LSbUVY4Mmi6c2x4pN2+Iv/k2I=;
        b=KXxqysLa3BLnkzxTHVjqgUPfhjr52mGQgvR/bX/zxX3LgT9Q6Uyvo2r3AVo1LUKKHk
         dME2hWMvoxhFrfDoF+F6BXaHnLoKVhp3yZqUjhfnHqNV7mMgtHs9HH68M9F9sL9gV8IY
         yZg6vZfVnk9TM16I4qmScrmyu2d0wnVY1pg6isQgWUCo7AzKKvoXvcu4AoSO3Sx2V2Sw
         RbfAmnUJctxPeEiDrgVl/8TuDleox4QrPv3NXmsYvqGdon3AfGx2aPvouvdQG71/sMik
         9LIB5USn9YVLCnWF85evWRROwtsudkrJqFMZUkQOQ4QJPEJCdtaXagcWq8w5sRmmTfQj
         Ffuw==
X-Received: by 10.224.26.71 with SMTP id d7mr5743754qac.89.1392854109975; Wed,
 19 Feb 2014 15:55:09 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 19 Feb 2014 15:54:39 -0800 (PST)
In-Reply-To: <xmqqeh2y7jff.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242420>

On Thu, Feb 20, 2014 at 6:48 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> @@ -651,14 +653,10 @@ static void update_refs_for_switch(const struc=
t checkout_opts *opts,
>>                                       new->name);
>>                       }
>>               }
>> -             if (old->path && old->name) {
>> -                     char log_file[PATH_MAX], ref_file[PATH_MAX];
>> -
>> -                     git_snpath(log_file, sizeof(log_file), "logs/%=
s", old->path);
>> -                     git_snpath(ref_file, sizeof(ref_file), "%s", o=
ld->path);
>> -                     if (!file_exists(ref_file) && file_exists(log_=
file))
>> -                             remove_path(log_file);
>> -             }
>> +             if (old->path && old->name &&
>> +                 !file_exists(git_path("%s", old->path)) &&
>> +                  file_exists(git_path("logs/%s", old->path)))
>> +                     remove_path(git_path("logs/%s", old->path));
>
> Hmph.  Is this conversion safe?
>
> This adds three uses of the round-robin path buffer; if a caller of
> this function used two or more path buffers obtained from
> get_pathname() and expected their contents to remain stable across
> the call to this, it will silently break.

three round-robin buffers but not all required at the same time, once
the first file_exists() returns the first round-robin buffer could be
free, and remove_path() calls git_path again, not reusing the result
from the second file_exists, so the second buffer is free to go too.
--=20
Duy
