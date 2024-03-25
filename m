Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FD65D724
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408544; cv=none; b=cscLb9ohioW5m0Mcaxj4VChS3Lr0e13wKksSkgaDouM3sol+Afx/r+gOtZeZQSoX51LI6QYuHqonPmqNmSfzSQMiODP/HmKNloUhEBZK2vj0P9WKM+uPadfvOQX43nNqaIW8UbuBoXSxkexGC5JqiS6S5sqPMXxurUmvIt+0fxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408544; c=relaxed/simple;
	bh=L27CKmEgL6kGn6CENRCwlr2uHnSOjL//0hF/gvdmOdE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KAlohid645kzpn+ptxktkGTR66004SRJZqc+OH6BaM0oS9Ceu3dKNMQTzerkSDROpFpuEfbcwBNcyFBz60mlCNg6m9za2VQ1bXnOsQC0Sm3nw/ymhu4BfuY/5HDeDELnGGU7qQPfpeVF0N2q9QuGLkTDmHsOBK7I3X+Dl5QPBn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=UENfqj55; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="UENfqj55"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A6EF1F44D
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1711408024;
	bh=L27CKmEgL6kGn6CENRCwlr2uHnSOjL//0hF/gvdmOdE=;
	h=From:To:Subject:Date:From;
	b=UENfqj55ZsYIn9sDeEkSwOQMwuLy1ydM6m8f0YLGDL/A6g+SY2qeIddR3ezQwUDPy
	 9RmovILjhQMCNYW+gBE03LN/e60CYz4C29TJ3XHbR0qpl8korhyc4QLndcntHVE8Ww
	 cVQQoWYuVOZ4ukK7759bGwJMd/gHyX6rFKT+zcSM=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Subject: [PATCH 0/3] switch to tombstone-free khashl table
Date: Mon, 25 Mar 2024 23:07:00 +0000
Message-ID: <20240325230704.262272-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory improvement is minor, but any memory reduction at all
is welcome at this point.  Fortunately, this set of changes is
unintrusive.

I have some other ideas that I'll hopefully get to implement before
swapping kills all my SSDs (see bottom).

Eric Wong (3):
  list-objects-filter: use kh_size API
  treewide: switch to khashl for memory savings
  khashl: fix ensemble lookups on empty table

 builtin/fast-import.c       |   2 +-
 builtin/fsmonitor--daemon.c |   4 +-
 delta-islands.c             |   4 +-
 khash.h                     | 338 -----------------------
 khashl.h                    | 522 ++++++++++++++++++++++++++++++++++++
 list-objects-filter.c       |   2 +-
 object-store-ll.h           |   2 +-
 object-store.h              |   7 +-
 oidset.h                    |   2 +-
 pack-bitmap.h               |   2 +-
 10 files changed, 535 insertions(+), 350 deletions(-)
 delete mode 100644 khash.h
 create mode 100644 khashl.h

TODO (some ideas stolen from khashl):

* obj_hash can probably use a 0.75 load factor (instead of 0.5)
  to save memory and not slow down too much.  oid_* khash has
  always had 0.77 which was fine and now khashl has 0.75.
  0.75 is cheaper to compute via (shifts + ORs) than 0.77.

* obj_hash can use `i = (i + 1) & mask' like khashl does to
  avoid branches in linear probe loops

* obj_hash can use realloc and copy in-place resize logic khashl does.
  khashl uses the ->used bitmap for this, but it should be
  possible to do for obj_hash w/o additional allocations
  via pointer tagging

(not khashl inspired):

* keep an identity pool of OIDs separately (similar to how Perl5
  pools all hash keys) and only use tagged pointers for OIDs.
  Pointer tagging can be used to distinguish between 7 hash
  functions, leaving us room for 5 more in addition to SHA-(1|256).
  This change will be a large effort (with a hopefully large savings).
  If we ever need more than 7 hash functions, we can switch to
  storing hash type information in slabs that can be looked up
  using address ranges (AFAIK, jemalloc does this).
