From: Pete Wyckoff <pw@padd.com>
Subject: [RFC PATCH] test showing EMFILE error with too many packs
Date: Sat, 13 Aug 2011 16:25:21 -0400
Message-ID: <20110813202521.GA9958@arf.padd.com>
References: <20110812151548.GA14385@padd.com>
 <CAJo=hJsj8_VjD5wN9Gge_Me-eXKK-P7nLAxERiiLp0+ayiEBbg@mail.gmail.com>
 <20110812172600.GA15896@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 13 22:28:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsKp6-0005d2-RQ
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 22:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283Ab1HMUZ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Aug 2011 16:25:26 -0400
Received: from honk.padd.com ([74.3.171.149]:40505 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852Ab1HMUZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2011 16:25:26 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 319E729CB;
	Sat, 13 Aug 2011 13:25:25 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E9C1D5A90E; Sat, 13 Aug 2011 16:25:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110812172600.GA15896@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179292>

pw@padd.com wrote on Fri, 12 Aug 2011 10:26 -0700:
> spearce@spearce.org wrote on Fri, 12 Aug 2011 09:09 -0700:
> > On Fri, Aug 12, 2011 at 08:15, Pete Wyckoff <pw@padd.com> wrote:
> > > Somebody at $work found this problem:
> > >
> > > =A0 =A0$ git ls-files -s | wc
> > > =A0 =A0error: packfile .git/objects/pack/pack-1627e77da82bbb36118=
762649c8aa88c05664b1e.pack cannot be accessed
> > > =A0 =A0[..lots more similar errors..]
> > >
> > > Turns out his shell's open file descriptor limit was 500. =A0And
> > > there are 1600 pack files in the repo.
> > >
> > > Increasing the descriptor limit to 1024 fixed it. =A0I could
> > > probably get him to repack, which may also fix it.
> > >
> > > Does it seem feasible to look for EMFILE errors and close
> > > some packs? =A0Or at least spit out a more intuitive error?
> >=20
> > What version of Git? I remember fixing this already.... :-)
>=20
> Initially 1.7.5.4.  Same problem on 1.7.6 and master. =20
>=20
> I have your "Limit file descriptors used by packs" (c793430, 28
> feb 2011).
>=20
> It fails here:
>=20
> 	if (!is_pack_valid(p)) {
> 		error("packfile %s cannot be accessed", p->pack_name);
> 		goto next;
> 	}
>=20
> because p->pack_fd is -1, because an earlier git_open_noatime()
> got EMFILE.  The function unuse_one_window() is never able to
> find anything to close.
>=20
> I'll do some more debugging this weekend.  Thanks for pointing
> out that it _should_ be fixed.

Here's a test case (on master).  It is easy to repack the
repository to avoid this situation, so I'm not convinced this is
a bug.

But it would be nice at least to report what's going on when we
run out of file descriptors.

The current error is:

    $ ../git commit -m fileN
    error: packfile .git/objects/pack/pack-7bff59b72a19f371ccd3e4ffefaa=
c6cd1e07c6ed.pack cannot be accessed
    error: invalid object 100644 a7d02de3336c72e6d2d24f382b82195dbf6254=
04 for 'file47'
    error: Error building trees


		-- Pete

--------8<--------

=46rom: Pete Wyckoff <pw@padd.com>
Date: Sat, 13 Aug 2011 15:57:55 -0400
Subject: [RFC PATCH] test showing EMFILE error with too many packs

In a repository with too many pack files, it is
possible to have too many open at once and exceed
the process file descriptor limit.

This test shows one failure with an artificially low limit
of 50.  The same failure happens at a "normal" value
like 1024, but takes longer.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t5308-pack-emfile.sh |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100755 t/t5308-pack-emfile.sh

diff --git a/t/t5308-pack-emfile.sh b/t/t5308-pack-emfile.sh
new file mode 100755
index 0000000..66c62a7
--- /dev/null
+++ b/t/t5308-pack-emfile.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description=3D'repos with too many packs should not fail'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	for i in {1..60}
+	do
+		echo "$i" >"file$i" &&
+		git add "file$i" &&
+		test_tick &&
+		git commit -q -m "$i" &&
+		git repack -q
+	done
+	git prune-packed -q
+'
+
+# run in a subshell since limits cannot be increased
+test_expect_failure 'commit fail with too many packs' '
+	(
+	ulimit -n 50 &&
+	>"fileN" &&
+	git add "fileN" &&
+	git commit -q -m "fileN"
+	)
+'
+
+test_done
--=20
1.7.5.4
