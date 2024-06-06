Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8DA13AA48
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662078; cv=none; b=jx7pxjxLOO3N6aiyEVb9v3/KHxyV6pydtRWhT6OHQoQMijNjW5SNd2iYLFJ0cwssgBdeovoTN0kZrL0EkYPztuwk0z/n6TtTvl+UI6COuC4LllVYgKZJhZb3BkGFH8bGrtng5L1gSj/mNUXsdwxMwAiP1GOx/2bJHok6adNWOIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662078; c=relaxed/simple;
	bh=U42q475rM8MrVl/DjB1zvCEujtTgNSU33LmnzaPVb4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpP4RhtJnpJ3M2ZUUpdqkU9+ezV4xq0ze+hBgty5cJduvZEzGlx1fFv5HMsTBhOBlHyxSVIrHVEyOnkUxECKQYzKuoXs32+Onvm6dh7438URGwAzrRhs3YrE3/2AaQnE2ZtNPt1MPXQuGhjdVoQ2JB8VaHpK8SblPEYVTjteWKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11203 invoked by uid 109); 6 Jun 2024 08:21:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Jun 2024 08:21:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6653 invoked by uid 111); 6 Jun 2024 08:21:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Jun 2024 04:21:12 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 6 Jun 2024 04:21:14 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH 1/2] am: add explicit "--retry" option
Message-ID: <20240606082114.GA1167215@coredump.intra.peff.net>
References: <20240606081724.GA1166769@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240606081724.GA1166769@coredump.intra.peff.net>

After a patch fails, you can ask "git am" to try applying it again with
new options by running without any of the resume options. E.g.:

  git am <patch
  # oops, it failed; let's try again
  git am --3way

But since this second command has no explicit resume option (like
"--continue"), it looks just like an invocation to read a fresh patch
from stdin. To avoid confusing the two cases, there are some heuristics,
courtesy of 8d18550318 (builtin-am: reject patches when there's a
session in progress, 2015-08-04):

	if (in_progress) {
		/*
		 * Catch user error to feed us patches when there is a session
		 * in progress:
		 *
		 * 1. mbox path(s) are provided on the command-line.
		 * 2. stdin is not a tty: the user is trying to feed us a patch
		 *    from standard input. This is somewhat unreliable -- stdin
		 *    could be /dev/null for example and the caller did not
		 *    intend to feed us a patch but wanted to continue
		 *    unattended.
		 */
		if (argc || (resume_mode == RESUME_FALSE && !isatty(0)))
			die(_("previous rebase directory %s still exists but mbox given."),
				state.dir);

		if (resume_mode == RESUME_FALSE)
			resume_mode = RESUME_APPLY;
		[...]

So if no resume command is given, then we require that stdin be a tty,
and otherwise complain about (potentially) receiving an mbox on stdin.
But of course you might not actually have a terminal available! And
sadly there is no explicit way to hit this same code path; this is the
only place that sets RESUME_APPLY. So you're stuck, and scripts like our
test suite have to bend over backwards to create a pseudo-tty.

Let's provide an explicit option to trigger this mode. The code turns
out to be quite simple; just setting "resume_mode" to RESUME_FALSE is
enough to dodge the tty check, and then our state is the same as it
would be with the heuristic case (which we'll continue to allow).

When we don't have a session in progress, there's already code to
complain when resume_mode is set (but we'll add a new test to cover
that).

To test the new option, we'll convert the existing tests that rely on
the fake stdin tty. That lets us test them on more platforms, and will
let us simplify test_terminal a bit in a future patch.

It does, however, mean we're not testing the tty heuristic at all.

Signed-off-by: Jeff King <peff@peff.net>
---
I think even without the test-terminal cleanup, this is a good thing.
Any time there is a heuristic like isatty(), we should have a way for
the user to be more explicit about what they want().

Do we are about losing the testing of the tty heuristic?

 Documentation/git-am.txt           |  8 +++++++-
 builtin/am.c                       |  3 +++
 t/t4153-am-resume-override-opts.sh | 14 +++++++++-----
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 624a6e6fe4..69d5cc9f21 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 	 [--quoted-cr=<action>]
 	 [--empty=(stop|drop|keep)]
 	 [(<mbox> | <Maildir>)...]
-'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)] | --allow-empty)
+'git am' (--continue | --skip | --abort | --quit | --retry | --show-current-patch[=(diff|raw)] | --allow-empty)
 
 DESCRIPTION
 -----------
@@ -208,6 +208,12 @@ Valid <action> for the `--whitespace` option are:
 	Abort the patching operation but keep HEAD and the index
 	untouched.
 
+--retry::
+	Try to apply the last conflicting patch again. This is generally
+	only useful for passing extra options to the retry attempt
+	(e.g., `--3way`), since otherwise you'll just see the same
+	failure again.
+
 --show-current-patch[=(diff|raw)]::
 	Show the message at which `git am` has stopped due to
 	conflicts.  If `raw` is specified, show the raw contents of
diff --git a/builtin/am.c b/builtin/am.c
index 36839029d2..926592691a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2393,6 +2393,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		  N_("show the patch being applied"),
 		  PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 		  parse_opt_show_current_patch, RESUME_SHOW_PATCH_RAW },
+		OPT_CMDMODE(0, "retry", &resume_mode,
+			N_("try to apply current patch again"),
+			RESUME_APPLY),
 		OPT_CMDMODE(0, "allow-empty", &resume_mode,
 			N_("record the empty patch as an empty commit"),
 			RESUME_ALLOW_EMPTY),
diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-override-opts.sh
index 4add7c7757..a32cec42aa 100755
--- a/t/t4153-am-resume-override-opts.sh
+++ b/t/t4153-am-resume-override-opts.sh
@@ -3,7 +3,6 @@
 test_description='git-am command-line options override saved options'
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-terminal.sh
 
 format_patch () {
 	git format-patch --stdout -1 "$1" >"$1".eml
@@ -27,7 +26,12 @@ test_expect_success 'setup' '
 	format_patch side2
 '
 
-test_expect_success TTY '--3way overrides --no-3way' '
+test_expect_success '--retry fails without in-progress operation' '
+	test_must_fail git am --retry 2>err &&
+	test_grep "operation not in progress" err
+'
+
+test_expect_success '--3way overrides --no-3way' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout renamed-file &&
@@ -40,7 +44,7 @@ test_expect_success TTY '--3way overrides --no-3way' '
 
 	# Applying side1 with am --3way will succeed due to the threeway-merge.
 	# Applying side2 will fail as --3way does not apply to it.
-	test_must_fail test_terminal git am --3way </dev/zero &&
+	test_must_fail git am --retry --3way &&
 	test_path_is_dir .git/rebase-apply &&
 	test side1 = "$(cat file2)"
 '
@@ -84,7 +88,7 @@ test_expect_success '--signoff overrides --no-signoff' '
 	test $(git cat-file commit HEAD | grep -c "Signed-off-by:") -eq 0
 '
 
-test_expect_success TTY '--reject overrides --no-reject' '
+test_expect_success '--reject overrides --no-reject' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout first &&
@@ -94,7 +98,7 @@ test_expect_success TTY '--reject overrides --no-reject' '
 	test_path_is_dir .git/rebase-apply &&
 	test_path_is_missing file.rej &&
 
-	test_must_fail test_terminal git am --reject </dev/zero &&
+	test_must_fail git am --retry --reject </dev/zero &&
 	test_path_is_dir .git/rebase-apply &&
 	test_path_is_file file.rej
 '
-- 
2.45.2.817.g6f0d0f2a6c

