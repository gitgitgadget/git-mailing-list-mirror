From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] list-objects: perform NULL check before the variable is dereferenced
Date: Tue, 10 Apr 2012 06:47:17 +0700
Message-ID: <CACsJy8ASo8j+hmJ7Kw2uLcD9cS8SXc6yOoc5GDUcFHYk9W9a_g@mail.gmail.com>
References: <1333968311-29889-1-git-send-email-pclouds@gmail.com> <7v7gxowxfh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 01:47:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHOJO-0006Gb-KH
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 01:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758188Ab2DIXrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Apr 2012 19:47:49 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56443 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727Ab2DIXrt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2012 19:47:49 -0400
Received: by wibhq7 with SMTP id hq7so2819879wib.1
        for <git@vger.kernel.org>; Mon, 09 Apr 2012 16:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=b0+VFH9seKMa3jJntb6nEuIJd1tqBepL5aPrNhttpLA=;
        b=P7UCm8oSGAaQG+SWlKjsN7Rd3jk/LsCM9dIyohbaJZMW2gYCEs5c1UtCmTkuZJoHGJ
         xdZnvsd7uH13CQ52eI5T/jK5RNcUiFkA/CAPk2ULbAoxE+dkE7I4eZnp0cuyL9jwfhlh
         9kgGa0hLgKRIlEyqLwZEO9b3zfxMDxAFaGLUFImir3RusAvJ0d3P2Qas5PVv6tAFHV9y
         euW6NPA6bthwofJYTFlC9SuQ+5+pRm6Osea6G6jlP4nvMsZCgQIWilwz19CNchAMCE9Y
         0Kkg9+N+AIBBJD6tR4uvZIe3OpmOLGJxvwaGhq0oZsY9pgNnARMIB8BoEtORStdMzT77
         H+pg==
Received: by 10.180.102.129 with SMTP id fo1mr1937758wib.6.1334015268039; Mon,
 09 Apr 2012 16:47:48 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Mon, 9 Apr 2012 16:47:17 -0700 (PDT)
In-Reply-To: <7v7gxowxfh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195046>

2012/4/10 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0list-objects.c | =C2=A0 10 ++++++----
>> =C2=A01 files changed, 6 insertions(+), 4 deletions(-)
>
> Please explain why this is needed?
>
> I can see that process_blob() is called from process_tree() which pas=
ses
> the return value from lookup_blob(entry.sha1) directly without lookin=
g at
> it. =C2=A0lookup_blob() can issue an error message and return NULL if=
 there is
> a SHA-1 collision with an object that is not a blob.

to avoid segmentation fault in that case, if "blob" is NULL, it dies
at blob->object anyway and the check "if (!obj)" is useless.

>
>> diff --git a/list-objects.c b/list-objects.c
>> index 3dd4a96..34044d9 100644
>> --- a/list-objects.c
>> +++ b/list-objects.c
>> @@ -15,12 +15,13 @@ static void process_blob(struct rev_info *revs,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0const char *name,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0void *cb_data)
>> =C2=A0{
>> - =C2=A0 =C2=A0 struct object *obj =3D &blob->object;
>> + =C2=A0 =C2=A0 struct object *obj;
>>
>> =C2=A0 =C2=A0 =C2=A0 if (!revs->blob_objects)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> - =C2=A0 =C2=A0 if (!obj)
>> + =C2=A0 =C2=A0 if (!blob)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("bad blob objec=
t");
>> + =C2=A0 =C2=A0 obj =3D &blob->object;
>> =C2=A0 =C2=A0 =C2=A0 if (obj->flags & (UNINTERESTING | SEEN))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> =C2=A0 =C2=A0 =C2=A0 obj->flags |=3D SEEN;
>> @@ -67,7 +68,7 @@ static void process_tree(struct rev_info *revs,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0const char *name,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0void *cb_data)
>> =C2=A0{
>> - =C2=A0 =C2=A0 struct object *obj =3D &tree->object;
>> + =C2=A0 =C2=A0 struct object *obj;
>> =C2=A0 =C2=A0 =C2=A0 struct tree_desc desc;
>> =C2=A0 =C2=A0 =C2=A0 struct name_entry entry;
>> =C2=A0 =C2=A0 =C2=A0 struct name_path me;
>> @@ -77,8 +78,9 @@ static void process_tree(struct rev_info *revs,
>>
>> =C2=A0 =C2=A0 =C2=A0 if (!revs->tree_objects)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> - =C2=A0 =C2=A0 if (!obj)
>> + =C2=A0 =C2=A0 if (!tree)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("bad tree objec=
t");
>> + =C2=A0 =C2=A0 obj =3D &tree->object;
>> =C2=A0 =C2=A0 =C2=A0 if (obj->flags & (UNINTERESTING | SEEN))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> =C2=A0 =C2=A0 =C2=A0 if (parse_tree(tree) < 0)



--=20
Duy
