From: Jeff King <peff@peff.net>
Subject: Re: git checkout no longer warning about uncommitted/untracked files!
Date: Mon, 23 May 2011 17:10:42 -0400
Message-ID: <20110523211042.GC6281@sigill.intra.peff.net>
References: <1306171797211-6395441.post@n2.nabble.com>
 <4DDAC57D.9020809@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: funeeldy <Marlene_Cote@affirmednetworks.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon May 23 23:11:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOcOv-0001gp-Q8
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 23:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031046Ab1EWVKs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2011 17:10:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57908
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031037Ab1EWVKp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 17:10:45 -0400
Received: (qmail 23580 invoked by uid 107); 23 May 2011 21:12:49 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 May 2011 17:12:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 May 2011 17:10:42 -0400
Content-Disposition: inline
In-Reply-To: <4DDAC57D.9020809@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174275>

On Mon, May 23, 2011 at 10:37:17PM +0200, Ren=C3=A9 Scharfe wrote:

> 	$ echo 1 >a
> 	$ git add a
> 	$ git commit -m.
> 	[master (root-commit) b0e60d3] .
> 	 1 files changed, 1 insertions(+), 0 deletions(-)
> 	 create mode 100644 a
>=20
> 	$ git branch x
> 	$ echo uncommitted >a
> 	$ echo untracked >b
>=20
> 	$ git checkout x
> 	M	a
> 	Switched to branch 'x'

But you're not actually switching trees here, so there is by definition
no merge that needs to happen, and the changes stay in place.

> 	$ cat a
> 	uncommitted
> 	$ cat b
> 	untracked

And here, there is no contention over "b" since git would never need to
write it at all.

A better test would be:

  git init repo && cd repo
  echo 1 >a && git add a && git commit -m a1
  echo 2 >a && git add a && git commit -m a2

  git checkout -b check-uncommitted master^
  # should fail because we would have to merge
  echo 3 >a && git checkout master

  git checkout -f master
  echo 4 >b && git add b && git commit -m b4
  git checkout -b check-untracked master^
  echo untracked >b
  # should fail because we would overwrite untracked b
  git checkout master

And indeed, testing with v1.7.3., both of my "should fail" checkouts do
fail, with the following messages respectively:

  error: Your local changes to the following files would be overwritten=
 by checkout:
        a
  Please, commit your changes or stash them before you can switch branc=
hes.
  Aborting

and

  error: The following untracked working tree files would be overwritte=
n by checkout:
        b
  Please move or remove them before you can switch branches.
  Aborting

So I still don't know what the bug is.

-Peff
