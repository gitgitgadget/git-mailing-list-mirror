Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F761E515
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757772894; cv=none; b=grpk9kjrVvQt/imE8uZkIewS0crntUNK3F1dkTOuktOYBdKIZP0FMhMRhcsbevf8QVi7XAXxB2l+IEDTcIZ7oAS2dCZjh6db0TTsA6heBUm6SXnn9tHMZPRLrYO4J5mV/7ug2tDL0ZufFKzrMeAIkR7HE34HXGpIzhFvF9rMIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757772894; c=relaxed/simple;
	bh=qPbBOPgpHm1Z3I0K/oayqXnMSETToPBCqr3De3PKeSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UFZWQt9FNFHnbtcDvewflcwTxGjoE5YqHS0A09A7v8pvX9QjhZ6DWdpINyrN2W4TIx3UQUUeikxjajNWnU/QWub22emo+pPAmD3Zf7EJcQHrzVaDfDIXSB+s1vFBhh9O6fmRmC1Turj05Ud/xXGrzrp3PMdyQreQ2Mxza1tu9b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=AJN4AmM3; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="AJN4AmM3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j5SR47jPph4LTCkgL1Z3Pf08fVyXm5htzR+eheHAlfM=;
  b=AJN4AmM3F6fZ1YbK3N45sw43ukglyn9wDiDHA4+m8J8VUwXzZM6Rchov
   NQVxaqUzfWD5tDWKYXcPrsTSTsGy8h4xirhHwqDAqFMM8xhgDlnm60Z1J
   ZfGbOJ5SCaQjQyXvWSPnejH8weEuqxzYUVPabI2BSVd8F4ecyAJffKU2P
   c=;
X-CSE-ConnectionGUID: 4nl7LiFITPmokmeNDQQXwA==
X-CSE-MsgGUID: Ch3scM+rT0m9WZprWREMhw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=gabriel.scherer@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.18,261,1751234400"; 
   d="scan'208";a="238904504"
Received: from 88-126-14-38.subs.proxad.net (HELO localhost) ([88.126.14.38])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2025 16:13:40 +0200
From: Gabriel Scherer <gabriel.scherer@inria.fr>
To: git@vger.kernel.org
Cc: Gabriel Scherer <gabriel.scherer@inria.fr>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/3] extend --ignore-other-worktrees to 'rebase', add hints
Date: Sat, 13 Sep 2025 16:13:17 +0200
Message-ID: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old 'workdir' contribution script was removed from git upstream in May
2025, as it is largely superseded by the 'worktree' command.

One significant difference between the old script and the command is that
'git' refuses to checkout or rebase branches that are already checked out in
another worktree. My understanding of the reasoning is that users may be
surprised when a clean worktree becomes dirty as its index is changed from
another worktree. However, this safety net adds a mental burden to worktree
users, as they have to keep the other worktrees in mind when moving
branches. Old goats like me who are used to the old 'workdir' script find
this restriction somewhat painful.

See the discussion thread
  https://lore.kernel.org/git/5580aa89-09f1-426e-8483-c99481c998ab@gmail.com/
about this transition.

The present patch series tries to provide a smoother migration path for
supporters of worktree independence:

 - when 'checkout' refuses because the branch is used in another worktree,
   display a 'hint' that mentions the possibility of using '--detach'
   instead, and the '--ignore-other-worktrees' option to proceed anyway.

 - add support for '--ignore-other-worktrees' in 'rebase' as well, with
   a similar hint.

In the future I would be interested in adding an option
'branch.ignoreOtherWorktrees' to be able to ignore other worktrees globally.

Note: this is my first experience submitting a patch to the Git project, so
I apologize in advance for any mishap and welcome beginner-level feedback.

Cc: Junio C Hamano <gitster@pobox.com>
Cc: D. Ben Knoble <ben.knoble@gmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>

Signed-off-by: Gabriel Scherer <gabriel.scherer@inria.fr>

Gabriel.Scherer (3):
  checkout: provide hint when failing due to another worktree
  rebase: support --ignore-other-worktrees
  rebase: hint when failing on branch used by another worktree

 Documentation/config/advice.adoc |  3 +++
 Documentation/git-rebase.adoc    |  6 ++++++
 advice.c                         |  1 +
 advice.h                         |  1 +
 branch.c                         | 13 +++++++++++--
 branch.h                         |  4 ++++
 builtin/checkout.c               | 12 ++++++++++--
 builtin/rebase.c                 | 19 ++++++++++++++++++-
 t/t3400-rebase.sh                |  4 +++-
 9 files changed, 57 insertions(+), 6 deletions(-)

-- 
2.51.0

