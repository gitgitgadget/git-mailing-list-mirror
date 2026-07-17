Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5536345741
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314522; cv=none; b=Up8rraWUwa1ZXHDhvboF257ov67y9whA3rLZaDu4YfnOMaPSYER5e/TtPkuQ24Y3uhGiBtex2MTsGGZtNsh/7LO1cr+hlrIqJwQyfFBvb/+3/AVLpbU+Mx9MIYsp1QpURMFEqXFikR9xJokPBFIrq0jiOoLryllaorkCT0e6uWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314522; c=relaxed/simple;
	bh=+HibFMD7WT6BNukS2nE+GbhFhn71Zaf1xApi8wYfym0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z/Zu2Tye/+gTqINcgDxe3pXEEc0aGS/r8jPklwD6b5uA0MkVCVeKyoJWRKWeLsyOSpdYptYS1JYpLpztZxqWemMZxJdmNgSrBOf5v1UX6Dc4jYFsjpX4vt3OGVmTFWiWCG/LyKaupoh820xqCejtiTJQW7S5BCD1VJgyPkKW9OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=oqTtVYO6; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="oqTtVYO6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784314516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=+NlBdNx4usEyncL77jFB8DTWfPF6fbr+Rrjms6agSpE=;
	b=oqTtVYO6VewFnAnFRdu+xxIbi6jugknFerqRfcq6dDUkVz6ih23yz3P42FuCcwTClRSp76
	HwvvCeyxf+e8S+wIIPmJPg78RbqW09bMVXT6qA5rhRfIiTmaoL0a3IfA8Sda1xDYhz8Z2O
	tH51+eRvFvFZKaBgbmiBvkWz07yUPJ0=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: git-history(1) fixup broken with worktrees?
Date: Fri, 17 Jul 2026 20:54:47 +0200
Message-ID: <87jyqt1m6g.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Hi,

Imagine this repoducer:

    $ git init
    $ echo Hello > README
    $ git add .
    $ git commit -m'initial commit'
    $ git worktree add ../feature
    $ echo world >> README
    $ git add .
    $ git history fixup HEAD
    $ cd ../feature

Now running git-status(1) in that other worktree gives me:

    $ git status

    On branch feature
    Changes to be committed:
      (use "git restore --staged <file>..." to unstage)
            modified:   README

And:

    $ git diff --staged

    diff --git a/README b/README
    index 65a56c3..e965047 100644
    --- a/README
    +++ b/README
    @@ -1,2 +1 @@
     Hello
    -world


So suddenly my other worktree is dirty? With staged changes?
And I didn't even touch it.

Now the commit history is correct:

    $ git log --graph --oneline --all

    * 16ef548 (HEAD -> feature, main) initial commit



-- 
Cheers,
Toon
