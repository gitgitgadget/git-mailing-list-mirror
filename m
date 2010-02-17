From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [RFC/PATCH 1/3] apply: Allow blank context lines to match beyond
 EOF
Date: Wed, 17 Feb 2010 08:03:04 +0100
Message-ID: <4B7B94A8.5000102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 08:03:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhdwL-0006kF-FT
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 08:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933831Ab0BQHDL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2010 02:03:11 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:46844 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933771Ab0BQHDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 02:03:09 -0500
Received: by ewy28 with SMTP id 28so2494610ewy.28
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 23:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=09htJNMq7RVAFb/Q6s/NP21krU6wJGWeZD52tYGiJYM=;
        b=J9GU9QiLKbJKsHxCaK3yJKg1iusYwT/2uruprD35XLwmGV5y4hXNHkrfzIW0T6ywsb
         FENgBaVW7kmHJj7xskUFrPSpF+XZm5w+e2Nsd6BnJ6Kse80fmGluoHYV8SwLvTCaiKx7
         /D1JwvTHikA5nBWK1+mUwlO39qDhx+u7JsJfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=nOUkwmx1SmYLuipuhU86ECzZlggFf1LzQGKETnxfBiDJtEnsacsMNwveXeOnqtAU34
         6xvGIz4ffgZIZIMEBMf8xezOkwdku8VTZfxilMuVAgvcS0IhqJVyVhXksZleC4fJcDz7
         gJ8T1g7vPr/r+VDMkgCidNPz3UfIA4eQwEt84=
Received: by 10.213.67.141 with SMTP id r13mr2368724ebi.93.1266390186270;
        Tue, 16 Feb 2010 23:03:06 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 5sm20138136eyh.8.2010.02.16.23.03.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 23:03:05 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140208>

"git apply --whitespace=3Dfix" will not always succeed when used
on a series of patches in the following circumstances:

* One patch adds a blank line at the end of a file. (Since
  --whitespace=3Dfix is used, the blank line will *not* be added.)

* The next patch adds non-blanks lines after the blank line
  introduced in the first patch. That patch will not apply
  because the blank line that is expected to be found at end
  of the file is no longer there.

=46ix this problem by allowing a blank context line at the beginning
of a hunk to match if parts of it falls beyond end of the file
(i.e. at least one context line must match an existing line in
the file).

TODO: We should probably require that at least one *non-blank*
context line should fall within the boundaries of the file.

TODO: Since this commit touches an important code path in git,
we probably want to add more test cases.

