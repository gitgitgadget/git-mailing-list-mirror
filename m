Received: from chiark.greenend.org.uk (permutation-city.chiark.greenend.org.uk [93.93.131.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2DC17E8FA
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234962; cv=none; b=RkiXIH5JSfcI2Ae+jKdLLNZp0csypMYEREWWB2M6Om3j8AIRJW0iHhZTEJG1a0y0Z6ojszJ0QZI3aPJ6iulec8zw/bw9s6Jnnxlh3lCPkx1aPdOilCXcp5MEN6SgQ+2PGLroPJQA4DJC2PZZioa5gM1vTwzxPrslgCFViYkHLGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234962; c=relaxed/simple;
	bh=3dQ3BVqcC+pCf+iKzFX22EmvX0U2i2NhYNvz+vnonwI=;
	h=From:Message-ID:Date:MIME-Version:Content-Type:To:Subject; b=r5tSN2wgqd1iljkKFQkTubO3PGlY+U67eUWFh4rUVXQBHRnVwN8huVAPy6Mx74gZmy48Hj/S+zalaD2ErdNX/ssid5EwAtIgoh+fWRA3Ztwghu0pF9Yo4eJ/aOyI0CFH8UUrw0pUna48m6L8GsM6h2Kf+EIDGt/A80CoccwPgGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk; spf=none smtp.mailfrom=chiark.greenend.org.uk; dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b=BbJdhTJV; arc=none smtp.client-ip=93.93.131.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b="BbJdhTJV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chiark.greenend.org.uk; s=g.chiark; h=DKIM-Signature-Warning:Subject:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=UaPgT7qn0gafoo5oPCoV4NgjfMlM+FSAhnAtsCypGLY=; b=BbJdhTJVFM5W
	FMlamgG+VDfHDh8AGPNU0ZGs32anJ+55V4aEBYE7j6b6ab9qVaZHO0REeDfJdmaB1xn7ViNITQe+R
	Zpx8wqL/mSAY8j/eeTAAiTNkzRm1s44a8sSaRs+Ifh2Q5EN361+7dZwAiC/+2cg/7HDjiaksZvL+m
	3T8Tf90MyWfcQiVRETn3zrLImAF7eVSI+YWweGqgK4akjHNqG++rHBU4WF3iMiVD5iF/1HEiu5kuB
	Ag2rEyBOviLi7BYwSgV0BDdp06sF53oKeI1EdFDHnYQELEkfQP9Xfvxt+AzN6btIWn1NWpzpeQPeH
	5afgUnw4qehyqmEkpudzCg==;
Received: by chiark.greenend.org.uk (Debian Exim 4.94.2 #2) with local
	(return-path ijackson@chiark.greenend.org.uk)
	id 1sU7q9-0003ON-SB
	for git@vger.kernel.org; Wed, 17 Jul 2024 17:49:17 +0100
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
Message-ID: <26263.62989.829497.450160@chiark.greenend.org.uk>
Date: Wed, 17 Jul 2024 17:49:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
