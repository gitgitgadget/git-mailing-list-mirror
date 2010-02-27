From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH v3 3/5] apply: Allow blank context lines to match beyond EOF
Date: Sat, 27 Feb 2010 14:52:27 +0100
Message-ID: <4B89239B.8040503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 14:53:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlN5v-0007er-MG
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 14:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968350Ab0B0Nwa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2010 08:52:30 -0500
Received: from mail-ew0-f220.google.com ([209.85.219.220]:55312 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968349Ab0B0Nw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 08:52:29 -0500
Received: by mail-ew0-f220.google.com with SMTP id 20so535804ewy.21
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 05:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=upiJs1hi4pySStFs/VdWMFFToJvZYFyEkhXKSttQ9UQ=;
        b=UQgs0VxMHmIFlx716D1QWROXGAJZ2IJZgwg7mIBXAOigAMBReyEG3cCDwMspIorsSY
         S5vW/u3cCenQyvaEsASx0kHOWwOnHNsbjHwMXUAl2I6QdccXUsN7tEw22sdRkh4udMH5
         z53+68X99By3srLcCnpC9TsVhKG2/WMk5w4n0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=bmpxqJX/2YXJXd8TZyC1LKbiWQjcBD/hvkUhphj2X6Zp/0z0VGRuILVAI+4SajXXpv
         rJ5q+eYdIMva59miFyCbzqybnVBSvHlj7hwtatwldmAqsHjznMVdfUQe7KNDqNLXk7uA
         nSStuXlM7a7x0xHYrtCV+iK8A68CvHJToMiiU=
Received: by 10.213.103.133 with SMTP id k5mr1229584ebo.76.1267278748702;
        Sat, 27 Feb 2010 05:52:28 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 28sm4655080eyg.6.2010.02.27.05.52.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Feb 2010 05:52:28 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141210>

"git apply --whitespace=3Dfix" will not always succeed when used
on a series of patches in the following circumstances:

* One patch adds a blank line at the end of a file. (Since
  --whitespace=3Dfix is used, the blank line will *not* be added.)

* The next patch adds non-blank lines after the blank line
  introduced in the first patch. That patch will not apply
  because the blank line that is expected to be found at end
  of the file is no longer there.

A patch series that starts by deleting lines at the end
will fail in a similar way.

=46ix this problem by allowing a blank context line at the beginning
of a hunk to match if parts of it falls beyond end of the file.
We still require that at least one non-blank context line match
before the end of the file.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 builtin-apply.c |  165 +++++++++++++++++++++++++++++++++++++++++++++--=
--------
 1 files changed, 135 insertions(+), 30 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 9641a64..a3130a1 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1854,33 +1854,76 @@ static int match_fragment(struct image *img,
 {
 	int i;
 	char *fixed_buf, *buf, *orig, *target;
+	int preimage_limit;
=20
-	if (preimage->nr + try_lno > img->nr)
+	if (preimage->nr + try_lno <=3D img->nr) {
+		/*
+		 * The hunk falls within the boundaries of img.
+		 */
+		preimage_limit =3D preimage->nr;
+		if (match_end && (preimage->nr + try_lno !=3D img->nr))
+			return 0;
+	} else if (ws_error_action =3D=3D correct_ws_error &&
+		   (ws_rule & WS_BLANK_AT_EOF) && match_end) {
+		/*
+		 * This hunk that matches at the end extends beyond
+		 * the end of img, and we are removing blank lines
+		 * at the end of the file.  This many lines from the
+		 * beginning of the preimage must match with img, and
+		 * the remainder of the preimage must be blank.
+		 */
+		preimage_limit =3D img->nr - try_lno;
+	} else {
+		/*
+		 * The hunk extends beyond the end of the img and
+		 * we are not removing blanks at the end, so we
+		 * should reject the hunk at this position.
+		 */
 		return 0;
+	}
=20
 	if (match_beginning && try_lno)
 		return 0;
=20
-	if (match_end && preimage->nr + try_lno !=3D img->nr)
-		return 0;
-
 	/* Quick hash check */
-	for (i =3D 0; i < preimage->nr; i++)
+	for (i =3D 0; i < preimage_limit; i++)
 		if (preimage->line[i].hash !=3D img->line[try_lno + i].hash)
 			return 0;
=20
-	/*
-	 * Do we have an exact match?  If we were told to match
-	 * at the end, size must be exactly at try+fragsize,
-	 * otherwise try+fragsize must be still within the preimage,
-	 * and either case, the old piece should match the preimage
-	 * exactly.
-	 */
-	if ((match_end
-	     ? (try + preimage->len =3D=3D img->len)
-	     : (try + preimage->len <=3D img->len)) &&
-	    !memcmp(img->buf + try, preimage->buf, preimage->len))
-		return 1;
+	if (preimage_limit =3D=3D preimage->nr) {
+		/*
+		 * Do we have an exact match?  If we were told to match
+		 * at the end, size must be exactly at try+fragsize,
+		 * otherwise try+fragsize must be still within the preimage,
+		 * and either case, the old piece should match the preimage
+		 * exactly.
+		 */
+		if ((match_end
+		     ? (try + preimage->len =3D=3D img->len)
+		     : (try + preimage->len <=3D img->len)) &&
+		    !memcmp(img->buf + try, preimage->buf, preimage->len))
+			return 1;
+	} else {
+		/*
+		 * The preimage extends beyond the end of img, so
+		 * there cannot be an exact match.
+		 *
+		 * There must be one non-blank context line that match
+		 * a line before the end of img.
+		 */
+		char *buf_end;
+
+		buf =3D preimage->buf;
+		buf_end =3D buf;
+		for (i =3D 0; i < preimage_limit; i++)
+			buf_end +=3D preimage->line[i].len;
+
+		for ( ; buf < buf_end; buf++)
+			if (!isspace(*buf))
+				break;
+		if (buf =3D=3D buf_end)
+			return 0;
+	}
=20
 	/*
 	 * No exact match. If we are ignoring whitespace, run a line-by-line
@@ -1891,7 +1934,9 @@ static int match_fragment(struct image *img,
 		size_t imgoff =3D 0;
 		size_t preoff =3D 0;
 		size_t postlen =3D postimage->len;
-		for (i =3D 0; i < preimage->nr; i++) {
+		size_t extra_lines;
+		char *preimage_end;
+		for (i =3D 0; i < preimage_limit; i++) {
 			size_t prelen =3D preimage->line[i].len;
 			size_t imglen =3D img->line[try_lno+i].len;
=20
@@ -1908,12 +1953,31 @@ static int match_fragment(struct image *img,
 		 * Ok, the preimage matches with whitespace fuzz.
 		 *
 		 * imgoff now holds the true length of the target that
-		 * matches the preimage.  Update the preimage and
-		 * the common postimage context lines to use the same
-		 * whitespace as the target.
+		 * matches the preimage before the end of the file.
+		 *
+		 * Count the number of characters in the preimage that fall
+		 * beyond the end  of the file and make sure that all of them
+		 * are whitespace characters. (This can only happen if
+		 * we are removing blank lines at the end of the file.)
 		 */
-		fixed_buf =3D xmalloc(imgoff);
+		buf =3D preimage->buf + preoff;
+		for ( ; i < preimage->nr; i++)
+			preoff +=3D preimage->line[i].len;
+		preimage_end =3D preimage->buf + preoff;
+		for ( ; buf < preimage_end; buf++)
+			if (!isspace(*buf))
+				return 0;
+
+		/*
+		 * Update the preimage and the common postimage context
+		 * lines to use the same whitespace as the target.
+		 */
+		extra_lines =3D preimage->nr - preimage_limit;
+		fixed_buf =3D xmalloc(imgoff + extra_lines);
 		memcpy(fixed_buf, img->buf + try, imgoff);
+		if (extra_lines)
+			memset(fixed_buf + imgoff, '\n', extra_lines);
+		imgoff +=3D extra_lines;
 		update_pre_post_images(preimage, postimage,
 				fixed_buf, imgoff, postlen);
 		return 1;
@@ -1927,12 +1991,16 @@ static int match_fragment(struct image *img,
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
@@ -1972,6 +2040,29 @@ static int match_fragment(struct image *img,
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
@@ -2088,12 +2179,26 @@ static void update_image(struct image *img,
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
@@ -2110,8 +2215,8 @@ static void update_image(struct image *img,
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
@@ -2119,10 +2224,10 @@ static void update_image(struct image *img,
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
@@ -2318,7 +2423,7 @@ static int apply_one_fragment(struct image *img, =
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
