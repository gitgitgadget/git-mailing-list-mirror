From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 2/2] bisect: make bisection refs per-worktree
Date: Tue, 11 Aug 2015 00:56:19 -0400
Message-ID: <1439268979-10456-2-git-send-email-dturner@twopensource.com>
References: <1439268979-10456-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com, mhagger@alum.mit.edu,
	Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Aug 11 06:56:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP1cE-0000nS-45
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 06:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbbHKE4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 00:56:41 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34605 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbbHKE4j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 00:56:39 -0400
Received: by qgeg42 with SMTP id g42so96106881qge.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 21:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uRMekDzK8fKndgqKCXGt+c4Ui6NhJFLGEdTpEV6Eouw=;
        b=BNgm4IVtsUZEYWiJfPW5P7eeBI/Bb4t1VaBC5Vdwsb1jjE6EBOAvVS1nnysdOioAcG
         O2mpsUatiecIeij+bld0Be0FgGuLkFP0KN53YJkOEBrQVJQTKwsidEdkLnxIfDwEiofZ
         H5gfyB210xf2qlQ+Kz7ygmK0IRmhJ6MMYcaQbMYfZ1Bgp38RflDF/+1ArGxDUNQcakFm
         +cAG1BSiBd5nPVZXdbWdOK3mRz5zn2nI/Atss2QzDkapI+fYRXfX8CvDKPAeLqhrWkif
         3eJVlhox0eH+qvFeQ60etkjjsIFE5oEtHt9SqRwXA2+niNq+yLleHTirV+ipVI6KzRoC
         I54g==
X-Gm-Message-State: ALoCoQnFy4cmneU/GufHz8bzQJgYa0FBX5jfJ9gqVXzNy8vFMSul9wEXv4JR4UqG/6mlAs9vSIbM
X-Received: by 10.141.28.200 with SMTP id f191mr47557913qhe.52.1439268999120;
        Mon, 10 Aug 2015 21:56:39 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id z33sm495417qkg.44.2015.08.10.21.56.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Aug 2015 21:56:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1439268979-10456-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275672>

Using the new refs/worktree/ refs, make bisection per-worktree.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-bisect.txt       |  4 ++--
 Documentation/rev-list-options.txt | 14 +++++++-------
 bisect.c                           |  2 +-
 builtin/rev-parse.c                |  6 ++++--
 revision.c                         |  2 +-
 t/t6030-bisect-porcelain.sh        | 20 ++++++++++----------
 6 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index e97f2de..f0c52d1 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -82,7 +82,7 @@ to ask for the next commit that needs testing.
 
 Eventually there will be no more revisions left to inspect, and the
 command will print out a description of the first bad commit. The
-reference `refs/bisect/bad` will be left pointing at that commit.
+reference `refs/worktree/bisect/bad` will be left pointing at that commit.
 
 
 Bisect reset
@@ -373,7 +373,7 @@ on a single line.
 ------------
 $ git bisect start HEAD <known-good-commit> [ <boundary-commit> ... ] --no-checkout
 $ git bisect run sh -c '
-	GOOD=$(git for-each-ref "--format=%(objectname)" refs/bisect/good-*) &&
+	GOOD=$(git for-each-ref "--format=%(objectname)" refs/worktree/bisect/good-*) &&
 	git rev-list --objects BISECT_HEAD --not $GOOD >tmp.$$ &&
 	git pack-objects --stdout >/dev/null <tmp.$$
 	rc=$?
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a9b808f..1175960 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -183,9 +183,9 @@ explicitly.
 
 ifndef::git-rev-list[]
 --bisect::
-	Pretend as if the bad bisection ref `refs/bisect/bad`
+	Pretend as if the bad bisection ref `refs/worktree/bisect/bad`
 	was listed and as if it was followed by `--not` and the good
-	bisection refs `refs/bisect/good-*` on the command
+	bisection refs `refs/worktree/bisect/good-*` on the command
 	line. Cannot be combined with --first-parent.
 endif::git-rev-list[]
 
@@ -548,10 +548,10 @@ Bisection Helpers
 --bisect::
 	Limit output to the one commit object which is roughly halfway between
 	included and excluded commits. Note that the bad bisection ref
