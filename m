Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B96022F757
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349756; cv=none; b=E0CRxpAAbxdkx5MqANx9Uohb02tH/PdOlHgBf9WRQ6S9rMqE/+uN/L3c5XA/y1Q809KUFjc3HxRa6eHzowrwvijecX/ghnitaB9Y/xUK8LaaFJ3XZbJtBKvM5dRmEqEk02qlWBbDBgSmt3uaejQGALlF+2y3Fx8NZJjYbhgjIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349756; c=relaxed/simple;
	bh=RXXePypX7RuSh81fHbg6BIyoagG8ZigXj7QPuvuWofw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4L0Dumz3BdVadnlqs/drM6wK2iRufNT+5S0X2tP26JPr52nSCQk/EO9aXhfJsyZmIWkCyrJM7URkrlQc34rDrECGQlCbeY7NDmK2oTK6WfvSRyzszjuZEWnvECQebWm6IzVCySi0+RVdsq1okBqnBMr5cZgkMzz5CrE02Sj/V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PgZcdfLT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PgZcdfLT"
Received: (qmail 21819 invoked by uid 109); 8 Sep 2025 16:42:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RXXePypX7RuSh81fHbg6BIyoagG8ZigXj7QPuvuWofw=; b=PgZcdfLTjVfRbqqJja1GVCjzanN3WDYi8sHJpZXN2zYRKqysZ6idgZwnGhkahHGkcIvkpqirJwp05lwYg2ROPVauBdNg7JhytJrzAZ6JUd3Mzp3ucAnZr/8Ny7M5DuBPUiCqywp04gknr+UmL7NfpIKMa0ReGodEZ+JVxBOFxytahlbw6HFJKpAApQWzv2WND4ca+QYN0s4QenIoWdJtsCJ1pjyKBq3cTGUMtTOC21FYf7ZpnkLjmg8afBIa3o4n8aj8DjQsLv3nEYeuQjIvxdJ8VbvwNaznINmvPciKhaHW6enABGkqcT3UQ6BoG6xLu9t4S302DpponF+GnQpNFA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Sep 2025 16:42:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 36160 invoked by uid 111); 8 Sep 2025 16:42:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Sep 2025 12:42:33 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Sep 2025 12:42:32 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Isaac Oscar Gariano <isaacoscar@live.com.au>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/4] stash: pass --no-color to diff plumbing child
 processes
Message-ID: <20250908164232.GA1323964@coredump.intra.peff.net>
References: <20250908164157.GA1323487@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250908164157.GA1323487@coredump.intra.peff.net>

After a partial stash, we may clear out the working tree by capturing
the output of diff-tree and piping it into git-apply (and likewise we
may use diff-index to restore the index). So we most definitely do not
want color diff output from that diff-tree process.  And it normally
would not produce any, since its stdout is not going to a tty, and the
default value of color.ui is "auto".

However, if GIT_PAGER_IN_USE is set in the environment, that overrides
the tty check, and we'll produce a colorized diff that chokes git-apply:

  $ echo y | GIT_PAGER_IN_USE=1 git stash -p
  [...]
  Saved working directory and index state WIP on main: 4f2e2bb foo
  error: No valid patches in input (allow with "--allow-empty")
  Cannot remove worktree changes

Setting this variable is a relatively silly thing to do, and not
something most users would run into. But we sometimes do it in our tests
to stimulate color. And it is a user-visible bug, so let's fix it rather
than work around it in the tests.

The root issue here is that diff-tree (and other diff plumbing) should
probably not ever produce color by default. It does so not by parsing
color.ui, but because of the baked-in "auto" default from 4c7f1819b3
(make color.ui default to 'auto', 2013-06-10). But changing that is
risky; we've had discussions back and forth on the topic over the years.
E.g.:

  https://lore.kernel.org/git/86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com/.

So let's accept that as the status quo for now and protect ourselves by
passing --no-color to the child processes. This is the same thing we did
for add-interactive itself in 1c6ffb546b (add--interactive.perl: specify
--no-color explicitly, 2020-09-07).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/stash.c        |  5 ++++-
 t/t3904-stash-patch.sh | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index f5ddee5c7f..67b291f3fd 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -377,7 +377,7 @@ static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
 	 * however it should be done together with apply_cached.
 	 */
 	cp.git_cmd = 1;
-	strvec_pushl(&cp.args, "diff-tree", "--binary", NULL);
+	strvec_pushl(&cp.args, "diff-tree", "--binary", "--no-color", NULL);
 	strvec_pushf(&cp.args, "%s^2^..%s^2", w_commit_hex, w_commit_hex);
 
 	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
@@ -1284,6 +1284,7 @@ static int stash_staged(struct stash_info *info, struct strbuf *out_patch,
 
 	cp_diff_tree.git_cmd = 1;
 	strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "--binary",
+		     "--no-color",
 		     "-U1", "HEAD", oid_to_hex(&info->w_tree), "--", NULL);
 	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
 		ret = -1;
@@ -1346,6 +1347,7 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 
 	cp_diff_tree.git_cmd = 1;
 	strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "-U1", "HEAD",
+		     "--no-color",
 		     oid_to_hex(&info->w_tree), "--", NULL);
 	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
 		ret = -1;
@@ -1720,6 +1722,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 
 			cp_diff.git_cmd = 1;
 			strvec_pushl(&cp_diff.args, "diff-index", "-p",
+				     "--no-color",
 				     "--cached", "--binary", "HEAD", "--",
 				     NULL);
 			add_pathspecs(&cp_diff.args, ps);
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index ae313e3c70..90a4ff2c10 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -107,4 +107,23 @@ test_expect_success 'stash -p with split hunk' '
 	! grep "added line 2" test
 '
 
+test_expect_success 'stash -p not confused by GIT_PAGER_IN_USE' '
+	echo to-stash >test &&
+	# Set both GIT_PAGER_IN_USE and TERM. Our goal is to entice any
+	# diff subprocesses into thinking that they could output
+	# color, even though their stdout is not going into a tty.
+	echo y |
+	GIT_PAGER_IN_USE=1 TERM=vt100 git stash -p &&
+	git diff --exit-code
+'
+
+test_expect_success 'index push not confused by GIT_PAGER_IN_USE' '
+	echo index >test &&
+	git add test &&
+	echo working-tree >test &&
+	# As above, we try to entice the child diff into using color.
+	GIT_PAGER_IN_USE=1 TERM=vt100 git stash push test &&
+	git diff --exit-code
+'
+
 test_done
-- 
2.51.0.462.g0a0e5b9b75

