From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] mingw-multibyte: fix memory acces violation and path
 length limits.
Date: Mon, 30 Sep 2013 19:00:26 +0200
Message-ID: <5249AE2A.3050302@web.de>
References: <1380403036-20413-1-git-send-email-wnoguchi.0727@gmail.com> <alpine.DEB.1.00.1309290112380.1191@s15462909.onlinehome-server.info> <524796DC.5020302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Wataru Noguchi <wnoguchi.0727@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 30 19:00:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQgpw-0005iG-Fb
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 19:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301Ab3I3RAl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Sep 2013 13:00:41 -0400
Received: from mout.web.de ([212.227.17.11]:65432 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753938Ab3I3RAk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 13:00:40 -0400
Received: from [192.168.2.102] ([79.250.177.159]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MIeCm-1VOTuf36Ou-002FM6 for <git@vger.kernel.org>;
 Mon, 30 Sep 2013 19:00:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <524796DC.5020302@gmail.com>
X-Provags-ID: V03:K0:7Qt9qIhpaLO+FQkyxRSYq+G8cfCmOBDGqzose6/NVXnJ3WQpOjW
 /rHyPHV3waX3zzujRUtLRGu2KpjpWFGFkh6XLocL4SFG7KgnSclaRrCosHT8T99HthOmS4O
 hVL6zBP0zciSCtB0R3LnNPVB7LfIpq5ZSmeJ+nLUk6ZedTBJCvHc0/xkblykYu69PqmgdL5
 amix3g+vNxFQe58qegTfA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235618>

Am 29.09.2013 04:56, schrieb Wataru Noguchi:
> Hi,
>=20
> Thanks for comments.
>=20
> My currently working repository is
>=20
> https://github.com/wnoguchi/git/tree/hotfix/mingw-multibyte-path-chec=
kout-failure
>=20
> I have revert commits to 1f10da3.
> I'll try failure step.
>=20
> - gcc optimization level is O2.(fail)
> - gcc O0, O1 works fine.
>=20
>=20
> $ gdb git-clone
> GNU gdb 6.8
> Copyright (C) 2008 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/g=
pl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show cop=
ying"
> and "show warranty" for details.
> This GDB was configured as "i686-pc-mingw32"...
> (gdb) r https://github.com/wnoguchi/mingw-checkout-crash.git
> Starting program: C:\msysgit\git/git-clone.exe https://github.com/wno=
guchi/mingw
> -checkout-crash.git
> [New thread 800.0xa10]
> Error: dll starting at 0x779f0000 not found.
> Error: dll starting at 0x75900000 not found.
> Error: dll starting at 0x779f0000 not found.
> Error: dll starting at 0x778f0000 not found.
> [New thread 800.0x92c]
> Cloning into 'mingw-checkout-crash'...
> Error: dll starting at 0x29f0000 not found.
> remote: Counting objects: 8, done.
> remote: Compressing objects: 100% (7/7), done.
> remote: Total 8 (delta 0), reused 8 (delta 0)
> Unpacking objects: 100% (8/8), done.
> Checking connectivity... done
> [New thread 800.0xea0]
>=20
> Program received signal SIGSEGV, Segmentation fault.
> 0x004d5200 in git_check_attr (
>       path=3D0xacc6a0 ""..., num=3D5, check=3D0x572440) at attr.c:754
> 754                     const char *value =3D check_all_attr[check[i]=
=2Eattr->attr_n
> r].value;
> (gdb) list
> 749             int i;
> 750
> 751             collect_all_attrs(path);
> 752
> 753             for (i =3D 0; i < num; i++) {
> 754                     const char *value =3D check_all_attr[check[i]=
=2Eattr->attr_n
> r].value;
> 755                     if (value =3D=3D ATTR__UNKNOWN)
> 756                             value =3D ATTR__UNSET;
> 757                     check[i].value =3D value;
> 758             }

I get a different crash on Linux if I set PATH_MAX to 260.  The followi=
ng
hackish patch prevents it.  Does it help in your case as well?  If it d=
oes
then I'll send a nicer (but longer) one.

Thanks,
Ren=E9


diff --git a/unpack-trees.c b/unpack-trees.c
index 1a61e6f..9bd7dcb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -961,7 +961,7 @@ static int clear_ce_flags(struct cache_entry **cach=
e, int nr,
 			    int select_mask, int clear_mask,
 			    struct exclude_list *el)
 {
-	char prefix[PATH_MAX];
+	char prefix[4096];
 	return clear_ce_flags_1(cache, nr,
 				prefix, 0,
 				select_mask, clear_mask,
