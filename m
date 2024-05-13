Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D7154BE7
	for <git@vger.kernel.org>; Mon, 13 May 2024 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715628079; cv=none; b=uhSnTH1e6U2RynLr6oCSFN/wSvJB3Bt9MSNkWrVcXKQhWQGuOg8NMbS6ScFc/opSRYh61okl1vCIEWmg+1ezNe4kFDLSyjGacNNgEGLk9GGj5Sg35RHXwDOdQH4QpAERPEba2HgXGZmjq3RTUT0SHjdzenFf8mhyvbq5zfZJDkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715628079; c=relaxed/simple;
	bh=UxGqE09StXh4EovunCnK5vGBXj9i5mTQklmXi73x2nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndJWFXSsr0Epnjx890B/16h4AEeoVH1AJqLQYyiDqfywxWElupzDvIOFVbHKpmMZryj0B345OOiCkKDm6njusHcGo3AsDcTftHU16Djwwuc+JaupowdE3YQhe2K6MFmW6YpVOwIqQ2jOBuCQB4XzUdBwQ5swyS6O2fNl/SIteYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lIQbJ464; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lIQbJ464"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CF2223650D;
	Mon, 13 May 2024 15:21:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UxGqE09StXh4
	EovunCnK5vGBXj9i5mTQklmXi73x2nY=; b=lIQbJ4642jRrp2C+HRuxQKVc2abI
	9J1AXyA4RUDdmRhw7rtTREa3YpFlMG5hgbswKKDpu2xh/7l0+YPGszbKglISwlQ+
	/lKSF2oDVpd5kMoc1gAMf3MIYiCjP63Wzq8OqFTx4bdzO0vja0ptdgK4a+NQZuYM
	+N8esrThTwTfptM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C83473650C;
	Mon, 13 May 2024 15:21:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5A5B03650B;
	Mon, 13 May 2024 15:21:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/4] Fix use of uninitialized hash algorithms
Date: Mon, 13 May 2024 12:21:08 -0700
Message-ID: <20240513192112.866021-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-145-g3e4a232f6e
In-Reply-To: <cover.1715582857.git.ps@pks.im>
References: <cover.1715582857.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID:
 F6E857F0-115D-11EF-8C05-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

The series adds an escape hatch to "the default hash algorithm is
no longer SHA-1; it is an error to rely on the default" by
introducing an undocumented GIT_TEST_DEFAULT_HASH_IS_SHA1=3D1
environment variable that users can set after reporting an failure
they saw to us.

We can see that Patrick's two fixes to patch-id and hash-object
corrects the breakage as the series progresses.

Junio C Hamano (2):
  setup: add an escape hatch for "no more default hash algorithm" change
  t1517: test commands that are designed to be run outside repository

Patrick Steinhardt (2):
  builtin/patch-id: fix uninitialized hash function
  builtin/hash-object: fix uninitialized hash function

 builtin/hash-object.c   |  7 +++++
 builtin/patch-id.c      | 13 +++++++++
 repository.c            | 24 ++++++++++++++++
 t/t1007-hash-object.sh  |  6 ++++
 t/t1517-outside-repo.sh | 61 +++++++++++++++++++++++++++++++++++++++++
 t/t4204-patch-id.sh     | 34 +++++++++++++++++++++++
 t/test-lib.sh           |  4 +++
 7 files changed, 149 insertions(+)
 create mode 100755 t/t1517-outside-repo.sh

--=20
2.45.0-145-g3e4a232f6e

