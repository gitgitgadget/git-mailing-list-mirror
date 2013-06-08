From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] diff: add --ignore-blank-lines option
Date: Sat,  8 Jun 2013 22:44:51 +0200
Message-ID: <1370724291-30088-1-git-send-email-apelisse@gmail.com>
References: <7v61xt7gej.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 22:45:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlQ10-0001Ur-Nl
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 22:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779Ab3FHUpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 16:45:09 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:47637 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab3FHUpH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 16:45:07 -0400
Received: by mail-wg0-f53.google.com with SMTP id y10so1490721wgg.8
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 13:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=B0fmUmMSCeAUGU/jLZnM36xSaEUHgupcZBT1hoFjf6s=;
        b=wnPVaMDlMG4Ly/yEI7mfMRwU2EJhg6OdiJc+taxrSkpmgc1M21NFqCchpqIDemC/zJ
         Eb1sKRin/rd6lH2bjuigvXZRFYeSScacnpyXvsb+AdD7AhqFDvuww06skVv1yi8vt5vD
         2LvENKWzuxEc3cwlxLxZeZMpv8j0ZNUFkSG/ghqUxzAWBsyAdk4iz3FCd+ZWRzxtmOk9
         elp496CZmm9AeHl7NLibgnecyvivFk9bYyS24NPm8ornr8pR5DLJR/seM82/+NosmAa4
         Tp/rw1KZBRIzJ3zmKD/cX3WozxcJSn71+WYY1BXV5FdyQ4D878vbTpg0MNQUYvX8YXCq
         BZmA==
X-Received: by 10.194.134.73 with SMTP id pi9mr2240596wjb.38.1370724305383;
        Sat, 08 Jun 2013 13:45:05 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPSA id ay7sm3804922wib.9.2013.06.08.13.45.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 13:45:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7v61xt7gej.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226862>

The goal of the patch is to introduce the GNU diff
-B/--ignore-blank-lines as closely as possible. The short option is not
available because it's already used for "break-rewrites".

When this option is used, git-diff will not create hunks that simply
adds or removes empty lines, but will still show empty lines
addition/suppression if they are close enough to "valuable" changes.

There are two differences between this option and GNU diff -B option:
- GNU diff doesn't have "--inter-hunk-context", so this must be handled
- The following sequence looks like a bug (context is displayed twice):

    $ seq 5 >file1
    $ cat <<EOF >file2
    change
    1
    2

    3
    4
    5
    change
    EOF
    $ diff -u -B file1 file2
    --- file1	2013-06-08 22:13:04.471517834 +0200
    +++ file2	2013-06-08 22:13:23.275517855 +0200
    @@ -1,5 +1,7 @@
    +change
     1
     2
    +
     3
     4
     5
    @@ -3,3 +5,4 @@
     3
     4
     5
    +change

So here is a more thorough description of the option:
- real changes are interesting
- blank lines that are close enough (less than context size) to
interesting changes are considered interesting (recursive definition)
- "context" lines are used around each hunk of interesting changes
- If two hunks are separated by less than "inter-hunk-context", they
will be merged into one.

The current implementation does the "interesting changes selection" in a
single pass.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
Hi,

On Tue, Jun 4, 2013 at 10:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> OK. Thanks.
>
> I think the logic would be more like:
>
>  1. Start from xscr, find the first xchp that is !xchp->ignore;
>     if there is none, we are done. There is no more to show.
>
>  2. Remember the xchp as the beginning.
>
>  3. Tangle ->next pointer to find the next xch that is !xch->ignore;
>     if there is none, we are also done.  xdchanges between the
>     beginning you remembered in the step 2. and your current xchp
>     are the only things we want to show.
>
>  4. Measure the distance between the end of xchp and the beginning
>     of xch.
>
>     - If it is larger than max_common, xdchanges between the
>       beginning you remembered in the step 2. and your current xchp
>       are the only things we want to show.  The next iteration will
>       start by skipping the blank-only changes between xchp and xch.
>
>     - If it is short enough, assign xchp = xch and go back to 3. to
>       find more interesting hunks (that is why we remembered the
>       real "beginning" in step 2.).

Actually it doesn't quite work like that because we don't totally ignore
"blank lines". We want to keep them if they are close enough to other
changes.

I've tried to improve the number of tests as it helped me during
implementation, and to give a better description of the feature.

The initial reroll was meant to simplify xdl_get_hunk() but I'm afraid
it became kind of "voodoo code".  I'm not sure if I should provide some
more comments about it and where.

Please let me know if something is not working as expected.

