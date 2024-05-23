Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1324A84DE9
	for <git@vger.kernel.org>; Thu, 23 May 2024 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716504614; cv=none; b=BxWL+V9Eq39+JaXYxNQqzkV00oKSQUhMdcp3RyHhPpH3iqQAcHdSZuxhDu2gupFRGgcxegtUsL0krhwSQBHCbpJT/2yLXaI4Xw8Lec0WSnmt3NNteXHDullTkqhARWGZ9iNmM+cb8/vO+Lm6o+9a38ZuO3lkPHvdJGPUSwBX+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716504614; c=relaxed/simple;
	bh=q59DK4ZaJLnqP5DxiScfmcsSb2xqpwHKXMXvxKKH1vM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EXIVvilz/ONV/Wwky1XVwMzM3MxmE/GaaZRlbNEBi2a5Uzo2xEduw6WUCPOBDQ4pyO7QyeLML32A6KJY/3Rcxv2m/ED8V2aEjGUYC0NrvxNVBbkeXbat7zO06DTUM/x/cMfIp5oMFOBmgQ4cJbLE7nIqB+K3Ex3x2RPH6+efD+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lJ0fN/Hx; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lJ0fN/Hx"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 52312236A8;
	Thu, 23 May 2024 18:50:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=q59DK4ZaJLnqP5DxiScfmcsSb2xqpwHKXMXvxKKH1vM=; b=lJ0f
	N/HxrrYeYGkYAg7xzhj/Wo09m+N+wtyCgoMwfJq1+cSaTNhsjGG4BO4Z/VdAkjeD
	1mGrtC0CZ2aA5slalBL6jGtxZCgNy5+8+YdJBLw3v9cxYDg3RBEGmQjoOtshZd0N
	3Zv5k+b6BR2pS9qoYWoGt1O4WxerGUVZLlpLkbk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C3A9236A7;
	Thu, 23 May 2024 18:50:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0F47A236A6;
	Thu, 23 May 2024 18:50:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/2] give range-diff at the end of single patch output
Date: Thu, 23 May 2024 15:50:05 -0700
Message-ID: <20240523225007.2871766-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-246-gb9cfe4845c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 CE4C4EFE-1956-11EF-B849-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

When running "format-patch" on a multiple patch series, the output
coming from "--interdiff" and "--range-diff" options is inserted
after the "shortlog" list of commits and the overall diffstat.

The idea is that shortlog/diffstat are shorter and with denser
information content, which gives a better overview before the
readers dive into more details of range/inter diff.

When working on a single patch, however, we stuff the inter/range
diff output before the actual patch, next to the diffstat.  This
pushes down the patch text way down with inter/range diff output,
distracting readers.

Move the inter/range diff output to the very end of the output,
after all the patch text is shown.

The first patch is a no-op refactoring, the second patch makes the
actual behaviour change.

Junio C Hamano (2):
  show_log: factor out interdiff/range-diff generation
  format-patch: move range/inter diff at the end of a single patch
    output

 log-tree.c              | 89 ++++++++++++++++++++++-------------------
 t/t4014-format-patch.sh | 17 +++++---
 2 files changed, 59 insertions(+), 47 deletions(-)

--=20
2.45.1-246-gb9cfe4845c

