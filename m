Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43E038BF62
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849520; cv=none; b=TKRLp+8A7NURf5nOSMUkYn6XPHWizFF6Q2xEdZqkdWqvIpAuWckFjmkUvQm34dr7/2MSfBwI8GE1hQCkk/Xgt7juBPU2VUe6x/ZM9ftEjlaIM32Tzz3drAeF4EruCoz6HGWDZ+UiM+rpVyYpsMkNNYK8RFg2PKysVmVRh1cILDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849520; c=relaxed/simple;
	bh=b3vRKPtF9rF40oTsVou9pLbsFpjts+lIitapJA47VQU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ku65rQ3MpKhQv2MynG28G7sDPGupUuS0KKxrBSLHldd98Hd2gagyPa3KEjS1/On1F1nXJf6TKhaG9X6ZHqfTNhLXnIhnZmXk1tbSITh4MVd5bSjv0cmhgfqRPvvGpYgweUdC452VVbkpNzA2BcvqKZxPJBjbGDdbzAsDHqnBr70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net; spf=pass smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opperschaap.net
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hW6xG33GRz8txJ;
	Thu, 27 Aug 2026 18:51:46 +0200 (CEST)
From: Wesley Schwengle <wesleys@opperschaap.net>
To: git@vger.kernel.org
Subject: [PATCH 0/2] git-svn: silence bogus v1-layout migration message
Date: Thu, 27 Aug 2026 12:51:32 -0400
Message-ID: <20260827165134.848207-1-wesleys@opperschaap.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While running `dzil build' (a Perl tool for minting and shipping
modules) without a git remote configured, git started printing
"Migrating from a git-svn v1 layout..." messages. In addition it also
created an empty `.git/svn' directory. After removing that directory, it
again repeated the behaviour on every `dzil build' invocation.

One of the plugins runs `git svn info' to probe whether the repo is an
SVN checkout. On a plain git-only repository this produced a wall of
migration text on the terminal and left behind an empty `.git/svn'
directory. I initially thought it was just a plugin being weird, but
running `git svn info' myself turned out to be the real "troublemaker".

You can do reproduce the behaviour by doing:

  git init .
  git svn info

This patch addresses that and uses the same pattern as
`migrate_from_v0'. I've included tests to t9107.

In addition, which was my intitial reaction: I've added a knob to
exclude git svn from being installed. When you add
`NO_GIT_SVN=YesPlease' to your make invocation, git is installed without
git-svn and no SVN tests run.

Wesley Schwengle (2):
  git-svn: don't print v1-layout migration noise when there's nothing to
    migrate
  Makefile: add NO_GIT_SVN knob to skip building/installing git-svn

 Makefile                   |  8 ++++++++
 perl/Git/SVN/Migration.pm  | 16 ++++++++++------
 t/t9107-git-svn-migrate.sh |  7 +++++++
 3 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.55.0.827.g48ce2c92dc

