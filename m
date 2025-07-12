Received: from mx01.frank.fyi (mx01.frank.fyi [5.189.178.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330B681E
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.178.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752345377; cv=none; b=XFWxDFw/e5D+DpgjcSEpf+8eNpGEBQDBhqYVtXe0vmPGZLhfcT94PkmEhrZRs0vQNPt8u/C+/n/yX2+CtbNHybjKRU8ACMi68219m1MKtTFJTt0Js25YfTw4DhU3IHSBhRNDTB5xaen10dSLgmeg+XvF35kVMBTuljjHehxJ4Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752345377; c=relaxed/simple;
	bh=+j0nmxPD2vVUUu9qAbKvowQEXfTdox6WUq5+MUNXzr4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Wg7OoJOJHSii2hiN+Kd8ggd0hOnSYdyUUA9x+y95O80wtHP6Hu2/Chlzp3ATn3Q06aN46uRkTCsXqzcAFbwcuin2T5kiZjwNFijbgqz2njFHBEymoy2wCTAL5OGKwLWT81DO4fvrEwG7uRwzG9b4SxPK0xazaReP7K+b6PAresc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=frank.fyi; spf=pass smtp.mailfrom=frank.fyi; dkim=pass (2048-bit key) header.d=frank.fyi header.i=@frank.fyi header.b=a71ERLxa; arc=none smtp.client-ip=5.189.178.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=frank.fyi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frank.fyi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frank.fyi header.i=@frank.fyi header.b="a71ERLxa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=frank.fyi; s=mail;
	t=1752344977; bh=+j0nmxPD2vVUUu9qAbKvowQEXfTdox6WUq5+MUNXzr4=;
	h=Date:From:To:Subject:From;
	b=a71ERLxapKK4efiA5gsWpDmLCM5Rio0gQYAsYnJ/avU/MQrES1B6shSGkgWmleUyt
	 EYHOanlf+kXImpcv66iopzglI5ujkx8kKHvutzOcnSMYwJBvRvBDN00Np7qvVEWT6j
	 CC9HmjtF1irU8Dk7g/xddukjEJ58Q36ae6v6KtoBxOxevhg+UCH0MpbX78DqH/VH8T
	 QlWfAHjEM+60vXK39OWrwxb+XWI7TswVGY9PGJHCKhy/gq3oUde27nbgzOccOdWflC
	 M01ynyorBuggo3wR7z7DMlZA8gxwfn0ovY1TwFtd6Y2E7nrxc0FtZFoojswZG3RuOZ
	 y7lDJlMCNXfkg==
Received: by mx01.frank.fyi (Postfix, from userid 1001)
	id AA36711205CA; Sat, 12 Jul 2025 20:29:37 +0200 (CEST)
Date: Sat, 12 Jul 2025 18:29:37 +0000
From: vger.kernel.org@frank.fyi
To: git@vger.kernel.org
Subject: Discuss improving defaults for git-submodule handling
Message-ID: <escjec6mhcqhhwwo42pl7ysmmfw73eo4wsiyvbokfx7z2vx2zf@adc36bybpd5d>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'd like to suggest changing some git-config defaults as well as ask for your input and feedback on this.
At least suggestion 1 and 3 should have 0 real world impact, 2 may have impact in very exotic edge cases.
But I made some unbacked assumptions within my assessment and I may also very likely be overlooking some of the issues.
Therefore I'd appreciate your feedback. Especially because I couldn't find anything regarding how or why the current defaults were choosen to begin with.

My goal by having these defaults changed is to improve the user experience of novice users with git-submodules.
The 1st suggestion is also what I've been using without any issues within my global git-config for quite a while now.
And by always having added "--recurse-submodules" to an alias wrapper of git-clone, I've basically also already been doing the 3rd one myself for quite a while now as well.

So I think it is safe to suggest these to become the default and have things "just work" for novices"


1)
  Change the default of "push.recurseSubmodules" to "check" instead of "no" in case "submodule.recurse" is not explicitly set (that's the same condition where the current default of "no" applies according to the docs).
  This will ensure that people that are lesser familiar with or new to submodules unintentionally push a commit with references to something that is within their local checkout of one of the submodules but not on the remote.
  e.g. them having ran "git add" and "git commit" within the submodules directory but forgot to "git push"; Especially since git status won't show anything unusual in this case.
  By setting it only to "check" instead of "on-demand" we can further prevent them from unintentionally pushing their local changes to the submodules repo but are still able to ensure they're informed about their misstake.
  After all it is very unlikely that a novice will ever want to push a commit that includs references to commits that don't exist on any (or if one on the same saerver exists that specific) remote.

2)
  Currently "push.recurseSubmdoules=check" doesn't ensure that when the project and its submdoules share one or more remotes that the reference is valid on just the remote the user is pushing to alone instead of just "at any of the known remotes".
  Even though I currently assume modifying the existing "check" mode to include this assurance at most has a "very minimal" impact, adding it within a new mode like "checkStrict" may turn out to be preverable.
  I think that extending the existing check-mode this way is safe through assuming that in the rare case where it is desirable to violate this assurance that remote shouldn't be listed within that submoduels definition to begin with and constitutes an error in itself.
  Also it should be noted that it is even more unlikely for a novice to encounter this scenario. And even if this was a breaking change that advanced users would be able to easily fix this e.g. removing that remote or by overwriting that default with "no" (the current one) locally explicitly.
  By adding a "checkStrict" mode the even rarer possibility where in addition also an existing "push.recurseSubmdoules=check" is set, as that one wouldn't be touched at all (changing the default where it is not defined would however still be the same and require a manual fix of an advanced user overwriting it to "no" as when the "check"-option was extended). 

3) 
  For a very similar reason I'd also like to suggest adding the currently absent git-config option "clone.recurseSubmodules" to allow "git clone" to behave as if "--recurse-submodules" was always specified as well.
  And ideally this would also become the default moving forward too.
  As the expected result especially for novice users is to also initialize all of the submodules when cloning as well.
  Thereby it avoids them from trying to build a project without having initialized its submodules.
  Which in turn would save some frustration and troubleshooting at the novices side as well as resources for handling bugreports for buils that are failing this way on the projects side.
  Also it would make it redundant for projects having to try to mitigate this by explicitly calling "git submodule update --init --recursive" from within thier ./configure or make script.
  Which currently is at best a bad user experience as there are submodules pulled while building and at worst fail because of the novice user having transfered the checkout into an air-gapped environment already.
  I currently consider making this change as very unlikely to break any existing workflows. In fact I currently cant immagine any scenario where this change would be able to cause issues.

4)
  A bit more general and not (just) related to submodules.
  For troubleshooting someone elses git environment (aka. when troubleshooting a novice users issues) it would be quite helpful to be able to query builtin defaults for git-config properties.
  Like e.g. by introducing a new "--builtin" switch that can be used like "git config get --builtin core.preloadIndex".
  Not only did default values already change in the past (like e.g. for the above mentioned "core.preloadIndex" within 2.1.0) but it is obviously also to be expected that default values will keep getting changed moving forward from time to time as well.
  So introducing a way to query what the built-in default would be quite helpful for debugging issues of coworkers as well.
  Also this would simplify finding differences within different environments especially when they have different versions of git (like CI/CD vs local).

Sincerely,
Klaus Frank

