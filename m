From: Jeff King <peff@peff.net>
Subject: [PATCH] merge_blobs: use strbuf instead of manually-sized mmfile_t
Date: Mon, 15 Feb 2016 20:12:58 -0500
Message-ID: <20160216011258.GA11961@sigill.intra.peff.net>
References: <56C2459B.5060805@uni-graz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stefan =?utf-8?Q?Fr=C3=BChwirth?= <stefan.fruehwirth@uni-graz.at>
X-From: git-owner@vger.kernel.org Tue Feb 16 02:13:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVUCR-00056w-59
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 02:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbcBPBNC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 20:13:02 -0500
Received: from cloud.peff.net ([50.56.180.127]:42684 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751432AbcBPBNB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 20:13:01 -0500
Received: (qmail 12161 invoked by uid 102); 16 Feb 2016 01:13:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 20:13:01 -0500
Received: (qmail 15086 invoked by uid 107); 16 Feb 2016 01:13:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 20:13:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 20:12:58 -0500
Content-Disposition: inline
In-Reply-To: <56C2459B.5060805@uni-graz.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286298>

On Mon, Feb 15, 2016 at 10:39:39PM +0100, Stefan Fr=C3=BChwirth wrote:

> in one specific circumstance, git-merge-tree exits with a segfault ca=
used by
> "*** Error in `git': malloc(): memory corruption (fast)":
>=20
> There has to be at least one commit first (as far as I can tell it do=
esn't
> matter what content). Then create a tree containing a file with a lea=
ding
> newline character (\n) followed by some random string, and another tr=
ee with
> a file containing a string without leading newline. Now merge trees:
> Segmentation fault.
>=20
> There is a test case[1] kindly provided by chrisrossi, which he craft=
ed
> after I discovered the problem[2] in the context of Pylons/acidfs.

Wow, I had to look up what "git merge-tree" even is. It looks like a
proof-of-concept added by 492e075 (Handling large files with GIT,
2006-02-14) that has somehow hung around forever.

I find some of the merging code there questionable, and I wonder if
people are actually using it.  And yet there is this report, and it has
received one or two fixes over the years. So maybe people are.

Anyway, here is an immediate fix for the memory corruption. I'm pretty
sure the _result_ is still buggy in this case, as explained below. I
suspect this weird add/add case should just be a full conflict (like it
is for the normal merge code), and we should just be using ll_merge()
directly. But I have to admit I have very little desire to think hard o=
n
this crufty code. My first preference would be to remove it, but I don'=
t
want to hurt people who might actually be using it. But they can do
their own hard-thinking.

-- >8 --
Subject: merge_blobs: use strbuf instead of manually-sized mmfile_t

The ancient merge_blobs function (which is used nowhere
except in the equally ancient git-merge-tree, which does
not itself seem to be called by any modern git code), tries
to create a plausible base object for an add/add conflict by
finding the common parts of the "ours" and "theirs" blobs.
It does so by calling xdiff with XDIFF_EMIT_COMMON, and
stores the result in a buffer that is as big as the smaller
of "ours" and "theirs".

In theory, this is right; we cannot have more common content
than is in the smaller of the two blobs. But in practice,
xdiff may give us more: if neither file ends in a newline,
we get the "\nNo newline at end of file" marker.

This is somewhat of a bug in itself (the "no newline" string
becomes part of the blob output!), but much worse is that we
may overflow our output buffer with this string (if the
common content was otherwise close to the size of the
smaller blob).

The minimal fix for the memory corruption is to size the
buffer appropriately. We could do so by manually adding in
an extra 29 bytes for the "no newline" string to our buffer
size. But that's somewhat fragile. Instead, let's replace
the fixed-size output buffer with a strbuf which can grow as
necessary.

Reported-by: Stefan Fr=C3=BChwirth <stefan.fruehwirth@uni-graz.at>
Signed-off-by: Jeff King <peff@peff.net>
---
 merge-blobs.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/merge-blobs.c b/merge-blobs.c
index ddca601..acfd110 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -51,19 +51,16 @@ static void *three_way_filemerge(const char *path, =
mmfile_t *base, mmfile_t *our
 static int common_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 {
 	int i;
-	mmfile_t *dst =3D priv_;
+	struct strbuf *dst =3D priv_;
=20
-	for (i =3D 0; i < nbuf; i++) {
-		memcpy(dst->ptr + dst->size, mb[i].ptr, mb[i].size);
-		dst->size +=3D mb[i].size;
-	}
+	for (i =3D 0; i < nbuf; i++)
+		strbuf_add(dst, mb[i].ptr, mb[i].size);
 	return 0;
 }
=20
 static int generate_common_file(mmfile_t *res, mmfile_t *f1, mmfile_t =
*f2)
 {
-	unsigned long size =3D f1->size < f2->size ? f1->size : f2->size;
-	void *ptr =3D xmalloc(size);
+	struct strbuf out =3D STRBUF_INIT;
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;
@@ -75,11 +72,15 @@ static int generate_common_file(mmfile_t *res, mmfi=
le_t *f1, mmfile_t *f2)
 	xecfg.flags =3D XDL_EMIT_COMMON;
 	ecb.outf =3D common_outf;
=20
-	res->ptr =3D ptr;
-	res->size =3D 0;
+	ecb.priv =3D &out;
+	if (xdi_diff(f1, f2, &xpp, &xecfg, &ecb) < 0) {
+		strbuf_release(&out);
+		return -1;
+	}
=20
-	ecb.priv =3D res;
-	return xdi_diff(f1, f2, &xpp, &xecfg, &ecb);
+	res->size =3D out.len; /* avoid long/size_t pointer mismatch below */
+	res->ptr =3D strbuf_detach(&out, NULL);
+	return 0;
 }
=20
 void *merge_blobs(const char *path, struct blob *base, struct blob *ou=
r, struct blob *their, unsigned long *size)
--=20
2.7.1.574.gccd43a9
