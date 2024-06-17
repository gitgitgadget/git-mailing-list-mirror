Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC41946CC
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621022; cv=none; b=P2dfKz0FTCcriIlmXJe4sYaasiw8NwukjGz1HholUlBBxPXClqhskDAg0mxcT9fDWi/d90mg0bjfV/qcxKyn3/nFHT7WKi1h4ZBuitFJ8ZN1igujlzMmABirC82rRyGhkXiRZSIrmv/KQHH39cj2w7zr2bUOpPuSjh9Q44Motb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621022; c=relaxed/simple;
	bh=cQ5A+PJ6t946+6JAMk5CPTOiWMTOCU+lKrOryYQflj0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwjawCYPLWfFnMX2y4H13RdEhJxH0afzd8bBL0+9o724qO2hlJ5ynrawF4kNthzMMTB2VXUrJpoitjIvBEbhcZlDBkrEPez3RHrnJu2aBvlOKbDqpIy9ccBrF1LjhN45K3WS+1cJ+HQ7lSKPScWs3AD8qgDH0joXm801TaoVbFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=YotXi4/o; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="YotXi4/o"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5C9B1FB12
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1718621006;
	bh=cQ5A+PJ6t946+6JAMk5CPTOiWMTOCU+lKrOryYQflj0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YotXi4/oz/cLpyrLdgy0bEON2PqfamQv+gtiSNW4w9clwqO+D+lMi2DVMeGsbnoTt
	 k6t07enGgI3IS3kfnHw2wEPPlfiyZKW3rsntFeaoal0gou1aQMzDYjj1cxY0h9JV37
	 C0LgWeImahHcm8B/KCb2jyAVON/JitcPmscup0VA=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Subject: [PATCH 2/2] t9700: ensure cat-file info isn't buffered by default
Date: Mon, 17 Jun 2024 10:43:26 +0000
Message-ID: <20240617104326.3522535-3-e@80x24.org>
In-Reply-To: <20240617104326.3522535-1-e@80x24.org>
References: <20240617104326.3522535-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on buffering changes to `git cat-file' in a
separate patch, I inadvertently made the output of --batch-check
and the `info' command of --batch-command buffered by default.

Buffering by default breaks some 3rd-party Perl scripts using
cat-file, but this breakage was not detected anywhere in our
test suite.  The easiest place to test this behavior is with
Git.pm, since (AFAIK) other equivalent way to test this behavior
from Bourne shell and/or awk would require racy sleeps,
non-portable FIFOs or tedious C code.

Signed-off-by: Eric Wong <e@80x24.org>
---
 t/t9700/test.pl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index d8e85482ab..94a2e2c09d 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -154,6 +154,20 @@ sub adjust_dirsep {
 		     "abc\"\\ \x07\x08\x09\x0a\x0b\x0c\x0d\x01 ",
 		     'unquote escape sequences');
 
+# ensure --batch-check is unbuffered by default
+my ($pid, $in, $out, $ctx) = $r->command_bidi_pipe(qw(cat-file --batch-check));
+print $out $file1hash, "\n" or die $!;
+my $info = <$in>;
+is $info, "$file1hash blob 15\n", 'command_bidi_pipe w/ --batch-check';
+$r->command_close_bidi_pipe($pid, $in, $out, $ctx);
+
+# ditto with `info' with --batch-command
+($pid, $in, $out, $ctx) = $r->command_bidi_pipe(qw(cat-file --batch-command));
+print $out 'info ', $file1hash, "\n" or die $!;
+$info = <$in>;
+is $info, "$file1hash blob 15\n", 'command_bidi_pipe w/ --batch-command=info';
+$r->command_close_bidi_pipe($pid, $in, $out, $ctx);
+
 printf "1..%d\n", Test::More->builder->current_test;
 
 my $is_passing = eval { Test::More->is_passing };
