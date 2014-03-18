From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] log: add --nonlinear-barrier to help see non-linear history
Date: Tue, 18 Mar 2014 18:46:28 +0700
Message-ID: <CACsJy8BsEsyrcis=+2HyocYWi9WM2oHKtSFPXzSt5ji6zVgeXA@mail.gmail.com>
References: <1391867417-979-1-git-send-email-pclouds@gmail.com>
 <1395060676-23144-1-git-send-email-pclouds@gmail.com> <xmqqob14d0qv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 12:47:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPsU6-0008CY-3t
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 12:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbaCRLrC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Mar 2014 07:47:02 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33404 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829AbaCRLrA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Mar 2014 07:47:00 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so20674102qgd.9
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 04:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gisOvMz453vwI4kTaHLO3ivBjt+Xqt9iXUDOUOnSWag=;
        b=URdKKZNC3LxAEfbjcQG4vwm+qi5hnXS32GPLYsk1dDu2EcJTupBHT7tweabBY7aRoi
         kIhB/4E5wwN5czgx4y+HeQ24RejT7kyZJeaIGgm2psmdS9Lj572PMPacKTYXc5J+dmJN
         AujV/pqlaVoywWxiXt8QZqLusbEEpk8iT+sOIWU0RCSIIpOSTmfHSpWVbJrpm3st2On1
         lkJlf3WcfQNojyvlLnlKhC+B5eO0sOULmghl4nBA7Z2GnGSoKA1sMkYiN2FPRFUN1eTt
         4srNa97XlWHpI29AziLU/jg5xHqeSMcDKXRKRvnZ3nXaDqxrNUqyVlVURiffFp3yzJX4
         CQ/g==
X-Received: by 10.224.161.4 with SMTP id p4mr2124676qax.89.1395143219675; Tue,
 18 Mar 2014 04:46:59 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Tue, 18 Mar 2014 04:46:28 -0700 (PDT)
In-Reply-To: <xmqqob14d0qv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244351>

On Tue, Mar 18, 2014 at 3:32 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  v2 renames the option name to --nonlinear-barrier and fixes using i=
t
>>  with --dense. Best used with --no-merges to see patch series.
>
> I think that the earlier name "show linear-break" is more easily
> understood than the new name, but maybe that is just me.  It's not
> like you are blocking something from going forward with a barrier,
> and internally it is called a "break-bar".

I'll change it back.

>>       opt->loginfo =3D NULL;
>>       maybe_flush_or_die(stdout, "stdout");
>>       return shown;
>
> Does this new feature interact with -z format output in any way?

Hmm.. never thought of it. Right now it's part of the previous commit.

> Should it, and if so how?

No idea.

>> +define_commit_slab(saved_linear, int);
>> +
>> +static void track_linear(struct rev_info *revs, struct commit *comm=
it)
>> +{
>> +     struct commit_list *p =3D revs->previous_parents;
>> +
>> +     if (p) {
>> +             int got_parent =3D 0;
>> +             for (; p && !got_parent; p =3D p->next)
>> +                     got_parent =3D !hashcmp(p->item->object.sha1,
>> +                                           commit->object.sha1);
>> +             revs->linear =3D got_parent;
>> +             free_commit_list(revs->previous_parents);
>> +     } else
>> +             revs->linear =3D 1;
>> +     if (revs->reverse) {
>> +             if (!revs->saved_linear_slab) {
>> +                     revs->saved_linear_slab =3D xmalloc(sizeof(str=
uct saved_linear));
>> +                     init_saved_linear(revs->saved_linear_slab);
>> +             }
>> +
>> +             *saved_linear_at(revs->saved_linear_slab, commit) =3D =
revs->linear;
>> +     }
>> +     revs->previous_parents =3D copy_commit_list(commit->parents);
>
> We are showing commit, and the parents (after history
> simplification) of the commit we showed before this commit is kept
> in previous-parents.  If we are one of them, we are showing
> linearly, which makes sense.  While we are accumulating the output
> in the forward direction in preparation for later emitting them in
> reverse, we need to save away the linear-ness bit somewhere, and a
> slab is a logical place to save that, which also makes sense.  But
> why do you need a full int?  Doesn't an unsigned char wide enough?

Yes it is. Will change.

> I also wondered if the saved-parents slab we already have can be
> easily reused for this, but it probably would not help.

That could end up a maintenance nightmare. revision.c is complex
enough as it is.

> I do not quite understand the "if we do not have previous parents"
> bit, though.  Is it meant to trigger only at the very beginning?

Only at the beginning.
--=20
Duy