-	`refs/bisect/bad` is added to the included commits (if it
-	exists) and the good bisection refs `refs/bisect/good-*` are
+	`refs/worktree/bisect/bad` is added to the included commits (if it
+	exists) and the good bisection refs `refs/worktree/bisect/good-*` are
 	added to the excluded commits (if they exist). Thus, supposing there
-	are no refs in `refs/bisect/`, if
+	are no refs in `refs/worktree/bisect/`, if
 +
 -----------------------------------------------------------------------
 	$ git rev-list --bisect foo ^bar ^baz
@@ -571,7 +571,7 @@ one. Cannot be combined with --first-parent.
 
 --bisect-vars::
 	This calculates the same as `--bisect`, except that refs in
-	`refs/bisect/` are not used, and except that this outputs
+	`refs/worktree/bisect/` are not used, and except that this outputs
 	text ready to be eval'ed by the shell. These lines will assign the
 	name of the midpoint revision to the variable `bisect_rev`, and the
 	expected number of commits to be tested after `bisect_rev` is tested
@@ -584,7 +584,7 @@ one. Cannot be combined with --first-parent.
 --bisect-all::
 	This outputs all the commit objects between the included and excluded
 	commits, ordered by their distance to the included and excluded
-	commits. Refs in `refs/bisect/` are not used. The farthest
+	commits. Refs in `refs/worktree/bisect/` are not used. The farthest
 	from them is displayed first. (This is the only one displayed by
 	`--bisect`.)
 +
