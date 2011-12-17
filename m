From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: How to automatically correct an almost correct auto-merge?
Date: Sat, 17 Dec 2011 12:07:06 +0100
Message-ID: <20111217110706.GH1868@goldbirke>
References: <20111216203215.GG1868@goldbirke>
	<201112162039.pBGKdR8H012831@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Sat Dec 17 12:07:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbs6k-0000CO-81
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 12:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab1LQLHK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Dec 2011 06:07:10 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:61595 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab1LQLHI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 06:07:08 -0500
Received: from localhost6.localdomain6 (p5B1310B3.dip0.t-ipconnect.de [91.19.16.179])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0M7sQq-1QpWdm3zSi-00vRIW; Sat, 17 Dec 2011 12:07:07 +0100
Content-Disposition: inline
In-Reply-To: <201112162039.pBGKdR8H012831@no.baka.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:T2e8pV8wX7C7bu8L+BKruep86Qx2rFGj/MHuQ4Hnbot
 Ln+0F4UR0heCzUccn7fdp7efemIIUQ7apobz4p2DewOvGPTCM1
 mPKA1V9MM4Oe7PKC0+K7k8voBsGNiammGemczSs1ooncoOIrNM
 oVwLWVnL5akIOofN+JNyBHfVjAbaBawhrUhZFZhXYf1lYepJ3v
 rpE8W+shQi7NT/eqO4e5ivbvvVBvhyDTVdV3q5d3ES2Y8b7u09
 fD3wuI98Cd86rSl8nAsMCiR/ng+poMdzI1s5oNZWIdED52CP+O
 RqZndRyxr8PRNKCwVjK/64yudh3Q2gPyUErpla8XbkQFQrVuwG
 n5diAqApSW6/hDRjk0/c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187377>

On Fri, Dec 16, 2011 at 03:39:27PM -0500, Seth Robertson wrote:
>=20
> > How can I teach git to produce the correct merge result when
> > performing the same merge later on?
>=20
> Custom merge driver.
>=20
> Type `man gitattributes` and search for "custom merge driver"
>=20
> Your merge driver can have whatever policy you can program, on a per
> file basis.

Thanks for the pointer, I knew it must be possible with git somehow.

=46or future reference, here's what I did to handle the minimal receipe
posted in my earlier email:

I stored the diff between the original and semantically almost correct
merge result and the fixed version in the file "patch", then put
together the little script below and configured it as custom merge
driver for the file "file", as described in the documentation.  The
script uses 'git merge-file' to perform the real merge, and then
applies the fixup patch (after rewriting the paths, because during the
merge the patch should be applied to the current file the merge driver
is working with instead of the original "file").  Of course, "file"
might be modified by other merges before or after the problematic
merge, but the fixup patch should not be applied in those cases.  The
two greps and the conditions make sure that the patch is applied only
if both "code blocks" are in the file and they are in the wrong order.

Unfortunately, applying a patch is more sensitive to matching context,
so it will fail easily when there are other changes in the
neighborhood, but at least it will fail loudly, and then I'll know I
have to fix it up manually.  We'll see, how it will cope with real
source code.


Thanks,
G=E1bor



#!/bin/sh

f=3D"file"

git merge-file "$1" "$2" "$3"

a_line=3D"$(grep -n '^a$' "$1" |cut -d: -f1)"
c_line=3D"$(grep -n '^c$' "$1" |cut -d: -f1)"

if [ -n "$a_line" -a -n "$c_line" ] && [ "$c_line" -lt "$a_line" ]; the=
n=20
	echo "Fixing incorrect auto-merge result of '$f'"
	sed -e "s%^diff --git a/$f b/$f%diff --git a/$1 b/$1%" \
		-e "s%^--- a/$f%--- a/$1%" \
		-e "s%^+++ b/$f%+++ b/$1%" patch \
		|git apply
fi
