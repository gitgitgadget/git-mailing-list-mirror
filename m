From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] combine-diff: coalesce lost lines optimally
Date: Sun, 17 Mar 2013 14:03:56 +0100
Message-ID: <1363525436-21667-1-git-send-email-apelisse@gmail.com>
References: <7vboalw6lt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 17 14:05:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHDHU-0000nl-9t
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 14:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246Ab3CQNFM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 09:05:12 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:53474 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756248Ab3CQNFG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 09:05:06 -0400
Received: by mail-wg0-f49.google.com with SMTP id ds1so3217024wgb.4
        for <git@vger.kernel.org>; Sun, 17 Mar 2013 06:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=TeDzoQDbTj36+6WgoQOYGymWe0HCDpyXIMXPIeeh0zg=;
        b=VcCv/jnVdrTp3ia3Wtz5nGs0sUDCUR8JPt6ZYnSnWiLIrFKVVYfXUWZMtBs2qgWtiI
         nfwj+SxY8ToW8R1bvHRNRn8jqmvGXIeviAaXdCZGs0KSkiU2lwZRLEO5p6n6gB8ngmA/
         TQUdM+C9IxMBC8hLOQY8/oj39YEGC1UqXoLgUaKWmIuF6aejm7m36xVYvPya71ATyLsO
         ddBgAvdNRzYM4auBrVTv3C4NWMKrJmWV+uMeY3Ky/XczHDqbEeYL+l2Z8DPSx6fnYFeC
         oX6+c2llsPT52K2aZ85Ff/U7VqU8I5pRKPOM/noDuSdISIJor1/Rcvtq6x/1F/yuMFwq
         lsXA==
X-Received: by 10.194.157.42 with SMTP id wj10mr19715639wjb.12.1363525504982;
        Sun, 17 Mar 2013 06:05:04 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id eo1sm7986035wib.8.2013.03.17.06.05.02
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Mar 2013 06:05:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7vboalw6lt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218361>

This replaces the greedy implementation to coalesce lost lines by using
dynamic programming to find the Longest Common Subsequence.

The O(n=C2=B2) time complexity is obviously bigger than previous
implementation but it can produce shorter diff results (and most likely
easier to read).

List of lost lines is now doubly-linked because we reverse-read it when
reading the direction matrix.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
Hi,
This is a very first draft for improving the way we coalesce lost
lines. It has only been tested with the two scenarios below.

What is left to do:
- Test it more extensively
- Had some tests scenarios

I'm also having a hard time trying it with more than two parents. How I
am supposed to have more than two parents while octopus merge refuses i=
f
there are conflicts ?

Tested scenarios:
git init
>test
git add test
git commit -m initial

git checkout -b side1
seq 10 >>test
git commit -m all -a
git checkout master
seq 1 2 10 >test
git commit -m three -a

git merge side1
>test
git commit -m merge -a
git show

AND

git init
>test
git add test
git commit -m initial

echo "3\n1\n2\n4" >test
git commit -m shuffled -a

git checkout -b side HEAD^
echo "1\n2\n3\n4" >test
git commit -m sorted -a

git merge master
>test
git commit -m merge -a
git show

 combine-diff.c |  192 ++++++++++++++++++++++++++++++++++++++++++++++--=
