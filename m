Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD48332AADB
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 01:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991474; cv=none; b=H9d4WGiHbX7SHZLeynZVBWgg0T13+1TbolRWTuWOv6jmj+LcDPE8dWnYVJl8tMe/lRmST4KBnOslV0s3cR9wKUG30Q60S3D9YMQdOY83itbymqAmrsa1AzBL13hrFKte7MiwUwik4KEUkF4D0ckFNhMGCxfCYxN5rbQiTkebTvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991474; c=relaxed/simple;
	bh=OugeHxMiMCJW3gjOcKK9g6SPK/vrYox2Vx9cxBAA6Ck=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=su/9+5KQ/OBTVxh0xBmcLq/aFXhu2FJbs9JVIgoEHr+1NhooyaKiMvihQhsGW8+skiKGv1VT0wMBib7L3+tdfGGc7GwGb0fT5+BWwWX8iWqtGhUrdo2DsZ1WLOrEzEqdGGe7WtB9zyzW41MWXqUFUJcD0Gnvr21Az6JTOU2dGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molly.im; spf=pass smtp.mailfrom=molly.im; dkim=pass (1024-bit key) header.d=molly.im header.i=@molly.im header.b=ybRY1Ip7; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molly.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molly.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=molly.im header.i=@molly.im header.b="ybRY1Ip7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molly.im;
	s=protonmail; t=1790991469; x=1791250669;
	bh=HVK8Nk5Ejbq3pJ6YvsyFaTCcVLqQm8bv828sWsKCS9M=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ybRY1Ip7s1CKvzePdX9MHwvCubtJpzRZO0eQVO8IacdjOceWkxRgwST6zcQ5MFvIY
	 avpf4sXfPp0dKmoyIoEwMw9psMaqXJyOsLGRdZsvLwIA4b68jLME4vFnYR6VNUil4P
	 G1W8HeCcMjLkS489+bc7w6BjGWgfOCokZsivwiis=
Date: Sat, 03 Oct 2026 01:37:44 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Oscar Mira <valldrac@molly.im>
Subject: [ANNOUNCE] git-carrier 0.1.0: park a stopped merge, land it later as a real merge
Message-ID: <DKZjdpQb-rCGMXf5m_vAwXJGqsNM5jacEb_nzx_qS46udko31UhnYZvppt-AmHdOasUzzGfs6xm69ziK4nstKM-ddNNm8HIBj1SLuEVPNMw=@molly.im>
Feedback-ID: 17485103:user:proton
X-Pm-Message-ID: 25e5d1afa29b3bf32949523d7acbda562d333c0c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I've just published a set of git extensions that park a merge that
stopped at conflicts as an ordinary commit, and land it later as a
real merge.

An idea like this has been proposed on this list several times, as a
solution to the problem of working with large merges. I believe ours
is the first tool to implement it in plain git.

I'm one of the maintainers of Molly, a Signal client fork of Signal
for Android. Upstream updates arrive in our tree as large merges
that generate many conflicts. I wrote this tool because we need to
distribute the resolution work across the team, so the conflict state
has to travel across clones.

git-carrier is one bash script that implements three git commands,
with no dependencies beyond git and standard Unix utilities:

  git park --branch carrier/v1.2.3
      Moves the stopped merge onto a carrier branch, without
      recreating the merge, and stores the conflicted paths under
      a .hangar directory in ordinary commits.

  git unpark -- <path>
      Takes a parked path back out of the hangar. If the file is
      unchanged, it reopens as the conflict git left, so
      `git mergetool` works as usual. If you changed or deleted it,
      the working file is the resolution.

  git land <dst>
      Stages the finished work onto the destination without the
      .hangar directory, and writes MERGE_HEAD. Then it stops, and
      you run `git commit` to finish the two-parent merge.

Everything in between is ordinary git. The carrier branch is pushed,
reviewed and cloned like any branch. The work left is the
.hangar/stages/<path>/ directories at HEAD, and a path is released
by deleting its directory, which shows in any diff. No new ref
namespaces, no server-side changes.

The tool was designed to meet our needs. We read the list's discussions
of the same problem only afterward, and it was a happy convergence.
In June 2020 this list discussed how to pass a partially resolved merge
on to the next person [1]. Junio's answer was that the important and
useful part is the data format used for that hand-off [2]. Chris Torek
sketched what the format holds [3]; his sketch reads like a description
of the hangar:

    resolved entries          the carrier's own commits
    stages 1, 2, 3            .hangar/stages/<path>/{1,2,3}
    the working file          .hangar/stages/<path>/w
    the merge's own context   .hangar/manifest and .hangar/message

And the 2025 contributor summit expected external tooling to cover this
until first-class conflicts exist [6].

I want to share the design, because the format is the useful part for
this list. The spec is on its own page, CC0, and git-carrier is just
one possible implementation. That said, the spec was written after the
first implementation and can have gaps; the script does more than it
explains.

Notes on the decisions, since the list has positions on them:

  * Out of tree. The thread's advice was to implement it outside
    git [4], and to help distros bundle good tools rather than
    integrate them [5]. We are not proposing contrib/ or core
    inclusion. But we would love to list the tool on the git wiki's
    tools page.

  * If everyone in the loop runs jj, it is a good alternative: jj
    makes conflicts first-class committable state. This tool is for
    loops where some resolvers, CI, or agents are plain git.

  * The carrier branch carries conflict markers by design. It is a
    handoff, never merged directly, and the landed tree is the
    carrier's tree minus .hangar.

  * Merge conflicts only, for now: no rebase, cherry-pick, or revert
    parking, one merge source, no octopus, no submodule gitlinks.

A note on confidence: the tool is brand new. The bash code was mostly
authored through several LLM iterations, and the commits carry
"Assisted-by: LLM" trailers for that reason. We reviewed and tested it
extensively, but it could still be wrong somewhere. The bash file grew
bigger than expected, and I know we pay for that in maintenance.

I built it with care, and I hope it is useful.

  Repo:  https://github.com/git-carrier/git-carrier
  Spec:  docs/hangar-format.txt in the repository, CC0.
  Tool:  one bash file, MIT, with a bats test suite. It needs bash
         3.2 or newer and git 2.34 or newer.

Thanks for reading. Comments welcome, especially on the format.
Bug reports even more.

Oscar Mira

[1] https://lore.kernel.org/git/BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5P=
R19MB3400.namprd19.prod.outlook.com/
[2] https://lore.kernel.org/git/xmqq1rmgxo67.fsf@gitster.c.googlers.com/
[3] https://lore.kernel.org/git/CAPx1GvdT6sZRtu8q1R9=3DfA-mE9pi1Ag-gKEzQfwb=
Gap+KqSoSg@mail.gmail.com/
[4] https://lore.kernel.org/git/874kr92xyz.fsf@osv.gnss.ru/
[5] https://lore.kernel.org/git/xmqqa716zs7w.fsf@gitster.c.googlers.com/
[6] https://lore.kernel.org/git/aOQV%2Fja9Ltw%2FbTP3@nand.local/
