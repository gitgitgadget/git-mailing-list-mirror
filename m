From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH v2] combine-diff: coalesce lost lines optimally
Date: Sat, 23 Mar 2013 18:23:28 +0100
Message-ID: <1364059408-22346-1-git-send-email-apelisse@gmail.com>
References: <7vhak9ps8w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 23 18:24:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJSAr-0007Nr-Bi
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 18:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746Ab3CWRXl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Mar 2013 13:23:41 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:50023 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab3CWRXk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 13:23:40 -0400
Received: by mail-we0-f174.google.com with SMTP id u7so114130wey.33
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=QXn2ANS2RcR/rnsGSbiA0hsMzuijqHc5kWgJ2JCFm4s=;
        b=Pr8NwspGd72AkjkB3aECjiGeEAair8FPll8FrxTSLKvGOZ2uiTZ30VHgODvZdASw+z
         s3U4KMWHDJHUI9vqZmDdw/TfKx550XlMDo8+H9c/Gxj1kTKF63MB1iklWFBjvQk+QFh+
         owLwIHN8wfEgVmDR/TXYxHiYzyTyZ3iiMk6C2ES78oLPYqg85iwcX8uRrQDE8CvLZt5Q
         X18MlcAz/idww2gnNd7hsSLvQTjf8lerHgeWgpvTH5AFpKFkEEFDz/WS/0pwOPRtUAx3
         eQEgNpcQHH+NJQSXFX/xoFu6GTIpbymRCXIcef/03AcLI/c+0PzsfyKrYXOLFTiccvsM
         oeQw==
X-Received: by 10.180.77.9 with SMTP id o9mr17608073wiw.16.1364059418083;
        Sat, 23 Mar 2013 10:23:38 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id o5sm10738560wix.3.2013.03.23.10.23.36
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Mar 2013 10:23:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7vhak9ps8w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218924>

This replaces the greedy implementation to coalesce lost lines by using
dynamic programming to find the Longest Common Subsequence.

The O(n=C2=B2) time complexity is obviously bigger than previous
implementation but it can produce shorter diff results (and most likely
easier to read).

List of lost lines is now doubly-linked because we reverse-read it when
reading the direction matrix.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
Hey,
This version includes some tests and is based on
ap/combine-diff-ignore-whitespace.
As you can see the last test is broken because the solution is not
optimal for more than two parents. It would probably require to extend
the dynamic programming to a k-dimension matrix (for k parents) but the
result would end-up being O(n^k) (when removing n consecutives lines
from p parents). I'm not sure there is any better solution known yet to
the k-LCS problem.
Implementing the dynamic solution with the k-dimension matrix would
probably require to re-hash the strings (I guess it's already done by
xdiff), as the number of string comparisons would increase.

Anyway I'm not exactly sure where to go from here :)

Cheers,
Antoine

 combine-diff.c           |  255 ++++++++++++++++++++++++++++++++++----=
