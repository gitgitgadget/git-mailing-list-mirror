Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558501D54E3
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694004; cv=none; b=LQExkNg144T8l3f2eIO+p0vNH0HPtXAYob/NEyAKCRRRw+1LzXsv4T5KtgGh93OHkuCOwl/DacuXUbn9yCeSguOQogx5eG6oCtt9732uFx4TZo6sctYtZzgHRu2NHoT5cP1uyPgvh8ahOxiMDOZ3qIT1R0WMDhMvTY30WFE1JdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694004; c=relaxed/simple;
	bh=MoP6UL6mNUwHJtfou53IhgvZp55JyrOUTBAkp1dOETU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=h8dYmgtlhVkrPmA47nYEjKxmILaGvXERMJ/Qq4GZ+1xko1J0eSAGrJoWdF/UR0Vi6xYdevG8bN31C5Z622brlSKwsYVJNi7boarBqkX2EdXVND+mjO6JLFJ0Wh62yWLmGqfCiqxL+OGXY+ZJf+fPg+PZn2OpBejUw3nqrlN8Qdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4cNflY1rFdzRnPx;
	Fri, 12 Sep 2025 18:19:53 +0200 (CEST)
Message-ID: <c9794ca2-0822-485f-a10f-6ecefa7275d1@kdbg.org>
Date: Fri, 12 Sep 2025 18:19:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: The case of `git update-ref MERGE_HEAD`
To: Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Cc: Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

When I commit a merge, the commit message shows this advice:

# It looks like you may be committing a merge.
# If this is not correct, please run
#       git update-ref -d MERGE_HEAD
# and try again.

However, when I follow the advice, I get this error:

$ git update-ref -d MERGE_HEAD
error: refusing to update pseudoref 'MERGE_HEAD'

Also, I found a use case to set MERGE_HEAD to a particular commit, but I
can't do that, either:

$ git update-ref MERGE_HEAD e9c115e666fd6a3faaf187f5d145b32861a45cc8
fatal: update_ref failed for ref 'MERGE_HEAD': refusing to update pseudoref 'MERGE_HEAD'

I know I can do

$ echo e9c115e666fd6a3faaf187f5d145b32861a45cc8 > .git/MERGE_HEAD

in the primary worktree. But I needed to do this in a secondary
worktree, where this is more like

$ echo e9c115e666fd6a3faaf187f5d145b32861a45cc8 \
     > "$(git rev-parse --git-dir)"/MERGE_HEAD

which is a bit unwieldy...

8e4f5c2dc26e ("refs: refuse to write pseudorefs", 2024-05-15) removed
the ability to wrangle pseudo-refs with `git update-ref`. Much earlier,
b6d2558c9ea3 ("builtin/commit: suggest update-ref for pseudoref
removal", 2020-08-21) changed the commit message template with the
justification:

> [S]uggest a "update-ref -d" command, which will work regardless of
> ref storage backend.

Looks like we couldn't uphold the promise. Any suggestions?

-- Hannes

