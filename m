From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git rev-list | git cherry-pick --stdin is leaky
Date: Wed, 01 May 2013 00:47:30 +0200
Message-ID: <51804A02.6080301@lsrfire.ath.cx>
References: <517F0C18.8060703@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
X-From: git-owner@vger.kernel.org Wed May 01 00:47:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXJKu-0005ZS-85
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 00:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933771Ab3D3Wro convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Apr 2013 18:47:44 -0400
Received: from india601.server4you.de ([85.25.151.105]:49630 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933785Ab3D3Wrn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 18:47:43 -0400
Received: from [192.168.2.105] (p4FFDBCB6.dip0.t-ipconnect.de [79.253.188.182])
	by india601.server4you.de (Postfix) with ESMTPSA id 50408265;
	Wed,  1 May 2013 00:47:41 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <517F0C18.8060703@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223037>

Am 30.04.2013 02:11, schrieb Stephen Boyd:
> (resending since the attachment seems to make vger sad)
>=20
> Hi,
>=20
> I'm running git rev-list | git cherry-pick --stdin on a range of abou=
t
> 300 commits. Eventually the chery-pick dies with:
>=20
>      error: cannot fork() for commit: Cannot allocate memory
>=20
> Running valgrind shows me that the tree traversal code is leaking
> gigabytes of memory (particularly unpack_callback). Since cherry-pick=
 is
> a very long running process all these allocations are never freed and
> eventually I run out of memory. The worst offender and summary is:
>=20
> =3D=3D7986=3D=3D 938,956,692 (929,961,582 direct, 8,995,110 indirect)=
 bytes in
> 7,765,439 blocks are definitely lost in loss record 257 of 257
> =3D=3D7986=3D=3D    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
> =3D=3D7986=3D=3D    by 0x4FAF57: xcalloc (wrapper.c:119)
> =3D=3D7986=3D=3D    by 0x4F5281: unpack_callback (unpack-trees.c:539)
> =3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
> =3D=3D7986=3D=3D    by 0x4F586C: unpack_callback (unpack-trees.c:467)
> =3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
> =3D=3D7986=3D=3D    by 0x4F586C: unpack_callback (unpack-trees.c:467)
> =3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
> =3D=3D7986=3D=3D    by 0x4F586C: unpack_callback (unpack-trees.c:467)
> =3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
> =3D=3D7986=3D=3D    by 0x4F586C: unpack_callback (unpack-trees.c:467)
> =3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
> =3D=3D7986=3D=3D
> =3D=3D7986=3D=3D LEAK SUMMARY:
> =3D=3D7986=3D=3D    definitely lost: 2,514,117,692 bytes in 21,210,86=
1 blocks
> =3D=3D7986=3D=3D    indirectly lost: 885,481,947 bytes in 10,165,801 =
blocks
> =3D=3D7986=3D=3D      possibly lost: 650,712,395 bytes in 6,014,309 b=
locks
> =3D=3D7986=3D=3D    still reachable: 7,734,870 bytes in 47,794 blocks
> =3D=3D7986=3D=3D         suppressed: 0 bytes in 0 blocks

I looked at that particular leak a year ago but couldn't convince mysel=
f
to submit the patch below.  If the callback function we call through
call_unpack_fn does something strange like free()ing entries itself or
adding them to some list without duplication then the added free() can
cause trouble.

Looking at it again today I don't understand that concern any more.  Th=
e
current callback functions don't do something like that, in any case.
Maybe I'm missing something.

Anyway, could you please check if the patch helps with your use case?

Thanks,
Ren=E9


diff --git a/unpack-trees.c b/unpack-trees.c
index ede4299..67bc698 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -590,8 +590,13 @@ static int unpack_nondirectories(int n, unsigned l=
ong mask,
 		src[i + o->merge] =3D create_ce_entry(info, names + i, stage);
 	}
=20
-	if (o->merge)
-		return call_unpack_fn(src, o);
+	if (o->merge) {
+		int ret =3D call_unpack_fn(src, o);
+		for (i =3D 1; i < n + 1; i++)
+			if (src[i] && src[i] !=3D o->df_conflict_entry)
+				free(src[i]);
+		return ret;
+	}
=20
 	for (i =3D 0; i < n; i++)
 		if (src[i] && src[i] !=3D o->df_conflict_entry)
