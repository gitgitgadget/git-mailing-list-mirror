Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997652264BB
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767114477; cv=none; b=B0FCSVy9UpXWJw/HT07rXGXVbcaainkTqlIJ05HwV62j7tEFCbMdnR1fHMeTAHAWrcTwqk9i7+MrfOgPkImY6LPGashozzuE5Uu9rRCPB2ZCFgntfR+jYyh1ni4MBZAfaKWGqjZNdVtHmyIHXcdqXn4faok6BWrR0DQ/yGAb/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767114477; c=relaxed/simple;
	bh=nMWWspLxZ6ipNKtn7H1vO2928CTeNCDXkM9/zfpvUSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qViLMustkLObSu/7Ri1OJE3Q3hf1tjkBuQsYcwXJZaraU28ZuQlLQ2vSCWe4cCgEjnwQO6/jZ57yNtJ3BctBuGLxtPf5cCbue+flCZVLalZaE/2veVhplw7+zTFDElMy5hcPJ3qkU/QXIUQMxH8xfUZvpxhDbofjBjgjWyvG/CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.dietrich.pub; spf=pass smtp.mailfrom=mail.dietrich.pub; dkim=pass (2048-bit key) header.d=mail.dietrich.pub header.i=@mail.dietrich.pub header.b=XD1AdsAu; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.dietrich.pub
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.dietrich.pub
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.dietrich.pub header.i=@mail.dietrich.pub header.b="XD1AdsAu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.dietrich.pub;
	s=protonmail; t=1767114457; x=1767373657;
	bh=Fdeq36+H/i7pSSwZWwNSlBzJSyx9QwdNhISYTsv5Fi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XD1AdsAu0n8Hrbg4TYlgm9BwJQfnUc/vIIFS3z/OtnS0Sk8Z/DoPrAeGHlN/bEUbA
	 lyNK+nWoMSeaWfpRBfJ3nxR5DoJ4cWyjWkoUXpKTsdshKKz15pawD+dut8klECGRWN
	 IQQgZyNam4Hb7NlAj6FQhIq2WfmAZ/w8HnkXC1vbHDEDbwkheyb35FmtabJLcvuy7b
	 o4ntCy0hnJxGhovQxJBMzbyX3o5x2pHgK+7ou13a76AEpcQA95YPDHynBacppq3dHa
	 CNv5Vr6pVlcZH2Swlscladso+VGVEBj+rRI7PD9kcXjJStFriDDN0XKcxtbSMgScYR
	 HGQY0BeRSddKg==
X-Pm-Submission-Id: 4dgffH6gscz2Scck
From: george@mail.dietrich.pub
To: george@mail.dietrich.pub
Cc: git@vger.kernel.org
Subject: Re: [Bug] Git subtree regression
Date: Tue, 30 Dec 2025 12:07:19 -0500
Message-ID: <20251230170719.845029-1-george@mail.dietrich.pub>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <176677910605.6.2281395015810449820.1087545551@dietrich.pub>
References: <176677910605.6.2281395015810449820.1087545551@dietrich.pub>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
I explored this more and think I found the root cause.
Commit `83f9dad7d6fb5988b68f80b25bd87c68693195dd` changed `should_ignore_subtree_split_commit()` to examine only a commit's own trailers via `git show --format='%(trailers:...)'`.
The old code used `git log -1 --grep=...` which had the important side effect of searching through ancestor commits.

In a multi-subtree monorepo with this topology:

```
  main:    A---B---M---E    (B = subtree add --squash for subA)
                  /
  feature:   C---D          (D = subtree add --squash for subB)
```

When splitting `subA`, commits `C` and `D` from the feature branch should be **ignored** because they belong to a branch that only contains `subB`, not `subA`.

## Old behavior (2.51.1)

`git log -1 --grep="git-subtree-dir:"` on commit `C` would traverse ancestors and find `D`'s subtree markers for `subB`, correctly identifying `C` as belonging to another subtree's branch.

## New behavior (2.52.0)

`git show` on commit `C` finds no trailers (regular commits don't have them), so `C` is **not** ignored.
This breaks the split because both parents of the merge `M` are processed, but `C` has no cache entry, leading to disconnected history.
Thus, split operations produce fewer commits than expected with broken parent chains, breaking push/pull workflows to upstream subtree repositories.

## Reproduction

This can be reproduced via my monorepo: https://github.com/athena-framework/athena

```bash
# 2.51.1 produces correct result (matches the number of commits in the `athena-framework/clock` repo)
$ git subtree split --prefix="src/components/clock"
4ee66f8198b2532110b75a36575e363ccccff47e  # 20 commits, connected to remote

# 2.52.0 produces broken result
$ git subtree split --prefix="src/components/clock"
0efb3d9858e3bfee65165508aeeacc50417c9a99  # 7 commits, disconnected

# The commits have identical trees but different parents:
$ git cat-file -p 4ee66f8198b2532110b75a36575e363ccccff47e
tree 8333b0cbb2a10528f8c803812af7a8e603e70367
parent d72f22f28ca5ed57ef3c2df74f0abd5569ac5934  # Connected to 19-commit history

$ git cat-file -p 0efb3d9858e3bfee65165508aeeacc50417c9a99
tree 8333b0cbb2a10528f8c803812af7a8e603e70367
parent 81c5dbe70ce26a7758fbe7f87b3ce0704043cfb1  # Only 6 commits, disconnected
```