TODO: It could also be useful to handle files that shrink with
blanks lines at the end.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 builtin-apply.c |  127 ++++++++++++++++++++++++++++++++++++++++++++++-=
-------
 1 files changed, 108 insertions(+), 19 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 2a1004d..75c04f0 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1854,18 +1854,55 @@ static int match_fragment(struct image *img,
 {
 	int i;
 	char *fixed_buf, *buf, *orig, *target;
+	int limit;
+	int preimage_limit;
=20
-	if (preimage->nr + try_lno > img->nr)
+	/*
+	 * Should we remove blanks line at the end of the file?
+	 *
+	 * If yes, we will allow blank lines in the preimage to
+	 * match non-existing lines beyond the last existing line
+	 * in the file, provided that at least one line falls
+	 * within the boundaries of the file.
+	 */
+	if (match_end && ws_error_action =3D=3D correct_ws_error &&
+	    ws_rule & WS_BLANK_AT_EOF &&
+	    try_lno < img->nr) {
+		/*
+		 * This hunk must match the end of the file (img) or
+		 * beyond. Set up limit and preimage_limit so that
+		 * the early rejection tests that follow will
+		 * allow the preimage to have lines that extend beyond
+		 * the end of the file. The quick hash test will
+		 * only compare the lines in the preimage that=20
+		 * fall within the boundaries of img.
+		 */
+		limit =3D try_lno + preimage->nr;
+		preimage_limit =3D img->nr - try_lno;
+	} else {
+		/*
+		 * Not the last hunk or not removing blanks lined
+		 * the end of the file.
+		 *
+		 * Set up the variables so that any hunk that
+		 * fall beyound the end of the file will be
+		 * quickly rejected.
+		 */
+		limit =3D img->nr;
+		preimage_limit =3D preimage->nr;
+	}
+
+	if (preimage->nr + try_lno > limit)
 		return 0;
=20
 	if (match_beginning && try_lno)
 		return 0;
=20
-	if (match_end && preimage->nr + try_lno !=3D img->nr)
+	if (match_end && preimage->nr + try_lno !=3D limit)
 		return 0;
=20
 	/* Quick hash check */
-	for (i =3D 0; i < preimage->nr; i++)
+	for (i =3D 0; i < preimage_limit; i++)
 		if (preimage->line[i].hash !=3D img->line[try_lno + i].hash)
 			return 0;
=20
@@ -1875,12 +1912,17 @@ static int match_fragment(struct image *img,
 	 * otherwise try+fragsize must be still within the preimage,
 	 * and either case, the old piece should match the preimage
 	 * exactly.
+	 *
+	 * We can only have an exact match if the preimage does not
+	 * extend beyond the end of the file.
 	 */
-	if ((match_end
-	     ? (try + preimage->len =3D=3D img->len)
-	     : (try + preimage->len <=3D img->len)) &&
-	    !memcmp(img->buf + try, preimage->buf, preimage->len))
-		return 1;
+	if (preimage_limit =3D=3D preimage->nr) {
+		if ((match_end
+		     ? (try + preimage->len =3D=3D img->len)
+		     : (try + preimage->len <=3D img->len)) &&
+		    !memcmp(img->buf + try, preimage->buf, preimage->len))
+			return 1;
+	}
=20
 	/*
 	 * No exact match. If we are ignoring whitespace, run a line-by-line
@@ -1932,12 +1974,16 @@ static int match_fragment(struct image *img,
 	 * it might with whitespace fuzz. We haven't been asked to
 	 * ignore whitespace, we were asked to correct whitespace
 	 * errors, so let's try matching after whitespace correction.
+	 *
+	 * The preimage may extend beyond the end of the file,
+	 * but in this loop we will only handle the part of the
+	 * preimage that falls within the file.
 	 */
 	fixed_buf =3D xmalloc(preimage->len + 1);
 	buf =3D fixed_buf;
 	orig =3D preimage->buf;
 	target =3D img->buf + try;
-	for (i =3D 0; i < preimage->nr; i++) {
+	for (i =3D 0; i < preimage_limit; i++) {
 		size_t fixlen; /* length after fixing the preimage */
 		size_t oldlen =3D preimage->line[i].len;
 		size_t tgtlen =3D img->line[try_lno + i].len;
@@ -1977,6 +2023,29 @@ static int match_fragment(struct image *img,
 		target +=3D tgtlen;
 	}
=20
+
+	/*
+	 * Now handle the lines in the preimage that falls beyond the
+	 * end of the file (if any). They will only match if they are
+	 * empty or only contain whitespace (if WS_BLANK_AT_EOL is
+	 * false).
+	 */
+	for ( ; i < preimage->nr; i++) {
+		size_t fixlen; /* length after fixing the preimage */
+		size_t oldlen =3D preimage->line[i].len;
+		int j;
+
+		/* Try fixing the line in the preimage */
+		fixlen =3D ws_fix_copy(buf, orig, oldlen, ws_rule, NULL);
+
+		for (j =3D 0; j < fixlen; j++)
+			if (!isspace(buf[j]))
+				goto unmatch_exit;
+
+		orig +=3D oldlen;
+		buf +=3D fixlen;
+	}
+
 	/*
 	 * Yes, the preimage is based on an older version that still
 	 * has whitespace breakages unfixed, and fixing them makes the
@@ -2002,11 +2071,17 @@ static int find_pos(struct image *img,
 	unsigned long backwards, forwards, try;
 	int backwards_lno, forwards_lno, try_lno;
=20
-	if (preimage->nr > img->nr)
-		return -1;
+	/*
+	 * There used to be a quick reject here in case preimage
+	 * had more lines than img. We must let match_fragment()
+	 * handle that case because a hunk is now allowed to
+	 * extend beyond the end of img when --whitespace=3Dfix
+	 * has been given (and core.whitespace.blanks-at-eof is
+	 * enabled).
+	 */
=20
 	/*
-	 * If match_begining or match_end is specified, there is no
+	 * If match_beginning or match_end is specified, there is no
 	 * point starting from a wrong line that will never match and
 	 * wander around and wait for a match at the specified end.
 	 */
@@ -2091,12 +2166,26 @@ static void update_image(struct image *img,
 	int i, nr;
 	size_t remove_count, insert_count, applied_at =3D 0;
 	char *result;
+	int preimage_limit;
+
+	/*
+	 * If we are removing blank lines at the end of img,
+	 * the preimage may extend beyond the end.
+	 * If that is the case, we must be careful only to
+	 * remove the part of the preimage that falls within
+	 * the boundaries of img. Initialize preimage_limit
+	 * to the number of lines in the preimage that falls
+	 * within the boundaries.
+	 */
+	preimage_limit =3D preimage->nr;
+	if (preimage_limit > img->nr - applied_pos)
+		preimage_limit =3D img->nr - applied_pos;
=20
 	for (i =3D 0; i < applied_pos; i++)
 		applied_at +=3D img->line[i].len;
=20
 	remove_count =3D 0;
-	for (i =3D 0; i < preimage->nr; i++)
+	for (i =3D 0; i < preimage_limit; i++)
 		remove_count +=3D img->line[applied_pos + i].len;
 	insert_count =3D postimage->len;
=20
@@ -2113,8 +2202,8 @@ static void update_image(struct image *img,
 	result[img->len] =3D '\0';
=20
 	/* Adjust the line table */
-	nr =3D img->nr + postimage->nr - preimage->nr;
-	if (preimage->nr < postimage->nr) {
+	nr =3D img->nr + postimage->nr - preimage_limit;
+	if (preimage_limit < postimage->nr) {
 		/*
 		 * NOTE: this knows that we never call remove_first_line()
 		 * on anything other than pre/post image.
@@ -2122,10 +2211,10 @@ static void update_image(struct image *img,
 		img->line =3D xrealloc(img->line, nr * sizeof(*img->line));
 		img->line_allocated =3D img->line;
 	}
-	if (preimage->nr !=3D postimage->nr)
+	if (preimage_limit !=3D postimage->nr)
 		memmove(img->line + applied_pos + postimage->nr,
-			img->line + applied_pos + preimage->nr,
-			(img->nr - (applied_pos + preimage->nr)) *
+			img->line + applied_pos + preimage_limit,
+			(img->nr - (applied_pos + preimage_limit)) *
 			sizeof(*img->line));
 	memcpy(img->line + applied_pos,
 	       postimage->line,
@@ -2321,7 +2410,7 @@ static int apply_one_fragment(struct image *img, =
struct fragment *frag,
=20
 	if (applied_pos >=3D 0) {
 		if (new_blank_lines_at_end &&
-		    preimage.nr + applied_pos =3D=3D img->nr &&
+		    preimage.nr + applied_pos >=3D img->nr &&
 		    (ws_rule & WS_BLANK_AT_EOF) &&
 		    ws_error_action !=3D nowarn_ws_error) {
 			record_ws_error(WS_BLANK_AT_EOF, "+", 1, frag->linenr);
--=20
1.7.0
