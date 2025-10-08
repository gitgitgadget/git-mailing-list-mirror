Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04871284884
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759957715; cv=none; b=ijABLBktVYgdBnKZn6opqG4sR7Z7kGH15l+mYSSruoPljior/T7hdo0x4hxhyFFo0uT48zWBYLDe2Zm0XPeYlsmTYTf5YepxcLgebrEuWkHFLGQRVsQGjYnZWofRxQ2OAG0R9u3SHJD710hK3Eu4stMJgu+AmvBB1gNUv6xv5mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759957715; c=relaxed/simple;
	bh=+lW+/0qB7BNvhmlYpzWTlBYAyzJdRmBjPYgGEO8+TaI=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=nEZ+QncquPUvL/G9xxFNruacWIE0cuYrrOhubmTU45HG/7GxQZM6wUxXYXMl4b/ns3ZhoCJXafnHhqtSvPRujVytWsOqGPrs89v8Gb5sZb7ZmnyTQZV3ER1Cjp6+p3ehcoq5I4B/0cKIkfFshHYX4WA89XyFIhKMuLdhKp26a7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=IPiv06bG; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="IPiv06bG"
From: Michael Lohmann <git@lohmann.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1759957324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PlXFoi4mK0v3rO62goplrbZHL3MKR7IKIfsDulqbcmk=;
	b=IPiv06bGUiddvSL3NRL/45ihOfCuzzPchzABaXYau/waexpXpkL+hMhskt3/2ABY5uO/Oo
	+baVslX7CLekGc8Z05vS3zveh7FEhpfD+TlJM+aLdMkl+VIWMnJ+1p09oj6sYdp9pL7MRM
	OTik7WUb3BuMMSyNNmVCt1LJh8DKoEMHztDwUOqg48wiGT1FRP6B0zYmITF9NIr4rpD/C1
	OSQhH72qYRs7BD4hmMQxNa993cz4JEdNQsGrde+ZEwquM2OZObDImBh7U/Q/7QjRZnn37l
	HZT1YRd2YZzAXvORTCeXAwRwTbW/7FbUXC+4J8pIjQ5L8mKAlawqDKOtfG/opQ==
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.33\))
Subject: [RCF] Secure git against involuntary arb. code execution without
 feature loss
Message-Id: <72F10412-8B0F-4F66-8674-FE194D016DF9@lohmann.sh>
Date: Wed, 8 Oct 2025 23:02:03 +0200
To: git@vger.kernel.org

Hello everyone,

Hooks, as well as certain config (e.g. `core.pager`) can do automatic
code execution for you. In general, this is a great feature and should
be kept without the user noticing any changes.

BUT if you download a random folder which to you unknowingly is a repo
and either you or e.g. your command line prompt automatically executes a
simple `git status`, it feels bad if this results in arbitrary code
execution (ACE), e.g.:

 =
https://www.sonarsource.com/blog/securing-developer-tools-git-integrations=
/

and

 =
https://github.com/justinsteven/advisories/blob/main/2022_git_buried_bare_=
repos_and_fsmonitor_various_abuses.md

Apart from one core maintainer, all git user I talked to were surprised
and shocked by how simple an exploit like this was.

* Proposed solution (keeping all existing features):
- On first use, git generates a secret "token" (e.g. a random string in
  ~/.gitsecret)
- On calling `git init` or `git clone`, the secret is copied into the
  new .git directory and serves as proof that this clone was created by
  this user
- Before executing any user-defined code, check for the local token:
  - If present, proceed as usual.
  - Otherwise abort.

* Benefit:
- Protects users from ACE when interacting with untrusted repositories.
- Editors would no longer need to prompt the user for "Do you trust this
  repository?" in most cases, because git could prove the clone is user
  generated.
- For new clones, the user wouldn't even notice a change.

* Drawbacks:
- Existing clones would need manual approval once (e.g., via a new
  `git allow` command).

* Migration strategy to ease adoption (risks to be weight up):
- A future minor release of `git` could already silently add the
  token to all clones it is executed in.
- Even if the repo was malicious, ACE has already occured,
- Since the ACE would have already occured, chances are, other forms of
  persistence had been taken
- By the time git 3.0 introduced the breaking change, most active clones
  would be migrated, so users would only manually need to act, if they
  have very infrequently used clones.

* Prototype:
On my machine `git` resolves to a 150 line bash wrapper script with a
rough implementation this proposal:

 =
https://git.lohmann.sh/michael/nixos-config/src/branch/main/modules/git.sh=


With that, `git` is no longer vulnerable against these kinds of attacks.
I also added some more background information/POC in a blog post:

 https://www.lohmann.sh/en/nuggits/002-dangerous-git/

Yes, I know even despite the "silent migration" this would be probably
lead to some pain for some people on the initial adoption of git v3, but
it would make it much safer for everyone to use and in the long run,
nobody would notice. What are your thoughts of weighing long-term risks
with the short-term pain of adopting something like this? Any other
ideas on how to solve this even better?
Feedback welcome!

Michael Lohmann=
