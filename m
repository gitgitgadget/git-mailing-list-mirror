From: Jeff King <peff@peff.net>
Subject: Re: make profile issue on Git 2.1.0
Date: Tue, 19 Aug 2014 02:12:03 -0400
Message-ID: <20140819061203.GA14924@peff.net>
References: <CAOUWSGA+6gX8ZBv3Wo8FgUdyd99TYWOybTwGT6ADv_HtNFsFMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andi Kleen <ak@linux.intel.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?Q?Andr=C3=A9s_Sicard-Ram=C3=ADrez?= <asr@eafit.edu.co>
X-From: git-owner@vger.kernel.org Tue Aug 19 08:12:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJceb-0006jf-CP
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 08:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbaHSGMG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Aug 2014 02:12:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:54685 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752589AbaHSGMF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 02:12:05 -0400
Received: (qmail 15351 invoked by uid 102); 19 Aug 2014 06:12:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Aug 2014 01:12:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Aug 2014 02:12:03 -0400
Content-Disposition: inline
In-Reply-To: <CAOUWSGA+6gX8ZBv3Wo8FgUdyd99TYWOybTwGT6ADv_HtNFsFMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255444>

On Sun, Aug 17, 2014 at 09:35:29PM -0500, Andr=C3=A9s Sicard-Ram=C3=ADr=
ez wrote:

> I have the following issue on Git 2.1.0:
>=20
> $ make prefix=3D/some-directory profile
> ...
> make[2]: Entering directory `/home/asr/src/git/git-2.1.0/t/perf'
> rm -rf test-results
> ./run
> =3D=3D=3D Running 9 tests in this tree =3D=3D=3D
> error: No $GIT_PERF_REPO defined, and your build directory is not a r=
epo
> error: No $GIT_PERF_REPO defined, and your build directory is not a r=
epo
> error: No $GIT_PERF_REPO defined, and your build directory is not a r=
epo
> error: No $GIT_PERF_REPO defined, and your build directory is not a r=
epo
> error: No $GIT_PERF_REPO defined, and your build directory is not a r=
epo
> error: No $GIT_PERF_REPO defined, and your build directory is not a r=
epo
> error: No $GIT_PERF_REPO defined, and your build directory is not a r=
epo
> error: No $GIT_PERF_REPO defined, and your build directory is not a r=
epo
> error: No $GIT_PERF_REPO defined, and your build directory is not a r=
epo
> cannot open test-results/p0000-perf-lib-sanity.subtests: No such file
> or directory at ./aggregate.perl line 77.
> make[2]: *** [perf] Error 2
>=20
> I hadn't issues running the same command on Git 2.0.2.

This is because v2.1.0 started using "make perf" to feed the profile
builds, but it doesn't work on tarballs.

Maybe we should do this:

-- >8 --
Subject: Makefile: make perf tests optional for profile build

The perf tests need a repository to operate on; if none is
defined, we fall back to the repository containing our build
directory.  That fails, though, for an exported tarball of
git.git, which has no repository.

Since 5d7fd6d we run the perf tests as part of "make
profile". Therefore "make profile" fails out of the box on
released tarballs of v2.1.0.

We can fix this by making the perf tests optional; if they
are skipped, we still run the regular test suite, which
should give a lot of profile data (and is what we used to do
prior to 5d7fd6d anyway).

Signed-off-by: Jeff King <peff@peff.net>
---
As a side note, while testing this I noticed that the "make perf" run
goes a lot faster if you set GIT_PERF_REPEAT_COUNT=3D1. This is bad for
actually measuring things, but probably fine for profile feedback. I
don't use the profile builds myself, though, so I will leave it to
somebody who cares more to investigate whether such a change would be a
good idea.

 Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 2320de5..9f984a9 100644
--- a/Makefile
+++ b/Makefile
@@ -1659,7 +1659,11 @@ endif
 profile:: profile-clean
 	$(MAKE) PROFILE=3DGEN all
 	$(MAKE) PROFILE=3DGEN -j1 test
-	$(MAKE) PROFILE=3DGEN -j1 perf
+	@if test -n "$$GIT_PERF_REPO" || test -d .git; then \
+		$(MAKE) PROFILE=3DGEN -j1 perf; \
+	else \
+		echo "Skipping profile of perf tests..."; \
+	fi
 	$(MAKE) PROFILE=3DUSE all
=20
 profile-fast: profile-clean
--=20
2.1.0.346.ga0367b9
