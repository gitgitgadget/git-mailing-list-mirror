From: Jeff King <peff@peff.net>
Subject: Re: t1450-fsck (sometimes/often) failes on Mac OS X
Date: Sun, 15 Jul 2012 05:08:50 -0400
Message-ID: <20120715090849.GB18385@sigill.intra.peff.net>
References: <5001644F.10901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jul 15 11:09:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqKpk-0002wX-MR
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 11:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611Ab2GOJI7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jul 2012 05:08:59 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:60024
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060Ab2GOJI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 05:08:57 -0400
Received: (qmail 19107 invoked by uid 107); 15 Jul 2012 09:08:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 15 Jul 2012 05:08:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Jul 2012 05:08:50 -0400
Content-Disposition: inline
In-Reply-To: <5001644F.10901@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201475>

On Sat, Jul 14, 2012 at 02:21:35PM +0200, Torsten B=C3=B6gershausen wro=
te:

> I saw the problem first on pu, some time ago,=20
> but it dissappeared after cloning git.git into another directory.
>=20
> Now it appeared on next as well, so it's time to look a little bit de=
eper.
>=20
> This test case of t1450 fails:
> test_expect_success 'tag pointing to something else than its type' '

I can't reproduce this failure; I tried both pu or next, on Linux and O=
S
X (10.7).

> Linux:
> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a blob, not=
 a commit
> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: broken links
> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: could not load=
 tagged object
>=20
> Mac OS X:
> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit, n=
ot a blob
> error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or mi=
ssing

That seems very broken. That sha1 can have only one type, so OS X is
actually mis-parsing the object type? Weird. I would suggest a memory
error or race condition, but the test is valgrind-clean, and fsck shoul=
d
not be threaded at all.

What does "git show 63499e4" show when the test has failed? If you
re-run "git fsck --tags", does it reproduce reliably (i.e., is it bogus
data that something wrote to the object db, or is it good data being
ruined during the reading process)?

> I reverted the last change in fsck.c (Use the streaming interface), b=
ut that doesn't help
>=20
> Looking into the trash directory and looking at the files, we can see=
 that the .git/index is different
> between Linux and Mac OS X.
>=20
> Is there a good way to debug the index file?

git ls-files -s will dump the entries. But I'd expect them not to be
byte-equivalent, because the index will contain things like mtimes for
each entry, which will vary from run to run. Plus the error message
above indicates something much more broken.

-Peff