diff --git a/bisect.c b/bisect.c
index 33ac88d..dbe3461 100644
--- a/bisect.c
+++ b/bisect.c
@@ -425,7 +425,7 @@ static int register_ref(const char *refname, const struct object_id *oid,
 
 static int read_bisect_refs(void)
 {
-	return for_each_ref_in("refs/bisect/", register_ref, NULL);
+	return for_each_ref_in("refs/worktree/bisect/", register_ref, NULL);
 }
 
 static void read_bisect_paths(struct argv_array *array)
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 02d747d..3240ddf 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -663,8 +663,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
-				for_each_ref_in("refs/bisect/bad", show_reference, NULL);
-				for_each_ref_in("refs/bisect/good", anti_reference, NULL);
+				for_each_ref_in("refs/worktree/bisect/bad",
+						show_reference, NULL);
+				for_each_ref_in("refs/worktree/bisect/good",
+						anti_reference, NULL);
 				continue;
 			}
 			if (starts_with(arg, "--branches=")) {
diff --git a/revision.c b/revision.c
index b6b2cf7..974a11f 100644
--- a/revision.c
+++ b/revision.c
@@ -2084,7 +2084,7 @@ extern void read_bisect_terms(const char **bad, const char **good);
 static int for_each_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data, const char *term) {
 	struct strbuf bisect_refs = STRBUF_INIT;
 	int status;
-	strbuf_addf(&bisect_refs, "refs/bisect/%s", term);
+	strbuf_addf(&bisect_refs, "refs/worktree/bisect/%s", term);
 	status = for_each_ref_in_submodule(submodule, bisect_refs.buf, fn, cb_data);
 	strbuf_release(&bisect_refs);
 	return status;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 9e2c203..bfd5463 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -68,7 +68,7 @@ test_expect_success 'bisect fails if given any junk instead of revs' '
 	git bisect reset &&
 	test_must_fail git bisect start foo $HASH1 -- &&
 	test_must_fail git bisect start $HASH4 $HASH1 bar -- &&
-	test -z "$(git for-each-ref "refs/bisect/*")" &&
+	test -z "$(git for-each-ref "refs/worktree/bisect/*")" &&
 	test -z "$(ls .git/BISECT_* 2>/dev/null)" &&
 	git bisect start &&
 	test_must_fail git bisect good foo $HASH1 &&
@@ -77,7 +77,7 @@ test_expect_success 'bisect fails if given any junk instead of revs' '
 	test_must_fail git bisect bad $HASH3 $HASH4 &&
 	test_must_fail git bisect skip bar $HASH3 &&
 	test_must_fail git bisect skip $HASH1 foo &&
-	test -z "$(git for-each-ref "refs/bisect/*")" &&
+	test -z "$(git for-each-ref "refs/worktree/bisect/*")" &&
 	git bisect good $HASH1 &&
 	git bisect bad $HASH4
 '
@@ -115,7 +115,7 @@ test_expect_success 'bisect reset removes packed refs' '
 	git pack-refs --all --prune &&
 	git bisect next &&
 	git bisect reset &&
-	test -z "$(git for-each-ref "refs/bisect/*")" &&
+	test -z "$(git for-each-ref "refs/worktree/bisect/*")" &&
 	test -z "$(git for-each-ref "refs/heads/bisect")"
 '
 
@@ -126,7 +126,7 @@ test_expect_success 'bisect reset removes bisect state after --no-checkout' '
 	git bisect bad $HASH3 &&
 	git bisect next &&
 	git bisect reset &&
-	test -z "$(git for-each-ref "refs/bisect/*")" &&
+	test -z "$(git for-each-ref "refs/worktree/bisect/*")" &&
 	test -z "$(git for-each-ref "refs/heads/bisect")" &&
 	test -z "$(git for-each-ref "BISECT_HEAD")"
 '
@@ -176,7 +176,7 @@ test_expect_success 'bisect start: no ".git/BISECT_START" if checkout error' '
 	git branch > branch.output &&
 	grep "* other" branch.output > /dev/null &&
 	test_must_fail test -e .git/BISECT_START &&
-	test -z "$(git for-each-ref "refs/bisect/*")" &&
+	test -z "$(git for-each-ref "refs/worktree/bisect/*")" &&
 	git checkout HEAD hello
 '
 
@@ -671,7 +671,7 @@ test_expect_success 'bisect: --no-checkout - target before breakage' '
 	git bisect bad BISECT_HEAD &&
 	check_same BROKEN_HASH5 BISECT_HEAD &&
 	git bisect bad BISECT_HEAD &&
-	check_same BROKEN_HASH5 bisect/bad &&
+	check_same BROKEN_HASH5 refs/worktree/bisect/bad &&
 	git bisect reset
 '
 
@@ -682,7 +682,7 @@ test_expect_success 'bisect: --no-checkout - target in breakage' '
 	git bisect bad BISECT_HEAD &&
 	check_same BROKEN_HASH5 BISECT_HEAD &&
 	git bisect good BISECT_HEAD &&
-	check_same BROKEN_HASH6 bisect/bad &&
+	check_same BROKEN_HASH6 refs/worktree/bisect/bad &&
 	git bisect reset
 '
 
@@ -693,7 +693,7 @@ test_expect_success 'bisect: --no-checkout - target after breakage' '
 	git bisect good BISECT_HEAD &&
 	check_same BROKEN_HASH8 BISECT_HEAD &&
 	git bisect good BISECT_HEAD &&
-	check_same BROKEN_HASH9 bisect/bad &&
+	check_same BROKEN_HASH9 refs/worktree/bisect/bad &&
 	git bisect reset
 '
 
@@ -702,13 +702,13 @@ test_expect_success 'bisect: demonstrate identification of damage boundary' "
 	git checkout broken &&
 	git bisect start broken master --no-checkout &&
 	git bisect run \"\$SHELL_PATH\" -c '
-		GOOD=\$(git for-each-ref \"--format=%(objectname)\" refs/bisect/good-*) &&
+		GOOD=\$(git for-each-ref \"--format=%(objectname)\" refs/worktree/bisect/good-*) &&
 		git rev-list --objects BISECT_HEAD --not \$GOOD >tmp.\$\$ &&
 		git pack-objects --stdout >/dev/null < tmp.\$\$
 		rc=\$?
 		rm -f tmp.\$\$
 		test \$rc = 0' &&
-	check_same BROKEN_HASH6 bisect/bad &&
+	check_same BROKEN_HASH6 refs/worktree/bisect/bad &&
 	git bisect reset
 "
 
-- 
2.0.4.315.gad8727a-twtrsrc
