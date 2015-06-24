From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: fix adding new files on i-t-a entries
Date: Tue, 23 Jun 2015 21:48:33 -0700
Message-ID: <CAPc5daXgEt==wpWH7CBXQFFZVSMuTR1PUMZqwQDmRG+QTJyt0g@mail.gmail.com>
References: <CACfKtTAvH7FH2AkC5hUNFEQ620gF401SNYaULLy62iE8S55-7A@mail.gmail.com>
 <1435062855-26274-1-git-send-email-pclouds@gmail.com> <xmqqoak6e5dx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Patrick Higgins <phiggins@google.com>,
	=?UTF-8?Q?Bj=C3=B8rnar_Snoksrud?= <snoksrud@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 06:48:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7ccM-0001SQ-N5
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 06:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbbFXEsz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Jun 2015 00:48:55 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33339 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbbFXEsx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jun 2015 00:48:53 -0400
Received: by oiyy130 with SMTP id y130so22189520oiy.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 21:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=R1rAJUvDGfqrZjBWhYr9HJQTkNXy6tnDFbTUe+TA5Ys=;
        b=qv4q7lajq5B8ViGg69LrwobcdqMJWT7cRQuE5JoBzzUuNRP5pXUg8PqUp3mtIsJ/s/
         hCtpgAMKRcXDStz9OuvQaIui70+y9vjpvmvmoWeQXnfI+Pc1nWexR4L6r5EudAcmvE5I
         0EiZZBdCGlba2xcJPId5qGnbnye1sgGeHoLyGo/fM1m2605UZiCKcpjadCI7eNGur3Pl
         lSBY7I8i/X4UARC8veFMXG4afWP6Lc9cOE0VpbCnuCAVx5GmTKpjZfHGS5Pc2j6dMc5b
         a4y0KUgy41/X7bVbJkHLzB+gG6qMLPeVOA5NzXyBrz+/jjzz0MUCeAFEF95Gdz/EDzfO
         4VYQ==
X-Received: by 10.60.79.97 with SMTP id i1mr33039241oex.44.1435121332967; Tue,
 23 Jun 2015 21:48:52 -0700 (PDT)
Received: by 10.202.202.129 with HTTP; Tue, 23 Jun 2015 21:48:33 -0700 (PDT)
In-Reply-To: <xmqqoak6e5dx.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 32r0LdbSfyrqqlYn7WfedLjxcYk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272530>

On Tue, Jun 23, 2015 at 9:50 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> -     pos =3D cache_name_pos(name, strlen(name));
>> +     pos =3D exists_in_cache(name, strlen(name));
>
> Something that is named as if it would return yes/no that returns a
> real value is not a very welcome idea.
>
>> +/* This is the same as index_name_pos, except that i-t-a entries ar=
e invisible */
>> +int exists_in_index(const struct index_state *istate, const char *n=
ame, int namelen)
>> +{
>> +     int pos =3D index_name_stage_pos(istate, name, namelen, 0);
>> +
>> +     if (pos < 0)
>> +             return pos;
>> +     if (istate->cache[pos]->ce_flags & CE_INTENT_TO_ADD)
>> +             return -pos-1;
>
> This is a useless complexity.  Your callers cannot use the returned
> value like this:
>
>         pos =3D exists_in_cache(...);
>         if (pos < 0) {
>                 if (active_cache[-pos-1]->ce_flags & CE_INTENT_TO_ADD=
)
>                         ; /* ah it actually exists but it is i-t-a */
>                 else
>                         ; /* no it does not really exist */
>         } else {
>                 ; /* yes it is really there at pos */
>         }
>
> because they cannot tell two cases apart: (1) you do have i-t-a with
> the given name, (2) you do not have the entry but the location you
> would insert an entry with such a name is occupied by an unrelated
> entry (i.e. with a name that sorts adjacent) that happens to be
> i-t-a.

Also, the callers cannot even use that return value in the usual way th=
ey
would use the return value from index_name_pos(), either.

    pos =3D exists_in_cache(...);
    if (pos < 0) {
        /* ah, it does not exist, so... */
        pos =3D -1 - pos;
        /*
         * ... it is OK to shift active_cache[pos..] by one and add our
         * entry at active_cache[pos]
         */
   } else {
        /* it exists, so update in place */
        ;
   }

So, returning pos that smells like a return value from index_name_pos()
only has an effect of confusing callers into buggy code, I am afraid. T=
he
callers that care need to be updated to check for ce_flags after findin=
g the
entry with index_name_pos() the usual way if you want to avoid search i=
n
the index_state->cache[] twice, and the callers that are only intereste=
d in
knowing if an entry "exists" are better off with an exists_in_cache() t=
hat
returns Yes/No and not a confusing and useless "pos", I think.
