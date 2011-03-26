From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] HOME must be set before calling git-init when creating
	test repositories
Date: Sat, 26 Mar 2011 19:21:26 +0100
Message-ID: <20110326182126.GA13496@blimp.localdomain>
References: <20110325200528.GA7302@blimp.localdomain> <7vsjub53j2.fsf@alter.siamese.dyndns.org> <AANLkTimQzPVOWCUx1hr+DEmRfdFB8=UeY_xCaxzVSwFy@mail.gmail.com> <7voc4y6g6v.fsf@alter.siamese.dyndns.org> <AANLkTikO4=TtFtpsQ_JtmGKqQ1NzgTuo7e8cdaQca+T7@mail.gmail.com> <7vvcz64ygm.fsf@alter.siamese.dyndns.org> <AANLkTi=+SZGxLyP8vFPpmK8DZvke6-Tu-crwq5+89qWx@mail.gmail.com> <20110326141118.GA3475@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 26 19:21:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3Y7N-0004KS-2B
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 19:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab1CZSVk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Mar 2011 14:21:40 -0400
Received: from mout9.freenet.de ([195.4.92.99]:54998 "EHLO mout9.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949Ab1CZSVj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 14:21:39 -0400
Received: from [195.4.92.18] (helo=8.mx.freenet.de)
	by mout9.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.72 #3)
	id 1Q3Y79-0005hl-NW; Sat, 26 Mar 2011 19:21:31 +0100
Received: from krlh-5f7246c3.pool.mediaways.net ([95.114.70.195]:59607 helo=tigra.home)
	by 8.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 25) (Exim 4.72 #3)
	id 1Q3Y79-0008IK-Hx; Sat, 26 Mar 2011 19:21:31 +0100
Received: from blimp.localdomain (unknown [192.168.0.94])
	by tigra.home (Postfix) with ESMTP id 7E7419FB69;
	Sat, 26 Mar 2011 19:21:27 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id E337F36D28; Sat, 26 Mar 2011 19:21:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110326141118.GA3475@sigill.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170063>

Otherwise the created test repositories will be affected by users ~/.gi=
tconfig.
=46or example, setting core.logAllrefupdates in users config will make =
all
calls to "git config --unset core.logAllrefupdates" fail which will bre=
ak
the first test which uses the statement and expects it to succeed.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Jeff King, Sat, Mar 26, 2011 15:11:18 +0100:
> On Sat, Mar 26, 2011 at 11:08:06AM +0100, Alex Riesen wrote:
>=20
> > >> Oh, it does. That's why the second patch (prefixed "[PATCH, fixe=
d]").
> > >> It makes HOME to be "$(pwd)/somewhere-else", or precisely:
> > >>
> > >> =A0 HOME=3D"$(pwd)"/"$test"
> > >> =A0 export HOME
> > >
> > > What happens to people who has non-empty "$root", iow, their $tes=
t begins
> > > with '/'?
> >=20
> > It's still under $test then.
>=20
> No, it's totally broken. $(pwd)/$test is nonsensical. The code right
> above your change guarantees that $test is an absolute path, either
> because the user gave us an absolute $root or because it has been
> prepended with $TEST_DIRECTORY (which itself comes from $(pwd)).

I see. I mistook "$root" for the root of a filesystem, not the variable=
 in
test-lib.sh. How about this, than?

 t/test-lib.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7cc9a52..2b24c3d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -984,14 +984,15 @@ rm -fr "$test" || {
 	exit 1
 }
=20
+HOME=3D"$(pwd)/$test"
+test -n "$root" && HOME=3D"$test"
+export HOME
+
 test_create_repo "$test"
 # Use -P to resolve symlinks in our working directory so that the cwd
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$test" || exit 1
=20
-HOME=3D$(pwd)
-export HOME
-
 this_test=3D${0##*/}
 this_test=3D${this_test%%-*}
 for skp in $GIT_SKIP_TESTS
--=20
1.7.4.1.471.gab01
