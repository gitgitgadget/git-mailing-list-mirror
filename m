Received: from hermes.quinlan.cloud (hermes.quinlan.cloud [185.53.57.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9581431E831
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 00:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.53.57.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792197686; cv=none; b=C9uIo86LM31TYtF2EPfqtDf8531H/Wsdzi0UfszM3AwGyeh9l7qtufAu1m18csg1ayvHxQ07UgAT9jytnfglE0KIgpDHfSxTRtNYuPFwtg1CjfmoXWUXrxPBwLzfV3aP2UtG0ixhru6N/bgCRZpHRJ11oLAGiL4Wjj0e1ifIwzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792197686; c=relaxed/simple;
	bh=78DGprY0+Ko3Ny182ivUpYdAgQxXOAa369WtLbNFKqY=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=AlU1wQ3nJ1JBr5ak+fjD9Y1Mml3u8c1LM6rEH946NjXVXRnJTHBYdT9LjYWjvVY+OzZHkUiF4YlwP9UPGY/mzW481Fs4mgFMZrWGUWf8whXXaHdrJuf77pbej8ZbAsm8up8f5EqEUuYn7yachuXrooSxxrY726LTQlbcyfKFni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=donquinleone.com; spf=pass smtp.mailfrom=donquinleone.com; dkim=pass (2048-bit key) header.d=donquinleone.com header.i=@donquinleone.com header.b=Bpr74QrM; arc=none smtp.client-ip=185.53.57.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=donquinleone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=donquinleone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=donquinleone.com header.i=@donquinleone.com header.b="Bpr74QrM"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 2F3B942320;
	Sat, 17 Oct 2026 01:35:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=donquinleone.com;
	s=hermes; t=1792197326;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=yqMisASVJMvsXw/v845SXsB/R5LjySUPSyQ4T2myDz0=;
	b=Bpr74QrMuRQN9O0/vBtjOOyimwtPTDqX6CjfVISUCoOOLWFOolm0mTcAMhCYuH1hofDejD
	KmHYy/A3PeHRxNe5Z3V1fJ7devC46UbhQZtEtaPTDh0YiBSDYgH8K4CjRzCacpJfF2/n8p
	a2YE5HhT6Tg0/3Ex9Gb5iPPNDqAbNzyvPQk+mxWr92OxgFDGvY5QZsjzv7mswruzWWJw7g
	sb4A7SvBkLdMYR0kqWFvotBRNKbkCvejQ/gt4FJGKXz+6bTb0AxthzEJx0WcgWM0sbWH/6
	edS2uW+jJ1MHKhNuw6vAN57cuxJBJg6TWLGoUOgmQVhI9XsDmgyhMZfR0dKowQ==
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 17 Oct 2026 01:35:25 +0100
From: DonQuinleone <don@donquinleone.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Harald Nordgren
 <haraldnordgren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [RFC] branch: delete gone-upstream branches only when proven merged
 into a named ref
Message-ID: <a8561fb7c2da446e7f7acc7e2a443991@donquinleone.com>
X-Sender: don@donquinleone.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: None

Hi all,

This is my first time posting to the list, so good to meet everyone,
and thanks in advance for bearing with me.

I've just noticed that "git branch --delete-merged" is now available,
and that it never deletes a topic in the workflow that hosting
services (e.g. GitHub) encourage. Before writing a patch, I wanted to
ask how the list might consider closing that gap.

In that workflow, the topic tracks and pushes to a branch of its own
name; when the pull request is merged with a merge commit, the server
deletes that branch. With master as of c51408889:

  $ git push -u origin topic
       ... merged on the server, and origin's topic deleted ...

  $ git fetch origin
  $ git branch --dry-run --delete-merged 'origin/*'
       ... spared, as pushing would update the upstream ...

  $ git fetch --prune origin
  $ git branch -vv
  * master 61e9886 [origin/master: behind 2] base
    topic  87d0c48 [origin/topic: gone] topic work
  $ git branch --dry-run --delete-merged 'origin/*'
       ... skipped, because the upstream is gone ...
  $ git merge-base --is-ancestor topic origin/master && echo merged
  merged

So the branch is provably merged, but at no point in this workflow
will --delete-merged remove it. A script reproducing this is at the
bottom.

From reading back through the archives, this is deliberate. When v7
of the series fell back to the remote's default branch for a gone
upstream, Junio wrote [1]:

> If the upstream itself is gone, removing anything based on some other
> criteria cannot by definition a "safety check".

I agree that a vanished upstream proves nothing, so I would like to
propose separating selection from proof:

"Upstream gone" may select a candidate, but it is never proof. The
only proof is that the branch tip is reachable from a ref the user
names explicitly, so nothing is inferred: neither HEAD, nor the
remote's default branch.

I can see two possible shapes.

(A) A modifier on --delete-merged:

  $ git branch --delete-merged 'origin/*' --into origin/master

Branches whose upstream matches the pattern but no longer exists would
become candidates, and would be deleted only if their tip is reachable
from the named commit. check_branch_commit() would be handed that
commit in place of HEAD, as suggested on v7 [1]. Branches whose
upstream still exists would be judged exactly as today, and the
worktree, stacked-branch and deleteMerged=false exclusions would still
apply.

(B) Composable filters on -d:

  $ git branch --upstream-gone --merged=origin/master      # preview
  $ git branch -d --upstream-gone --merged=origin/master   # delete

--upstream-gone would be useful on its own for listing (today the
usual approach is to grep "git branch -vv" for ": gone]"). But it
turns -d into a second bulk-delete mode beside --delete-merged, and
--merged defaults to HEAD when it comes last, so a forgotten argument
would quietly bring back HEAD as the proxy.

I lean towards (A) because it is small and keeps every existing
protection, but I'd rather settle the shape here than assume anything.

So:

 1. Is "selection is not proof" an acceptable basis for touching
    gone-upstream branches?

 2. (A), (B), or something else? If (A), is there a better name than
    --into (--merged-into?), and should it stay limited to branches
    whose upstream is gone?

I would leave squashing and rebasing out of scope, in keeping with
--delete-merged staying "one stable and strict" operation [2]. I've
Cc'd Harald, as this relates closely to his in-flight --delete-merged
topics [3][4], and Phillip, who reviewed the series.

Thanks in advance. Look forward to hearing what people think.

~ Don

[1] https://lore.kernel.org/git/xmqq5x4sn393.fsf@gitster.g/
[2] https://lore.kernel.org/git/xmqqy0c21gq1.fsf@gitster.g/
[3] https://lore.kernel.org/git/pull.2428.v2.git.git.1791102886740.gitgitgadget@gmail.com/
[4] https://lore.kernel.org/git/94a6d23f8b96d4a07fb58c71f4a2f7dc4d3055bc.1791711665.git.gitgitgadget@gmail.com/

-- >8 --
#!/bin/sh
set -e
export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1
export GIT_AUTHOR_NAME=A GIT_AUTHOR_EMAIL=a@example.com
export GIT_COMMITTER_NAME=C GIT_COMMITTER_EMAIL=c@example.com
cd "$(mktemp -d)"
git init -q --bare -b master origin.git
git clone -q origin.git work 2>/dev/null && cd work
git commit -q --allow-empty -m base && git push -q origin HEAD:master
git switch -q -c topic && git commit -q --allow-empty -m "topic work"
git push -q -u origin topic 2>/dev/null && git switch -q master
git clone -q ../origin.git ../server && (cd ../server &&
	git merge -q --no-ff -m "Merge topic" origin/topic &&
	git push -q origin master :topic)
echo "after fetch:";         git fetch -q
git branch --dry-run --delete-merged 'origin/*'
echo "after fetch --prune:"; git fetch -q --prune
git branch --dry-run --delete-merged 'origin/*'
git merge-base --is-ancestor topic origin/master && echo merged
