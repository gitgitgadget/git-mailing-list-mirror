From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] index-pack: kill union delta_base to save memory
Date: Sat, 4 Jul 2015 01:29:19 +0700
Message-ID: <CACsJy8D872sj9WQec_FZrTxx=gqy++L1XLxJdEtEQNpGpFYr=Q@mail.gmail.com>
References: <1429354025-24659-1-git-send-email-pclouds@gmail.com>
 <1429354025-24659-3-git-send-email-pclouds@gmail.com> <xmqqoajt5glu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 20:29:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB5im-0004B2-8q
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 20:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387AbbGCS3u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jul 2015 14:29:50 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34407 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784AbbGCS3t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jul 2015 14:29:49 -0400
Received: by igcsj18 with SMTP id sj18so192697108igc.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=LFPI1VrcPW7vO3iK9sA9lOZJUzyhPaF9nFJeNsmJktA=;
        b=slRVzgRgdknRlBaryIAhN3PRbQCcs+CTYduw4ysnliQtHq1vDoK6FhIf8gGO1K2yDs
         TxO3VLs7EWK5vHLMU5hAsmbD1cAlxe7utCEjQxgegCyi7y5mkgs2UyaMGl1YixX14OAH
         fL50VP8OBEEmTa8Kxcbj6tTqe5piKtEIlFZHgjzcLLC08BlmvPsR+7uzfKoULm2WppsH
         zWsk6SuBHVC/9yIUst/2LsNmVR+zE3it9mqSEURqkbEIJAU0szr1tR3HEdK2hvjTsWUl
         H/Dm7kJdQ9IEW59Jnm9KkI5VgX3M+I+Iljfrtg3cHG1wQSEKNK9w6PRP1EiG+vnBgKa5
         l0lA==
X-Received: by 10.107.128.72 with SMTP id b69mr54257934iod.84.1435948189239;
 Fri, 03 Jul 2015 11:29:49 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Fri, 3 Jul 2015 11:29:19 -0700 (PDT)
In-Reply-To: <xmqqoajt5glu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273308>

On Fri, Jul 3, 2015 at 11:51 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Once we know the number of objects in the input pack, we allocate an
>> array of nr_objects of struct delta_entry. On x86-64, this struct is
>> 32 bytes long. The union delta_base, which is part of struct
>> delta_entry, provides enough space to store either ofs-delta (8 byte=
s)
>> or ref-delta (20 bytes).
>
> Sorry for responding to a patch 7000+ messages ago, but some kind
> folks at Google were puzzled by this code, and I think they found a
> small bug.
>
>>  static void fix_unresolved_deltas(struct sha1file *f, int nr_unreso=
lved)
>>  {
>> -     struct delta_entry **sorted_by_pos;
>> +     struct ref_delta_entry **sorted_by_pos;
>>       int i, n =3D 0;
>>
>>       /*
>> @@ -1282,28 +1344,25 @@ static void fix_unresolved_deltas(struct sha=
1file *f, int nr_unresolved)
>>        * resolving deltas in the same order as their position in the=
 pack.
>>        */
>>       sorted_by_pos =3D xmalloc(nr_unresolved * sizeof(*sorted_by_po=
s));
>> -     for (i =3D 0; i < nr_deltas; i++) {
>> -             if (objects[deltas[i].obj_no].real_type !=3D OBJ_REF_D=
ELTA)
>> -                     continue;
>> -             sorted_by_pos[n++] =3D &deltas[i];
>> -     }
>> +     for (i =3D 0; i < nr_ref_deltas; i++)
>> +             sorted_by_pos[n++] =3D &ref_deltas[i];
>>       qsort(sorted_by_pos, n, sizeof(*sorted_by_pos), delta_pos_comp=
are);
>
> You allocate an array of nr_unresolved (which is the sum of
> nr_ref_deltas and nr_ofs_deltas in the new world order with patch)
> entries, fill only the first nr_ref_deltas entries of it, and then
> sort that first n (=3D nr_ref_deltas) entries.  The qsort and the
> subsequent loop only looks at the first n entries, so nothing is
> filling or reading these nr_ofs_deltas entres at the end.
>
> I do not see any wrong behaviour other than temporary wastage of
> nr_ofs_deltas pointers that would be caused by this, but this
> allocation is misleading.
>
> Also, the old code before this change had to use 'i' and 'n' because
> some of the things we see in the (old) deltas[] array we scanned
> with 'i' would not make it into the sorted_by_pos[] array in the old
> world order, but now because you have only ref delta in a separate
> ref_deltas[] array, they increment lock&step.  That also puzzled me
> while re-reading this code.
>
> Perhaps something like this is needed?

Yeah I can see the confusion when reading the code without checking
its history. You probably want to kill the argument nr_unresolved too
because it's not needed anymore after your patch.

So what's the bug you mentioned? All I got from the above was wastage
and confusion, no bug.
--=20
Duy
