From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] find_pack_entry(): do not keep packed_git pointer locally
Date: Tue, 31 Jan 2012 09:01:11 +0700
Message-ID: <CACsJy8AS0nZOoXZZfz0OEwoWe88wp2aGR5NGqpG7xQmUvwi7TA@mail.gmail.com>
References: <1327922750-12106-1-git-send-email-pclouds@gmail.com> <7v62fsai1i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 03:02:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rs32y-0006o3-IY
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 03:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774Ab2AaCBn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 21:01:43 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46367 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894Ab2AaCBn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 21:01:43 -0500
Received: by bkcjm19 with SMTP id jm19so86734bkc.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 18:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=G7054gxxKGyJ5qE7aH9uGvxXTMkLikP/teFrhT69Pto=;
        b=xaovUP5nvrx6m+cl/CprBtXXsHQPA/O42Zk0FrtbgC/Sx7AxxKQd0QyUCzG4oeGiJY
         cpai2OZfGp1oOVpA+oRKAGsrP73/0QSUcd05WoVU1+cq3kLDYXD/jmQwAxpoZH1CSGLx
         OcarnGyDNugvUntfnzjjNneQJrHVsw+SPhhZc=
Received: by 10.205.135.146 with SMTP id ig18mr9521976bkc.73.1327975301143;
 Mon, 30 Jan 2012 18:01:41 -0800 (PST)
Received: by 10.204.33.70 with HTTP; Mon, 30 Jan 2012 18:01:11 -0800 (PST)
In-Reply-To: <7v62fsai1i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189441>

(Pulling Nico in for Q2 below. No snipping so he has a context)

2012/1/31 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> Commit f7c22cc (always start looking up objects in the last used pac=
k
>> first - 2007-05-30) introduces a static packed_git* pointer as an
>> optimization. =C2=A0The kept pointer however may become invalid if
>> free_pack_by_name() happens to free that particular pack.
>>
>> Current code base does not access packs after calling
>> free_pack_by_name() so it should not be a problem. Anyway, move the
>> pointer out so that free_pack_by_name() can reset it to avoid runnin=
g
>> into troubles in future.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>
> Thanks. Two curiosities:
>
> - Why is there no hunk to actually clear the pointer in
>  free_pack_by_name() in this patch?

I think it's there (the patch did work for me when I tried to
integrate repack to pack-objects).

-- 8<--
> @@ -720,6 +722,8 @@ void free_pack_by_name(const char *pack_name)
>                       close_pack_index(p);
>                       free(p->bad_object_sha1);
>                       *pp =3D p->next;
> +                     if (find_pack_entry_last_found =3D=3D p)
> +                             find_pack_entry_last_found =3D (void*)1=
;
>                       free(p);
>                       return;
>               }
-- 8< --

>  - Could we make the magic (void *)1 value a #define'd constant? Perh=
aps
>   we could even use NULL for that purpose?

Q1. Sure.

Q2. No NULL is probably not suitable. I think Nico wanted to express
"we tried to find but found none (i.e. NULL)" too and 1 means "no we
have not tried".

>> diff --git a/sha1_file.c b/sha1_file.c
>> index 88f2151..4ecc953 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -54,6 +54,8 @@ static struct cached_object empty_tree =3D {
>> =C2=A0 =C2=A0 =C2=A0 0
>> =C2=A0};
>>
>> +static struct packed_git *find_pack_entry_last_found =3D (void *)1;
>> +
>> =C2=A0static struct cached_object *find_cached_object(const unsigned=
 char *sha1)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 int i;
>> @@ -720,6 +722,8 @@ void free_pack_by_name(const char *pack_name)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 close_pack_index(p);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 free(p->bad_object_sha1);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 *pp =3D p->next;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (find_pack_entry_last_found =3D=3D p)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 find_pack_entry_last_found =3D (void*)1=
;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 free(p);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> @@ -2012,14 +2016,13 @@ int is_pack_valid(struct packed_git *p)
>>
>> =C2=A0static int find_pack_entry(const unsigned char *sha1, struct p=
ack_entry *e)
>> =C2=A0{
>> - =C2=A0 =C2=A0 static struct packed_git *last_found =3D (void *)1;
>> =C2=A0 =C2=A0 =C2=A0 struct packed_git *p;
>> =C2=A0 =C2=A0 =C2=A0 off_t offset;
>>
>> =C2=A0 =C2=A0 =C2=A0 prepare_packed_git();
>> =C2=A0 =C2=A0 =C2=A0 if (!packed_git)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> - =C2=A0 =C2=A0 p =3D (last_found =3D=3D (void *)1) ? packed_git : l=
ast_found;
>> + =C2=A0 =C2=A0 p =3D (find_pack_entry_last_found =3D=3D (void *)1) =
? packed_git : find_pack_entry_last_found;
>>
>> =C2=A0 =C2=A0 =C2=A0 do {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p->num_bad_obje=
cts) {
>> @@ -2046,16 +2049,16 @@ static int find_pack_entry(const unsigned ch=
ar *sha1, struct pack_entry *e)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 e->offset =3D offset;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 e->p =3D p;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 hashcpy(e->sha1, sha1);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 last_found =3D p;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 find_pack_entry_last_found =3D p;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return 1;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next:
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p =3D=3D last_found)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p =3D=3D find_pack_e=
ntry_last_found)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 p =3D packed_git;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 p =3D p->next;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p =3D=3D last_found)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p =3D=3D find_pack_e=
ntry_last_found)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 p =3D p->next;
>> =C2=A0 =C2=A0 =C2=A0 } while (p);
>> =C2=A0 =C2=A0 =C2=A0 return 0;



--=20
Duy
