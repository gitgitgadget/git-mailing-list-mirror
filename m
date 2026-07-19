Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34CA43F0B5
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784429184; cv=none; b=V1x+2FJk9KacVIqAEC9XzA9vE1dcTUMwL4v/lATIOwqgOwJI8+ia4FDHSu2n0rabuKwpWfLYY0Yo0tzNQjdzFhfNv1+FogHtJ4hULUy2Cfh8Iu63F0bQ5QUdl/vcNlxShqeKIGHKI13SpNdYNGt375GAJdsARN7/7x19dfDs0RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784429184; c=relaxed/simple;
	bh=iY7NSDw8yn6O1+ld22Uvw+9voHaMJ+FntLVinCSewMs=;
	h=Date:Message-ID:Subject:From:To:Content-Type; b=BJv6uug98NYFiZBbph9TwxWOkGmOV1a24C8D/SwZeZc3tfpM6uPOhE1Mu2hXbzPD2CfGss8bzejT0lOj32PPSX0EY2H9DErymCxf1aZ8+gtZ0l1fshOmr0swNSCfxeaQ0mgrrP5e6SIAdslrzLWzNvfoRqMLuAxSqANx0Uy4Bvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=JFuwByA+; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="JFuwByA+"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 0D62487287
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 04:46:12 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M8MBytK8P-lt for <git@vger.kernel.org>;
 Sun, 19 Jul 2026 04:46:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1784429171; bh=iY7NSDw8yn6O1+ld22Uvw+9voHaMJ+FntLVinCSewMs=;
	h=Date:Subject:From:To;
	b=JFuwByA+9oWLnT36thlMbpoJnza3i5akXxdg6O9jOnnXBIg3fkSU1BkQ2XwebuZtG
	 0t9mlkLMlceoUKbIGiRpgg6ceNNDiLfkLJmQY1vemx9yfms9a4DWsOm/hoZFymHiPh
	 UbpXRdelSedf68JjTbKCa+YXmKBbvDyZi3HHC1iDwb90sEfJ09ZNjDJr1qIj1CHHIK
	 ETMZhi8H/AVbCao97O8kGUQiYy4vzk9IP484/cpZxKuJABkSpy89e3CJXAsGhD14RR
	 xA/RSVj3PQCrC9kOY/MVK0OsC8seNmIXi4uOeEM6uhz/qGrE7s5prZJh8NbKRDJlIr
	 VSrvpQWkEt3yQ==
Date: Sun, 19 Jul 2026 05:46:09 +0300
Message-ID: <6b78724639d248e0fa9089035b1ff2fb.sporteka2@disroot.org>
Subject: [Feature] linked files — one source, multiple paths, always identical
From: sporteka2@disroot.org
To: git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>

Hi all,

I would like to propose a 'linked files' mechanism for Git: a file can be
declared to mirror another file in the same repository, so the two are
always byte-identical. The tooling would enforce identity and keep the
copies in sync automatically — no manual copy, no symlink, no commit hook.

== Motivation ==

Many projects need the same source file available from multiple paths:

- a library core reused by an example folder
  (examples/demo/core.js must equal the root core.js);
- a shared header copied into submodules;
- documentation snippets embedded in several places.

Today the only ways to keep them identical are:

- Copy — drifts whenever one side is edited;
- Symlink — breaks on some archive downloads and cross-filesystem;
- Hardlink — lost by every git checkout / git reset;
- Commit hook — a workaround, not a platform guarantee, and runs only
  at commit time.

None of these guarantees that the files are identical at any moment,
which is what a maintainer actually wants.

== Proposed mechanism ==

Add a declarative file (e.g. .gitlinks, similar to .gitignore) mapping
a linked path to its source:

  .gitlinks
  # linked path            source path
  examples/demo/core.js   core.js

The tooling would then:

- On commit — reject the commit if a linked file differs from its source
  (or auto-overwrite it from the source);
- On checkout / clone — materialise the linked file from the source
  (hardlink when the filesystem allows, otherwise an identical copy);
- On archive / ZIP download — keep the link so the downloaded tree
  stays correct;
- On edit — editing either path updates both, so divergence is
  impossible.

== Why this belongs at the tooling level ==

Git already stores content-addressed blobs, so two identical files share
one blob internally. The missing piece is a working-tree guarantee that
the paths stay identical.

== Concrete first step (smaller scope) ==

Even without full 'linked files', a valuable first deliverable would be:
git archive should preserve hardlinks between identical files, the way it
already preserves symlinks. That alone would let a maintainer hardlink a
file locally and have the archive keep the two entries pointing at one
object.

== Alternatives considered ==

- Submodules / subtrees — heavier, separate history or full copy, not
  'same file'.
- Symlinks — already preserved by git archive, but break on some download
  tools and cross-filesystem.
- Commit hooks — work only at commit time, easy to forget, not enforced.

I would appreciate feedback on this proposal.

Thanks,
sporteka

