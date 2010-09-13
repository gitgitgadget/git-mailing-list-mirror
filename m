From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] log --author: take union of multiple "author" requests
Date: Mon, 13 Sep 2010 01:18:07 -0700
Message-ID: <7vmxrmawg0.fsf_-_@alter.siamese.dyndns.org>
References: <AANLkTikONxneEgF5m+m6100pwzThTnaiAB+OFzYufcC2@mail.gmail.com>
 <7veidlkxdb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Emil Sit <sit@emilsit.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 10:18:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov4F3-0005KJ-Jh
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 10:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625Ab0IMISP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 04:18:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269Ab0IMISO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 04:18:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 12685D5501;
	Mon, 13 Sep 2010 04:18:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8YuSU3kWcBVxwCGcX6yS4n9+04I=; b=kzEivn
	nUyvpCqL2T1yCf7V8i+S7bmRQxSd7164P0SedZ97mz1fWqiYioLY+tsscRFJGZaZ
	WQWtQEWDdLvPMXVUXui4LjLCF8DcBDuIjXbrsC2surz+aVDf/R5KlqVfTl+VQ51z
	fMuLPlKRvUiW+MNIYZAV191c9wSzCwNTBfjw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T4dQK1AFpPjnDapJxSoZzdhx+euYzG8e
	6GYLin/rQpC7giMfHoKpkYaCLWPrH/cBHRrnUrxJKZcCzumWFyOGzzsTk06TMp2G
	HrU18oHEg/GAWdCGyQtEDcBFqL5f4kbJ+l35JNQs6m3h/sAEwzlMWDrIvfNtZTzc
	Rv4LA4JEEvo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E0AE0D5500;
	Mon, 13 Sep 2010 04:18:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A979D54FF; Mon, 13 Sep
 2010 04:18:08 -0400 (EDT)
In-Reply-To: <7veidlkxdb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 26 Aug 2010 12\:05\:52 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 72FBCFC6-BF0F-11DF-8F3E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156081>

In the olden days,

    log --author=me --committer=him --grep=this --grep=that

used to be turned into:

    (OR (HEADER-AUTHOR me)
        (HEADER-COMMITTER him)
        (PATTERN this)
        (PATTERN that))

showing my patches that do not have any "this" nor "that", which was
totally useless.

80235ba ("log --author=me --grep=it" should find intersection, not union,
2010-01-17) improved it greatly to turn the same into:

    (ALL-MATCH
      (HEADER-AUTHOR me)
      (HEADER-COMMITTER him)
      (OR (PATTERN this) (PATTERN that)))

That is, "show only patches by me and committed by him, that have either
this or that", which is a lot more natural thing to ask.

We however need to be a bit more clever when the user asks more than one
"author" (or "committer"); because a commit has only one author (and one
committer), they ought to be interpreted as asking for union to be useful.
The current implementation simply added another author/committer pattern
at the same top-level for ALL-MATCH to insist on matching all, finding
nothing.

Turn

    log --author=me --author=her \
    	--committer=him --committer=you \
	--grep=this --grep=that

into

    (ALL-MATCH
      (OR (HEADER-AUTHOR me) (HEADER-AUTHOR her))
      (OR (HEADER-COMMITTER him) (HEADER-COMMITTER you))
      (OR (PATTERN this) (PATTERN that)))

instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 grep.c          |   65 ++++++++++++++++++++++++++++++++++++++++++++----------
 grep.h          |    2 +
 t/t7810-grep.sh |   29 +++++++++++++++++++++++-
 3 files changed, 83 insertions(+), 13 deletions(-)

diff --git a/grep.c b/grep.c
index 718a3c2..63c4280 100644
--- a/grep.c
+++ b/grep.c
@@ -189,17 +189,32 @@ static struct grep_expr *compile_pattern_expr(struct grep_pat **list)
 	return compile_pattern_or(list);
 }
 
