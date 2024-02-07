Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77D11E516
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707330909; cv=none; b=YK0G+2vNdzygsbmanV9ll8upAD8rWoDUuHB7IXLsp2N6gbu7mrp1y9kSLcLw3h61D/T34KL7DubRfuTCrJdx14hkwmPLSZBiTPqCQz7tozyVLgal9VsNYhVJSaJBaFOl94wBPcmw3CaNksCFPG4BzqSNE05+wtGtu/6puw4NEGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707330909; c=relaxed/simple;
	bh=GRFu9DJBlLBsl34ppe/epCCFaWWpaaWF0nJ1WJC9JTg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aVNJIIxiJr5Ii/jqvu5Ys/AvFgBZZm7lB8bg7RbUKAFi/tFFctwa24UR62d9FBDg+nSe6la3wEuoSBy+TzSqfKuaj0h5VpV/TZ8FgF9URF4o2UHNDVZgJgV90hfefQAiPQChQ/fxH9GRdIMgZjyfT9DHgLPc1lrLkvacnjc6WwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=A98du3ss; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A98du3ss"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C9DD2A81E;
	Wed,  7 Feb 2024 13:35:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=G
	RFu9DJBlLBsl34ppe/epCCFaWWpaaWF0nJ1WJC9JTg=; b=A98du3sswztKF2Oio
	LwiX8a4Sa87eRO6WDEm6et8iKUMh+Glc4d3FpphZ7cnNnTItxw7FFlfJphDGpJjd
	4M7EgBDTA+T0TVXCTu/+Ti2MjQhs8DgjqiFPrHqKJCJn0xNqd83nLhenDyN3J90P
	jAxCwFpa4P39m8g592JIjP/Z1Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9574F2A81D;
	Wed,  7 Feb 2024 13:35:01 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3CD9C2A81A;
	Wed,  7 Feb 2024 13:34:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [RFH] "git -C there add foo" completes, s/add/diff/ does not
Date: Wed, 07 Feb 2024 10:34:56 -0800
Message-ID: <xmqqcyt89l7z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 988E3D3A-C5E7-11EE-93EA-A19503B9AAD1-77302942!pb-smtp21.pobox.com

As some of you may already know, I keep an untracked directory
called "Meta" at the top-level of the working tree of the Git
source tree.  This "Meta" directory is actually a single-branch
clone of the git.kernel.org/pub/scm/git/git.git that checks out
its "todo" branch, where files like whats-cooking.txt lives.

So, what I often would do is

    $ git -C Meta add whats-cooking.txt

after updating the draft of the next issue of the "What's cooking"
report.  The command line completion support for "git add" knows how
to complete this when I stopped typing the above after whats-" and
hit <TAB>.  It seems that __git_find_repo_path helper function that
notices "-C there" and discovers the $GIT_DIR, and _git_add helper
uses __git_complete_index_file that honors the discovered $GIT_DIR
to find paths in the correct index, which is wonderful.

But the same does not work for the step before I can decide to
actually "add" the contents, which is to "diff", i.e.

    $ git -C Meta diff whats-<TAB>

does not complete.

Anybody wants to take a crack at it?

Thanks.

