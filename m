From: Jeff King <peff@peff.net>
Subject: Re: When Will We See Collisions for SHA-1? (An interesting analysis
 by Bruce Schneier)
Date: Tue, 16 Oct 2012 13:32:54 -0400
Message-ID: <20121016173254.GD27243@sigill.intra.peff.net>
References: <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>
 <CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com>
 <20121015183438.GB31658@sigill.intra.peff.net>
 <507D4651.6080207@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:33:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOB10-0005uZ-5e
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 19:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462Ab2JPRdD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2012 13:33:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55154 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755192Ab2JPRc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 13:32:58 -0400
Received: (qmail 18195 invoked by uid 107); 16 Oct 2012 17:33:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Oct 2012 13:33:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Oct 2012 13:32:54 -0400
Content-Disposition: inline
In-Reply-To: <507D4651.6080207@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207863>

On Tue, Oct 16, 2012 at 01:34:41PM +0200, Ren=C3=A9 Scharfe wrote:

> FWIW, I couldn't measure a performance difference for git log with an=
d
> without the following patch, which catches commits created with your
> hash collision trick, but might be too strict:
>=20
> diff --git a/commit.c b/commit.c
> index 213bc98..4cd1e83 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -262,6 +262,12 @@ int parse_commit_buffer(struct commit *item, con=
st void *buffer, unsigned long s
>  	if (item->object.parsed)
>  		return 0;
>  	item->object.parsed =3D 1;
> +
> +	if (memchr(buffer, '\0', size)) {
> +		return error("bogus commit contains a NUL character: %s",
> +			     sha1_to_hex(item->object.sha1));
> +	}
> +

Hmm. Yeah, that should be relatively inexpensive, since we are about to
read through most of the bytes anyway (we probably have just zlib
inflated them all, so they would even be in cache). It might make more
of a difference for a raw traversal that is not even going to look at
below the header, like rev-list or merge-base. But I couldn't measure a
difference doing "git rev-list HEAD >/dev/null" in either git.git or
linux-2.6.git.

So maybe it is worth doing preemptively. Even without security concerns=
,
we would be truncating the commit message, so it is probably better to
let the user know (a warning is probably more appropriate, though, just
in case somebody does have embedded NULs for historical reason).

-Peff
