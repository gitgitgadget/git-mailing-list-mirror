Received: from mail-24431.protonmail.ch (mail-24431.protonmail.ch [109.224.244.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AFC487BE
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765378905; cv=none; b=ZZ3dz0etgOE9AT/P4RWpSuzNzo3ahl3f66rxG0iv/DuL7kUfM7DbsinXsx5cjM7UjTEviOwH9YDQ5CpKrmTQboWkOBWTgsbNsa7gOY4/JIhKA8bK0vGh0ttrnpVHapVdimqGVkw2h+kUEVc0+9AcWqAj7Pl30qhwEAqr6u3+10M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765378905; c=relaxed/simple;
	bh=ezkT9LBe/nj6UrK1Ji1NTUWv18zpj/JDLlopqo+tSWk=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=g4Z5vzV1kAkBE3PnXz0EAK/ZEwLPZp9/7bMpH3uGfOGXUGYMWUywC7wIKWCoYJ6cKDTJ33Jg1G1g6oPoZvAQsrf1Me0csnagy9IJtfmOvWzrMSHQch1KtlwGCd8E1n4hX/J94+iG4it5kb9j9xCd0VTiA4HjM4oz/I8wIpEVcCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MI81Ejo7; arc=none smtp.client-ip=109.224.244.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MI81Ejo7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1765378900; x=1765638100;
	bh=QNCtcyF4W8I8oosawrFMu1NN6MPbikdudMC30skxG9k=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MI81Ejo7a1jgo7H0EJjLIyLd8MvJjGrynw1xX8RCrirbFQTIh7vtEapf+8Ka8HOyp
	 m+FHQmxgmDZDqNewg2hgo+b88d4oxoAP6GcebKesazm0oZDtE7RkvxmnkusrKr7EHD
	 n64930I57vUG8U9ybmdMRzoA4QHl0gEWDMU0o2T5WMLttPmKOYJiPwPXRqK8xBGJbq
	 LkdhenqGq7ERiDWNrcnwG5JnuR17aHy38COMe4aEoE7VOfeM0JWqS6wTGcy7B+DQle
	 MEoNPgp1uzGnU+P45HEodOggmc6VT0qAFh55XB2H0f1a63pbkWtq/YzIinVUGqBUWX
	 +Cg6SSCrfRAxQ==
Date: Wed, 10 Dec 2025 15:01:36 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Koutsouflakis Stefanos <koutsouflakis.stefanos@proton.me>
Subject: [RFC] reset --hard: warn before discarding staged content with no commit history
Message-ID: <a5wKtD6Tn0gzcba1IEUhukYnXPHxMwPq6puQKIPywmjNufi5vc6vX-v5BpPJ7qj_zZsuXF5FiS2gbpsurWmVjoWHtMm8A-kAbaZyjMfrTcs=@proton.me>
Feedback-ID: 140350232:user:proton
X-Pm-Message-ID: c988eff2c00bfb5e8d3319c65fffa03246ae3920
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When running "git reset --hard" in a repository where staged content
has never been committed, the staged files are lost. This seems like a case=
 where requiring --force could be helpful.

Reproduction:

    mkdir test && cd test
    git init
    echo "hello" > a.txt
    git add .
    git reset --hard

Result: a.txt is removed from both the index and working tree.
While the blob temporarily remains as a dangling object (recoverable
via "git fsck --lost-found" until garbage collection), this is not a
realistic safety net as the filename is lost and most users are
unaware of this recovery mechanism.

The most likely scenario is a user initializing a Git repository in an
existing project. They have a folder with files they've been working on,
run "git init", then "git add ." to stage everything. A mistyped or
misunderstood command later, their entire project is wiped out.

Proposed behavior:

When "git reset --hard" would discard staged content that does not
exist in any commit (i.e., the blob has no reachable reference),
print a warning and require confirmation or --force:

    warning: the following staged files have never been committed
    and will be permanently lost:
        a.txt
    use --force to proceed, or commit first

This would be consistent with Git's general trend toward safer
defaults.

Questions for discussion:

1. Is this safety check worth the added complexity?

2. Are there workflows where this would be annoying? (can't think of any bu=
t I might be missing something).

I'm happy to work on a patch if there's interest.

Thanks,
Stefanos
