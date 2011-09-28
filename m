From: Jeff King <peff@peff.net>
Subject: Re: 6d4bb3833c3d2114d (fetch: verify we have everything we need
 before updating our ref) breaks fetch
Date: Wed, 28 Sep 2011 14:53:28 -0400
Message-ID: <20110928185327.GB1482@sigill.intra.peff.net>
References: <1317225869.30267.18.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Sep 28 20:53:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8zGC-0005CU-0P
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 20:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102Ab1I1Sxb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Sep 2011 14:53:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47518
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426Ab1I1Sxa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 14:53:30 -0400
Received: (qmail 7838 invoked by uid 107); 28 Sep 2011 18:58:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Sep 2011 14:58:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Sep 2011 14:53:28 -0400
Content-Disposition: inline
In-Reply-To: <1317225869.30267.18.camel@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182357>

On Wed, Sep 28, 2011 at 06:04:27PM +0200, Carlos Mart=C3=ADn Nieto wrot=
e:

> Whilst trying to do some work related to fetch, I came across a
> regression in the 'next' branch. Bisecting gave me this commit as
> breaking point (and I tried with the parent and there it worked). Whe=
n
> doing 'git fetch', rev-list will complain about usage, and fetch will
> say that we didn't receive enough, even though earlier versions of gi=
t
> have no problems. This fails both on github and on git.or.cz and for =
git
> and http transports:
>=20
> $ ./git-fetch git://repo.or.cz/git
> usage: git rev-list [OPTION] <commit-id>... [ -- paths... ]

Hmm. I notice you're running a not-installed version of fetch. Might
this be a problem with a new git fetch running an older, installed
version of rev-list?

The commit you mention calls rev-list with --verify-objects, but that
feature is only added in the parent commit. So I can reproduce your
issue with:

  $ git checkout 6d4bb38~2 ;# or anything before --verify-objects
  $ make install
  $ git checkout 6d4bb38
  $ make
  $ ./git-fetch git://repo.or.cz/git

but this works (because it sets the exec path properly):

  $ ./bin-wrappers/git fetch git://repo.or.cz/git

as does this:

  $ make install
  $ ./git-fetch git://repo.or.cz/git

So I don't think there's a bug. It's just that running compiled program=
s
straight out of the build directory isn't supported. It works _most_ of
the time, but as you can see, you may end up calling older, installed
versions of git. The bin-wrappers scripts set up the exec path properly
to let you test.

-Peff
