From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix -B "very-different" logic.
Date: Thu, 02 Jun 2005 16:54:36 -0700
Message-ID: <7vll5sz54z.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
	<m1psv7bjb6.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org>
	<7vmzqau3es.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 01:52:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdzTX-0006Cr-E0
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 01:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVFBXyv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 19:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVFBXyv
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 19:54:51 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:27369 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261188AbVFBXyi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 19:54:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050602235435.XCSD8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Jun 2005 19:54:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vmzqau3es.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 31 May 2005 21:06:19 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

>     (Btw, current versions of git will consider the change
>     in question to be so big that it's considered a whole
>     new file, since the diff is actually bigger than the
>     file. 

JCH> Do you want me to do something about this with -B (and possibly
JCH> -C/-M), like skipping the comparison altogether if the file size
JCH> is smaller than, say, 1k bytes or something silly like that?  Or
JCH> not having special case for this kind of "contrived example"
JCH> preferrable?

I was looking at the -B code.  The reason it thinks change is
too big is because xdelta tells us to reconstruct the
destination by all new literal bytes in this small string case.
There is not much I can do about it.

However I think the diffcore-break algorithm itself was basing
its "very_different" computation on numbers somewhat bogus.  It
was counting newly inserted bytes into account, but amount of
those bytes should not make any difference when determining if
the change is a complete rewrite.

I suspect that -M/-C heuristics has similar (if not the same)
issues, but I would like to address that separately.

Here is a proposed fix for -B.  It also tells diffcore-break not
to break a file smaller than 400 bytes.  I did not make this
number configurable, since that would be too many knobs to
tweak.  If somebody feels strong enough about it, it can be made
into an option later, but for now that size "feels" reasonable.

  -- >8 -- cut here -- >8 --

------------
What we are interested in here is how much the original source
material remains in the final result, and it does not really
matter how much new contents are added as part of the edit.  If
you remove 97 lines from an original 100-line document, it does
not matter if you add 47 lines of your own to make a 50-line
document, or if you add 997 lines to make a 1000-line document.
Either way, you did a complete rewrite.

Earlier code counted both new material and deletions to detect
complete rewrites.  This patch fixes it.  With its default
setting, it detects three such complete rewrites in the core-GIT
repository.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 count-delta.h    |    1 +
 diffcore.h       |    4 ++-
 count-delta.c    |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 diffcore-break.c |   55 +++++++++++++++---------------------------
 4 files changed, 92 insertions(+), 38 deletions(-)

diff --git a/count-delta.h b/count-delta.h
--- a/count-delta.h
+++ b/count-delta.h
@@ -5,5 +5,6 @@
 #define COUNT_DELTA_H
 
 unsigned long count_delta(void *, unsigned long);
+unsigned long count_excluded_source_material(void *, unsigned long);
 
 #endif
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -10,9 +10,9 @@
  */
 #define MAX_SCORE 60000
 #define DEFAULT_RENAME_SCORE 30000 /* rename/copy similarity minimum (50%) */
-#define DEFAULT_BREAK_SCORE  59400 /* minimum for break to happen (99%)*/
+#define DEFAULT_BREAK_SCORE  48000 /* minimum for break to happen    (80%) */
 
-#define RENAME_DST_MATCHED 01
+#define DIFF_MINIMUM_BREAK   400 /* minimum size of source that -B breaks */
 
 struct diff_filespec {
 	unsigned char sha1[20];
diff --git a/count-delta.c b/count-delta.c
--- a/count-delta.c
+++ b/count-delta.c
@@ -93,3 +93,73 @@ unsigned long count_delta(void *delta_bu
 		return 0;
 	return (src_size - copied_from_source) + added_literal;
 }
+
+
+/*
+ * What we are interested in here is how much the original source
+ * material remains in the final result, and it does not really matter
+ * how much new contents are added as part of the edit.  If you remove
+ * 97 lines from an original 100-line document, it does not matter if
+ * you add 47 lines of your own to make a 50-line document, or if you
+ * add 997 lines to make a 1000-line document.  Either way, you did a
+ * complete rewrite.
+ *
+ * Note.  We do not interprete delta fully.  Instead, we look at xdelta
+ * instructions that copy bytes from the source, and count those copied
+ * bytes.  Subtracting this number from the original source size yields
+ * the number of bytes not used from the source material.  In the above
+ * example, this number corresponds to 97-line (but we count in bytes).
+ */
+unsigned long count_excluded_source_material(void *delta_buf,
+					     unsigned long delta_size)
+{
+	unsigned long copied_from_source;
+	const unsigned char *data, *top;
+	unsigned char cmd;
+	unsigned long src_size, dst_size, out;
+
+	/* the smallest delta size possible is 6 bytes */
+	if (delta_size < 6)
+		return UINT_MAX;
+
+	data = delta_buf;
+	top = delta_buf + delta_size;
+
+	src_size = get_hdr_size(&data);
+	dst_size = get_hdr_size(&data);
+
+	copied_from_source = out = 0;
+	while (data < top) {
+		cmd = *data++;
+		if (cmd & 0x80) {
+			unsigned long cp_off = 0, cp_size = 0;
+			if (cmd & 0x01) cp_off = *data++;
+			if (cmd & 0x02) cp_off |= (*data++ << 8);
+			if (cmd & 0x04) cp_off |= (*data++ << 16);
+			if (cmd & 0x08) cp_off |= (*data++ << 24);
+			if (cmd & 0x10) cp_size = *data++;
+			if (cmd & 0x20) cp_size |= (*data++ << 8);
+			if (cp_size == 0) cp_size = 0x10000;
+
+			if (cmd & 0x40)
+				/* copy from dst */
+				;
+			else
+				copied_from_source += cp_size;
+			out += cp_size;
+		} else {
+			/* write literal into dst */
+			out += cmd;
+			data += cmd;
+		}
+	}
+
+	/* sanity check */
+	if (data != top || out != dst_size)
+		return UINT_MAX;
+
+	if (src_size < copied_from_source)
+		/* we ended up overcounting and underflowed; I dunno why */
+		return 0;
+	return src_size - copied_from_source;
+}
diff --git a/diffcore-break.c b/diffcore-break.c
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -13,63 +13,46 @@ static int very_different(struct diff_fi
 {
 	/* dst is recorded as a modification of src.  Are they so
 	 * different that we are better off recording this as a pair
-	 * of delete and create?  min_score is the minimum amount of
-	 * new material that must exist in the dst and not in src for
-	 * the pair to be considered a complete rewrite, and recommended
-	 * to be set to a very high value, 99% or so.
+	 * of delete and create?
 	 *
-	 * The value we return represents the amount of new material
-	 * that is in dst and not in src.  We return 0 when we do not
-	 * want to get the filepair broken.
+	 * We base the score on the amount of material originally from
+	 * src that still remains in the dst.  If src was 100-line
+	 * file among which only 3-line remains in the dst, then it is
+	 * a complete rewrite with 97% "change", and it does not
+	 * matter if the resulting file is a 15-line file or a
+	 * 2000-line file.  On the other hand, if 40-line remains
+	 * among those 100-lines, even if the resulting file is a
+	 * 2000-lines file, it still is an edit with 60% "change",
+	 * which may sound counter-intuitive at first but that is the
+	 * right number to use.
 	 */
+
 	void *delta;
-	unsigned long delta_size, base_size;
+	unsigned long delta_size;
 
 	if (!S_ISREG(src->mode) || !S_ISREG(dst->mode))
 		return 0; /* leave symlink rename alone */
 
-	if (diff_populate_filespec(src, 1) || diff_populate_filespec(dst, 1))
-		return 0; /* error but caught downstream */
-
-	delta_size = ((src->size < dst->size) ?
-		      (dst->size - src->size) : (src->size - dst->size));
-
-	/* Notice that we use max of src and dst as the base size,
-	 * unlike rename similarity detection.  This is so that we do
-	 * not mistake a large addition as a complete rewrite.
-	 */
-	base_size = ((src->size < dst->size) ? dst->size : src->size);
-
-	/*
-	 * If file size difference is too big compared to the
-	 * base_size, we declare this a complete rewrite.
-	 */
-	if (base_size * min_score < delta_size * MAX_SCORE)
-		return MAX_SCORE;
-
 	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
 		return 0; /* error but caught downstream */
 
+	if (src->size < DIFF_MINIMUM_BREAK)
+		return 0; /* Too small to consider breaking */
+
 	delta = diff_delta(src->data, src->size,
 			   dst->data, dst->size,
 			   &delta_size);
 
-	/* A delta that has a lot of literal additions would have
-	 * big delta_size no matter what else it does.
-	 */
-	if (base_size * min_score < delta_size * MAX_SCORE)
-		return MAX_SCORE;
-
 	/* Estimate the edit size by interpreting delta. */
-	delta_size = count_delta(delta, delta_size);
+	delta_size = count_excluded_source_material(delta, delta_size);
 	free(delta);
 	if (delta_size == UINT_MAX)
 		return 0; /* error in delta computation */
 
-	if (base_size < delta_size)
+	if (src->size < delta_size)
 		return MAX_SCORE;
 
-	return delta_size * MAX_SCORE / base_size; 
+	return delta_size * MAX_SCORE / src->size;
 }
 
 void diffcore_break(int min_score)
------------

