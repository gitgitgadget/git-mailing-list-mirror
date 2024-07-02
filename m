Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0401200134
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953511; cv=none; b=mPSIifvqtJ7btdIN6BqwKcWMbQEVsdh+O33Q11fgqU6BJ2IC2lmMSSIR6tSpWnhmj0WrRlSSCTH4mBbCSQRLq3yXbGGeLA25SRyomGHevkGU0kYHxfzOmyHWaUvSB/AVVnnYniKK6uQejbvgt/UVUF7jcSvevfM/8XZw3kW1SxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953511; c=relaxed/simple;
	bh=NMmVmGtWgzIJQ3sKVss5DgAr//SzRmWZAo3pAlt8gwU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mRBVG3DU2GnPiYR0Z2Ac+KTfkpmymsDkJvWliQtGUuqW3m14C+vxa/TKjHMTbnJ0XN5Wk6o/aNcmL5w61a3Kj37Wisy2qfHhMA8xj8YQVFKMUylZgfQ3eVKgbKhib+fTq4KUHx/78HMbAjJeS8xV4lLkg0nCeyAuSrJiFh4blA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gC5Aymcs; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gC5Aymcs"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1401827262;
	Tue,  2 Jul 2024 16:51:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=N
	MmVmGtWgzIJQ3sKVss5DgAr//SzRmWZAo3pAlt8gwU=; b=gC5Aymcsp/pGcjyT4
	uesykEy43bU2GLZrfUZGf1x/huc+RsEOj4kdGt2drwCWl85hxBEjpKAe4pLAgK2f
	qzdpKNbkuGtbNyNmmw985Rxld4T7N9VqMpqWTgzTYCieB84/pPQwcbydkJd9H+5+
	cUHfVuM0GzJwI+49+VksI+wB6E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D40E27261;
	Tue,  2 Jul 2024 16:51:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9580927260;
	Tue,  2 Jul 2024 16:51:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] checkout: special case error messages during noop switching
Date: Tue, 02 Jul 2024 13:51:43 -0700
Message-ID: <xmqqikxnqzz4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E4D6640C-38B4-11EF-A58F-C38742FD603B-77302942!pb-smtp20.pobox.com

"git checkout" ran with no branch and no pathspec behaves like
switching the branch to the current branch (in other words, a
no-op, except that it gives a side-effect "here are the modified
paths" report).  But unlike "git checkout HEAD" or "git checkout
main" (when you are on the 'main' branch), the user is much less
conscious that they are "switching" to the current branch.

This twists end-user expectation in a strange way.  There are
options (like "--ours") that make sense only when we are checking
out paths out of either the tree-ish or out of the index.  So the
error message the command below gives

    $ git checkout --ours
    fatal: '--ours/theirs' cannot be used with switching branches

is technically correct, but because the end-user may not even be
aware of the fact that the command they are issuing is about no-op
branch switching [*], they may find the error confusing.

Let's refactor the code to make it easier to special case the "no-op
branch switching" situation, and then customize the exact error
message for "--ours/--theirs".  Since it is more likely that the
end-user forgot to give pathspec that is required by the option,
let's make it say

    $ git checkout --ours
    fatal: '--ours/theirs' needs the paths to check out

instead.

Among the other options that are incompatible with branch switching,
there may be some that benefit by having messages tweaked when a
no-op branch switching is done, but I'll leave them as #leftoverbits
material.

[Footnote]

 * Yes, the end-users are irrational.  When they did not give
   "--ours", they take it granted that "git checkout" gives a short
   status, e.g..

    $ git checkout
    M	builtin/checkout.c
    M	t/t7201-co.sh

   exactly as a branch switching command.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c | 21 ++++++++++++++-------
 t/t7201-co.sh      | 13 +++++++++++++
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3cf44b4683..1748d68c96 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1572,6 +1572,10 @@ static void die_if_switching_to_a_branch_in_use(struct checkout_opts *opts,
 static int checkout_branch(struct checkout_opts *opts,
 			   struct branch_info *new_branch_info)
 {
+	int noop_switch = (!new_branch_info->name &&
+			   !opts->new_branch &&
+			   !opts->force_detach);
+
 	if (opts->pathspec.nr)
 		die(_("paths cannot be used with switching branches"));
 
@@ -1583,9 +1587,14 @@ static int checkout_branch(struct checkout_opts *opts,
 		die(_("'%s' cannot be used with switching branches"),
 		    "--[no]-overlay");
 
-	if (opts->writeout_stage)
-		die(_("'%s' cannot be used with switching branches"),
-		    "--ours/--theirs");
+	if (opts->writeout_stage) {
+		const char *msg;
+		if (noop_switch)
+			msg = _("'%s' needs the paths to check out");
+		else
+			msg = _("'%s' cannot be used with switching branches");
+		die(msg, "--ours/--theirs");
+	}
 
 	if (opts->force && opts->merge)
 		die(_("'%s' cannot be used with '%s'"), "-f", "-m");
@@ -1612,10 +1621,8 @@ static int checkout_branch(struct checkout_opts *opts,
 		die(_("Cannot switch branch to a non-commit '%s'"),
 		    new_branch_info->name);
 
-	if (!opts->switch_branch_doing_nothing_is_ok &&
-	    !new_branch_info->name &&
-	    !opts->new_branch &&
-	    !opts->force_detach)
+	if (noop_switch &&
+	    !opts->switch_branch_doing_nothing_is_ok)
 		die(_("missing branch or commit argument"));
 
 	if (!opts->implicit_detach &&
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 42352dc0db..793da6e64e 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -497,6 +497,19 @@ test_expect_success 'checkout unmerged stage' '
 	test ztheirside = "z$(cat file)"
 '
 
+test_expect_success 'checkout --ours is incompatible with switching' '
+	test_must_fail git checkout --ours 2>error &&
+	test_grep "needs the paths to check out" error &&
+
+	test_must_fail git checkout --ours HEAD 2>error &&
+	test_grep "cannot be used with switching" error &&
+
+	test_must_fail git checkout --ours main 2>error &&
+	test_grep "cannot be used with switching" error &&
+
+	git checkout --ours file
+'
+
 test_expect_success 'checkout path with --merge from tree-ish is a no-no' '
 	setup_conflicting_index &&
 	test_must_fail git checkout -m HEAD -- file
-- 
2.45.2-892-g51054c73d0

