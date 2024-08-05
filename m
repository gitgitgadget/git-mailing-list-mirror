Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843356A01E
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722837615; cv=none; b=iJYuvqgr/HbvDJ5X22Llm0DHquQFlcnM65D+1gPwpyvYkT55QtgwtmZ6uJTMQ77b4p5r6rByOty8GRHVHs6FdV4/dWs/EhdtyMyp6+6IPXnWf+nwjEzUJLXMPmwTlzgIr5g2kOvdVwSfpcPQuf06aIZXyNInc0fh+oh86Tf42Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722837615; c=relaxed/simple;
	bh=wHw4hk1X0F8XDGahMC1Yy8peVW3riSEgqwLA9Qnjveo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5fzooc3cD87V/BmZQtjD3OXLjToOLepxbDPng+winxMBWszqHQD5i+5c6pNXvzjCGTGFt8y4UPc3MPVu+M+itFxLZBZocG8eMadzYR9IR5033oE33GJwTVWSTr1BZWhmdTVsreKRPKnqaTCturJXW29ErtDz6ynLW5vE3oBJLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24061 invoked by uid 109); 5 Aug 2024 06:00:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Aug 2024 06:00:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8370 invoked by uid 111); 5 Aug 2024 06:00:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Aug 2024 02:00:14 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 5 Aug 2024 02:00:10 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
Subject: [PATCH] apply: canonicalize modes read from patches
Message-ID: <20240805060010.GA120016@coredump.intra.peff.net>
References: <20240801155702.70242c31d476c46c84ee11a3@linux-foundation.org>
 <xmqqed77hifn.fsf@gitster.g>
 <20240801180706.933d797b0ae5744fdcdf47d2@linux-foundation.org>
 <20240802035121.GB1246312@coredump.intra.peff.net>
 <xmqq7cczgefh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7cczgefh.fsf@gitster.g>

On Fri, Aug 02, 2024 at 07:57:54AM -0700, Junio C Hamano wrote:

> Makes sense.
> 
> The above is consistent with what we do for the permission bits;
> only the execute bit matters, and the patch recording 100664 should
> mean the same thing to us as permission bits 100644---we should warn
> if the on-disk file is executable while applying such a patch, and
> we should not warn otherwise.

OK, here it is with tests and a commit message. I dug around to make
sure there were no cases where the unusual mode would cause other
behavior changes, but there aren't any. We are careful to use the
canonical mode whenever we create a file.

