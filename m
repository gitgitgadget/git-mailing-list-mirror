From: Jeff King <peff@peff.net>
Subject: Re: [BUG/PATCH] t9350-fast-export: Add failing test for
 symlink-to-directory
Date: Fri, 21 Aug 2015 10:58:27 -0400
Message-ID: <20150821145827.GA565@sigill.intra.peff.net>
References: <alpine.DEB.2.10.1508191532330.31851@buzzword-bingo.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Anders Kaseorg <andersk@mit.edu>
X-From: git-owner@vger.kernel.org Fri Aug 21 16:58:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSnm7-0003WW-37
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 16:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbbHUO6b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 10:58:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:48180 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752704AbbHUO6a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 10:58:30 -0400
Received: (qmail 31988 invoked by uid 102); 21 Aug 2015 14:58:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Aug 2015 09:58:30 -0500
Received: (qmail 1879 invoked by uid 107); 21 Aug 2015 14:58:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Aug 2015 10:58:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Aug 2015 10:58:27 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1508191532330.31851@buzzword-bingo.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276302>

On Wed, Aug 19, 2015 at 03:46:27PM -0400, Anders Kaseorg wrote:

> git fast-export | git fast-import fails to preserve a commit that rep=
laces=20
> a symlink with a directory.  Add a failing test case demonstrating th=
is=20
> bug.
>=20
> The fast-export output for the commit in question looks like
>=20
>   commit refs/heads/master
>   mark :4
>   author =E2=80=A6
>   committer =E2=80=A6
>   data 4
>   two
>   M 100644 :1 foo/world
>   D foo
>=20
> fast-import deletes the symlink foo and ignores foo/world.  Swapping =
the M=20
> line with the D line would give the correct result.

Thanks for providing a patch to the tests. That is my favorite form of
bug report. :)

The problem seems to be that we output the entries in a "depth first"
way; "foo/bar" always comes before "foo", to cover the cases explained
in 060df62 (fast-export: Fix output order of D/F changes, 2010-07-09).

I'm tempted to say we would want to do all deletions (at any level)
first, to make room for new files. That patch looks like:

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d23f3be..336fd6f 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -267,6 +267,14 @@ static int depth_first(const void *a_, const void =
*b_)
 	const char *name_a, *name_b;
 	int len_a, len_b, len;
 	int cmp;
+	int deletion;
+
+	/*
+	 * Move all deletions first, to make room for any later modifications=
=2E
+	 */
+	deletion =3D (b->status =3D=3D 'D') - (a->status =3D=3D 'D');
+	if (deletion)
+		return deletion;
=20
 	name_a =3D a->one ? a->one->path : a->two->path;
 	name_b =3D b->one ? b->one->path : b->two->path;


and does indeed pass your test. But I'm not sure that covers all cases,
and I'm not sure it doesn't make some cases worse:

  - if we moved a deletion to the front, is it possible for that path t=
o
    have been the source side of a copy or rename, that is now broken? =
I
    don't _think_ so. If it's a copy, then the file by definition canno=
t
    also be deleted (that would make it a rename, not a copy). We could
    have a copy along with a rename, but again, then we don't have a
    delete (we have a rename, which is explicitly bumped to the end for
    this reason).

  - we may still have the opposite problem with renames. That is, a
    rename is _also_ a deletion, but will go to the end. So I would
    expect renaming the symlink "foo" to "bar" and then adding
    "foo/world" would end up with:

       M 100644 :3 foo/world
       R foo bar

    (because we push renames to the end in our sort). And indeed,
    importing that does seem to get it wrong (we end up with "bar/world=
"
    and no symlink).

We can't fix the ordering in the second case without breaking the first
case. So I'm not sure it's fixable on the fast-export end.

-Peff
