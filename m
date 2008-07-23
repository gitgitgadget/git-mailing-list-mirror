From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: regression in  92392b4
Date: Wed, 23 Jul 2008 12:14:15 +0200
Message-ID: <20080723101415.GA23769@atjola.homenet>
References: <20080722231745.GD11831@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Pierre Habouzit <madcoder@debian.org>, spearce@spearce.org,
	Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 12:15:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLbNf-000100-E6
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 12:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbYGWKOW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 06:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753349AbYGWKOV
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 06:14:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:37866 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752994AbYGWKOU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 06:14:20 -0400
Received: (qmail invoked by alias); 23 Jul 2008 10:14:18 -0000
Received: from i577BBDAB.versanet.de (EHLO atjola.local) [87.123.189.171]
  by mail.gmx.net (mp061) with SMTP; 23 Jul 2008 12:14:18 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19ViWRTIepVRW6silxisA9Ywojkg71hm2GSpAik8e
	d6HclaDeCM3sQs
Content-Disposition: inline
In-Reply-To: <20080722231745.GD11831@artemis.madism.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89620>

On 2008.07.23 01:17:45 +0200, Pierre Habouzit wrote:
>   Hi, here is a manual painful down-secting (opposed to a bisect ;P) =
I
> did, since git in next cannot fetch on a regular basis for me. The
> culprit seems to be commit  92392b4:
>=20
>     =E2=94=8C=E2=94=80(1:11)=E2=94=80=E2=94=80<~/dev/scm/git 92392b4.=
=2E.>=E2=94=80=E2=94=80
>     =E2=94=94[artemis] git fetch
>     remote: Counting objects: 461, done.
>     remote: Compressing objects: 100% (141/141), done.
>     remote: Total 263 (delta 227), reused 155 (delta 121)
>     Receiving objects: 100% (263/263), 95.55 KiB, done.
>     fatal: Out of memory, malloc failed
>     fatal: index-pack failed
>     [2]    16674 abort (core dumped)  git fetch
>=20
>     =E2=94=8C=E2=94=80(1:12)=E2=94=80=E2=94=80<~/dev/scm/git 92392b4.=
=2E.>=E2=94=80=E2=94=80
>     =E2=94=94[artemis] git checkout -m HEAD~1; make git-index-pack
>     Previous HEAD position was 92392b4... index-pack: Honor core.delt=
aBaseCacheLimit when resolving deltas
>     HEAD is now at 03993e1... index-pack: Track the object_entry that=
 creates each base_data
>     GIT_VERSION =3D 1.5.6.3.3.g03993
> 	CC index-pack.o
> 	LINK git-index-pack
>=20
>     =E2=94=8C=E2=94=80(1:12)=E2=94=80=E2=94=80<~/dev/scm/git 03993e1.=
=2E.>=E2=94=80=E2=94=80
>     =E2=94=94[artemis] git fetch
>     remote: Counting objects: 461, done.
>     remote: Compressing objects: 100% (141/141), done.
>     remote: Total 263 (delta 227), reused 155 (delta 121)
>     Receiving objects: 100% (263/263), 95.55 KiB, done.
>     Resolving deltas: 100% (227/227), completed with 153 local object=
s.
>     From git://git.kernel.org/pub/scm/git/git
>        5ba2c22..0868a30  html       -> origin/html
>        2857e17..abeeabe  man        -> origin/man
>        93310a4..95f8ebb  master     -> origin/master
>        559998f..e8bf351  next       -> origin/next
>=20
> You can see the commit sha's in the prompt. 03993e1 is fine, 92392b4 =
is
> broken, I've absolutely no clue about what happens.
>=20
> All I can say is that at some point in get_data_from_pack, obj[1].idx
> points to something that is *not* a sha so it's probably corrupted.
> (from index-pack.c).

Here's how to reproduce:

#!/bin/bash

[ -d git-bug ] || \
	git clone git://git.kernel.org/pub/scm/git/git git-bug
cd git-bug

git update-ref refs/remotes/origin/html 5ba2c22
git update-ref refs/remotes/origin/man 2857e17
git update-ref refs/remotes/origin/maint 2d9c572
git update-ref refs/remotes/origin/master 93310a4
git update-ref refs/remotes/origin/next 559998f
git update-ref refs/remotes/origin/pu 010581c8

git reset --hard origin/master

sleep 1

git reflog expire --expire=3D0 --all

git repack -A -d -f --depth=3D10 --window=3D10
git prune

git config core.deltaBaseCacheLimit 100

git fetch



The values for html, man, master and next are taken from Pierre's
output, those for maint and pu are from a repo that works for
reproducing the bug, just in case that future output of those branches
manage to break the reproducability.

Might be, that any fetch will fail if deltaBaseCacheLimit is low enough=
,
but I'm too lazy to test that as well, now that I realized it. My head
seems not to be working correctly anyway, can't even manage to get a
core dump... Stupid flu...

HTH
Bj=C3=B6rn
