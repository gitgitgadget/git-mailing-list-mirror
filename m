From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] commit: accept tag objects in HEAD/MERGE_HEAD
Date: Thu, 18 Aug 2011 09:10:43 +0700
Message-ID: <CACsJy8BxAOtaJKv50_Ntr2qjEpJNaWNq_obYv4u+L3O=z27wLA@mail.gmail.com>
References: <1313422716-26432-1-git-send-email-pclouds@gmail.com>
 <1313545369-7096-1-git-send-email-pclouds@gmail.com> <7vy5yrex70.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 04:11:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qts4l-0006kE-66
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 04:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171Ab1HRCLO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Aug 2011 22:11:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59046 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab1HRCLO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2011 22:11:14 -0400
Received: by bke11 with SMTP id 11so1121462bke.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 19:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=sFApg9mwBQozNK9o4mdZ+fA1LhkhvkgWBn34Jkseq8s=;
        b=eKaXyLW96GUUEiXD7Gv7+8Tb3nhOU0VRFP7oVZcwlPkOda1FL6a6/83E9PoyX7DhKM
         ClruaJKPa91EKCcluIPEV8NIiA8m1kwHfKYM0PMOJuON3czj8f0Dp9zdw31TbjNOw7qf
         VKNe5yeCMDPhHHYjX/qOngS30FVgGAe8z6g4s=
Received: by 10.204.174.130 with SMTP id t2mr49125bkz.383.1313633473135; Wed,
 17 Aug 2011 19:11:13 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Wed, 17 Aug 2011 19:10:43 -0700 (PDT)
In-Reply-To: <7vy5yrex70.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179553>

2011/8/18 Junio C Hamano <gitster@pobox.com>:
> By the way, what happens when you try to merge when HEAD points at a =
tag
> that points at a commit? Would we end up creating a commit that point=
s at
> a bogus parent?

I guess I'd segfault the same way commit does. It does
lookup_commit(head) without checking the result.

>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 2088b6b..f327595 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1387,6 +1387,7 @@ int cmd_commit(int argc, const char **argv, co=
nst char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 unsigned char commit_sha1[20];
>> =C2=A0 =C2=A0 =C2=A0 struct ref_lock *ref_lock;
>> =C2=A0 =C2=A0 =C2=A0 struct commit_list *parents =3D NULL, **pptr =3D=
 &parents;
>> + =C2=A0 =C2=A0 struct commit *commit;
>> =C2=A0 =C2=A0 =C2=A0 struct stat statbuf;
>> =C2=A0 =C2=A0 =C2=A0 int allow_fast_forward =3D 1;
>> =C2=A0 =C2=A0 =C2=A0 struct wt_status s;
>
> Here, you are being inconsistent with your own argument you made in y=
our
> previous message "later somebody may forget to update the former whil=
e
> updating the latter" when I suggested to separate the two logically
> separate operations (grab the head_commit object when necessary, and
> decide how the commit is made). By hoisting of the scope of "commit",=
 you
> made the variable undefined when dealing with the initial_commit, exp=
osing
> the code to the same risk that somebody may try to use "commit" varia=
ble
> after the if/elseif/... cascade, where it may or may not be defined.

=46air enough.

>> @@ -1423,12 +1424,11 @@ int cmd_commit(int argc, const char **argv, =
const char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 reflog_msg =3D "commit (initial)";
>> =C2=A0 =C2=A0 =C2=A0 } else if (amend) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct commit_list =
*c;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct commit *commit;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!reflog_msg)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 reflog_msg =3D "commit (amend)";
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 commit =3D lookup_commit=
(head_sha1);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!commit || parse_com=
mit(commit))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 commit =3D lookup_expect=
_commit(head_sha1, "HEAD");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (parse_commit(commit)=
)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die(_("could not parse HEAD commit"));
>
> Is this still necessary? I think your lookup_expect_commit() already
> checks this condition and barfs.

It is. lookup_expect_commit() does not parse commit content, only
makes sure it's a commit object.
--=20
Duy
