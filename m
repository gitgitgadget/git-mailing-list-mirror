From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 12/13] git-apply --whitespace=fix: fix whitespace fuzz introduced by previous run
Date: Sat,  2 Feb 2008 02:54:18 -0800
Message-ID: <1201949659-27725-13-git-send-email-gitster@pobox.com>
References: <1201949659-27725-1-git-send-email-gitster@pobox.com>
 <1201949659-27725-2-git-send-email-gitster@pobox.com>
 <1201949659-27725-3-git-send-email-gitster@pobox.com>
 <1201949659-27725-4-git-send-email-gitster@pobox.com>
 <1201949659-27725-5-git-send-email-gitster@pobox.com>
 <1201949659-27725-6-git-send-email-gitster@pobox.com>
 <1201949659-27725-7-git-send-email-gitster@pobox.com>
 <1201949659-27725-8-git-send-email-gitster@pobox.com>
 <1201949659-27725-9-git-send-email-gitster@pobox.com>
 <1201949659-27725-10-git-send-email-gitster@pobox.com>
 <1201949659-27725-11-git-send-email-gitster@pobox.com>
 <1201949659-27725-12-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 11:56:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLG2u-0005Ue-Gu
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 11:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763449AbYBBKzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 05:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763299AbYBBKzJ
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 05:55:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43767 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762915AbYBBKzC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 05:55:02 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A3FB50F9
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:55:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 117E650F8
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:54:59 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.g41ac4
In-Reply-To: <1201949659-27725-12-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72258>

When you have more than one patch series, an earlier one of which
tries to introduce whitespace breakages and a later one of which
has such a new line in its context, "git-apply --whitespace=fix"
will apply and fix the whitespace breakages in the earlier one,
making the resulting file not to match the context of the later
patch.

A short demonstration is in the new test, t4125.

For example, suppose the first patch is:

    diff a/hello.txt b/hello.txt
    --- a/hello.txt
    +++ b/hello.txt
    @@ -20,3 +20,3 @@
     Hello world.$
    -How Are you$
    -Today?$
    +How are you $
    +today? $

to fix broken case in the string, but it introduces unwanted
trailing whitespaces to the result (pretend you are looking at
"cat -e" output of the patch --- '$' signs are not in the patch
but are shown to make the EOL stand out).  And the second patch
is to change the wording of the greeting further:

    diff a/hello.txt b/hello.txt
    --- a/hello.txt
    +++ b/hello.txt
    @@ -18,5 +18,5 @@
     Greetings $

    -Hello world.$
    +Hello, everybody. $
     How are you $
    -today? $
    +these days? $

If you apply the first one with --whitespace=fix, you will get
this as the result:

    Hello world.$
    How are you$
    today?$

and this does not match the preimage of the second patch, which
demands extra whitespace after "How are you" and "today?".

This series is about teaching "git apply --whitespace=fix" to
cope with this situation better.  If the patch does not apply,
it rewrites the second patch like this and retries:

    diff a/hello.txt b/hello.txt
    --- a/hello.txt
    +++ b/hello.txt
    @@ -18,5 +18,5 @@
     Greetings$

    -Hello world.$
    +Hello, everybody.$
     How are you$
    -today?$
    +these days?$

This is done by rewriting the preimage lines in the hunk
(i.e. the lines that begin with ' ' or '-'), using the same
whitespace fixing rules as it is using to apply the patches, so
that it can notice what it did to the previous ones in the
series.

A careful reader may notice that the first patch in the example
did not touch the "Greetings" line, so the trailing whitespace
that is in the original preimage of the second patch is not from
the series.  Is rewriting this context line a problem?

If you think about it, you will realize that the reason for the
difference is because the submitter's tree was based on an
earlier version of the file that had whitespaces wrong on that
"Greetings" line, and the change that introduced the "Greetings"
line was added independently of this two-patch series to our
tree already with an earlier "git apply --whitespace=fix".

So it may appear this logic is rewriting too much, it is not
so.  It is just rewriting what we would have rewritten in the
past.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c          |  133 ++++++++++++++++++++++++++++++++++++++++++++--
 t/t4125-apply-ws-fuzz.sh |  103 +++++++++++++++++++++++++++++++++++
 2 files changed, 231 insertions(+), 5 deletions(-)
 create mode 100755 t/t4125-apply-ws-fuzz.sh

