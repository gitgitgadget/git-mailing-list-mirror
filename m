From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] Add documentation for virtual repositories
Date: Wed, 25 May 2011 13:10:22 -0400
Message-ID: <20110525171021.GA24038@sigill.intra.peff.net>
References: <1306284392-12034-1-git-send-email-jamey@minilop.net>
 <1306284392-12034-3-git-send-email-jamey@minilop.net>
 <20110525160708.GE8795@sigill.intra.peff.net>
 <BANLkTikwxiBTVdqnQtdvr-VTCm2hSOcRjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Triplett <josh@joshtriplett.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 25 19:10:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPHbO-000434-Vh
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 19:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250Ab1EYRK0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 13:10:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36429
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819Ab1EYRKY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 13:10:24 -0400
Received: (qmail 2225 invoked by uid 107); 25 May 2011 17:10:23 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 May 2011 13:10:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2011 13:10:22 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikwxiBTVdqnQtdvr-VTCm2hSOcRjw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174431>

On Wed, May 25, 2011 at 10:01:20AM -0700, Shawn O. Pearce wrote:

> > and so on. And this fits in with the idea of it not just being an
> > upload-pack and receive-pack thing. I could do:
> >
> > =C2=A0GIT_REF_PREFIX=3Drefs/virtual/repo1; export GIT_REF_PREFIX
> > =C2=A0git fetch some-remote
>=20
> +1 * 1000. This should be a single environment variable / top level
> option. HEAD should also use the GIT_REF_PREFIX, like any other ref.

Good, I am glad I'm not the only one thinking this. :)

> FETCH_HEAD and MERGE_HEAD probably should as well if GIT_REF_PREFIX i=
s
> set, however these are going to be a bit harder to move. Not all tool=
s
> that read them are GIT_REF_PREFIX aware, or go through C code that ca=
n
> be modified to be GIT_REF_PREFIX aware. (git-gui and EGit, I'm talkin=
g
> about you here!)  They can obviously be fixed, but until then using a
> working directory with GIT_REF_PREFIX set will be slightly
> interesting.

Yeah, most scripts these days will need to go through the C programs to
handle packed-refs. But the top-level pseudo-refs are a bit more
magical. That is perhaps why they split HEAD and refs handling in the
original patch. Still, I don't think it's insurmountable.

> > So the virtual repository is basically just a "chroot" of the ref
> > namespace. And it's dirt simple to implement, because you do the
> > translation at the refs.c layer.
>=20
> Yes, exactly.

Like chroots, there is a sticky point with symbolic links. What should
"refs/virtual/repo1/HEAD" have in it? Either:

  ref: refs/virtual/repo1/refs/heads/master

or

  ref: refs/heads/master

?

If the former, then we will have to make sure the ref is inside our
prefix, and strip it out. If the latter, then you will get different
results for:

  git show refs/virtual/repo1/HEAD

versus

  GIT_REF_PREFIX=3Drefs/virtual/repo1 git show HEAD

which I think is a bad thing.

-Peff
