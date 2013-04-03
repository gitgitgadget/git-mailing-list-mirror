From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lint-duplicates: Only check for numbered test cases
Date: Wed, 3 Apr 2013 10:28:04 -0400
Message-ID: <20130403142804.GB10494@sigill.intra.peff.net>
References: <201304030754.03100.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 03 16:28:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNOg3-0004tT-R8
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 16:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757549Ab3DCO2K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Apr 2013 10:28:10 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53474 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755529Ab3DCO2J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 10:28:09 -0400
Received: (qmail 24491 invoked by uid 107); 3 Apr 2013 14:29:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Apr 2013 10:29:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Apr 2013 10:28:04 -0400
Content-Disposition: inline
In-Reply-To: <201304030754.03100.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219937>

On Wed, Apr 03, 2013 at 07:54:02AM +0200, Torsten B=C3=B6gershausen wro=
te:

> Running make inside contrib/remote-helpers fails in "test-lint-duplic=
ates"
>=20
> This was because the regexp checking for duplicate numbers strips eve=
rything
> after the first "-" in the filename, including the prefix.
>=20
> As a result, 2 pathnames like
> "xxxx/contrib/remote-helpers/test-bzr.sh" and
> "xxxx/contrib/remote-helpers/test-hg-bidi.sh"
>=20
> are both converted into
> "xxxx/contrib/remote", and reported as duplicate.
>=20
> Improve the regexp:
> Remove everything after tNNNN- (where X stand for a digit)

I think the approach to just make test-lint-duplicates a no-op on
non-numbered tests is reasonable, but this is side-stepping half of the
issue. The problems are:

  1. We do not have numbers in our test names.

  2. We _do_ have full paths in the test names, which might have
     elements which look like test script names.

Your patch tightens the match so that a hyphen in the path name does no=
t
confuse our script. But it trades it for being confused by tNNNN in the
pathname. Which is admittedly less likely, but is not addressing the
fundamental issues that we should only be processing basenames.

So something like "sed 's,.*/,,'" would fix that. But that still leaves
us with a bunch of tests called "test-foo", "test-bar", etc, which will
appear as duplicates. So we would still want to tighten the number
parsing.

Like:

diff --git a/t/Makefile b/t/Makefile
index 5c6de81..e5afa4c 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -47,7 +47,9 @@ test-lint-duplicates:
 test-lint: test-lint-duplicates test-lint-executable
=20
 test-lint-duplicates:
-	@dups=3D`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` &&=
 \
+	@dups=3D`echo $(T) | tr ' ' '\n' | \
+		sed -e 's,.*/,,' -e 's/\(t[0-9][0-9][0-9][0-9]\)-.*/\1/' | \
+		sort | uniq -d` && \
 		test -z "$$dups" || { \
 		echo >&2 "duplicate test numbers:" $$dups; exit 1; }
=20

-Peff
