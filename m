From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] apply: compute patch->def_name correctly under -p0
Date: Sat, 25 Aug 2012 00:10:34 -0700
Message-ID: <7vwr0nwiol.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@linux-foundation.org,
	Colin McCabe <cmccabe@alumni.cmu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 25 09:10:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5AW5-0006BO-Lm
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 09:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083Ab2HYHKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 03:10:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36850 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591Ab2HYHKi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 03:10:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38B7D438B;
	Sat, 25 Aug 2012 03:10:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=w
	xKL5ihYsNPEZCn3VQejI+089ps=; b=EFeCH91ZkrpnLCNSUlv/V7t2Xk4Kcz2qe
	PA7OiTeLUFuwvtO46McUNPEjyQPMLH1xNLSmUu7ExzH3hPNlR9QUoXVI5vrdSfKi
	jgFalZq8O/c0INSQGIB/XEaxVUZUceq62LzcUuNSf+HYvwKg7fVEPjqei2MKQT5A
	+zoxlSb5tM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=Ic9L0hFgMkxCccJ6CloZ7qLBTTBe1l9Z2yqcMBDXlt8nVVtPlOMSILLc
	LL3PtUQfNHvDspYXEGxGQJBBiuybxmLfob2egupc5+l2TvVJh6gARK1u4ALoQk4r
	dggekEJfDAv/NHUYRbmfMCOdtlheP1v2IYwdf9oeNCYyJMJk8ck=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27508438A;
	Sat, 25 Aug 2012 03:10:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F4FC4389; Sat, 25 Aug 2012
 03:10:36 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7AE7B88-EE83-11E1-9725-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204268>

Back when "git apply" was written, we made sure that the user can
skip more than the default number of path components (i.e. 1) by
giving "-p<n>", but the logic for doing so was built around the
notion of "we skip N slashes and stop".  This obviously does not
work well when running under -p0 where we do not want to skip any,
but still want to skip SP/HT that separates the pathnames of
preimage and postimage and want to reject absolute pathnames.

Stop using "stop_at_slash()", and instead introduce a new helper
"skip_tree_prefix()" with similar logic but works correctly even for
the -p0 case.

This is an ancient bug, but has been masked for a long time because
most of the patches are text and have other clues to tell us the
name of the preimage and the postimage.

Noticed by Colin McCabe.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This time, with a test.  The patch is designed to apply to a bit
   older codebase, and won't apply cleanly to 'master', but the
   result of merging it to newer codebase can be seen near the tip
   of 'pu' tonight.

 builtin/apply.c         | 68 +++++++++++++++++++++++++++++++------------------
 t/t4103-apply-binary.sh | 54 ++++++++++++++++++++++++---------------
 2 files changed, 76 insertions(+), 46 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c24dc54..2ad8c48 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1022,15 +1022,23 @@ static int gitdiff_unrecognized(const char *line, struct patch *patch)
 	return -1;
 }
 
-static const char *stop_at_slash(const char *line, int llen)
+/*
+ * Skip p_value leading components from "line"; as we do not accept
+ * absolute paths, return NULL in that case.
+ */
+static const char *skip_tree_prefix(const char *line, int llen)
 {
-	int nslash = p_value;
+	int nslash;
 	int i;
 
+	if (!p_value)
+		return (llen && line[0] == '/') ? NULL : line;
+
+	nslash = p_value;
 	for (i = 0; i < llen; i++) {
 		int ch = line[i];
 		if (ch == '/' && --nslash <= 0)
-			return &line[i];
+			return (i == 0) ? NULL : &line[i + 1];
 	}
 	return NULL;
 }
@@ -1060,12 +1068,11 @@ static char *git_header_name(char *line, int llen)
 		if (unquote_c_style(&first, line, &second))
 			goto free_and_fail1;
 
-		/* advance to the first slash */
-		cp = stop_at_slash(first.buf, first.len);
-		/* we do not accept absolute paths */
-		if (!cp || cp == first.buf)
+		/* strip the a/b prefix including trailing slash */
+		cp = skip_tree_prefix(first.buf, first.len);
+		if (!cp)
 			goto free_and_fail1;
-		strbuf_remove(&first, 0, cp + 1 - first.buf);
+		strbuf_remove(&first, 0, cp - first.buf);
 
 		/*
 		 * second points at one past closing dq of name.
@@ -1079,22 +1086,21 @@ static char *git_header_name(char *line, int llen)
 		if (*second == '"') {
 			if (unquote_c_style(&sp, second, NULL))
 				goto free_and_fail1;
-			cp = stop_at_slash(sp.buf, sp.len);
-			if (!cp || cp == sp.buf)
+			cp = skip_tree_prefix(sp.buf, sp.len);
+			if (!cp)
 				goto free_and_fail1;
 			/* They must match, otherwise ignore */
-			if (strcmp(cp + 1, first.buf))
+			if (strcmp(cp, first.buf))
 				goto free_and_fail1;
 			strbuf_release(&sp);
 			return strbuf_detach(&first, NULL);
 		}
 
 		/* unquoted second */
-		cp = stop_at_slash(second, line + llen - second);
-		if (!cp || cp == second)
+		cp = skip_tree_prefix(second, line + llen - second);
+		if (!cp)
 			goto free_and_fail1;