--------
 1 file changed, 160 insertions(+), 32 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 35d41cd..252dd72 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -73,16 +73,24 @@ static struct combine_diff_path *intersect_paths(st=
ruct combine_diff_path *curr,

 /* Lines lost from parent */
 struct lline {
-	struct lline *next;
+	struct lline *next, *prev;
 	int len;
 	unsigned long parent_map;
 	char line[FLEX_ARRAY];
 };

+/* Lines lost from current parent (before coalescing) */
+struct plost {
+	struct lline *lost_head, *lost_tail;
+	int len;
+};
+
 /* Lines surviving in the merge result */
 struct sline {
-	struct lline *lost_head, **lost_tail;
-	struct lline *next_lost;
+	/* Accumulated and coalesced lost lines */
+	struct lline *lost;
+	int lenlost;
+	struct plost plost;
 	char *bol;
 	int len;
 	/* bit 0 up to (N-1) are on if the parent has this line (i.e.
@@ -94,6 +102,132 @@ struct sline {
 	unsigned long *p_lno;
 };

+enum coalesce_direction { MATCH, BASE, NEW };
+
+/* Coalesce new lines into base by finding LCS */
+static struct lline *coalesce_lines(struct lline *base, int *lenbase,
+				    struct lline *new, int lennew,
+				    unsigned long parent)
+{
+	int **lcs;
+	enum coalesce_direction **directions;
+	struct lline *baseend, *newend;
+	int i, j, origbaselen =3D *lenbase;
+
+	if (new =3D=3D NULL)
+		return base;
+
+	if (base =3D=3D NULL) {
+		*lenbase =3D lennew;
+		return new;
+	}
+
+	/*
+	 * Coalesce new lines into base by finding the LCS
+	 * - Create the table to run dynamic programing
+	 * - Compute the LCS
+	 * - Then reverse read the direction structure:
+	 *   - If we have MATCH, assign parent to base flag, and consume
+	 *   both baseend and newend
+	 *   - Else if we have BASE, consume baseend
+	 *   - Else if we have NEW, insert newend lline into base and
+	 *   consume newend
+	 */
+	lcs =3D xcalloc(origbaselen + 1, sizeof(int*));
+	directions =3D xcalloc(origbaselen + 1, sizeof(enum coalesce_directio=
n*));
+	for (i =3D 0; i < origbaselen + 1; i++) {
+		lcs[i] =3D xcalloc(lennew + 1, sizeof(int));
+		directions[i] =3D xcalloc(lennew + 1, sizeof(enum coalesce_direction=
));
+		directions[i][0] =3D BASE;
+	}
+	for (j =3D 1; j < lennew + 1; j++)
+		directions[0][j] =3D NEW;
+
+	for (i =3D 1, baseend =3D base; i < origbaselen + 1; i++) {
+		for (j =3D 1, newend =3D new; j < lennew + 1; j++) {
+			if (baseend->len =3D=3D newend->len &&
+			    !memcmp(baseend->line, newend->line, baseend->len)) {
+				lcs[i][j] =3D lcs[i - 1][j - 1] + 1;
+				directions[i][j] =3D MATCH;
+			} else if (lcs[i][j - 1] >=3D lcs[i - 1][j]) {
+				lcs[i][j] =3D lcs[i][j - 1];
+				directions[i][j] =3D NEW;
+			} else {
+				lcs[i][j] =3D lcs[i - 1][j];
+				directions[i][j] =3D BASE;
+			}
+			if (newend->next)
+				newend =3D newend->next;
+		}
+		if (baseend->next)
+			baseend =3D baseend->next;
+	}
+
+	for (i =3D 0; i < origbaselen + 1; i++)
+		free(lcs[i]);
+	free(lcs);
+
+	/* At this point, baseend and newend point to the end of each lists *=
/
+	i--;
+	j--;
+	while (i !=3D 0 || j !=3D 0) {
+		if (directions[i][j] =3D=3D MATCH) {
+			baseend->parent_map |=3D 1<<parent;
+			baseend =3D baseend->prev;
+			newend =3D newend->prev;
+			i--;
+			j--;
+		} else if (directions[i][j] =3D=3D NEW) {
+			struct lline *lline;
+
+			lline =3D newend;
+			/* Remove lline from new list and update newend */
+			if (lline->prev)
+				lline->prev->next =3D lline->next;
+			else
+				new =3D lline->next;
+			if (lline->next)
+				lline->next->prev =3D lline->prev;
+
+			newend =3D lline->prev;
+			j--;
+
+			/* Add lline to base list */
+			if (baseend) {
+				lline->next =3D baseend->next;
+				lline->prev =3D baseend;
+				if (lline->prev)
+					lline->prev->next =3D lline;
+			}
+			else {
+				lline->next =3D base;
+				base =3D lline;
+			}
+			(*lenbase)++;
+
+			if (lline->next)
+				lline->next->prev =3D lline;
+
+		} else {
+			baseend =3D baseend->prev;
+			i--;
+		}
+	}
+
+	newend =3D new;
+	while (newend) {
+		struct lline *lline =3D newend;
+		newend =3D newend->next;
+		free(lline);
+	}
+
+	for (i =3D 0; i < origbaselen + 1; i++)
+		free(directions[i]);
+	free(directions);
+
+	return base;
+}
+
 static char *grab_blob(const unsigned char *sha1, unsigned int mode,
 		       unsigned long *size, struct userdiff_driver *textconv,
 		       const char *path)
@@ -129,29 +263,19 @@ static void append_lost(struct sline *sline, int =
n, const char *line, int len)
 	if (line[len-1] =3D=3D '\n')
 		len--;

-	/* Check to see if we can squash things */
-	if (sline->lost_head) {
-		lline =3D sline->next_lost;
-		while (lline) {
-			if (lline->len =3D=3D len &&
-			    !memcmp(lline->line, line, len)) {
-				lline->parent_map |=3D this_mask;
-				sline->next_lost =3D lline->next;
-				return;
-			}
-			lline =3D lline->next;
-		}
-	}
-
 	lline =3D xmalloc(sizeof(*lline) + len + 1);
 	lline->len =3D len;
 	lline->next =3D NULL;