Cheers, Antoine

 Documentation/diff-options.txt |    3 +
 diff.c                         |    2 +
 t/t4015-diff-whitespace.sh     |  282 ++++++++++++++++++++++++++++++++++++++++
 xdiff/xdiff.h                  |    2 +
 xdiff/xdiffi.c                 |   29 ++++-
 xdiff/xdiffi.h                 |    1 +
 xdiff/xemit.c                  |   47 ++++++-
 xdiff/xemit.h                  |    2 +-
 xdiff/xutils.c                 |   13 ++
 xdiff/xutils.h                 |    1 +
 10 files changed, 374 insertions(+), 8 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index b8a9b86..4e042d9 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -439,6 +439,9 @@ endif::git-format-patch[]
 	differences even if one line has whitespace where the other
 	line has none.

+--ignore-blank-lines::
+	Ignore changes whose lines are all blank.
+
 --inter-hunk-context=<lines>::
 	Show the context between diff hunks, up to the specified number
 	of lines, thereby fusing hunks that are close to each other.
diff --git a/diff.c b/diff.c
index f0b3e7c..208094f 100644
--- a/diff.c
+++ b/diff.c
@@ -3593,6 +3593,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_CHANGE);
 	else if (!strcmp(arg, "--ignore-space-at-eol"))
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
+	else if (!strcmp(arg, "--ignore-blank-lines"))
+		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
 	else if (!strcmp(arg, "--patience"))
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
 	else if (!strcmp(arg, "--histogram"))
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index cc3db13..fc77713 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -142,6 +142,288 @@ EOF
 git diff --ignore-space-at-eol > out
 test_expect_success 'another test, with --ignore-space-at-eol' 'test_cmp expect out'

+test_expect_success 'ignore-blank-lines: only new lines' '
+	test_seq 5 >x &&
+	git update-index x &&
+	test_seq 5 | sed "/3/i \\
+" >x &&
+	git diff --ignore-blank-lines >out &&
+	>expect &&
+	test_cmp out expect
+'
+
+test_expect_success 'ignore-blank-lines: only new lines with space' '
+	test_seq 5 >x &&
+	git update-index x &&
+	test_seq 5 | sed "/3/i \ " >x &&
+	git diff -w --ignore-blank-lines >out &&
+	>expect &&
+	test_cmp out expect
+'
+
+test_expect_success 'ignore-blank-lines: after change' '
+	test_seq 7 >x &&
+	git update-index x &&
+	cat <<-\EOF >x &&
+	change
+	1
+	2
+
+	3
+	4
+
+	5
+	6
+	7
+
+	EOF
+	git diff --inter-hunk-context=100 --ignore-blank-lines >out.tmp &&
+	cat <<-\EOF >expected &&
+	diff --git a/x b/x
+	--- a/x
+	+++ b/x
+	@@ -1,7 +1,10 @@
+	+change
+	 1
+	 2
+	+
+	 3
+	 4
+	+
+	 5
+	 6
+	 7
+	EOF
+	compare_diff_patch expected out.tmp
+'
+
+test_expect_success 'ignore-blank-lines: before change' '
+	test_seq 7 >x &&
+	git update-index x &&
+	cat <<-\EOF >x &&
+
+	1
+	2
+	3
+
+	4
+	5
+
+	6
+	7
+	change
+	EOF
+	git diff --inter-hunk-context=100 --ignore-blank-lines >out.tmp &&
+	cat <<-\EOF >expected &&
+	diff --git a/x b/x
+	--- a/x
+	+++ b/x
+	@@ -1,7 +2,10 @@
+	 1
+	 2
+	 3
+	+
+	 4
+	 5
+	+
+	 6
+	 7
+	+change
+	EOF
+	compare_diff_patch expected out.tmp
+'
+
+test_expect_success 'ignore-blank-lines: between changes' '
+	test_seq 10 >x &&
+	git update-index x &&
+	cat <<-\EOF >x &&
+	change
+	1
+	2
+
+	3
+	4
+	5
+
+	6
+	7
+	8
+	9
+
+	10
+	change
+	EOF
+	git diff --ignore-blank-lines >out.tmp &&
+	cat <<-\EOF >expected &&
+	diff --git a/x b/x
+	--- a/x
+	+++ b/x
+	@@ -1,5 +1,7 @@
+	+change
+	 1
+	 2
+	+
+	 3
+	 4
+	 5
+	@@ -7,4 +10,6 @@
+	 7
+	 8
+	 9
+	+
+	 10
+	+change
+	EOF
+	compare_diff_patch expected out.tmp
+'
+
+test_expect_success 'ignore-blank-lines: between changes (with interhunkctx)' '
+	test_seq 10 >x &&
+	git update-index x &&
+	cat <<-\EOF >x &&
+	change
+	1
+	2
+
+	3
+	4
+	5
+
+	6
+	7
+	8
+	9
+
+	10
+	change
+	EOF
+	git diff --inter-hunk-context=2 --ignore-blank-lines >out.tmp &&
+	cat <<-\EOF >expected &&
+	diff --git a/x b/x
+	--- a/x
+	+++ b/x
+	@@ -1,10 +1,15 @@
+	+change
+	 1
+	 2
+	+
+	 3
+	 4
+	 5
+	+
+	 6
+	 7
+	 8
+	 9
+	+
+	 10
+	+change
+	EOF
+	compare_diff_patch expected out.tmp
+'
+
+test_expect_success 'ignore-blank-lines: scattered spaces' '
+	test_seq 10 >x &&
+	git update-index x &&
+	cat <<-\EOF >x &&
+	change
+	1
+	2
+	3
+
+	4
+
+	5
+
+	6
+
+	7
+
+	8
+	9
+	10
+	change
+	EOF
+	git diff --inter-hunk-context=4 --ignore-blank-lines >out.tmp &&
+	cat <<-\EOF >expected &&
+	diff --git a/x b/x
+	--- a/x
+	+++ b/x
+	@@ -1,3 +1,4 @@
+	+change
+	 1
+	 2
+	 3
+	@@ -8,3 +14,4 @@
+	 8
+	 9
+	 10
+	+change
+	EOF
+	compare_diff_patch expected out.tmp
+'
+
+test_expect_success 'ignore-blank-lines: mix changes and blank lines' '
+	test_seq 16 >x &&
+	git update-index x &&
+	cat <<-\EOF >x &&
+	change
+	1
+	2
+
+	3
+	4
+	5
+	change
+	6
+	7
+	8
+
+	9
+	10
+	11
+	change
+	12
+	13
+	14
+
+	15
+	16
+	change
+	EOF
+	git diff --ignore-blank-lines >out.tmp &&
+	cat <<-\EOF >expected &&
+	diff --git a/x b/x
+	--- a/x
+	+++ b/x
+	@@ -1,8 +1,11 @@
+	+change
+	 1
+	 2
+	+
+	 3
+	 4
+	 5
+	+change
+	 6
+	 7
+	 8
+	@@ -9,8 +13,11 @@
+	 9
+	 10
+	 11
+	+change
+	 12
+	 13
+	 14
+	+
+	 15
+	 16
+	+change
+	EOF
+	compare_diff_patch expected out.tmp
+'
+
 test_expect_success 'check mixed spaces and tabs in indent' '

 	# This is indented with SP HT SP.
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 219a3bb..c033991 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -39,6 +39,8 @@ extern "C" {
 #define XDF_DIFF_ALGORITHM_MASK (XDF_PATIENCE_DIFF | XDF_HISTOGRAM_DIFF)
 #define XDF_DIFF_ALG(x) ((x) & XDF_DIFF_ALGORITHM_MASK)

+#define XDF_IGNORE_BLANK_LINES (1 << 7)
+
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_COMMON (1 << 1)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index b2eb6db..2358a2d 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -394,6 +394,7 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 	xch->i2 = i2;
 	xch->chg1 = chg1;
 	xch->chg2 = chg2;
+	xch->ignore = 0;

 	return xch;
 }
