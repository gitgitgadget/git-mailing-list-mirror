Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068F117FE
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721004239; cv=none; b=FHmrbADtMC4wxp6EIiiGle7odfqHxI5ZHNvh3ctYaz6eFIAnth1fvWZc7RlkZ9rcA89hnHRTQGV2OEur5N56OVlRtuHknuCuxfyohD6FDnjYaLMk6muFlqoM0DbNuC2msLrsFmD/v9x4khgfZpqoB9+1lgr90yLrnratIoU5XPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721004239; c=relaxed/simple;
	bh=f0DWrsdf/uOwBGd8qKHLpDxztREajQx4LmDHlDU0GQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5osoXwE0xmFlKmeT61/3P1ix2Lfr3k4bq7tBxYYvgrr5/IG1ghV5cf4KCv3+DLuXWisZKKi6ZHxvan7u/8wg2+/SHoMN/L2oJmolRWIh9d1dtQTPByd6apHAH+kUC/5uxSi08HE13+AYa1uHWIJC+jWp/UFSzK1ibSLusOX+pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=NNPyAPn9; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="NNPyAPn9"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA1401F572;
	Mon, 15 Jul 2024 00:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1721003719;
	bh=f0DWrsdf/uOwBGd8qKHLpDxztREajQx4LmDHlDU0GQU=;
	h=From:To:Cc:Subject:Date:From;
	b=NNPyAPn9lmBIBUQ0WKr67HQukLwXBFZhoeN61k7bfqiYian2HhzM4xZ60aMeAT7CL
	 GPzPKbfh0WiQHBJOvsMqqpYx9corJzCGaPYEz7V8zZERc0Rqx7RR4j507+2ajChk7k
	 fWucN7ymxSO1Cd6i9D/Ex/UcFZm4embrRjHEiux8=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v1 00/10] cat-file speedups
Date: Mon, 15 Jul 2024 00:35:09 +0000
Message-ID: <20240715003519.2671385-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This continues the work of Jeff King and my initial work to
speed up cat-file --batch(-contents)? users in
https://lore.kernel.org/git/20240621062915.GA2105230@coredump.intra.peff.net/T/

There's more speedups I'm working on, but this series touches
on the work Jeff and I have already published.

I've started putting some Perl5 + Inline::C benchmarks with
several knobs up at: git clone https://80x24.org/misc-git-benchmarks.git

I've found it necessary to use schedtool(1) on Linux to pin all
processes to a single CPU on multicore systems.

Some patches make more sense for largish objects, some for
smaller objects.  Small objects (several KB) were my main focus,
but I figure 5/10 could help with some pathological big cases
and also open the door to expanding the use of caching down the
line.

10/10 actually ended up being more significant than I originally
anticipated for repeat lookups of the same objects (common for
web frontends getting hammered).

Jeff: I started writing commit messages for your patches (1 and
2), but there's probably better explanations you could do :>

Eric Wong (8):
  packfile: fix off-by-one in content_limit comparison
  packfile: inline cache_or_unpack_entry
  cat-file: use delta_base_cache entries directly
  packfile: packed_object_info avoids packed_to_object_type
  object_info: content_limit only applies to blobs
  cat-file: batch-command uses content_limit
  cat-file: batch_write: use size_t for length
  cat-file: use writev(2) if available

Jeff King (2):
  packfile: move sizep computation
  packfile: allow content-limit for cat-file

 Makefile            |   3 ++
 builtin/cat-file.c  | 124 +++++++++++++++++++++++++++++++-------------
 config.mak.uname    |   5 ++
 git-compat-util.h   |  10 ++++
 object-file.c       |  12 +++++
 object-store-ll.h   |   8 +++
 packfile.c          | 120 ++++++++++++++++++++++++++----------------
 packfile.h          |   4 ++
 t/t1006-cat-file.sh |  19 +++++--
 wrapper.c           |  18 +++++++
 wrapper.h           |   1 +
 write-or-die.c      |  66 +++++++++++++++++++++++
 write-or-die.h      |   2 +
 13 files changed, 308 insertions(+), 84 deletions(-)