+	lline->prev =3D sline->plost.lost_tail;
+	if (lline->prev)
+		lline->prev->next =3D lline;
+	else
+		sline->plost.lost_head =3D lline;
+	sline->plost.lost_tail =3D lline;
+	sline->plost.len++;
 	lline->parent_map =3D this_mask;
 	memcpy(lline->line, line, len);
 	lline->line[len] =3D 0;
-	*sline->lost_tail =3D lline;
-	sline->lost_tail =3D &lline->next;
-	sline->next_lost =3D NULL;
 }

 struct combine_diff_state {
@@ -194,7 +318,6 @@ static void consume_line(void *state_, char *line, =
unsigned long len)
 				xcalloc(state->num_parent,
 					sizeof(unsigned long));
 		state->sline[state->nb-1].p_lno[state->n] =3D state->ob;
-		state->lost_bucket->next_lost =3D state->lost_bucket->lost_head;
 		return;
 	}
 	if (!state->lost_bucket)
@@ -255,8 +378,17 @@ static void combine_diff(const unsigned char *pare=
nt, unsigned int mode,
 		struct lline *ll;
 		sline[lno].p_lno[n] =3D p_lno;

+		/* Coalesce new lines */
+		if (sline[lno].plost.lost_head) {
+			struct sline *sl =3D &sline[lno];
+			sl->lost =3D coalesce_lines(sl->lost, &sl->lenlost,
+						  sl->plost.lost_head, sl->plost.len, n);
+			sl->plost.lost_head =3D sl->plost.lost_tail =3D NULL;
+			sl->plost.len =3D 0;
+		}
+
 		/* How many lines would this sline advance the p_lno? */
-		ll =3D sline[lno].lost_head;
+		ll =3D sline[lno].lost;
 		while (ll) {
 			if (ll->parent_map & nmask)
 				p_lno++; /* '-' means parent had it */
@@ -276,7 +408,7 @@ static int interesting(struct sline *sline, unsigne=
d long all_mask)
 	/* If some parents lost lines here, or if we have added to
 	 * some parent, it is interesting.
 	 */
-	return ((sline->flag & all_mask) || sline->lost_head);
+	return ((sline->flag & all_mask) || sline->lost);
 }

 static unsigned long adjust_hunk_tail(struct sline *sline,
@@ -459,7 +591,7 @@ static int make_hunks(struct sline *sline, unsigned=
 long cnt,
 		has_interesting =3D 0;
 		for (j =3D i; j < hunk_end && !has_interesting; j++) {
 			unsigned long this_diff =3D sline[j].flag & all_mask;
-			struct lline *ll =3D sline[j].lost_head;
+			struct lline *ll =3D sline[j].lost;
 			if (this_diff) {
 				/* This has some changes.  Is it the
 				 * same as others?
@@ -613,7 +745,7 @@ static void dump_sline(struct sline *sline, const c=
har *line_prefix,
 			int j;
 			unsigned long p_mask;
 			struct sline *sl =3D &sline[lno++];
-			ll =3D (sl->flag & no_pre_delete) ? NULL : sl->lost_head;
+			ll =3D (sl->flag & no_pre_delete) ? NULL : sl->lost;
 			while (ll) {
 				printf("%s%s", line_prefix, c_old);
 				for (j =3D 0; j < num_parent; j++) {
@@ -664,7 +796,7 @@ static void reuse_combine_diff(struct sline *sline,=
 unsigned long cnt,
 	jmask =3D (1UL<<j);

 	for (lno =3D 0; lno <=3D cnt; lno++) {
-		struct lline *ll =3D sline->lost_head;
+		struct lline *ll =3D sline->lost;
 		sline->p_lno[i] =3D sline->p_lno[j];
 		while (ll) {
 			if (ll->parent_map & jmask)
@@ -923,10 +1055,6 @@ static void show_patch_diff(struct combine_diff_p=
ath *elem, int num_parent,

 	sline =3D xcalloc(cnt+2, sizeof(*sline));
 	sline[0].bol =3D result;
-	for (lno =3D 0; lno <=3D cnt + 1; lno++) {
-		sline[lno].lost_tail =3D &sline[lno].lost_head;
-		sline[lno].flag =3D 0;
-	}
 	for (lno =3D 0, cp =3D result; cp < result + result_size; cp++) {
 		if (*cp =3D=3D '\n') {
 			sline[lno].len =3D cp - sline[lno].bol;
@@ -976,8 +1104,8 @@ static void show_patch_diff(struct combine_diff_pa=
th *elem, int num_parent,
 	free(result);

 	for (lno =3D 0; lno < cnt; lno++) {
-		if (sline[lno].lost_head) {
-			struct lline *ll =3D sline[lno].lost_head;
+		if (sline[lno].lost) {
+			struct lline *ll =3D sline[lno].lost;
 			while (ll) {
 				struct lline *tmp =3D ll;
 				ll =3D ll->next;
--
1.7.9.5
