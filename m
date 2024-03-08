Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07154085D
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709932811; cv=none; b=MFTbLNHuBnZWqsdOzWAiQxyqXzXpXlqIU9GPsnyqWFDZqhbF8ajwpzmRM1qmbSsZm4PyOT9tWLGbH/fE5fPQAfGnU3ESnxHz2GVFR/BnRiA22ecOygOWA/RIG6SMcjzNvGfWW9Lh47Lsgxj2C75UvAIHVah50onfobNu/p5+MBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709932811; c=relaxed/simple;
	bh=TAZSCHnKh6MlT+rv77RMAPa/h1PSIW8Ag1r11Ohrpqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOGxZDxswxtZSyn62pNoag7v1KaJxvyoAxa5ivR5BlgDKK6i0YjJke5+5UCqKBLXSO70YBQgOt1CV9qrK3q1nuSAs+CxhFAFY0r0onmADKPGO+g4DIDZ//UKwM45WUL9KubJvIdu0JmTTn1K3uaH395E6StlGGQq/yBVNuVmCIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jdfvnu/3; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jdfvnu/3"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E83D73B156;
	Fri,  8 Mar 2024 16:20:02 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=TAZSCHnKh6MlT+rv77RMAPa/h
	1PSIW8Ag1r11Ohrpqg=; b=jdfvnu/3bF59cq5TdK5pIOlRvE67yCJugKifOXjsZ
	XXCYDsMpMci8G3TfUCk0PTazChRwu4l3uOII+I3HPrOpn1f2oV+rQSbnYFI/TaUs
	0ZqJKlEQQCuLMESs+EF9l6W/IrGAIuFZlLRa+ClIY8XWM+RJVUQxlV8PKC7d3Mxb
	x4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E217B3B155;
	Fri,  8 Mar 2024 16:20:02 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5ECE83B151;
	Fri,  8 Mar 2024 16:19:59 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Kyle Lippincott <spectral@google.com>,
	Glen Choo <glencbz@gmail.com>
Subject: [PATCH 0/2] Loosening safe.bareRepository=explicit even further
Date: Fri,  8 Mar 2024 13:19:55 -0800
Message-ID: <20240308211957.3758770-1-gitster@pobox.com>
X-Mailer: git-send-email 2.44.0-165-ge09f1254c5
In-Reply-To: <xmqqv85zqniu.fsf@gitster.g>
References: <xmqqv85zqniu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 9E7CCBDC-DD91-11EE-A9F4-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Earlier 45bb9162 (setup: allow cwd=3D.git w/ bareRepository=3Dexplicit,
2024-01-20) loosened safe.bareRepository=3Dexplicit in such a way that
working inside the ".git/" directory (or its subdirectories) of a
repository that is not bare can be done without an explicit GIT_DIR
or "git --git-dir=3D<path>".  The code needed for its change was
almost trivial---when it looks like we encountered a bare
repository, if the last path component of the discovered "$GIT_DIR"
is ".git", then it cannot be anything but the $GIT_DIR of a non-bare
repository, the root of whose working tree is the parent directory
of that ".git" directory.  This is because projects cannot create a
".git" directory in their working tree and cause clone/checkout to
extract them in the victim's working tree.

This almost works, until somebody starts using "git worktree add" to
create a secondary worktree.  Their $GIT_DIR resides inside the
$GIT_DIR of the primary worktree of the same repository, at
$GIT_DIR/worktree/$name where $name is the name of the secondary
worktree, which is not ".git".

These two patches are to extend the "if you can work in its working
tree, you should be able to work in its $GIT_DIR" for secondary
worktrees.

Junio C Hamano (2):
  setup: detect to be in $GIT_DIR with a new helper
  setup: make bareRepository=3Dexplicit work in GIT_DIR of a secondary wo=
rktree

 setup.c                         | 57 ++++++++++++++++++++++++++++++++-
 t/t0035-safe-bare-repository.sh |  8 ++++-
 2 files changed, 63 insertions(+), 2 deletions(-)

--=20
2.44.0-165-ge09f1254c5

