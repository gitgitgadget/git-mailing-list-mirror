From: Jeff King <peff@peff.net>
Subject: Re: Is there a --stat or --numstat like option that'll allow me to
 have my cake and eat it too?
Date: Tue, 8 Mar 2016 15:51:24 -0500
Message-ID: <20160308205124.GA25849@sigill.intra.peff.net>
References: <CACBZZX7o+VA1RVvja3xtBQf+rr2bWoByas4D5GKZ_VfQr7H19w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 21:51:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adObL-0007XE-Qx
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 21:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbcCHUv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2016 15:51:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:56553 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751255AbcCHUv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 15:51:27 -0500
Received: (qmail 29255 invoked by uid 102); 8 Mar 2016 20:51:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Mar 2016 15:51:26 -0500
Received: (qmail 6780 invoked by uid 107); 8 Mar 2016 20:51:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Mar 2016 15:51:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Mar 2016 15:51:24 -0500
Content-Disposition: inline
In-Reply-To: <CACBZZX7o+VA1RVvja3xtBQf+rr2bWoByas4D5GKZ_VfQr7H19w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288452>

On Tue, Mar 08, 2016 at 04:08:21PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> What I really want is something for git-log more like
> git-for-each-ref, so I could emit the following info for each file
> being modified delimited by some binary marker:
>=20
>     - file name before
>     - file name after
>     - is rename?
>     - is binary?
>     - size in bytes before
>     - size it bytes after
>     - removed lines
>     - added lines

If you get the full sha1s of each object (e.g., by adding --raw), then
you can dump them all to a single cat-file invocation to efficiently ge=
t
the sizes.

I'm not quite sure I understand why you want to know about renames and
added/removed lines if you are just blocking binary files. If I were
implementing this[1], I'd probably just block based on blob size, which
you can do with:

  git rev-list --objects $old..$new |
  git cat-file --batch-check=3D'%(objectsize) %(objectname) %(rest)' |
  perl -alne 'print if $F[0] > 1_000_000; # or whatever' |
  while read size sha1 file; do
	echo "Whoops, $file ($sha1) is too big"
	exit 1
  done

You can also use %(objectsize:disk) to get the on-disk size (which can
tell you about things that don't compress well, which tend to be the
sorts of things you are trying to keep out).

You can't ask about binary-ness, but I don't think it would unreasonabl=
e
for cat-file to have a "would git consider this content binary?"
placeholder for --batch-check.

The other things are properties of the comparison, not of individual
objects, so you'll have to get them from "git log". But with some cleve=
r
scripting, I think you could feed those sha1s (or $commit:$path
specifiers) into a single cat-file invocation to get the before/after
sizes.

-Peff

[1] GitHub has hard and soft limits for various blob sizes, and at one
    point the implementation looked very similar to what I showed here.
    The downside is that for a large push, the rev-list can actually
    take a fair bit of time (e.g., consider pushing up all of the kerne=
l
    history to a brand new repo), and this is on top of the similar wor=
k
    already done by index-pack and check_everything_connected().

    These days I have a hacky patch to notice the too-big size directly
    in index-pack, which is essentially free. It doesn't know about the
    file path, so we pull that out later in the pre-receive hook. But w=
e
    only have to do so in the uncommon case that there _is_ actually a
    too-big file, so normal pushes incur no penalty.
