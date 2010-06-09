From: Carl Worth <cworth@cworth.org>
Subject: Re: [PATCH] format-patch: Properly escape From_ lines when creating an mbox.
Date: Tue, 08 Jun 2010 22:14:23 -0700
Message-ID: <87eiggiy8g.fsf@yoom.home.cworth.org>
References: <1276045305-20743-1-git-send-email-cworth@cworth.org> <7vljaorhjq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git <git@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 07:14:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMDcp-0001bY-TK
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 07:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424Ab0FIFOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 01:14:35 -0400
Received: from u15218177.onlinehome-server.com ([74.208.220.233]:36060 "EHLO
	olra.theworths.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab0FIFOf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 01:14:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 7E8DE4196F2;
	Tue,  8 Jun 2010 22:14:34 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T9FRsyxc3926; Tue,  8 Jun 2010 22:14:24 -0700 (PDT)
Received: from yoom.home.cworth.org (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 26B54431FC1;
	Tue,  8 Jun 2010 22:14:24 -0700 (PDT)
Received: by yoom.home.cworth.org (Postfix, from userid 1000)
	id CA680568FC7; Tue,  8 Jun 2010 22:14:23 -0700 (PDT)
In-Reply-To: <7vljaorhjq.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/0.3.1-54-g42e146a (http://notmuchmail.org) Emacs/23.1.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148740>

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Tue, 08 Jun 2010 20:50:01 -0700, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Carl Worth <cworth@cworth.org> writes:
> Especially because your implementation quotes lines that begin with "From=
 "
> unconditionally (even when the tail end of the line would never be a
> valid-looking timestamp).  Such an output will confuse existing mailsplit,
> but the worst part of the story is that somebody who is applying a series
> of patches will _not_ notice the breakage.  The payload of the second and
> subsequent messages will likely be concatenated as if it were part of the
> first message, ignoring cruft between patches, but the resulting tree
> would likely to be the same as what the sending end intended.

I agree that anything that results in multiple patches being (silently!)
concatenated would be catastrophic and I do not recommend accepting any
patches that could result in failures like that.

Could you describe in more detail how the implementation could lead to a
case like that? I'm not seeing it myself. But if you can show me, I'll
be happy to attempt a fix.

In particular, I don't see how any of the new quoting will confuse
existing mailsplit. The splitting itself shouldn't be changed. And at
worst, using new "git format-patch" with old mailsplit could result in a
">From " getting into a commit message where a "From " should be.

We could reduce the occurrence of that problem by being less aggressive
with "From " quoting, (for example, examining whether the tail of the
line looks like a timestamp before quoting). The cost there would be
fairly minor. It would increase the occurrence of a failure to pass a
">From " correctly from a new "git am" to a new "git mailsplit". [*]

I don't see a way to eliminate both problems other than specifying that
git's mbox format is a non-standard mbox format that looks specifically
for From_ lines ending in timestamps and is not capable of containing an
arbitrary message, (namely messages with lines that begin with "From "
and end with timestamps).

That would be a particularly unsatisfying solution for me, since I'm
trying to implement an mbox-export option in a mail client as a general
feature (that happens to work with git) rather than implementing a
git-specific export option.

=2DCarl

[*] It would seem a strange strategy to make new git compatible with old
git while not being perfectly compatible with itself going forward, but
that is a possibility.

=2D-=20
carl.d.worth@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQFMDyMv6JDdNq8qSWgRAm+WAKCAkribUwLokc7LhYH07QvT+hxIcwCgp9Zq
D1O/aW13B2gOPgBcP4X9f7M=
=mv+/
-----END PGP SIGNATURE-----
--=-=-=--
