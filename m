From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH v2 2/4] apply: Allow blank context lines to match beyond EOF
Date: Wed, 24 Feb 2010 20:24:20 +0100
Message-ID: <4B857CE4.4000201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 20:24:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkMqW-0007K7-JZ
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 20:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757692Ab0BXTYY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 14:24:24 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:63598 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757673Ab0BXTYX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 14:24:23 -0500
Received: by ey-out-2122.google.com with SMTP id 25so25818eya.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 11:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=Cw7mGaA8m69hBPTIDK4Gr/sdVP+geml0iYhJiffYTJI=;
        b=onkMZETrxX3h7ot8W5ZqLEmHf3NsmOu9tpFVofv4xb7yyKn8UBod3UDhZH0CVwQFtq
         2nbT0Ix2GhX/Um8mrjnJ68FdOvzEnJDJzGAD4M490ucPjbzT5LpWu5xyaibjAp0YaQpp
         SDbr3VZQonmVGvbLZIXN0lqLoLiO6neU9HvD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=QxvRzlNc//cuLIUEhbfkkjVkDfP/1D4vFAk1lBBSbh0UcGiAM0QB+34b9JNCnbhh1L
         BzIEoK/A7V6l2ylmCWAX2LIsni7T1hsgmg46JtsM71i1/Hf37EthqPb6bIYFgTpqRB6T
         bTigYBy9XGDSJQsCgkBKsE7VosYKQdH4SzBBU=
Received: by 10.213.109.208 with SMTP id k16mr191019ebp.15.1267039462078;
        Wed, 24 Feb 2010 11:24:22 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 7sm346944eyg.32.2010.02.24.11.24.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 11:24:21 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140975>

"git apply --whitespace=3Dfix" will not always succeed when used
on a series of patches in the following circumstances:

* One patch adds a blank line at the end of a file. (Since
  --whitespace=3Dfix is used, the blank line will *not* be added.)

* The next patch adds non-blanks lines after the blank line
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
 builtin-apply.c |  135 +++++++++++++++++++++++++++++++++++++++++++++--=
-------
 1 files changed, 112 insertions(+), 23 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index e1f849d..b8b89f7 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1854,33 +1854,81 @@ static int match_fragment(struct image *img,
 {
 	int i;
 	char *fixed_buf, *buf, *orig, *target;
+	int limit;
+	int preimage_limit;
=20
-	if (preimage->nr + try_lno > img->nr)
+	if (preimage->nr + try_lno <=3D img->nr) {
+		/*
+		 * The hunk falls within the boundaries of img.
+		 */
+		limit =3D img->nr;
+		preimage_limit =3D preimage->nr;
+	} else if (ws_error_action =3D=3D correct_ws_error &&
+		   ws_rule & WS_BLANK_AT_EOF && match_end) {
+		/*
+		 * This hunk that matches at the end, extends beyond
+		 * the end of img and we are removing blanks line at
+		 * the end of the file. Set up the limits so that
+		 * tests below will pass and the quick hash test
+		 * will only test the lines up to the last line
+		 * in img.
+		 */
+		limit =3D try_lno + preimage->nr;
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
+	if (match_end && preimage->nr + try_lno !=3D limit)
 		return 0;
=20
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
+		 * a line before the of img.
+		 */
+		char *buf_end;
+
+		buf =3D preimage->buf;=20
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
@@ -1932,12 +1980,16 @@ static int match_fragment(struct image *img,
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
@@ -1977,6 +2029,29 @@ static int match_fragment(struct image *img,
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
@@ -2092,12 +2167,26 @@ static void update_image(struct image *img,
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
@@ -2114,8 +2203,8 @@ static void update_image(struct image *img,
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
@@ -2123,10 +2212,10 @@ static void update_image(struct image *img,
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
@@ -2322,7 +2411,7 @@ static int apply_one_fragment(struct image *img, =
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