-		cp++;
-		if (line + llen - cp != first.len + 1 ||
+		if (line + llen - cp != first.len ||
 		    memcmp(first.buf, cp, first.len))
 			goto free_and_fail1;
 		return strbuf_detach(&first, NULL);
@@ -1106,10 +1112,9 @@ static char *git_header_name(char *line, int llen)
 	}
 
 	/* unquoted first name */
-	name = stop_at_slash(line, llen);
-	if (!name || name == line)
+	name = skip_tree_prefix(line, llen);
+	if (!name)
 		return NULL;
-	name++;
 
 	/*
 	 * since the first name is unquoted, a dq if exists must be
@@ -1123,10 +1128,9 @@ static char *git_header_name(char *line, int llen)
 			if (unquote_c_style(&sp, second, NULL))
 				goto free_and_fail2;
 
-			np = stop_at_slash(sp.buf, sp.len);
-			if (!np || np == sp.buf)
+			np = skip_tree_prefix(sp.buf, sp.len);
+			if (!np)
 				goto free_and_fail2;
-			np++;
 
 			len = sp.buf + sp.len - np;
 			if (len < second - name &&
@@ -1158,13 +1162,27 @@ static char *git_header_name(char *line, int llen)
 		case '\n':
 			return NULL;
 		case '\t': case ' ':
-			second = stop_at_slash(name + len, line_len - len);
+			/*
+			 * Is this the separator between the preimage
+			 * and the postimage pathname?  Again, we are
+			 * only interested in the case where there is
+			 * no rename, as this is only to set def_name
+			 * and a rename patch has the names elsewhere
+			 * in an unambiguous form.
+			 */
+			if (!name[len + 1])
+				return NULL; /* no postimage name */
+			second = skip_tree_prefix(name + len + 1,
+						  line_len - (len + 1));
 			if (!second)
 				return NULL;
-			second++;
-			if (second[len] == '\n' && !strncmp(name, second, len)) {
+			/*
+			 * Does len bytes starting at "name" and "second"
+			 * (that are separated by one HT or SP we just
+			 * found) exactly match?
+			 */
+			if (second[len] == '\n' && !strncmp(name, second, len))
 				return xmemdupz(name, len);
-			}
 		}
 	}
 }
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index dbbf56c..1b420e3 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -8,30 +8,28 @@ test_description='git apply handling binary patches
 '
 . ./test-lib.sh
 
-# setup
-
-cat >file1 <<EOF
-A quick brown fox jumps over the lazy dog.
-A tiny little penguin runs around in circles.
-There is a flag with Linux written on it.
-A slow black-and-white panda just sits there,
-munching on his bamboo.
-EOF
-cat file1 >file2
-cat file1 >file4
-
-test_expect_success 'setup' "
+test_expect_success 'setup' '
+	cat >file1 <<-\EOF &&
+	A quick brown fox jumps over the lazy dog.
+	A tiny little penguin runs around in circles.
+	There is a flag with Linux written on it.
+	A slow black-and-white panda just sits there,
+	munching on his bamboo.
+	EOF
+	cat file1 >file2 &&
+	cat file1 >file4 &&
+
 	git update-index --add --remove file1 file2 file4 &&
-	git commit -m 'Initial Version' 2>/dev/null &&
+	git commit -m "Initial Version" 2>/dev/null &&
 
 	git checkout -b binary &&
-	perl -pe 'y/x/\000/' <file1 >file3 &&
+	perl -pe "y/x/\000/" <file1 >file3 &&
 	cat file3 >file4 &&
 	git add file2 &&
-	perl -pe 'y/\000/v/' <file3 >file1 &&
+	perl -pe "y/\000/v/" <file3 >file1 &&
 	rm -f file2 &&
 	git update-index --add --remove file1 file2 file3 file4 &&
-	git commit -m 'Second Version' &&
+	git commit -m "Second Version" &&
 
 	git diff-tree -p master binary >B.diff &&
 	git diff-tree -p -C master binary >C.diff &&
@@ -42,17 +40,25 @@ test_expect_success 'setup' "
 	git diff-tree -p --full-index master binary >B-index.diff &&
 	git diff-tree -p -C --full-index master binary >C-index.diff &&
 
+	git diff-tree -p --binary --no-prefix master binary -- file3 >B0.diff &&
+
 	git init other-repo &&
-	(cd other-repo &&
-	 git fetch .. master &&
-	 git reset --hard FETCH_HEAD
+	(
+		cd other-repo &&
+		git fetch .. master &&
+		git reset --hard FETCH_HEAD
 	)
-"
+'
 
 test_expect_success 'stat binary diff -- should not fail.' \
 	'git checkout master &&
 	 git apply --stat --summary B.diff'
 
+test_expect_success 'stat binary -p0 diff -- should not fail.' '
+	 git checkout master &&
+	 git apply --stat -p0 B0.diff
+'
+
 test_expect_success 'stat binary diff (copy) -- should not fail.' \
 	'git checkout master &&
 	 git apply --stat --summary C.diff'
@@ -143,4 +149,10 @@ test_expect_success 'apply binary diff (copy).' \
 	 git apply --allow-binary-replacement --index CF.diff &&
 	 test -z "$(git diff --name-status binary)"'
 
+test_expect_success 'apply binary -p0 diff' '
+	do_reset &&
+	git apply -p0 --index B0.diff &&
+	test -z "$(git diff --name-status binary -- file3)"
+'
+
 test_done
-- 
1.7.12.252.gef4e272