--------
 t/t4038-diff-combined.sh |  129 +++++++++++++++++++++++
 2 files changed, 320 insertions(+), 64 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 6288485..77d7872 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -74,16 +74,24 @@ static struct combine_diff_path *intersect_paths(st=
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
@@ -95,34 +103,6 @@ struct sline {
 	unsigned long *p_lno;
 };

-static char *grab_blob(const unsigned char *sha1, unsigned int mode,
-		       unsigned long *size, struct userdiff_driver *textconv,
-		       const char *path)
-{
-	char *blob;
-	enum object_type type;
-
-	if (S_ISGITLINK(mode)) {
-		blob =3D xmalloc(100);
-		*size =3D snprintf(blob, 100,
-				 "Subproject commit %s\n", sha1_to_hex(sha1));
-	} else if (is_null_sha1(sha1)) {
-		/* deleted blob */
-		*size =3D 0;
-		return xcalloc(1, 1);
-	} else if (textconv) {
-		struct diff_filespec *df =3D alloc_filespec(path);
-		fill_filespec(df, sha1, 1, mode);
-		*size =3D fill_textconv(textconv, df, &blob);
-		free_filespec(df);
-	} else {
-		blob =3D read_sha1_file(sha1, &type, size);
-		if (type !=3D OBJ_BLOB)
-			die("object '%s' is not a blob!", sha1_to_hex(sha1));
-	}
-	return blob;
-}
-
 static int match_string_spaces(const char *line1, int len1,
 			       const char *line2, int len2,
 			       long flags)
@@ -163,36 +143,180 @@ static int match_string_spaces(const char *line1=
, int len1,
 	return 0;
 }

-static void append_lost(struct sline *sline, int n, const char *line, =
int len, long flags)
+enum coalesce_direction { MATCH, BASE, NEW };
+
+/* Coalesce new lines into base by finding LCS */
+static struct lline *coalesce_lines(struct lline *base, int *lenbase,
+				    struct lline *new, int lennew,
+				    unsigned long parent, long flags)
 {
-	struct lline *lline;
-	unsigned long this_mask =3D (1UL<<n);
-	if (line[len-1] =3D=3D '\n')
-		len--;
+	int **lcs;
+	enum coalesce_direction **directions;
+	struct lline *baseend, *newend =3D NULL;
+	int i, j, origbaselen =3D *lenbase;

-	/* Check to see if we can squash things */
-	if (sline->lost_head) {
-		lline =3D sline->next_lost;
-		while (lline) {
-			if (match_string_spaces(lline->line, lline->len,
-						line, len, flags)) {
-				lline->parent_map |=3D this_mask;
-				sline->next_lost =3D lline->next;
-				return;
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
+			if (match_string_spaces(baseend->line, baseend->len,
+						newend->line, newend->len, flags)) {
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
 			}
-			lline =3D lline->next;
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
 		}
 	}

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
+static char *grab_blob(const unsigned char *sha1, unsigned int mode,
+		       unsigned long *size, struct userdiff_driver *textconv,
+		       const char *path)
+{
+	char *blob;
+	enum object_type type;
+
+	if (S_ISGITLINK(mode)) {
+		blob =3D xmalloc(100);
+		*size =3D snprintf(blob, 100,
+				 "Subproject commit %s\n", sha1_to_hex(sha1));
+	} else if (is_null_sha1(sha1)) {
+		/* deleted blob */
+		*size =3D 0;
+		return xcalloc(1, 1);
+	} else if (textconv) {
+		struct diff_filespec *df =3D alloc_filespec(path);
+		fill_filespec(df, sha1, 1, mode);
+		*size =3D fill_textconv(textconv, df, &blob);
+		free_filespec(df);
+	} else {
+		blob =3D read_sha1_file(sha1, &type, size);
+		if (type !=3D OBJ_BLOB)
+			die("object '%s' is not a blob!", sha1_to_hex(sha1));
+	}
+	return blob;
+}
+
+static void append_lost(struct sline *sline, int n, const char *line, =
int len)
+{
+	struct lline *lline;
+	unsigned long this_mask =3D (1UL<<n);
+	if (line[len-1] =3D=3D '\n')
+		len--;
+
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
@@ -203,7 +327,6 @@ struct combine_diff_state {
 	int n;
 	struct sline *sline;
 	struct sline *lost_bucket;
-	long flags;
 };

 static void consume_line(void *state_, char *line, unsigned long len)
@@ -236,14 +359,13 @@ static void consume_line(void *state_, char *line=
, unsigned long len)
 				xcalloc(state->num_parent,
 					sizeof(unsigned long));
 		state->sline[state->nb-1].p_lno[state->n] =3D state->ob;
-		state->lost_bucket->next_lost =3D state->lost_bucket->lost_head;
 		return;
 	}
 	if (!state->lost_bucket)
 		return; /* not in any hunk yet */
 	switch (line[0]) {
 	case '-':
-		append_lost(state->lost_bucket, state->n, line+1, len-1, state->flag=
s);
+		append_lost(state->lost_bucket, state->n, line+1, len-1);
 		break;
 	case '+':
 		state->sline[state->lno-1].flag |=3D state->nmask;
@@ -276,7 +398,6 @@ static void combine_diff(const unsigned char *paren=
t, unsigned int mode,
 	xpp.flags =3D flags;
 	memset(&xecfg, 0, sizeof(xecfg));
 	memset(&state, 0, sizeof(state));
-	state.flags =3D flags;
 	state.nmask =3D nmask;
 	state.sline =3D sline;
 	state.lno =3D 1;
@@ -298,8 +419,18 @@ static void combine_diff(const unsigned char *pare=
nt, unsigned int mode,
 		struct lline *ll;
 		sline[lno].p_lno[n] =3D p_lno;

+		/* Coalesce new lines */
+		if (sline[lno].plost.lost_head) {
+			struct sline *sl =3D &sline[lno];
+			sl->lost =3D coalesce_lines(sl->lost, &sl->lenlost,
+						  sl->plost.lost_head,
+						  sl->plost.len, n, flags);
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
@@ -319,7 +450,7 @@ static int interesting(struct sline *sline, unsigne=
d long all_mask)
 	/* If some parents lost lines here, or if we have added to
 	 * some parent, it is interesting.
 	 */
-	return ((sline->flag & all_mask) || sline->lost_head);
+	return ((sline->flag & all_mask) || sline->lost);
 }

 static unsigned long adjust_hunk_tail(struct sline *sline,
@@ -502,7 +633,7 @@ static int make_hunks(struct sline *sline, unsigned=
 long cnt,
 		has_interesting =3D 0;
 		for (j =3D i; j < hunk_end && !has_interesting; j++) {
 			unsigned long this_diff =3D sline[j].flag & all_mask;
-			struct lline *ll =3D sline[j].lost_head;
+			struct lline *ll =3D sline[j].lost;
 			if (this_diff) {
 				/* This has some changes.  Is it the
 				 * same as others?
@@ -656,7 +787,7 @@ static void dump_sline(struct sline *sline, const c=
har *line_prefix,
 			int j;
 			unsigned long p_mask;
 			struct sline *sl =3D &sline[lno++];
-			ll =3D (sl->flag & no_pre_delete) ? NULL : sl->lost_head;
+			ll =3D (sl->flag & no_pre_delete) ? NULL : sl->lost;
 			while (ll) {
 				printf("%s%s", line_prefix, c_old);
 				for (j =3D 0; j < num_parent; j++) {
@@ -707,7 +838,7 @@ static void reuse_combine_diff(struct sline *sline,=
 unsigned long cnt,
 	jmask =3D (1UL<<j);

 	for (lno =3D 0; lno <=3D cnt; lno++) {
-		struct lline *ll =3D sline->lost_head;
+		struct lline *ll =3D sline->lost;
 		sline->p_lno[i] =3D sline->p_lno[j];
 		while (ll) {
 			if (ll->parent_map & jmask)
@@ -966,10 +1097,6 @@ static void show_patch_diff(struct combine_diff_p=
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
@@ -1019,8 +1146,8 @@ static void show_patch_diff(struct combine_diff_p=
ath *elem, int num_parent,
 	free(result);

 	for (lno =3D 0; lno < cnt; lno++) {
-		if (sline[lno].lost_head) {
-			struct lline *ll =3D sline[lno].lost_head;
+		if (sline[lno].lost) {
+			struct lline *ll =3D sline[lno].lost;
 			while (ll) {
 				struct lline *tmp =3D ll;
 				ll =3D ll->next;
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index b7e16a7..1261dbb 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -224,4 +224,133 @@ test_expect_success 'check combined output (ignor=
e all spaces)' '
 	compare_diff_patch expected actual
 '

+test_expect_success 'combine diff coalesce simple' '
+	>test &&
+	git add test &&
+	git commit -m initial &&
+	test_seq 4 >test &&
+	git commit -a -m empty1 &&
+	git branch side1 &&
+	git checkout HEAD^ &&
+	test_seq 5 >test &&
+	git commit -a -m empty2 &&
+	test_must_fail git merge side1 &&
+	>test &&
+	git commit -a -m merge &&
+	git show >actual.tmp &&
+	sed -e "1,/^@@@/d" < actual.tmp >actual &&
+	tr -d Q <<-\EOF >expected &&
+	--1
+	--2
+	--3
+	--4
+	- 5
+	EOF
+	compare_diff_patch expected actual
+'
+
+test_expect_success 'combine diff coalesce tricky' '
+	>test &&
+	git add test &&
+	git commit -m initial --allow-empty &&
+	cat <<-\EOF >test &&
+	3
+	1
+	2
+	3
+	4
+	EOF
+	git commit -a -m empty1 &&
+	git branch -f side1 &&
+	git checkout HEAD^ &&
+	cat <<-\EOF >test &&
+	1
+	3
+	5
+	4
+	EOF
+	git commit -a -m empty2 &&
+	git branch -f side2 &&
+	test_must_fail git merge side1 &&
+	>test &&
+	git commit -a -m merge &&
+	git show >actual.tmp &&
+	sed -e "1,/^@@@/d" < actual.tmp >actual &&
+	tr -d Q <<-\EOF >expected &&
+	 -3
+	--1
+	 -2
+	--3
+	- 5
+	--4
+	EOF
+	compare_diff_patch expected actual &&
+	git checkout -f side1 &&
+	test_must_fail git merge side2 &&
+	>test &&
+	git commit -a -m merge &&
+	git show >actual.tmp &&
+	sed -e "1,/^@@@/d" < actual.tmp >actual &&
+	tr -d Q <<-\EOF >expected &&
+	- 3
+	--1
+	- 2
+	--3
+	 -5
+	--4
+	EOF
+	compare_diff_patch expected actual
+'
+
+test_expect_failure 'combine diff coalesce three parents' '
+	>test &&
+	git add test &&
+	git commit -m initial --allow-empty &&
+	cat <<-\EOF >test &&
+	3
+	1
+	2
+	3
+	4
+	EOF
+	git commit -a -m empty1 &&
+	git checkout -B side1 &&
+	git checkout HEAD^ &&
+	cat <<-\EOF >test &&
+	1
+	3
+	7
+	5
+	4
+	EOF
+	git commit -a -m empty2 &&
+	git branch -f side2 &&
+	git checkout HEAD^ &&
+	cat <<-\EOF >test &&
+	3
+	1
+	6
+	5
+	4
+	EOF
+	git commit -a -m empty3 &&
+	>test &&
+	git add test &&
+	TREE=3D$(git write-tree) &&
+	COMMIT=3D$(git commit-tree -p HEAD -p side1 -p side2 -m merge $TREE) =
&&
+	git show $COMMIT >actual.tmp &&
+	sed -e "1,/^@@@/d" < actual.tmp >actual &&
+	tr -d Q <<-\EOF >expected &&
+	-- 3
+	---1
+	-  6
+	 - 2
+	 --3
+	  -7
+	- -5
+	---4
+	EOF
+	compare_diff_patch expected actual
+'
+
 test_done
--
1.7.9.5