diff --git a/builtin-apply.c b/builtin-apply.c
index 5f3c047..fccf4a4 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1516,7 +1516,7 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 }
 
 static int copy_wsfix(char *output, const char *patch, int plen,
-		      unsigned ws_rule)
+		      unsigned ws_rule, int count_error)
 {
 	/*
 	 * plen is number of bytes to be copied from patch, starting
@@ -1604,11 +1604,74 @@ static int copy_wsfix(char *output, const char *patch, int plen,
 	memcpy(output, patch, plen);
 	if (add_nl_to_tail)
 		output[plen++] = '\n';
-	if (fixed)
+	if (fixed && count_error)
 		applied_after_fixing_ws++;
 	return output + plen - buf;
 }
 
+static void update_pre_post_images(struct image *preimage,
+				   struct image *postimage,
+				   char *buf,
+				   size_t len)
+{
+	int i, ctx;
+	char *new, *old, *fixed;
+	struct image fixed_preimage;
+
+	/*
+	 * Update the preimage with whitespace fixes.  Note that we
+	 * are not losing preimage->buf -- apply_one_fragment() will
+	 * free "oldlines".
+	 */
+	prepare_image(&fixed_preimage, buf, len, 1);
+	assert(fixed_preimage.nr == preimage->nr);
+	for (i = 0; i < preimage->nr; i++)
+		fixed_preimage.line[i].flag = preimage->line[i].flag;
+	free(preimage->line_allocated);
+	*preimage = fixed_preimage;
+
+	/*
+	 * Adjust the common context lines in postimage, in place.
+	 * This is possible because whitespace fixing does not make
+	 * the string grow.
+	 */
+	new = old = postimage->buf;
+	fixed = preimage->buf;
+	for (i = ctx = 0; i < postimage->nr; i++) {
+		size_t len = postimage->line[i].len;
+		if (!(postimage->line[i].flag & LINE_COMMON)) {
+			/* an added line -- no counterparts in preimage */
+			memmove(new, old, len);
+			old += len;
+			new += len;
+			continue;
+		}
+
+		/* a common context -- skip it in the original postimage */
+		old += len;
+
+		/* and find the corresponding one in the fixed preimage */
+		while (ctx < preimage->nr &&
+		       !(preimage->line[ctx].flag & LINE_COMMON)) {
+			fixed += preimage->line[ctx].len;
+			ctx++;
+		}
+		if (preimage->nr <= ctx)
+			die("oops");
+
+		/* and copy it in, while fixing the line length */
+		len = preimage->line[ctx].len;
+		memcpy(new, fixed, len);
+		new += len;
+		fixed += len;
+		postimage->line[i].len = len;
+		ctx++;
+	}
+
+	/* Fix the length of the whole thing */
+	postimage->len = new - postimage->buf;
+}
+
 static int match_fragment(struct image *img,
 			  struct image *preimage,
 			  struct image *postimage,
@@ -1618,6 +1681,7 @@ static int match_fragment(struct image *img,
 			  int match_beginning, int match_end)
 {
 	int i;
+	char *fixed_buf, *buf, *orig, *target;
 
 	if (preimage->nr + try_lno > img->nr)
 		return 0;
@@ -1646,10 +1710,68 @@ static int match_fragment(struct image *img,
 	    !memcmp(img->buf + try, preimage->buf, preimage->len))
 		return 1;
 
+	if (ws_error_action != correct_ws_error)
+		return 0;
+
+	/*
+	 * The hunk does not apply byte-by-byte, but the hash says
+	 * it might with whitespace fuzz.
+	 */
+	fixed_buf = xmalloc(preimage->len + 1);
+	buf = fixed_buf;
+	orig = preimage->buf;
+	target = img->buf + try;
+	for (i = 0; i < preimage->nr; i++) {
+		size_t fixlen; /* length after fixing the preimage */
+		size_t oldlen = preimage->line[i].len;
+		size_t tgtlen = img->line[try_lno + i].len;
+		size_t tgtfixlen; /* length after fixing the target line */
+		char tgtfixbuf[1024], *tgtfix;
+		int match;
+
+		/* Try fixing the line in the preimage */
+		fixlen = copy_wsfix(buf, orig, oldlen, ws_rule, 0);
+
+		/* Try fixing the line in the target */
+		if (sizeof(tgtfixbuf) < tgtlen)
+			tgtfix = tgtfixbuf;
+		else
+			tgtfix = xmalloc(tgtlen);
+		tgtfixlen = copy_wsfix(tgtfix, target, tgtlen, ws_rule, 0);
+
+		/*
+		 * If they match, either the preimage was based on
+		 * a version before our tree fixed whitespace breakage,
+		 * or we are lacking a whitespace-fix patch the tree
+		 * the preimage was based on already had (i.e. target
+		 * has whitespace breakage, the preimage doesn't).
+		 * In either case, we are fixing the whitespace breakages
+		 * so we might as well take the fix together with their
+		 * real change.
+		 */
+		match = (tgtfixlen == fixlen && !memcmp(tgtfix, buf, fixlen));
+
+		if (tgtfix != tgtfixbuf)
+			free(tgtfix);
+		if (!match)
+			goto unmatch_exit;
+
+		orig += oldlen;
+		buf += fixlen;
+		target += tgtlen;
+	}
+
 	/*
-	 * NEEDSWORK: We can optionally match fuzzily here, but
-	 * that is for a later round.
+	 * Yes, the preimage is based on an older version that still
+	 * has whitespace breakages unfixed, and fixing them makes the
+	 * hunk match.  Update the context lines in the postimage.
 	 */
+	update_pre_post_images(preimage, postimage,
+			       fixed_buf, buf - fixed_buf);
+	return 1;
+
+ unmatch_exit:
+	free(fixed_buf);
 	return 0;
 }
 
@@ -1871,7 +1993,8 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 				added = plen;
 			}
 			else {
-				added = copy_wsfix(new, patch + 1, plen, ws_rule);
+				added = copy_wsfix(new, patch + 1, plen,
+						   ws_rule, 1);
 			}
 			add_line_info(&postimage, new, added,
 				      (first == '+' ? 0 : LINE_COMMON));
