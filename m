Received: from thechases.com (thechases.com [54.39.151.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3A815E1E3
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.151.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966653; cv=none; b=nR3jwJbnCr5uNGSppt8X2Bxs7GOIvc4BuumxhYsUIrYyOQnr6Ab9F0Iscu98gKNrgdkHQbIaUevDxmIp1wcOUabHLjHWE+iFOYxQeIOSVNHP8g2s5BNjsuc9lsj19++XBcHEOuxDxssv1hCF9N2zj0O9H3kN+6xqyyacsMQs4gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966653; c=relaxed/simple;
	bh=ZsTu2f+yT/qt3Tcg2k+1tWX1O0pMj5VV/TzCm35zFN0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q1jQkjO3+zjl3V3Dsh1NyzJ/XNO9wO9WAzmh9g+u+eCSOmsypH7CeCbzekHPdMO7U5Vcqy1NVBm6GH2LQy+PQDly1FbTIuNVEwubLgFDmTnELnHu1CWewMe1hoPAMBgiq7684SfyhreYJRag87lGmTWAfWQjMhwTA9ELO4LLsVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tim.thechases.com; spf=pass smtp.mailfrom=tim.thechases.com; arc=none smtp.client-ip=54.39.151.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tim.thechases.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tim.thechases.com
Received: from localhost (thechases.com [local])
	by thechases.com (OpenSMTPD) with ESMTPA id 9e153548
	for <git@vger.kernel.org>;
	Wed, 24 Apr 2024 13:44:09 +0000 (UTC)
Date: Wed, 24 Apr 2024 08:44:09 -0500
From: Tim Chase <git@tim.thechases.com>
To: git@vger.kernel.org
Subject: Stashing just index..working-copy rather than HEAD..working-copy?
Message-ID: <ZikMqXeDnOqK_wlq@thechases.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A while back[1] I'd encountered a situation and sparred my way
around it, but was hoping there was a better solution.

I'd done a

  $ git add -p

to selectively add things that I wanted in the next commit.
So I wanted to stash the changes that appeared in

  $ git diff

and test just the changes I was about to commit so I did a

  $ git stash

However, that reset my index and stashed everything HEAD..working-copy.
Okay, my fault.  There's a --keep-index that isn't default, so I
carefully re-staged my commit with another

  $ git add -p

and did

  $ git stash --keep-index

to keep the index.  Great.  My index was still good.  But when I went to

  $ git stash pop

as described in `git help stash` under the "Testing partial commits"
it generated conflicts because it had still stashed HEAD..working-copy
(as confirmed with a `git stash show -p`) rather than index..working-copy
and some of those popped changes were already in the working-copy/index.

To work around it, I re-staged my index yet again:

  $ git add -p

and then did

  $ git diff > temp.diff
  $ git reset --staged

did my testing, and then re-applied the temp.diff patch to the
working-copy to get back to where I'd been.  Conflict-free as
expected.

As a slight improvement, /u/splettnet suggested actually committing
a dummy-commit:

  $ git add -p
  $ git commit --allow-empty-message
  $ git stash

at which point I could build/run/test and then resetting to uncommit:

  $ git stash pop
  $ git reset --soft HEAD~1

which I've been using since.  However, I was wondering if there was
a better way to instruct git-stash to stash index..working-copy
instead of HEAD..working-copy (and leave the index alone in the
process) in the first place.

Thanks,

-tkc

[1]
https://www.reddit.com/r/git/comments/vchu83/stashing_only_unstaged_changes/