So the tests here may be overkill (since except for the warning message,
they'd pass already), but I thought it worth demonstrating the complete
set of expected behavior. Likewise the commit message is long because I
laid out all of the things I poked at.

I didn't add tests confirming that we complain when the executable bit
is not as expected. Earlier tests in t4129 already cover that.

-- >8 --
Subject: apply: canonicalize modes read from patches

Git stores only canonical modes for blobs. So for a regular file, we
care about only "100644" or "100755" (depending only on the executable
bit), but never modes where the group or other permissions are more
exotic. So never "100664", "100700", etc. When a file in the working
tree has such a mode, we quietly turn it into one of the two canonical
modes, and that's what is stored both in the index and in tree objects.

However, we don't canonicalize modes we read from incoming patches in
git-apply. These may appear in a few lines:

  - "old mode" / "new mode" lines for mode changes

  - "new file mode" lines for newly created files

  - "deleted file mode" for removing files

For "new mode" and for "new file mode", this is harmless. The patch is
asking the result to have a certain mode, but:

  - when we add an index entry (for --index or --cached), it is
    canonicalized as we create the entry, via create_ce_mode().

  - for a working tree file, try_create_file() passes either 0777 or
    0666 to open(), so what you get depends only on your umask, not any
    other bits (aside from the executable bit) in the original mode.

However, for "old mode" and "deleted file mode", there is a minor
annoyance. We compare the patch's expected preimage mode with the
current state. But that current state is always going to be a canonical
mode itself:

  - updating an index entry via --cached will have the canonical mode in
    the index

  - for updating a working tree file, check_preimage() runs the mode
    through ce_mode_from_stat(), which does the usual canonicalization

So if the patch feeds a non-canonical mode, it's impossible for it to
match, and we will always complain with something like:

  file has type 100644, expected 100664

Since this is just a warning, the operation proceeds, but it's
confusing and annoying.

These cases should be pretty rare in practice. Git would never produce a
patch with non-canonical modes itself (since it doesn't store them).
And while we do accept patches from other programs, all of those lines
were invented by Git. So you'd need a program trying to be Git
compatible, but not handling canonicalization the same way. Reportedly
"quilt" is such a program.

We should canonicalize the modes as we read them so that the user never
sees the useless warning.

A few notes on the tests:

  - I've covered instances of all lines for completeness, even though
    the "new mode" / "new file mode" ones behave OK currently.

  - the tests apply patches to both the index and working tree, and
    check the result of both. Again, we know that all of these paths
    canonicalize anyway, but it's giving us extra coverage (although we
    are even less likely to have such a bug now since we canonicalize up
    front).

  - the test patches are missing "index" lines, which is also something
    Git would never produce. But they don't matter for the test, they do
    match the case from quilt we saw in the wild, and they avoid some
    sha1/sha256 complexity.

Reported-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 apply.c                   |  1 +
 t/t4129-apply-samemode.sh | 62 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/apply.c b/apply.c
index 0f2f5dabe3..6e1060a952 100644
--- a/apply.c
+++ b/apply.c
@@ -995,6 +995,7 @@ static int parse_mode_line(const char *line, int linenr, unsigned int *mode)
 	*mode = strtoul(line, &end, 8);
 	if (end == line || !isspace(*end))
 		return error(_("invalid mode on line %d: %s"), linenr, line);
+	*mode = canon_mode(*mode);
 	return 0;
 }
 
diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index 4eb8444029..d9a1084b5e 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -130,4 +130,66 @@ test_expect_success 'git apply respects core.fileMode' '
 	test_grep ! "has type 100644, expected 100755" err
 '
 
+test_expect_success POSIXPERM 'patch mode for new file is canonicalized' '
+	cat >patch <<-\EOF &&
+	diff --git a/non-canon b/non-canon
+	new file mode 100660
+	--- /dev/null
+	+++ b/non-canon
+	+content
+	EOF
+	test_when_finished "git reset --hard" &&
+	(
+		umask 0 &&
+		git apply --index patch 2>err
+	) &&
+	test_must_be_empty err &&
+	git ls-files -s -- non-canon >staged &&
+	test_grep "^100644" staged &&
+	ls -l non-canon >worktree &&
+	test_grep "^-rw-rw-rw" worktree
+'
+
+test_expect_success POSIXPERM 'patch mode for deleted file is canonicalized' '
+	test_when_finished "git reset --hard" &&
+	echo content >non-canon &&
+	git add non-canon &&
+	chmod 666 non-canon &&
+
+	cat >patch <<-\EOF &&
+	diff --git a/non-canon b/non-canon
+	deleted file mode 100660
+	--- a/non-canon
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-content
+	EOF
+	git apply --index patch 2>err &&
+	test_must_be_empty err &&
+	git ls-files -- non-canon >staged &&
+	test_must_be_empty staged &&
+	test_path_is_missing non-canon
+'
+
+test_expect_success POSIXPERM 'patch mode for mode change is canonicalized' '
+	test_when_finished "git reset --hard" &&
+	echo content >non-canon &&
+	git add non-canon &&
+
+	cat >patch <<-\EOF &&
+	diff --git a/non-canon b/non-canon
+	old mode 100660
+	new mode 100770
+	EOF
+	(
+		umask 0 &&
+		git apply --index patch 2>err
+	) &&
+	test_must_be_empty err &&
+	git ls-files -s -- non-canon >staged &&
+	test_grep "^100755" staged &&
+	ls -l non-canon >worktree &&
+	test_grep "^-rwxrwxrwx" worktree
+'
+
 test_done
-- 
2.46.0.257.g39958a5326