diff --git a/t/t4125-apply-ws-fuzz.sh b/t/t4125-apply-ws-fuzz.sh
new file mode 100755
index 0000000..d6f15be
--- /dev/null
+++ b/t/t4125-apply-ws-fuzz.sh
@@ -0,0 +1,103 @@
+#!/bin/sh
+
+test_description='applying patch that has broken whitespaces in context'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	>file &&
+	git add file &&
+
+	# file-0 is full of whitespace breakages
+	for l in a bb c d eeee f ggg h
+	do
+		echo "$l "
+	done >file-0 &&
+
+	# patch-0 creates a whitespace broken file
+	cat file-0 >file &&
+	git diff >patch-0 &&
+	git add file &&
+
+	# file-1 is still full of whitespace breakages,
+	# but has one line updated, without fixing any
+	# whitespaces.
+	# patch-1 records that change.
+	sed -e "s/d/D/" file-0 >file-1 &&
+	cat file-1 >file &&
+	git diff >patch-1 &&
+
+	# patch-all is the effect of both patch-0 and patch-1
+	>file &&
+	git add file &&
+	cat file-1 >file &&
+	git diff >patch-all &&
+
+	# patch-2 is the same as patch-1 but is based
+	# on a version that already has whitespace fixed,
+	# and does not introduce whitespace breakages.
+	sed -e "s/ $//" patch-1 >patch-2 &&
+
+	# If all whitespace breakages are fixed the contents
+	# should look like file-fixed
+	sed -e "s/ $//" file-1 >file-fixed
+
+'
+
+test_expect_success nofix '
+
+	>file &&
+	git add file &&
+
+	# Baseline.  Applying without fixing any whitespace
+	# breakages.
+	git apply --whitespace=nowarn patch-0 &&
+	git apply --whitespace=nowarn patch-1 &&
+
+	# The result should obviously match.
+	diff -u file-1 file
+'
+
+test_expect_success 'withfix (forward)' '
+
+	>file &&
+	git add file &&
+
+	# The first application will munge the context lines
+	# the second patch depends on.  We should be able to
+	# adjust and still apply.
+	git apply --whitespace=fix patch-0 &&
+	git apply --whitespace=fix patch-1 &&
+
+	diff -u file-fixed file
+'
+
+test_expect_success 'withfix (backward)' '
+
+	>file &&
+	git add file &&
+
+	# Now we have a whitespace breakages on our side.
+	git apply --whitespace=nowarn patch-0 &&
+
+	# And somebody sends in a patch based on image
+	# with whitespace already fixed.
+	git apply --whitespace=fix patch-2 &&
+
+	# The result should accept the whitespace fixed
+	# postimage.  But the line with "h" is beyond context
+	# horizon and left unfixed.
+
+	sed -e /h/d file-fixed >fixed-head &&
+	sed -e /h/d file >file-head &&
+	diff -u fixed-head file-head &&
+
+	sed -n -e /h/p file-fixed >fixed-tail &&
+	sed -n -e /h/p file >file-tail &&
+
+	! diff -u fixed-tail file-tail
+
+'
+
+test_done
-- 
1.5.4.2.g41ac4
