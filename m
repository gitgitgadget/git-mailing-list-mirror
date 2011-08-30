From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] traverse_trees(): allow pruning with pathspec
Date: Tue, 30 Aug 2011 19:53:15 +0700
Message-ID: <CACsJy8CmZv7Fuhw+m6X2CVO4vWLYFQNmStu1jJmhVXSi4mPxJQ@mail.gmail.com>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org> <1314653603-7533-1-git-send-email-gitster@pobox.com>
 <1314653603-7533-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 14:53:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyNp9-0003kp-V4
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 14:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab1H3Mxr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Aug 2011 08:53:47 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45396 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab1H3Mxq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Aug 2011 08:53:46 -0400
Received: by bke11 with SMTP id 11so5016497bke.19
        for <git@vger.kernel.org>; Tue, 30 Aug 2011 05:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JhymZfRIE1YRNzfmU1cTM6WR//UgbNfl77lFc2WYgJ4=;
        b=XElTxMB9G0hs0GNks4o6t3pd9jxNNThjyS+cSarBVQN6bsp4tHDfG1szFu9D4aE9FM
         42Uo11R5dMwrylKV7WDbk6yCwHvhx0EGx2Bkmo3a2O7ujwWABZ8iKmTp9aC0FXodND/I
         GgMaWwYxREuxcta5/ywokvFqRzT4Uhu6Cm5kI=
Received: by 10.204.13.69 with SMTP id b5mr56829bka.289.1314708825330; Tue, 30
 Aug 2011 05:53:45 -0700 (PDT)
Received: by 10.204.7.138 with HTTP; Tue, 30 Aug 2011 05:53:15 -0700 (PDT)
In-Reply-To: <1314653603-7533-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180408>

On Tue, Aug 30, 2011 at 4:33 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> @@ -316,10 +328,18 @@ int traverse_trees(int n, struct tree_desc *t, =
struct traverse_info *info)

Not related to the patch, but a bit of comment how this function works
and how it expects info->fn() to return would be appreciated.


> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct name_entry *entry =3D xmalloc(n*siz=
eof(*entry));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tree_desc_x *tx =3D xcalloc(n, size=
of(*tx));
> + =C2=A0 =C2=A0 =C2=A0 struct strbuf base =3D STRBUF_INIT;
> + =C2=A0 =C2=A0 =C2=A0 int interesting =3D 1;

I suspect making "base" an argument to traverse_trees() may save us a
few more alloc/free (or a lot, depends on how crowded the tree is).
There are only two users of traverse_trees(): merge-tree.c and
unpack-trees.c, changes should be manageable.


> @@ -376,16 +396,22 @@ int traverse_trees(int n, struct tree_desc *t, =
struct traverse_info *info)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0mask |=3D 1ul << i;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (S_ISDIR(entry[i].mode))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dirmask |=3D 1ul << i;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 e =3D &entry[i];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}

Why? "e" is not used in that loop or anywhere after that.


> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!mask)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D info->fn(n=
, mask, dirmask, entry, info);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret < 0) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 error =3D ret;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!info->show_all_errors)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interesting =3D pr=
une_traversal(e, info, &base, interesting);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (interesting < =
0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;

I don't really understand this function to comment. But I guess when
interesting < 0, we only skip info->fn() and assume it returns "mask"
(its user unpack_callback() only returns either "mask" or -1). So the
code at the end of the main loop

		for (i =3D 0; i < n; i++)
			if (mask & (1ul << i))
				update_extended_entry(tx + i, entry + i);

should not be skipped (by putting a break here). IOW, there should be
no "break;" here.


> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask &=3D ret;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;

While at there, remove "ret =3D 0;" too? I think this statement is usel=
ess.
--=20
Duy
