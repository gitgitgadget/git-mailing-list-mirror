From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [long] worktree setup cases
Date: Thu, 21 Oct 2010 09:23:28 +0700
Message-ID: <AANLkTi=dUtRrOwksXWrJ3v-TGAQPBRAduLgjS9CE8hJd@mail.gmail.com>
References: <20101020085859.GA13135@do> <7v8w1svate.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>, git@vger.kernel.org,
	fbriere@fbriere.net, drizzd@aon.at, 575917@bugs.debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 04:23:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8kou-0002UH-Gm
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 04:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756938Ab0JUCXv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Oct 2010 22:23:51 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45587 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756788Ab0JUCXu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Oct 2010 22:23:50 -0400
Received: by wwf26 with SMTP id 26so1971431wwf.1
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 19:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=crpCq2kXSOxO3yet9Sw03LCJXEL1LXeXHIIc6UtyOIY=;
        b=FeZr+jrYMH1u77UjvkEfaqV20YTg4ywWBPwAlHMhwmp7xpsU2FVagcJIHvZN+ZuUkv
         LKMj4nGVnM9hwjZHMeFdCdoW9BTCGdQ+dDEG739w2n04toZVBLMAltZde4xI6S+8N/6s
         BHXaeA2+MaNzo+AQBHjIf5Raftnfo1GN3fUag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OydIwg0uywKP+MfgdP4LPdDrgu2sMmVcQ3xJ0JkCPw9JEfkrspr7XSdwH+EfxtpAE3
         P5gutch9XjKOlTzGOCxJvd+o1Ij1UtdIXl0m77+QQEGBt1bT4NPhP+mpnIIDLsAkWUBk
         ZUwAyTP/tA6aoQisAkOJw/CJ4lDJIOIEEJfSE=
Received: by 10.216.5.202 with SMTP id 52mr266529wel.83.1287627829027; Wed, 20
 Oct 2010 19:23:49 -0700 (PDT)
Received: by 10.216.171.207 with HTTP; Wed, 20 Oct 2010 19:23:28 -0700 (PDT)
In-Reply-To: <7v8w1svate.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159480>

On Thu, Oct 21, 2010 at 4:00 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> There are a few factors that affect gitdir/worktree/cwd/prefix setup=
=2E
>> Those are:
>>
>> =C2=A0- GIT_DIR (or --git-dir)
>> =C2=A0- GIT_WORK_TREE (or --work-tree)
>> =C2=A0- core.worktree
>> =C2=A0- .git is a file pointing to real .git directory
>> =C2=A0- Bare repo
>>
>> So there are 2^5 =3D 32 cases in total.
> Hmm, why is core.worktree separate from the second item?

It's how the code does it. GIT_WORK_TREE can be detected early, when
cwd has not been moved. When core.worktree is found, cwd could be
somewhere. I need to separate those cases to make sure cwd is not
misused after it's been moved.

> In any case, the
> three mechanisms to specify the working tree should only be in effect=
 when
> GIT_DIR/--git-dir is used, so the above are not orthogonal, and the t=
otal
> count should be smaller than 32 cases.

Good to hear. I forgot that GIT_DIR must be set for the three
mechanisms in effect.

>> The following questions must be answered for each case:
>>
>> 0. What setup function handles that case?
>> 1. Is worktree available?
>> 2. Where is new cwd? Is it at worktree root?
>> 3. Prefix?
>> 4. Is (relative) $GIT_DIR accessible from current cwd?
>> 5. What if original cwd is outside worktree, or new cwd if it's not =
at
>> =C2=A0 =C2=A0worktree root?
>
> All good questions to ask, except for the last one which I cannot qui=
te
> parse.

Skip "or new cwd... worktree root" part.

>> 1 Cases
>> ~~~~~~~~
>>
>> Case# =C2=A0Bare =C2=A0.git-file =C2=A0core.worktree =C2=A0GIT_DIR =C2=
=A0GIT_WORK_TREE
>> 0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0=
 =C2=A0 =C2=A00
>> 8 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0=
 =C2=A0 =C2=A00
>
> Ok.
>
>> 1 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0=
 =C2=A0 =C2=A01
>> 4 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0=
 =C2=A0 =C2=A00
>> 5 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0=
 =C2=A0 =C2=A01
>> 9 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0=
 =C2=A0 =C2=A01
>> 12 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00
>> 13 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0=
 =C2=A01
>
> How does it make sense to have GIT_WORK_TREE without GIT_DIR? =C2=A0W=
ithout
> GIT_DIR, we will run repository discovery, which means we will always=
 go
> up to find a .git dir, and the reason for doing that is because we wa=
nt to
> also work in a subdirectory of a working tree (the very original git =
never
> worked from anywhere other than the root level of the working tree). =
=C2=A0By
> definition, the root of the working tree is the same as in cases 0/8.

OK.

>> 2 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0=
 =C2=A0 =C2=A00
>> 10 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00
>
> If you set GIT_DIR, we do no discovery, so git will work only from th=
e
> root level of the working tree (or bare repository operation) if you =
do
> not tell us where the working tree is.

OK

>> 3 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0=
 =C2=A0 =C2=A01
>> 6 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0=
 =C2=A0 =C2=A00
>> 7 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0=
 =C2=A0 =C2=A01
>> 11 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0=
 =C2=A01
>> 14 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00
>> 15 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0=
 =C2=A01
>
> Without discovery, we know where the root level of the working tree i=
s,
> and we know where the repository is, because you told us. =C2=A0The a=
nswers to
> questions 1-5, i.e. semantics observable by the end user, should be t=
he
> same as case 0/8 even though the internal codepath to achieve that,
> i.e. question 0, may be different.

OK too.

>> 16 =C2=A0 =C2=A0 1 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00
>> ...
>> 31 =C2=A0 =C2=A0 1 =C2=A0 =C2=A0 1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0=
 =C2=A01
>
> Shouldn't all of these 16 be the same, if the repository is bare? =C2=
=A0What is
> your definition of bareness? =C2=A0core.bare? =C2=A0In any case we sh=
ould say "you
> are using a bare repository, there is no working tree" and cwd should=
n't
> change in these cases. =C2=A0They are all bare and there is no workin=
g tree.

Better this way. Although some sanity checks can be used. Like setting
core.bare and explicitly requesting worktree is insane.

> Alternatively, you could give precedence to core.worktree and friends=
, in
> which case these can go to the other categories in your description,
> ignoring core.bare settings. =C2=A0For example, 31 explicitly specifi=
es where
> the .git directory and the working tree are, which would fall into th=
e
> same category as 3,6,7,11,14,15.

I don't want to ignore core.bare. If there are bare/worktree
conflicts, notify users. There are cases that a normal repo tends to
become a bare repo for just one operation. It's when "." is found a
repo, handled by setup_bare_git_dir(). In these cases, we might want
to consider core.worktree and friends again.

> Either way is fine.
--=20
Duy
