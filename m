From: Jeff King <peff@peff.net>
Subject: Re: When Will We See Collisions for SHA-1? (An interesting analysis
 by Bruce Schneier)
Date: Mon, 15 Oct 2012 14:34:38 -0400
Message-ID: <20121015183438.GB31658@sigill.intra.peff.net>
References: <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>
 <CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 20:34:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNpV6-00045r-AG
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 20:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381Ab2JOSel convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 14:34:41 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53098 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754076Ab2JOSel (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 14:34:41 -0400
Received: (qmail 3754 invoked by uid 107); 15 Oct 2012 18:35:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Oct 2012 14:35:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Oct 2012 14:34:38 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207771>

On Mon, Oct 15, 2012 at 07:47:09PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Mon, Oct 15, 2012 at 6:42 PM, Elia Pinto <gitter.spiros@gmail.com>=
 wrote:
> > Very clear analysis. Well written. Perhaps is it the time to update
> > http://git-scm.com/book/ch6-1.html (A SHORT NOTE ABOUT SHA-1) ?
> >
> > Hope useful
> >
> > http://www.schneier.com/crypto-gram-1210.html
>=20
> This would be concerning if the Git security model would break down i=
f
> someone found a SHA1 collision, but it really wouldn't.
>=20
> It's one thing to find *a* collision, it's quite another to:
>=20
>  1. Find a collision for the sha1 of harmless.c which I know you use,
>     and replace it with evil.c.
>=20
>  2. Somehow make evil.c compile so that it actually does something
>     useful and nefarious, and doesn't just make the C compiler puke.
>=20
>     If finding one arbitrary collision costs $43K in 2021 dollars
>     getting past this point is going to take quite a large multiple o=
f
>     $43K.

There are easier attacks than that if you can hide arbitrary bytes
inside a file. It's hard with C source code. The common one in hash
collision detection circles is to put invisible cruft into binary
document formats like PDF or Postscript. Git blobs themselves do not
have such an invisible place to put it, but you might be storing a
format that does.

But worse, git _commits_ have such an invisible portion. We calculate
the sha1 over the full commit, but we tend to show only the portion up
to the first NUL byte. I used that horrible trick in my "choose your ow=
n
sha1 prefix" patch. However, we could mitigate that by checking for
embedded NULs in git-fsck.

>  3. Somehow inject the new evil object into your repository, or
>     convince you to re-clone it / clone it from somewhere you usually
>     wouldn't.

Yeah, this part is the kicker. With the commit NUL trick, you would mak=
e
a useful commit and then ask somebody to pull it, and then later replac=
e
it with a commit pointing to an arbitrary tree. But if we assume we can
detect that easily (which I think we can), we are left with replacing
binary blobs that have hidden bits. And most projects do not take many
such blobs, and the result is that you could only replace the contents
of that particular blob, not an arbitrary part of the tree.

> It would be very interesting to see an analysis that deals with some
> actual Git-related security scenarios, instead of something that just
> assumes that if someone finds *any* SHA1 collision the sky is going t=
o
> fall.

I agree that most of the analysis is overblown. Having read the analysi=
s
Schneier pointed to, it actually is not that bad. We have 5-10 years to
get to a point where it's really expensive and extremely complex to
mount a single attack.

That doesn't seem like an emergency to me. It sounds like something we
should be thinking about (and we are). The simplest thing would be to
wait for a moment when it makes sense to break compatibility (e.g., we
decide that "git 2.0" is here, and everybody will have to rewrite to
take advantage of new features, so we can jump to sha-2). We can also
start building sha-2 history that references sha-1 history. That would
mean everybody needs to upgrade their git, but that is not a problem
that requires 5-10 years of foresight and planning.

-Peff