+static struct grep_expr *grep_true_expr(void)
+{
+	struct grep_expr *z = xcalloc(1, sizeof(*z));
+	z->node = GREP_NODE_TRUE;
+	return z;
+}
+
+static struct grep_expr *grep_or_expr(struct grep_expr *left, struct grep_expr *right)
+{
+	struct grep_expr *z = xcalloc(1, sizeof(*z));
+	z->node = GREP_NODE_OR;
+	z->u.binary.left = left;
+	z->u.binary.right = right;
+	return z;
+}
+
 static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 {
 	struct grep_pat *p;
 	struct grep_expr *header_expr;
+	struct grep_expr *(header_group[GREP_HEADER_FIELD_MAX]);
+	enum grep_header_field fld;
 
 	if (!opt->header_list)
 		return NULL;
 	p = opt->header_list;
-	header_expr = compile_pattern_expr(&p);
-	if (p)
-		die("incomplete pattern expression: %s", p->pattern);
 	for (p = opt->header_list; p; p = p->next) {
 		if (p->token != GREP_PATTERN_HEAD)
 			die("bug: a non-header pattern in grep header list.");
@@ -207,6 +222,33 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 			die("bug: unknown header field %d", p->field);
 		compile_regexp(p, opt);
 	}
+
+	for (fld = 0; fld < GREP_HEADER_FIELD_MAX; fld++)
+		header_group[fld] = NULL;
+
+	for (p = opt->header_list; p; p = p->next) {
+		struct grep_expr *h;
+		struct grep_pat *pp = p;
+
+		h = compile_pattern_atom(&pp);
+		if (!h || pp != p->next)
+			die("bug: malformed header expr");
+		if (!header_group[p->field]) {
+			header_group[p->field] = h;
+			continue;
+		}
+		header_group[p->field] = grep_or_expr(h, header_group[p->field]);
+	}
+
+	header_expr = NULL;
+
+	for (fld = 0; fld < GREP_HEADER_FIELD_MAX; fld++) {
+		if (!header_group[fld])
+			continue;
+		if (!header_expr)
+			header_expr = grep_true_expr();
+		header_expr = grep_or_expr(header_group[fld], header_expr);
+	}
 	return header_expr;
 }
 
@@ -242,22 +284,18 @@ void compile_grep_patterns(struct grep_opt *opt)
 	if (!header_expr)
 		return;
 
-	if (opt->pattern_expression) {
-		struct grep_expr *z;
-		z = xcalloc(1, sizeof(*z));
-		z->node = GREP_NODE_OR;
-		z->u.binary.left = opt->pattern_expression;
-		z->u.binary.right = header_expr;
-		opt->pattern_expression = z;
-	} else {
+	if (!opt->pattern_expression)
 		opt->pattern_expression = header_expr;
-	}
+	else
+		opt->pattern_expression = grep_or_expr(opt->pattern_expression,
+						       header_expr);
 	opt->all_match = 1;
 }
 
 static void free_pattern_expr(struct grep_expr *x)
 {
 	switch (x->node) {
+	case GREP_NODE_TRUE:
 	case GREP_NODE_ATOM:
 		break;
 	case GREP_NODE_NOT:
@@ -486,6 +524,9 @@ static int match_expr_eval(struct grep_expr *x, char *bol, char *eol,
 	if (!x)
 		die("Not a valid grep expression");
 	switch (x->node) {
+	case GREP_NODE_TRUE:
+		h = 1;
+		break;
 	case GREP_NODE_ATOM:
 		h = match_one_pattern(x->u.atom, bol, eol, ctx, &match, 0);
 		break;
diff --git a/grep.h b/grep.h
index efa8cff..06621fe 100644
--- a/grep.h
+++ b/grep.h
@@ -22,6 +22,7 @@ enum grep_header_field {
 	GREP_HEADER_AUTHOR = 0,
 	GREP_HEADER_COMMITTER
 };
+#define GREP_HEADER_FIELD_MAX (GREP_HEADER_COMMITTER + 1)
 
 struct grep_pat {
 	struct grep_pat *next;
@@ -41,6 +42,7 @@ enum grep_expr_node {
 	GREP_NODE_ATOM,
 	GREP_NODE_NOT,
 	GREP_NODE_AND,
+	GREP_NODE_TRUE,
 	GREP_NODE_OR
 };
 
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 8a63227..dc5c085 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -324,8 +324,13 @@ test_expect_success 'log grep setup' '
 
 	echo a >>file &&
 	test_tick &&
-	git commit -a -m "third"
+	git commit -a -m "third" &&
 
+	echo a >>file &&
+	test_tick &&
+	GIT_AUTHOR_NAME="Night Fall" \
+	GIT_AUTHOR_EMAIL="nitfol@frobozz.com" \
+	git commit -a -m "fourth"
 '
 
 test_expect_success 'log grep (1)' '
@@ -372,6 +377,28 @@ test_expect_success 'log --grep --author implicitly uses all-match' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log with multiple --author uses union' '
+	git log --author="Thor" --author="Aster" --format=%s >actual &&
+	{
+	    echo third && echo second && echo initial
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log with --grep and multiple --author uses all-match' '
+	git log --author="Thor" --author="Night" --grep=i --format=%s >actual &&
+	{
+	    echo third && echo initial
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log with --grep and multiple --author uses all-match' '
+	git log --author="Thor" --author="Night" --grep=q --format=%s >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'grep with CE_VALID file' '
 	git update-index --assume-unchanged t/t &&
 	rm t/t &&
-- 
1.7.3.rc1.227.gee5c7b
