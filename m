Received: from smtp-1.orcon.net.nz (smtp-1.orcon.net.nz [60.234.4.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F4B45FFB0
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.234.4.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462215; cv=none; b=gSrHOVsw9o7EncaScljN5kiGkg0NN4g5eNdieuQOVTbmM3cOxt5d5pfGzXiFmTKV9o72cMyEU7xsG0b2VDgmSbWM1i1QlBYFxp/kz5Ty7TZjVLZd3wB694GgqlifUb6yOtqrRKhyH+boTTwUSNbY+DQz84yhhe2P2JJETvAX+9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462215; c=relaxed/simple;
	bh=F8fyFsg43pU90NT5FvZEmD1RZoqFBGv/JOY82h4wCS0=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=p0TYzKe7e/2ULh9nhL8wpblDYolm139P3gASlBhHODi97CDo0qZO9GVYN4I3mn2LJHKHHxd8osh4DbntSHI8KfrF7jmKL2TN+1Md8dPquC/4XwtP0pjCB4IcRV74s24qGJxO5dP4g/DtLMKQlNyFMRl9yMAYOeJJmEIPfKx/K5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orcon.net.nz; spf=pass smtp.mailfrom=orcon.net.nz; dkim=pass (2048-bit key) header.d=orcon.net.nz header.i=@orcon.net.nz header.b=GXVDYMRD; arc=none smtp.client-ip=60.234.4.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orcon.net.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orcon.net.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orcon.net.nz header.i=@orcon.net.nz header.b="GXVDYMRD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=orcon.net.nz; s=s1; h=Content-Transfer-Encoding:Content-Type:Message-ID:
	Subject:To:From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S2G+MRyn3o7BmkK1D3kbK7yzpeSGocCs8FSex4Gwytw=; b=GXVDYMRDMe1rPC7Covg8eNHfGR
	p7dL+7zbnP+cNE4aG+chhwdy4cFF0QfqbDVLQj+VmdRe37dQsrIUZMSQN7YIOfQ8aFehAYOdx1olf
	XXD9g+rFwYYPU1kfi/eKC+5jjo8TIVhYLzGte1yp+AExSM8rbxgTpRj6xFzQUZIxKFObA5VhOGvM/
	4BPenfL8SbM9mjPM90vKRPXlUl8pzV5jWxoEpGedjakkkykkT0FxatoxA2Mj4sC0JusIhXqp481H+
	r/mkpA7enDH+izsgqmpFOi7cMR6JemlWCRV9TFApSJxmX4goVwY67nJs6sA6aRsr8pUqKn8IOh0Iv
	JAqFhaOA==;
Received: from [10.253.37.70] (port=16050 helo=webmail.orcon.net.nz)
	by smtp-1.orcon.net.nz with esmtpa (Exim 4.90_1)
	(envelope-from <psainty@orcon.net.nz>)
	id 1x6OSt-0004cc-Iq
	for git@vger.kernel.org; Tue, 15 Sep 2026 20:24:32 +1200
Received: from ip-180-148-114-126.as55850.net ([180.148.114.126])
 via [10.253.37.253]
 by webmail.orcon.net.nz
 with HTTP (HTTP/1.1 POST); Tue, 15 Sep 2026 20:24:31 +1200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 20:24:31 +1200
From: Phil Sainty <psainty@orcon.net.nz>
To: git@vger.kernel.org
Subject: GIT_WORK_TREE is not exported for post-checkout-hook
User-Agent: Orcon Webmail
Message-ID: <17f331aef833b34fbddbefd66c330465@orcon.net.nz>
X-Sender: psainty@orcon.net.nz
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GeoIP: --
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --

I have a post-checkout-hook shell script which indirectly calls
"git rev-parse --show-toplevel", and I've found that when that hook
runs for a checkout within a worktree directory, GIT_DIR is set but
GIT_WORK_TREE is not set, which leads to the CWD being returned
instead of the genuine toplevel value.

The script is seeing a GIT_DIR value like this:

     GIT_DIR=/path/to/repo/.git/worktrees/name

The only other git variables in the environment are GIT_EXEC_PATH
and GIT_PREFIX.

The outcome I'm seeing is explained by
https://git-scm.com/book/en/v2/Git-Internals-Environment-Variables#_repository_locations
which says:

     "If --git-dir or GIT_DIR is specified but none of --work-tree,
     GIT_WORK_TREE or core.worktree is specified, the current working
     directory is regarded as the top level of your working tree."

The current githooks(5) man page talks about this somewhat:

     "Environment variables, such as GIT_DIR, GIT_WORK_TREE, etc., are
     exported so that Git commands run by the hook can correctly locate
     the repository.  If your hook needs to invoke Git commands in a
     foreign repository or in a different working tree of the same
     repository, then it should clear these environment variables so
     they do not interfere with Git operations at the foreign
     location."

Unsetting GIT_DIR certainly fixes the problem, but I don't think that
ought to be necessary in my case, as my hook script is calling git in
the *same* working copy where the checkout happens.  It is not dealing
with "a foreign" repository [or] a different working tree".

My impression is that GIT_WORK_TREE should also be set for this hook
when dealing with a worktree.  I have tested this in git version 2.34
and 2.55 (maint) and also 2.56.0.rc0.355.g945ea7012d (next).

I have only tested post-checkout-hook, so I do not know if this
applies to other hooks as well.


[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.8.0-138-generic #138~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC 
Fri Aug  7 13:43:15 UTC  x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash
