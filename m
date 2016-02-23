From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] merge-tree: drop generate_common strategy
Date: Tue, 23 Feb 2016 01:06:55 -0500
Message-ID: <20160223060655.GB3205@sigill.intra.peff.net>
References: <20160223060338.GA2912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?Q?Fr=C3=BChwirth?= <stefan.fruehwirth@uni-graz.at>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 07:07:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY67i-0000wt-J8
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 07:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbcBWGG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 01:06:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:47314 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750704AbcBWGG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 01:06:58 -0500
Received: (qmail 8985 invoked by uid 102); 23 Feb 2016 06:06:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 01:06:58 -0500
Received: (qmail 25873 invoked by uid 107); 23 Feb 2016 06:07:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 01:07:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Feb 2016 01:06:55 -0500
Content-Disposition: inline
In-Reply-To: <20160223060338.GA2912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287019>

When merge_blobs sees an add/add conflict, it tries to
create a virtual base object for the 3-way merge that
consists of the common lines of each file. It inherited this
strategy from merge-one-file in 0c79938 (Improved three-way
blob merging code, 2006-06-28), and the point is to minimize
the size of the conflict hunks. That commit talks about "if
libxdiff were to ever grow a compatible three-way merge, it
could probably be directly plugged in".

That has long since happened. So as with merge-one-file in
the previous commit, this extra step is no longer necessary.
Our 3-way merge code is smart enough to do the minimizing
itself if we simply feed it an empty base, which is what the
more modern merge-recursive strategy already does.

Not only does this let us drop some code, but it removes an
overflow bug in generate_common_file(). We allocate a buffer
as large as the smallest of the two blobs, under the
assumption that there cannot be more common content than
what is in the smaller blob. However, xdiff may feed us
more: if neither file ends in a newline, it feeds us the
"\nNo newline at end of file" marker as common content, and
we write it into the output. If the differences between the
files are small than that string, we overflow the output
buffer.  This patch solves it by simply dropping the buggy
code entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
 merge-blobs.c | 38 ++------------------------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

diff --git a/merge-blobs.c b/merge-blobs.c
index ddca601..9b6eac2 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -48,40 +48,6 @@ static void *three_way_filemerge(const char *path, mmfile_t *base, mmfile_t *our
 	return res.ptr;
 }
 
-static int common_outf(void *priv_, mmbuffer_t *mb, int nbuf)
-{
-	int i;
-	mmfile_t *dst = priv_;
-
-	for (i = 0; i < nbuf; i++) {
-		memcpy(dst->ptr + dst->size, mb[i].ptr, mb[i].size);
-		dst->size += mb[i].size;
-	}
-	return 0;
-}
-
-static int generate_common_file(mmfile_t *res, mmfile_t *f1, mmfile_t *f2)
-{
-	unsigned long size = f1->size < f2->size ? f1->size : f2->size;
-	void *ptr = xmalloc(size);
-	xpparam_t xpp;
-	xdemitconf_t xecfg;
-	xdemitcb_t ecb;
-
-	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags = 0;
-	memset(&xecfg, 0, sizeof(xecfg));
-	xecfg.ctxlen = 3;
-	xecfg.flags = XDL_EMIT_COMMON;
-	ecb.outf = common_outf;
-
-	res->ptr = ptr;
-	res->size = 0;
-
-	ecb.priv = res;
-	return xdi_diff(f1, f2, &xpp, &xecfg, &ecb);
-}
-
 void *merge_blobs(const char *path, struct blob *base, struct blob *our, struct blob *their, unsigned long *size)
 {
 	void *res = NULL;
@@ -112,8 +78,8 @@ void *merge_blobs(const char *path, struct blob *base, struct blob *our, struct
 		if (fill_mmfile_blob(&common, base) < 0)
 			goto out_free_f2_f1;
 	} else {
-		if (generate_common_file(&common, &f1, &f2) < 0)
-			goto out_free_f2_f1;
+		common.ptr = xstrdup("");
+		common.size = 0;
 	}
 	res = three_way_filemerge(path, &common, &f1, &f2, size);
 	free_mmfile(&common);
-- 
2.7.2.645.g4e1306c
