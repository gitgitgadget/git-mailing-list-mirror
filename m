Received: from flyer.ispras.ru (flyer.ispras.ru [83.149.199.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113FF1D6AA
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729956; cv=none; b=NOEqH6zBwssX4lBWn0BM0x3GVW/znxjRkvDy5qLvV/KjcPDH02Z3/jJVlRn9u9I9/cDNjv3ONDbTrM4X1pqRhlnWZUlmZVMR9AFl8MpgW/ePUluSSo20H/W9ckQixIJi76DJ0TArfKi0FD0DgFZux2e0eX3BQ3zG1ggcyeQyjaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729956; c=relaxed/simple;
	bh=o+9GpTUSu++gRaXS/AgDoX9gpJEpOkQyrC9YjmSvTIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m8dfoIQhj1191RX9rlP72C/Go47n7R4g8ipRlOjYfE966/0wjAsH3xKRYjwjD0Zs9I+i3zcOWWnn+EfJRtVwtEQ93UE7O5a0SUPfEBsbFrMpyrzGuug1Je2VOEy+qmarZ/5o7atUZfU/4q37BQfzaMoV6J+oLBzyunXqJWkWmUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=dHFZgQBA; arc=none smtp.client-ip=83.149.199.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="dHFZgQBA"
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
	by flyer.ispras.ru (Postfix) with ESMTP id 6D9EA1407236;
	Mon, 28 Jul 2025 22:05:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 flyer.ispras.ru 6D9EA1407236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1753729521;
	bh=JTm/worCCPh/LgE3LH6caYPVO0GGctMfx/aTcYe/O7k=;
	h=From:To:Cc:Subject:Date:From;
	b=dHFZgQBAHxDZsF076zZ/AOgskBjcGpo6acd476VmWvMVvbxsq2fkIpfdYYF9Dcsca
	 gbWe/u32+kpR85bvTp7VuowDN1WE+snu+2dCeYIFck/tdRjseyXsHsQSTm3eV95v20
	 kDfMcBu0f5c6IJbm7zw/a5EUzxqwXkeSvFSqbnrM=
From: Alexander Monakov <amonakov@ispras.ru>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH 0/2] optimize string hashing in xdiff
Date: Mon, 28 Jul 2025 22:05:18 +0300
Message-ID: <20250728190520.10962-1-amonakov@ispras.ru>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello world,

I've noticed the work by Phillip Wood regarding hash optimization for xdiff.
I want to point out that it is possible to speed up the existing hash by 1.5x
matching the peformance of xxhash (but without introducing a dependendency).

The additive variant of the djb2 hash is used in ELF symbol lookup, and
Noah Goldstein contributed a well-optimized implementation to Glibc.

I'm taking the refactoring patch from Phillip and building on top of it.

Alexander Monakov (1):
  xdiff: optimize xdl_hash_record_verbatim

Phillip Wood (1):
  xdiff: refactor xdl_hash_record()

 xdiff/xutils.c | 66 +++++++++++++++++++++++++++++++++++++++++++-------
 xdiff/xutils.h | 10 +++++++-
 2 files changed, 66 insertions(+), 10 deletions(-)

-- 
2.44.2

