Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC122B9A7
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159832; cv=none; b=FLbiRIyA3NLwzMzQFYYrI7ZFJtbh4nloU7149BetrizEUJcUqUWgVREQBycON7iC0wMs7dGh9MAqOkq/lo/zjw76jKlsa+MKX7K7HSfSIWi2DPwrhXr0Oc/ISpBUNQskZ9bKHinsC78JMnMC1MlCc9eNNu5QcdZPTDBZjmRnOEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159832; c=relaxed/simple;
	bh=WbFjJ6m6tb9LhE6tGv4NA4QEi3E8gicKbdOh3AkHFFs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tDEClrIf3Lub7QSIDGTWET4JJOBxstkhCkKdHU3w6fTdJFjyjomVCKjC9i+a7x2Dh/eVW+2gXWjQU1eIu5CAZoK4a2Tftqu8AFNt2h2d8MP3wJRlVCmbAYxiAOkpRMCBdSl7/t4de5mQj/kaTId88Sp90G8pjGGybdwIMeRau6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23641 invoked by uid 109); 28 Feb 2024 22:37:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Feb 2024 22:37:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26710 invoked by uid 111); 28 Feb 2024 22:37:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Feb 2024 17:37:02 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Feb 2024 17:37:00 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Benjamin Flesch <benjaminflesch@icloud.com>
Subject: [PATCH 0/9] bound upload-pack memory allocations
Message-ID: <20240228223700.GA1157826@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Benjamin Flesch reported to the security list that a client can convince
upload-pack to allocate arbitrary amounts of memory by sending a few
repeated nonsense directives. Patches 1-6 here eliminate those spots.
which roughly bounds the amount of memory that upload-pack will allocate
to scale with the number of refs and objects in the repository. I also
found a few spots where upload-pack is a little too eager to hold object
contents in memory (so still bounded, but something like "all the trees"
can get pretty big). That's patches 7-9.

We're not doing a coordinated disclosure or special release for this.
Even after these patches, it's possible to get upload-pack to allocate
quite a bit of memory, especially for a large repository. Not to mention
that pack-objects may also allocate quite a bit to serve the pack
itself. So while this is low-hanging fruit, a public-facing Git site
probably still needs to have some kind of external tooling to kill
hungry processes (even if it's just OOM-killing them so they don't hurt
other clients).

There are a few unbounded parts of receive-pack (e.g., you can send an
infinite number of refs to push). That may be something we want to put
some configurable boundaries on, but I punted on it for this series.
IMHO it is a lot less interesting since you'd usually have to
authenticate to invoke receive-pack in the first place.

  [1/9]: upload-pack: drop separate v2 "haves" array
  [2/9]: upload-pack: switch deepen-not list to an oid_array
  [3/9]: upload-pack: use oidset for deepen_not list
  [4/9]: upload-pack: use a strmap for want-ref lines
  [5/9]: upload-pack: accept only a single packfile-uri line
  [6/9]: upload-pack: disallow object-info capability by default
  [7/9]: upload-pack: always turn off save_commit_buffer
  [8/9]: upload-pack: use PARSE_OBJECT_SKIP_HASH_CHECK in more places
  [9/9]: upload-pack: free tree buffers after parsing

 Documentation/config/transfer.txt |   4 +
 Documentation/gitprotocol-v2.txt  |   6 +-
 builtin/upload-pack.c             |   2 +
 object.c                          |  14 ++++
 object.h                          |   1 +
 revision.c                        |   3 +-
 serve.c                           |  14 +++-
 t/t5555-http-smart-common.sh      |   1 -
 t/t5701-git-serve.sh              |  24 +++++-
 upload-pack.c                     | 117 +++++++++++++-----------------
 10 files changed, 113 insertions(+), 73 deletions(-)

-Peff