@@ -544,7 +545,9 @@ static int xdl_call_hunk_func(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 	xdchange_t *xch, *xche;

 	for (xch = xscr; xch; xch = xche->next) {
-		xche = xdl_get_hunk(xch, xecfg);
+		xche = xdl_get_hunk(&xch, xecfg);
+		if (!xch)
+			break;
 		if (xecfg->hunk_func(xch->i1, xche->i1 + xche->chg1 - xch->i1,
 				     xch->i2, xche->i2 + xche->chg2 - xch->i2,
 				     ecb->priv) < 0)
@@ -553,6 +556,27 @@ static int xdl_call_hunk_func(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 	return 0;
 }

+static void xdl_mark_ignorable(xdchange_t *xscr, xdfenv_t *xe, long flags)
+{
+	xdchange_t *xch;
+
+	for (xch = xscr; xch; xch = xch->next) {
+		int ignore = 1;
+		xrecord_t **rec;
+		long i;
+
+		rec = &xe->xdf1.recs[xch->i1];
+		for (i = 0; i < xch->chg1 && ignore; i++)
+			ignore = xdl_blankline(rec[i]->ptr, rec[i]->size, flags);
+
+		rec = &xe->xdf2.recs[xch->i2];
+		for (i = 0; i < xch->chg2 && ignore; i++)
+			ignore = xdl_blankline(rec[i]->ptr, rec[i]->size, flags);
+
+		xch->ignore = ignore;
+	}
+}
+
 int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
 	xdchange_t *xscr;
@@ -571,6 +595,9 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		return -1;
 	}
 	if (xscr) {
+		if (xpp->flags & XDF_IGNORE_BLANK_LINES)
+			xdl_mark_ignorable(xscr, &xe, xpp->flags);
+
 		if (ef(&xe, xscr, ecb, xecfg) < 0) {

 			xdl_free_script(xscr);
diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
index 7a92ea9..8b81206 100644
--- a/xdiff/xdiffi.h
+++ b/xdiff/xdiffi.h
@@ -41,6 +41,7 @@ typedef struct s_xdchange {
 	struct s_xdchange *next;
 	long i1, i2;
 	long chg1, chg2;
+	int ignore;
 } xdchange_t;


diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index d11dbf9..04b4bb1 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -56,16 +56,49 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *
 /*
  * Starting at the passed change atom, find the latest change atom to be included
  * inside the differential hunk according to the specified configuration.
+ * Also advance xscr if the first changes must be discareded.
  */
-xdchange_t *xdl_get_hunk(xdchange_t *xscr, xdemitconf_t const *xecfg) {
-	xdchange_t *xch, *xchp;
+xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg) {
+	xdchange_t *xch, *xchp, *lxch;
 	long max_common = 2 * xecfg->ctxlen + xecfg->interhunkctxlen;
+	long max_ignorable = xecfg->ctxlen;
+	int interesting = 1;

-	for (xchp = xscr, xch = xscr->next; xch; xchp = xch, xch = xch->next)
-		if (xch->i1 - (xchp->i1 + xchp->chg1) > max_common)
+	/* remove ignorable changes that are too far before other changes */
+	for (xchp = *xscr; xchp && xchp->ignore; xchp = xchp->next) {
+		xch = xchp->next;
+
+		if (xch == NULL ||
+		    xch->i1 - (xchp->i1 + xchp->chg1) >= max_ignorable)
+			*xscr = xch;
+	}
+
+	if (*xscr == NULL)
+		return NULL;
+
+	lxch = *xscr;
+
+	for (xchp = *xscr, xch = xchp->next; xch; xchp = xch, xch = xch->next) {
+		long distance = xch->i1 - (xchp->i1 + xchp->chg1);
+		if (distance > max_common)
 			break;

-	return xchp;
+		if (distance < max_ignorable && (!xch->ignore || interesting)) {
+			lxch = xch;
+			interesting = 1;
+		} else if (!interesting) {
+			if (xch->i1 - (lxch->i1 + lxch->chg1) < max_common)
+				continue;
+			else
+				break;
+		} else if (!xch->ignore) {
+			lxch = xch;
+		} else {
+			interesting = 0;
+		}
+	}
+
+	return lxch;
 }


@@ -139,7 +172,9 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		return xdl_emit_common(xe, xscr, ecb, xecfg);

 	for (xch = xscr; xch; xch = xche->next) {
-		xche = xdl_get_hunk(xch, xecfg);
+		xche = xdl_get_hunk(&xch, xecfg);
+		if (!xch)
+			break;

 		s1 = XDL_MAX(xch->i1 - xecfg->ctxlen, 0);
 		s2 = XDL_MAX(xch->i2 - xecfg->ctxlen, 0);
diff --git a/xdiff/xemit.h b/xdiff/xemit.h
index c2e2e83..d297107 100644
--- a/xdiff/xemit.h
+++ b/xdiff/xemit.h
@@ -27,7 +27,7 @@
 typedef int (*emit_func_t)(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			   xdemitconf_t const *xecfg);

-xdchange_t *xdl_get_hunk(xdchange_t *xscr, xdemitconf_t const *xecfg);
+xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg);
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg);

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 9504eae..62cb23d 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -143,6 +143,19 @@ long xdl_guess_lines(mmfile_t *mf, long sample) {
 	return nl + 1;
 }

+int xdl_blankline(const char *line, long size, long flags)
+{
+	long i;
+
+	if (!(flags & XDF_WHITESPACE_FLAGS))
+		return (size <= 1);
+
+	for (i = 0; i < size && XDL_ISSPACE(line[i]); i++)
+		;
+
+	return (i == size);
+}
+
 int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 {
 	int i1, i2;
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index ad1428e..4646ce5 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -32,6 +32,7 @@ int xdl_cha_init(chastore_t *cha, long isize, long icount);
 void xdl_cha_free(chastore_t *cha);
 void *xdl_cha_alloc(chastore_t *cha);
 long xdl_guess_lines(mmfile_t *mf, long sample);
+int xdl_blankline(const char *line, long size, long flags);
 int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags);
 unsigned long xdl_hash_record(char const **data, char const *top, long flags);
 unsigned int xdl_hashbits(unsigned int size);
--
1.7.9.5
