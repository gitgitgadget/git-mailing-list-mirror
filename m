From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 01/19] dir.c: optionally compute sha-1 of a .gitignore file
Date: Tue, 28 Oct 2014 07:12:26 +0700
Message-ID: <CACsJy8CgiQhAs2ydKLei9QUZLUXCfCHMCAaZcOdKgMVBGNB=FA@mail.gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1414411846-4450-2-git-send-email-pclouds@gmail.com> <xmqq7fzl5dxw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 01:13:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiuPF-0002LN-VX
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 01:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbaJ1AM6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 20:12:58 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:52561 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbaJ1AM5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Oct 2014 20:12:57 -0400
Received: by mail-ie0-f176.google.com with SMTP id rd18so4804145iec.7
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 17:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ngsKGivglcrOiUuvWAZA8k+dBO7Hm6ESxLN8nv1x7BQ=;
        b=D8OKE4b15toXZdKjXfDJDHun8LARzDiuR58iLzdtHey4JZPIMf3utemlKketKdbU4W
         NcxE3gU8zB7wMEHtMumjXA1VWWz+6CWy0BDktGcSd7U10qErIBgv4phBLrQ7gSVuiTsU
         ZsFN/YsU30gsh9RtuiZOH080QDRyOwZjB9kfbgY4rQg1SBLL17B69eDpjfdR0widLaHq
         kh63TNzRI/JjMiJmCkRZNITmwo8Bqfaetsk+CitjggLNp9PRc4uCLoI52MW58cF16GSk
         QMwpqL9sNArqkYsMHd/76d7EJL7UG6Os2UCPOJIN0CvFHDS/LB70Oz1r5i85vRkHCUIE
         O+5w==
X-Received: by 10.107.38.136 with SMTP id m130mr28981iom.72.1414455176796;
 Mon, 27 Oct 2014 17:12:56 -0700 (PDT)
Received: by 10.107.176.8 with HTTP; Mon, 27 Oct 2014 17:12:26 -0700 (PDT)
In-Reply-To: <xmqq7fzl5dxw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 28, 2014 at 5:46 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> This is not used anywhere yet. But the goal is to compare quickly if=
 a
>> .gitignore file has changed when we have the SHA-1 of both old (cach=
ed
>> somewhere) and new (from index or a tree) versions.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  dir.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
>>  dir.h |  5 +++++
>>  2 files changed, 48 insertions(+), 7 deletions(-)
>>
>> diff --git a/dir.c b/dir.c
>> index bd274a7..33a35c1 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -466,7 +466,8 @@ void add_exclude(const char *string, const char =
*base,
>>       x->el =3D el;
>>  }
>>
>> -static void *read_skip_worktree_file_from_index(const char *path, s=
ize_t *size)
>> +static void *read_skip_worktree_file_from_index(const char *path, s=
ize_t *size,
>> +                                             struct sha1_stat *ss)
>>  {
>>       int pos, len;
>>       unsigned long sz;
>> @@ -485,6 +486,10 @@ static void *read_skip_worktree_file_from_index=
(const char *path, size_t *size)
>>               return NULL;
>>       }
>>       *size =3D xsize_t(sz);
>> +     if (ss) {
>> +             memset(&ss->stat, 0, sizeof(ss->stat));
>> +             hashcpy(ss->sha1, active_cache[pos]->sha1);
>> +     }
>>       return data;
>>  }
>>
>> @@ -529,11 +534,18 @@ static void trim_trailing_spaces(char *buf)
>>               *last_space =3D '\0';
>>  }
>>
>> -int add_excludes_from_file_to_list(const char *fname,
>> -                                const char *base,
>> -                                int baselen,
>> -                                struct exclude_list *el,
>> -                                int check_index)
>> +/*
>> + * Given a file with name "fname", read it (either from disk, or fr=
om
>> + * the index if "check_index" is non-zero), parse it and store the
>> + * exclude rules in "el".
>> + *
>> + * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
>> + * stat data from disk (only valid if add_excludes returns zero). I=
f
>> + * ss_valid is non-zero, "ss" must contain good value as input.
>> + */
>
> Hmm, do we want a separate parameter for that?  Wouldn't it be
> sufficient and cleaner to pass is_null_sha1(ss->sha1[]),

Hm.. no. If both ss->sha1 and ss->stat are valid, then we could try to
match stat on disk and reuse ss->sha1, so we can't use a special value
of ss->sha1[] to mark the validity.

> or alternatively have an element ss->valid that is initialized to fal=
se?

Yeah..
--=20
Duy
