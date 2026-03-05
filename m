Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F1369232
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755012; cv=none; b=mmwMQCUZ/rtJMzhWSSwNgYF6hRxWl8iXaDtxAEMxhod92wQQvpAfvHzIxRQTdNqGkpTggFh1el15keVzEPScfzjLweuwtDNpPmcZGEYISrczLKn6FLRipJAAdvdIaleejrPO0qHDtZkPHl2B4S42I91QgD3UVsPJVYH02din7vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755012; c=relaxed/simple;
	bh=0iLQHPKth8Lx5H/ehu/WtPYBZfqFE6Ik9rWGWWvd+vs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMWiptOk9oaBx6u7cqEezcPnSkZkCrvu621n88teFlaQ7NFRVQ4IvX0SZL+ukWF+QAjrvYWY46JtWiOaqXDgesaUyQKX7j2gTj3uO6xilnOqikFmbNsd8pzRp8ssFB9TRQh52RfdJ2PEe4MQlr6elQDqe683uLtl1rOYrib8xBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=oQdcawcD; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="oQdcawcD"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vyIYi-00EYT2-Nr; Fri, 06 Mar 2026 00:56:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=HZSejCqSB8Rttu/mbqbFx9z5CqvdlXvCcuSrZ51i7zY=; b=oQdcawcDgusD8K8nrAinA2cPI1
	n+zw80U4hNNn+iyW1WsuN3QpwYh6Z4qdr+WXadifAoiyptDUNiVBLGcBl/bAzhyWV5MsRMnIu0Xh0
	KZQ+p0IxPX8FumF9klm3mOo0CvTQlyESTWoDH+J1rZJeCGgnbIgQUNN0lmMGvPyEXbr9ky/omiyoQ
	qPu070f8wZChxw0fg5TiMRExlTDhvASrmJeRNcvnjtDb16gericzr01hEoIEoYJ2vVZkgP+CmNGal
	Hzqj+XAQx2qX2MY4e0Bh/YSI2BWjjngT18xdcDAdKmmlb+zW/D6t5/mqhBxmoc2rl8y6QwRR/yrIQ
	MufqNQZw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vyIYi-0005qf-DK; Fri, 06 Mar 2026 00:56:48 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vyIYQ-000JoT-Bf; Fri, 06 Mar 2026 00:56:30 +0100
From: Colin Stagner <ask+git@howdoi.land>
Date: Thu, 05 Mar 2026 17:55:49 -0600
Subject: [PATCH v2 3/3] contrib/subtree: reduce recursion during split
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-cs-subtree-split-recursion-v2-3-7266be870ba9@howdoi.land>
References: <20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
In-Reply-To: <20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
To: git@vger.kernel.org, Christian Heusel <christian@heusel.eu>, 
 george@mail.dietrich.pub
Cc: Christian Hesse <list@eworm.de>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Junio C Hamano <gitster@pobox.com>, Colin Stagner <ask+git@howdoi.land>
X-Mailer: b4 0.15-dev

On Debian-alikes, POSIX sh has a hardcoded recursion depth
of 1000. This limit operates like bash's `$FUNCNEST` [1], but
it does not actually respect `$FUNCNEST`. This is non-standard
behavior. On other distros, the sh recursion depth is limited
only by the available stack size.

With certain history graphs, subtree splits are recursive—with
one recursion per commit. Attempting to split complex repos that
have thousands of commits, like [2], may fail on these distros.

Reduce the amount of recursion required by eagerly discovering
the complete range of commits to process.

The recursion is a side-effect of the rejoin-finder in
`find_existing_splits`. Rejoin mode, as in

    git subtree split --rejoin -b hax main ...

improves the speed of later splits by merging the split history
back into `main`. This gives the splitting algorithm a stopping
point. The rejoin maps one commit on `main` to one split commit
on `hax`. If we encounter this commit, we know that it maps to
`hax`.

But this is only a single point in the history. Many splits
require history from before the rejoin. See patch content for
examples.

If pre-rejoin history is required, `check_parents` recursively
discovers each individual parent, with one recursion per commit.
The recursion deepens the entire tree, even if an older rejoin
is available. This quickly overwhelms the Debian sh stack.

Instead of recursively processing each commit, process *all* the
commits back to the next obvious starting point: i.e., either the
next-oldest --rejoin or the beginning of history. This is where the
recursion is likely to stop anyway.

While this still requires recursion, it is *considerably* less
recursive.

[1]: https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html#index-FUNCNEST

[2]: https://github.com/christian-heusel/aur.git

Signed-off-by: Colin Stagner <ask+git@howdoi.land>
---
 contrib/subtree/git-subtree.sh | 56 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index c1756b3e74..c649a9e393 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -315,6 +315,46 @@ cache_miss () {
 }
 
 # Usage: check_parents [REVS...]
+#
+# During a split, check that every commit in REVS has already been
+# processed via `process_split_commit`. If not, deepen the history
+# until it is.
+#
+# Commits authored by `subtree split` have to be created in the
+# same order as every other git commit: ancestor-first, with new
+# commits building on old commits. The traversal order normally
+# ensures this is the case, but it also excludes --rejoins commits
+# by default.
+#
+# The --rejoin tells us, "this mainline commit is equivalent to
+# this split commit." The relationship is only known for that
+# exact commit---and not before or after it. Frequently, commits
+# prior to a rejoin are not needed... but, just as often, they
+# are! Consider this history graph:
+#
+#              --D---
+#             /      \
+#         A--B--C--R--X--Y    main
+#                 /     /
+#          a--b--c     /      split
+#              \      /
+#               --e--/
+#
+# The main branch has commits A, B, and C. main is split into
+# commits a, b, and c. The split history is rejoined at R.
+#
+# There are at least two cases where we might need the A-B-C
+# history that is prior to R:
+#
+# 1. Commit D is based on history prior to R, but
+#    it isn't merged into mainline until after R.
+#
+# 2. Commit e is based on old split history. It is merged
+#    back into mainline with a subtree merge. Again, this
+#    happens after R.
+#
+# check_parents detects these cases and deepens the history
+# to the next available rejoin.
 check_parents () {
 	missed=$(cache_miss "$@") || exit $?
 	local indent=$(($indent + 1))
@@ -322,8 +362,20 @@ check_parents () {
 	do
 		if ! test -r "$cachedir/notree/$miss"
 		then
-			debug "incorrect order: $miss"
-			process_split_commit "$miss" ""
+			debug "found commit excluded by --rejoin: $miss. skipping to the next --rejoin..."
+			unrevs="$(find_existing_splits "$dir" "$miss" "$repository")" || exit 1
+
+			find_commits_to_split "$miss" "$unrevs" |
+			while read -r rev parents
+			do
+				process_split_commit "$rev" "$parents"
+			done
+
+			if ! test -r "$cachedir/$miss" &&
+				! test -r "$cachedir/notree/$miss"
+			then
+				die "failed to deepen history at $miss"
+			fi
 		fi
 	done
 }

-- 
2.43.0

