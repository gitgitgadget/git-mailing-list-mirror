From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] dir.c: do not trip over difference in "/"
Date: Sat, 26 Mar 2011 14:59:52 +0700
Message-ID: <AANLkTi=s1+BhwWrG_8S6kaF+_m9FHKdBEUMT5hgUGSvu@mail.gmail.com>
References: <1301060989-7246-1-git-send-email-pclouds@gmail.com> <b28c22b42c43f5dced45bee8ba4c76965b736d9a.1301068238.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthijs Kooijman <matthijs@stdin.nl>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Mar 26 09:00:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3OQH-0001R1-Mp
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 09:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568Ab1CZIAZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Mar 2011 04:00:25 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:44053 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab1CZIAY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Mar 2011 04:00:24 -0400
Received: by wwk4 with SMTP id 4so245281wwk.1
        for <git@vger.kernel.org>; Sat, 26 Mar 2011 01:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=0YVNcMDGmNVQ4+Qcgse9fNZsKbXveSN041rA4UZ0Du8=;
        b=DP9vVEJbPUSREaTPJCZwTSSzgN8h2Af7rkHHveGGlgzZ3dsEuP3A1T1ptorUo3BBDS
         Ma+vTepApkiY54KDhAAR6o0mflS6nT0WBha+uIq+Cjpk9BB3dV3NqHQZQJbduXnJQpXA
         ccuF5Md9LMnstssc5tkKrT22CxDt2IukcFu+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sLC4hQ0V0krrYk+882mgxRW8l7397m37hsobE20PtyqJuYrk5s3aSLmGygh428haLI
         zQNKpFl6FQ1Ib7k3mH13j+Z4BgxyudcHvYTMyXBgX+X1VX6wpac9t0kRAIrI8W/DhKGQ
         VpUbsOTA2VdloDkkHyBUQ4WZspr5OZMVprqkg=
Received: by 10.216.120.129 with SMTP id p1mr1715681weh.81.1301126423126; Sat,
 26 Mar 2011 01:00:23 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Sat, 26 Mar 2011 00:59:52 -0700 (PDT)
In-Reply-To: <b28c22b42c43f5dced45bee8ba4c76965b736d9a.1301068238.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170043>

2011/3/25 Michael J Gruber <git@drmicha.warpmail.net>:
> get_relative_cwd() tries to determine a common prefix for dir and cwd=
=2E
> The fix in
> 490544b (get_cwd_relative(): do not misinterpret suffix as subdirecto=
ry, 2010-05-22)
> made the logic less naive (so that foo-bar is not misdetected as bein=
g
> within foo) but broke some other cases, in particular foo not being
> detected as being within foo/ any more.

I'd rather kill this function off. It's only used in is_inside_dir(),
we can be replaced with is_subdir_or_same() in my previous patch (more
or less the same function with get_relative_cwd, but less cryptic).

> diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
> index bd8b607..f0dbdd8 100755
> --- a/t/t1501-worktree.sh
> +++ b/t/t1501-worktree.sh
> @@ -63,6 +63,19 @@ cd sub/dir || exit 1
> =C2=A0test_rev_parse 'subdirectory' false false true sub/dir/
> =C2=A0cd ../../.. || exit 1
>
> +say "core.worktree =3D absolute path/"
> +GIT_DIR=3D$(pwd)/repo.git
> +GIT_CONFIG=3D$GIT_DIR/config
> +git config core.worktree "$(pwd)/work/"
> +test_rev_parse 'outside' =C2=A0 =C2=A0 =C2=A0false false false
> +cd work2
> +test_rev_parse 'outside2' =C2=A0 =C2=A0 false false false
> +cd ../work || exit 1
> +test_rev_parse 'inside' =C2=A0 =C2=A0 =C2=A0 false false true ''
> +cd sub/dir || exit 1
> +test_rev_parse 'subdirectory' false false true sub/dir/
> +cd ../../.. || exit 1
> +
> =C2=A0say "GIT_WORK_TREE=3Drelative path (override core.worktree)"
> =C2=A0GIT_DIR=3D$(pwd)/repo.git
> =C2=A0GIT_CONFIG=3D$GIT_DIR/config

I tried something similar (basically core.worktree =3D $(pwd)/work/) bu=
t
could not reproduce. Note that worktree will be normalized by
real_path() (or get_absolute_path() earlier) and the trailing '/' may
have been removed.
--=20
Duy
