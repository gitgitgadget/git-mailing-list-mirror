Received: from dd18010.kasserver.com (dd18010.kasserver.com [85.13.161.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2025732470F
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.161.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785743617; cv=none; b=E3hzcAExxq67SzX7pBKJMTCQIo6Sw2dAU7CJFU422Q8TYU/BHWQrY3ZhH6+Ys3iks9VGx2SY8oj0ioC9w6PvUMyf4QSyvG8GUrXGcFohEwrIqgi9waHPI4ja0b2lNvHMNcFdQpYG+bT/Y7mlIT4orgYBZp14SItJOUzj2544I9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785743617; c=relaxed/simple;
	bh=QEyn/PzBo+dxjd9qRopxNxavbM59p60BNMpZHtJ8G98=;
	h=Subject:To:From:MIME-Version:Content-Type:Message-Id:Date; b=NE7EIuHqNJJyfQ4XMyHX06HLCu4he8YuJLXOzbdbdaVyOjPGtt4p4YjXmRy6N7Oqohv9kR8Lvomzadevk1z8WNhZNRRqGGzwml7LqQizr4tumo4LZhVZzZ1PdtTkcUPSQL2g9qVRuIY3IhKS1KLaqMYvKkaxpdjuoBqHdft5seA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evolution515.net; spf=pass smtp.mailfrom=evolution515.net; dkim=pass (2048-bit key) header.d=evolution515.net header.i=@evolution515.net header.b=P0QDwdoS; arc=none smtp.client-ip=85.13.161.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evolution515.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=evolution515.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=evolution515.net header.i=@evolution515.net header.b="P0QDwdoS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=evolution515.net;
	s=kas202607300014; t=1785743199;
	bh=QEyn/PzBo+dxjd9qRopxNxavbM59p60BNMpZHtJ8G98=;
	h=Subject:To:From:Reply-To:Date:From;
	b=P0QDwdoS5IHSc4LQtiZw+zrbfb58MfIOL29RsdygNCJmcyzmjDVzhpYoLQRa1F5zM
	 2Eo+z+Txx1u4QZfF0MA46PuSZ2X699BrLDHmnD/ZX737kUR9cVYlPhA6LYewn1xK3M
	 TErnZJ3f138N/1RHjItxnCaV2MWcxgyvs2WFkMvfD9f4L29VBe/6V1psOk/OZZjrZ5
	 VA8x5vOsiVXcuMEXLlxDDOf3HQbnlHyMi3FhA5qVZieJGZVgfSsFpKCBM+EH1cQEBo
	 kJQK6HTDIpJxUePQ1yPzyDZSKnj8A/HmCXUjVOWkPJizuN3aeNZpsDyIalz9bUTrEb
	 +apHuVuDbzoqw==
Received: from dd18010.kasserver.com (dd0802.kasserver.com [85.13.143.1])
	by dd18010.kasserver.com (Postfix) with ESMTPSA id 0B7DB5946343
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 09:46:39 +0200 (CEST)
Subject: git rebase writes worktree "Ref ... checked out at ..." todo comments
 with a hardcoded '#', breaking parsing when core.commentChar is not '#'.
To: git@vger.kernel.org
From: "Markus Geiger" <mgeiger@evolution515.net>
Reply-To: mg@evolution515.net
User-Agent: ALL-INKL Webmail 2.11
X-SenderIP: 77.2.123.233
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20260803074639.0B7DB5946343@dd18010.kasserver.com>
Date: Mon,  3 Aug 2026 09:46:39 +0200 (CEST)
X-Spamd-Bar: ----

When core.commentChar is set to a non-'#' value (e.g. ';') AND a branch that
falls within the rebased commit range is checked out in another worktree,
`git rebase` generates a todo list in which the informational
"Ref ... checked out at ..." lines are prefixed with a hardcoded '#' instead of
the configured comment character. Git's own sequencer then re-reads that todo,
does not recognize '#' as a comment, and aborts with `error: invalid command '#'`.

Minimal, self-contained reproduction:

    T=$(mktemp -d); export HOME="$T"
    git config --global user.email t@t.t
    git config --global user.name t
    git config --global init.defaultBranch main

    cd "$T"; git init -q super && cd super
    echo a > f && git add f && git commit -qm base   # upstream (ancestor)
    echo b >> f && git commit -qam A
    echo c >> f && git commit -qam B
    git branch feat
    git checkout -q feat                             # primary worktree on 'feat'
    git worktree add -q ../mainwt main               # 'main' (in range) checked out elsewhere

    git config core.commentChar ';'                  # <-- the trigger
    git rebase main~2                                # replay A, B onto 'base'

What did you expect to happen? (Expected behavior)

Rebase succeeds, exactly as it does with the default core.commentChar='#'.
The "Ref ... checked out at ..." advisory lines are informational comments and
should be ignored by the sequencer.

What happened instead? (Actual behavior)

    error: invalid command '#'
    error: invalid line 3: # Ref refs/heads/main checked out at '.../mainwt'
    error: invalid command '#'
    error: invalid line 5: # Ref refs/heads/feat checked out at '.../super'
    You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.

Exit code 1, with a half-initialized rebase left in progress.

What's different between what you expected and what actually happened?

The generated rebase-merge/git-rebase-todo mixes two comment characters, which
shows one code path respects core.commentChar while another hardcodes '#':

    pick 2fbb49f A
    pick 15691cb B
    # Ref refs/heads/main checked out at '.../mainwt'    <-- hardcoded '#'  (BUG)
    # Ref refs/heads/feat checked out at '.../super'     <-- hardcoded '#'  (BUG)
    ; Rebase a0b3bf8..15691cb onto a0b3bf8 (2 commands)  <-- correct ';'   (respects config)

On re-read, todo_list_parse_insn_buffer() treats any line not starting with the
configured comment char as an instruction, so '#' is parsed as a command.

Anything else you want to add:

Root cause: the sequencer code (sequencer.c) that appends the
"Ref <ref> checked out at <path>" advisory lines when a ref in the rebased range
is checked out in another worktree prepends a literal '#' rather than the
resolved comment_line_char. Suggested fix: use comment_line_char for those lines,
as the surrounding template lines already do.

Trigger conditions (both required):
  1. core.commentChar set to a value other than '#' (also affects 'auto' when it
     resolves to a non-'#' character).
  2. A branch within the rebased range is checked out in another worktree.

Impact: `git rebase` is unusable from the CLI for users who set a custom
core.commentChar (common for teams that begin commit-message lines with '#123'
issue refs) as soon as they use worktrees.

Workarounds:
  - git -c core.commentChar='#' rebase ...
  - set core.commentChar='#' globally
  - git rebase --edit-todo and delete the offending '#' lines by hand

Reproduced on git version 2.43.0 (details below). Not yet checked against master.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.43.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 7.0.0-28-generic #28~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Wed Jul  1 15:50:57 UTC 2 x86_64
compiler info: gnuc: 13.3
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]
