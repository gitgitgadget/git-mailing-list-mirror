From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add--interactive: Preserve diff heading when
 splitting hunks
Date: Mon, 12 May 2014 14:39:55 -0400
Message-ID: <20140512183955.GB31164@sigill.intra.peff.net>
References: <1399824596-4670-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 20:40:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wjv8s-0002Fp-4j
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 20:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbaELSj6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 May 2014 14:39:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:50077 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750924AbaELSj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 14:39:57 -0400
Received: (qmail 16560 invoked by uid 102); 12 May 2014 18:39:57 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 May 2014 13:39:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 May 2014 14:39:55 -0400
Content-Disposition: inline
In-Reply-To: <1399824596-4670-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248717>

On Sun, May 11, 2014 at 04:09:56PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> Change the display of hunks in hunk splitting mode to preserve the di=
ff
> heading, which hasn't been done ever since the hunk splitting was
> initially added in v1.4.4.2-270-g835b2ae.
>=20
> Splitting the first hunk of this patch will now result in:
>=20
>     Stage this hunk [y,n,q,a,d,/,j,J,g,s,e,?]? s
>     Split into 2 hunks.
>     @@ -792,7 +792,7 @@ sub hunk_splittable {
>     [...]
>=20
> Instead of:
>=20
>     Stage this hunk [y,n,q,a,d,/,j,J,g,s,e,?]? s
>     Split into 2 hunks.
>     @@ -792,7 +792,7 @@
>     [...]
>=20
> This makes it easier to use the tool when you're splitting some giant
> hunk and can't remember in which function you are anymore.

This makes a lot of sense to me. I did notice two interesting quirks,
one of which might be worth addressing.

One, there is a slightly funny artifact in that the hunk header comes
from the top of the context line, and that top is a different position
for each of the split hunks. So in a file like:

  header_A
      content
  header_B
      one
      two
      three
      four

you might have a diff like:

  @@ ... @@ header_A
   header_B
       one
       two
  +    new line 1
       three
  +    new line 2
       four

The hunk header for "new line 1" is "A", because "B" itself is part of
the context. But the hunk header for "new line 2", if it were an
independent hunk, would be "B". We print "A" because we copy it from th=
e
original hunk.

It probably won't matter much in practice (and I can even see an
argument that "A" is the "right" answer). And figuring out "B" here
would be prohibitively difficult, I would think, as it would require
applying the funcname rules internal to git-diff to a hunk that git-dif=
f
itself never actually sees.

Since the output from your patch is strictly better than what we saw
before, I think there is no reason we cannot leave such an improvement
to later (or never).

> The diff is somewhat larger than I initially expected because in orde=
r
> to display the headings in the same color scheme as the output from
> git-diff(1) itself I had to split up the code that would previously
> color diff output that previously consisted entirely of the fraginfo,
> but now consists of the fraginfo and the diff heading (the latter of
> which isn't colored).

The func heading is not colored by default, but you can configure it to
be so with color.diff.func. I double-checked the behavior with your
patch: you end up with the uncolored header in the split hunks, because
it is parsed from the uncolored line. Which is not bad, but I think we
can trivially do better, just by adding back in the color as we do with
the fraginfo.

Like:

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ed1e564..ac5763d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -29,6 +29,10 @@ my ($fraginfo_color) =3D
 	$diff_use_color ? (
 		$repo->get_color('color.diff.frag', 'cyan'),
 	) : ();
+my ($funcname_color) =3D
+	$diff_use_color ? (
+		$repo->get_color('color.diff.func', ''),
+	) : ();
 my ($diff_plain_color) =3D
 	$diff_use_color ? (
 		$repo->get_color('color.diff.plain', ''),
@@ -902,7 +906,7 @@ sub split_hunk {
 		unshift @{$hunk->{DISPLAY}}, join(
 			"",
 			$diff_use_color ? colored($fraginfo_color, $fraginfo) : $fraginfo,
-			$heading,
+			$diff_use_color ? colored($funcname_color, $heading) : $heading,
 			"\n"
 		);
 	}

I didn't prepare a commit message because I think it should probably
just be squashed in.

-Peff
