From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 02/10] unpack-trees: move all skip-worktree check back to unpack_trees()
Date: Mon, 15 Nov 2010 10:34:31 -0200
Message-ID: <AANLkTi=cvt2W1Eqj7KmtM+ng-BS7wRTM=+49gq5n+ghs@mail.gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
	<1289817410-32470-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 13:34:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHyGa-0005du-Sh
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 13:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909Ab0KOMed convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 07:34:33 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43799 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab0KOMec convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Nov 2010 07:34:32 -0500
Received: by bwz15 with SMTP id 15so5121510bwz.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 04:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VsXNAfIpLxOfSN5VZRFKJYke5ViEDj3Vp0hpfufK13Q=;
        b=X3Yy3sOUYRFsOrKj4A1V/GsOwHvgGWnLGHI9cpkbEtKLJE3jdZwOf4na8WHyYCklz/
         cYNLhy4WR3WuojIUGmhxIbrq6Bc2r+dz0AYATPtCc8xyf7O5LWmvbNEIjJAqYS7vlZtW
         7Y6EtkOneLAbJwxxbyCqcFzlgZDQYrBFtSKoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wG/EinURKavVb5yHSqLwbJR4/IS2wu5huZ/I90v6cTbdkFDrRNiCsbbgzN3CFbGbZf
         1j1zptqqyo5LYkHcCeeOHs/NnJpjAqLgtD+NmHkQOFYoFc4qSrsmrGgeMMFQDes8qB0U
         r9yBcO3DhJIODUKi9NX3y7G3HVP7RYqGl8D+c=
Received: by 10.204.62.17 with SMTP id v17mr6015234bkh.67.1289824471275; Mon,
 15 Nov 2010 04:34:31 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Mon, 15 Nov 2010 04:34:31 -0800 (PST)
In-Reply-To: <1289817410-32470-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161489>

2010/11/15 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
> =C2=A0cache.h =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
> =C2=A0unpack-trees.c | =C2=A0 69 ++++++++++++++++++++++++++++++++++++=
++++++++++++++-----
> =C2=A02 files changed, 63 insertions(+), 7 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 33decd9..d87708a 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -182,6 +182,7 @@ struct cache_entry {
> =C2=A0#define CE_WT_REMOVE (0x400000) /* remove in work directory */
>
> =C2=A0#define CE_UNPACKED =C2=A0(0x1000000)
> +#define CE_NEW_SKIP_WORKTREE (0x2000000)
>
Would be good to remove the () around the hex here and else in this fil=
e?

> =C2=A0/*
> =C2=A0* Extended on-disk flags
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 803445a..9acd9be 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -258,7 +258,7 @@ static int apply_sparse_checkout(struct cache_ent=
ry *ce, struct unpack_trees_opt
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int was_skip_worktree =3D ce_skip_worktree=
(ce);
>
> - =C2=A0 =C2=A0 =C2=A0 if (!ce_stage(ce) && will_have_skip_worktree(c=
e, o))
> + =C2=A0 =C2=A0 =C2=A0 if (ce->ce_flags & CE_NEW_SKIP_WORKTREE)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ce->ce_flags |=
=3D CE_SKIP_WORKTREE;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ce->ce_flags &=
=3D ~CE_SKIP_WORKTREE;
> @@ -834,6 +834,49 @@ static int unpack_callback(int n, unsigned long =
mask, unsigned long dirmask, str
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return mask;
> =C2=A0}
>
> +static void set_new_skip_worktree_1(struct unpack_trees_options *o)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int i;
> +
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0;i < o->src_index->cache_nr;i++) {
Could you add spaces after ; for readability, please? There is another
for below that needs this to.
