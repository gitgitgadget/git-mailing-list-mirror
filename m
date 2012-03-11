From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] apply: reallocate the postimage buffer when needed
Date: Sun, 11 Mar 2012 15:24:17 +0100
Message-ID: <1331475857-15169-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 15:23:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6jgA-0007as-Cw
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 15:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030Ab2CKOXR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Mar 2012 10:23:17 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:39568 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860Ab2CKOXR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 10:23:17 -0400
Received: from centaur.lab.cmartin.tk (brln-4db9f50e.pool.mediaWays.net [77.185.245.14])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id A322146057;
	Sun, 11 Mar 2012 15:23:04 +0100 (CET)
Received: (nullmailer pid 15203 invoked by uid 1000);
	Sun, 11 Mar 2012 14:24:17 -0000
X-Mailer: git-send-email 1.7.10.rc0.17.g74595
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192812>

The buffer in the postimage may become too small when whitespace fixes
are applied to the patch and update_pre_post_images might write past
the end of the buffer.

Teach the code to reallocate the buffer if needed. When it comes time
to free the buffer, do it directly on postimage.buf instead of the
newlines strbuf.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

This was reported on IRC. Reproduction steps are at
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D663338 and it
involves applying a patch whilst fixing whitespace changes.

Blame says Junio and Giuseppe were the last ones to touch this part of
the code, so there you go.

While this seems like a reasonable fix to me, it's the first time I've
looked at this part of the code, so there might be a better way of
growing the buffer to its final size. I considered adding a loop at
the beginning to determine the final size, but I'm unsure about which
lines actually get skipped.

 builtin/apply.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 389898f..8899b09 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2003,10 +2003,12 @@ static void update_pre_post_images(struct image=
 *preimage,
 	 * in place (postlen=3D=3D0) or not.
 	 */
 	old =3D postimage->buf;
-	if (postlen)
+	if (postlen) {
 		new =3D postimage->buf =3D xmalloc(postlen);
-	else
+		postimage->alloc =3D postlen;
+	} else {
 		new =3D old;
+	}
 	fixed =3D preimage->buf;
 	for (i =3D ctx =3D 0; i < postimage->nr; i++) {
 		size_t len =3D postimage->line[i].len;
@@ -2032,6 +2034,13 @@ static void update_pre_post_images(struct image =
*preimage,
=20
 		/* and copy it in, while fixing the line length */
 		len =3D preimage->line[ctx].len;
+		if (postimage->alloc < (new - postimage->buf) + len) {
+			size_t post_len =3D new - postimage->buf;
+			postimage->buf =3D xrealloc(postimage->buf, post_len + len);
+			postimage->alloc =3D post_len + len;
+			new =3D postimage->buf + post_len;
+		}
+
 		memcpy(new, fixed, len);
 		new +=3D len;
 		fixed +=3D len;
@@ -2594,6 +2603,7 @@ static int apply_one_fragment(struct image *img, =
struct fragment *frag,
 	preimage.len =3D old - oldlines;
 	postimage.buf =3D newlines.buf;
 	postimage.len =3D newlines.len;
+	postimage.alloc =3D newlines.alloc;
 	preimage.line =3D preimage.line_allocated;
 	postimage.line =3D postimage.line_allocated;
=20
@@ -2679,7 +2689,7 @@ static int apply_one_fragment(struct image *img, =
struct fragment *frag,
 	}
=20
 	free(oldlines);
-	strbuf_release(&newlines);
+	free(postimage.buf);
 	free(preimage.line_allocated);
 	free(postimage.line_allocated);
=20
--=20
1.7.10.rc0.17.g74595
