Received: from chiark.greenend.org.uk (permutation-city.chiark.greenend.org.uk [93.93.131.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D8822EEF
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236073; cv=none; b=kLXsxyESEuDRLJ4jcwVXLpBd22CWjXWGi1d62JmGpVe21WcF7J/8cO1AvJ/1r56VIcOGgLBuRy3oO7nVpzbKy1t3404ZaCt3cjlBEsE1MruaqKF57Y0gQjQeyLRliNpS3qE1tXapQns8MbQ2af0n98ZR+qsC6QRQgpJlZPCK0BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236073; c=relaxed/simple;
	bh=3dQ3BVqcC+pCf+iKzFX22EmvX0U2i2NhYNvz+vnonwI=;
	h=From:MIME-Version:Content-Type:Message-ID:Date:To:Subject; b=T/0XKh104JNMQ9jbi3D9B0KZpLh8FTIxpE6F0xCnFWrHEghChSCb2aIa2b7GC2eIusdQriWH+15UnTS5YBMGja/jYo0TsR5UBQy/TkCqIfmYv1ZVZGrL8xaoiq4SEpH1KDboe7I3hseNS9xSQd4JWtuxKzgZaQNK4iiS5jxbHj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk; spf=none smtp.mailfrom=chiark.greenend.org.uk; dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b=nrg8fpzB; arc=none smtp.client-ip=93.93.131.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b="nrg8fpzB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chiark.greenend.org.uk; s=g.chiark; h=DKIM-Signature-Warning:Subject:To:
	Date:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:From:
	Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=UaPgT7qn0gafoo5oPCoV4NgjfMlM+FSAhnAtsCypGLY=; b=nrg8fpzBEFNB
	NXKXviUMVk0RuYo5duDaHzGkvBLyYYLwT9a7jnKyW1ybVJHS2LCZG5LFYbapqzetAME7tnp/so7vM
	D2foWLV2o5goTm35zzln8FdXXGiMOSjVgYQwjIFvEZHIX9/U2CrFeyfA+kjNNAnRPyuztIqaaxPeW
	CmYRtZF+c4Wu/889uUG1SIbm+pLiwZRMpsq7T4b5R0YlOLIFw31GkrI7If7A0jC0g2esqON8MSHMB
	aea9Wpvj0GeTwRzoDrjcSOQsPzWK2X1THWPb58nUrmmjPhf+5AgRzPmfuz70n4I11uBsSRm9ib0nU
	gXk/D0LZmIlTlk3Y+wH9Cw==;
Received: by chiark.greenend.org.uk (Debian Exim 4.94.2 #2) with local
	(return-path ijackson@chiark.greenend.org.uk)
	id 1sU7ZM-0004MI-0L
	for git@vger.kernel.org; Wed, 17 Jul 2024 17:31:56 +0100
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <26263.61947.950592.361959@chiark.greenend.org.uk>
Date: Wed, 17 Jul 2024 17:31:55 +0100
To: git@vger.kernel.org
Subject: git subtree bugs (mishandled merges, recursion depth)
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
DKIM-Signature-Warning: NOTE REGARDING DKIM KEY COMPROMISE https://www.chiark.greenend.org.uk/dkim-rotate/README.txt https://www.chiark.greenend.org.uk/dkim-rotate/ad/add64bdf8e770171c60b2aa901328b04.pem

I have what ought to be a fairly straightforward situation that
git-subtree seems to be mishandling.

Steps to reproduce:

 git clone https://gitlab.torproject.org/tpo/core/arti.git
 cd arti
 git checkout 01d02118cdda30636e606fc1a89b3e04f28b8ad1
 git subtree split -P maint/rust-maint-common

Expected behaviour:

 git subtree (hopefully fairly rapidly) prints a the commitid of the
 tip of a branch suitable for merging back to the upstream repo, which
 is at https://gitlab.torproject.org/tpo/core//rust-maint-common

 The resulting history ought to have a few dozen commits,
 most of which are the upstream history of the subtree.

Actual behaviour (git 2.45.2, Debian amd64 1:2.45.2-1 .deb):

 $ git subtree split -P maint/rust-maint-common
 /usr/lib/git-core/git-subtree: 318: Maximum function recursion depth (1000) reached
 $

Actual behaviour (git 2.20.1, Debian ancient 1:2.20.1-2+deb10u9):

 Takes a very long time.  Everntually produces an output commit
 which has most of arti.git#main in its history.

Notes about the source repository:

 The state of arti.git:maint/rust-maint-common is the result of the
 following:
   (i) create a new rust-maint-common.git, and add and edit files
     (many of these changes came via gitlab MRs, there are merges)
   (ii) in arti.git, `git subtree add`, and make further changes,
     to files both within and without the subtree
   (iii) Make a gitlab MR from (ii) and merge it into arti.git#main.
     (resulting in a fairly merge-rich history)
     https://gitlab.torproject.org/tpo/core/arti/-/merge_requests/2267

A workaround:

 If I check out main^2 (01d02118cdda30636e606fc1a89b3e04f28b8ad1^2)
 and run git-subtree split using the ancient version of git, it still
 takes ages, but the output is correct.  So the old version of git has
 a bug meaning it can produce higly excessive output, when merges are
 present.

 This workaround is only available because right now the history of
 the subtree's files, within arti.git, is fairly simple.

 With the new version of git, I get the "recursion depth" error,
 regardless.

Thanks for your attention.

Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.  

Pronouns: they/he.  If I emailed you from @fyvzl.net or @evade.org.uk,
that is a private address which bypasses my fierce spamfilter.
