Received: from donotpassgo.dyslexicfish.net (donotpassgo.dyslexicfish.net [209.250.224.51])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C241FB5
	for <git@vger.kernel.org>; Sun, 28 Jul 2024 03:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.250.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722138425; cv=none; b=scgixzWSLfez7J8Mu9YpzxH+P0Bi+1TwtUCwzM1/8/5INBd+eHh91LWRXXKUQYyWcX7IKybWTJykqy48FNgacaTUbNLNSffvrjS+2ECj85xJC6AXGH6j8IIY2JUw4dj6ZFjhwt3jOlYsQ9TiMILtCXVXSLqZcU+PTwvL5tsxfs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722138425; c=relaxed/simple;
	bh=G5Zz4Qe0mLdf+dt9hDRzSz93cH45+Ssr/ja6fxQcrqI=;
	h=From:Message-Id:Date:To:Cc:Subject:References:In-Reply-To:
	 MIME-Version:Content-Type; b=PavmJFGa0ykgxe9LBhcOaHbRxlMb1tJghhp1A5TA7esQpyakLOJ1M31qsNm3VfiDLpV4mmbDL+zAcHEKzDKFrF0GUVDTVsSrNolfMQWzIuimRNZYD9pB06iR/gDlmm43pHEy9qWu2CRPx4o3/Ek9CZ4TSaR3yCKWYy6jY4lvM38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=catflap.org; spf=pass smtp.mailfrom=catflap.org; arc=none smtp.client-ip=209.250.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=catflap.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catflap.org
X-Catflap-Envelope-From: <jamie@donotpassgo.dyslexicfish.net>
Received: from donotpassgo.dyslexicfish.net (donotpassgo.dyslexicfish.net [209.250.224.51])
	by donotpassgo.dyslexicfish.net (8.14.5/8.14.5) with ESMTP id 46S3khug005130;
	Sun, 28 Jul 2024 04:46:43 +0100 (BST)
	(envelope-from jamie@donotpassgo.dyslexicfish.net)
Received: (from jamie@localhost)
	by donotpassgo.dyslexicfish.net (8.14.5/8.14.5/Submit) id 46S3khd9005129;
	Sun, 28 Jul 2024 04:46:43 +0100 (BST)
	(envelope-from jamie)
From: Jamie Landeg-Jones <jamie@catflap.org>
Message-Id: <202407280346.46S3khd9005129@donotpassgo.dyslexicfish.net>
Date: Sun, 28 Jul 2024 04:46:43 +0100
Organization: Dyslexic Fish
To: Johannes.Schindelin@gmx.de, jamie@catflap.org, gitster@pobox.com,
        drankinatty@gmail.com
Cc: msuchanek@suse.de, git@vger.kernel.org
Subject: Re: Local git server can't serve https until repos owned by http,
 can't serve ssh unless repos owned by user after 2.45.1
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
 <xmqq8qz376fb.fsf@gitster.g> <20240617211513.GM19642@kitsune.suse.cz>
 <20240625072419.GU19642@kitsune.suse.cz> <xmqqr0cl6lxl.fsf@gitster.g>
 <202407260038.46Q0ctEV083266@donotpassgo.dyslexicfish.net>
 <5747ba0d-7268-4538-9705-11650a7d6e35@gmail.com>
In-Reply-To: <5747ba0d-7268-4538-9705-11650a7d6e35@gmail.com>
User-Agent: Heirloom mailx 12.4 7/29/08
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.7 (donotpassgo.dyslexicfish.net [209.250.224.51]); Sun, 28 Jul 2024 04:46:43 +0100 (BST)

"David C. Rankin" <drankinatty@gmail.com> wrote:

> I too am stuck. It's a damned if you do, damned if you don't Hobson's choice 
> of git repo ownership on the server. All worked fine serving both https and 
> ssh prior to the change, now it is either one or the other but not both. So 
> either your read-only pulls and clones are hosed, or your read/write are.

Thanks for the reply. I guess I'm potentially not as stuck as you, because
I don't require ssh access to the repos - they are just mirrors. I have one
unix user that updates the repository, and the cgit and git https backends run
as another suexec user exclusively for that task. However, I'm not going to
compromise security by giving the web user effective write-access to the files
it only needs read access to.

> If more info is needed, let me know and I'm happy to privide it.

If you have any solution, I'd be grateful to hear. I'm a bit puzzled to
what's going on though.

From what I gather, the idea was to stop a client user from unintentionally
running potential hook scripts that could be evil. A similar protection was
already present, I note, for other methods (I couldn't run git log and other
commands directly on a repo i had unix-level read access to, but were owned
by another user until I added the safe directory thing in .gitconfig)

Closing this hole to make security more consistent is fair enough... however,
in the case of git-http-backend the "safe directory" method doesn't work at
all!

Is this an accurate summary of the situation?

As an aside, do you know why this security mechanism blocks ALL access, and
not just the execution of hooks? - my mirrors don't have any hook-scripts,
and as long as I give them read access at the unix level, why are they still
blocked from doing things like "git log" on a repo without having to first
mark it as safe?

Cheers, Jamie

