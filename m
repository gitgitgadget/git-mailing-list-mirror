Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFEA1CFB5
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717871877; cv=none; b=IDTT0gQTEYP5titkkV+f/r6Vkjl1lGnvlF+8DwHQhyW57ADGgMpehXJoVtSkbx4VCK6ybMZu3DuMu/BHENULtYUrdvsjA0vOzzyW93aaWExBo0KJCFHcrxEIijubVQ+AhLg4C2cJvBJOusV8S2TkkHagt4iqBggcvRmriwATVEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717871877; c=relaxed/simple;
	bh=QgLuvSGFDHClvQ0NvalHVl5Kd5G+qdkdJEaxmJd7Wek=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bv+804fGKWF7yP+fH2n+A3J4mQEapmaWLE5duZ82IdsyiTcQqUvhRmC5Qxo2SoV1MC9reUjEgJ9KKjf7WYKiDkUiVgHPY/kKedxvaWW+PFvqCYTL3U6YXYOZtmIzOHJaSbJce1z9Dgde7SLBY2ZvCEFc1+kYH9tQUjacTeh72To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qask6whj; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qask6whj"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E629638CC5;
	Sat,  8 Jun 2024 14:37:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=QgLuvSGFDHClvQ0NvalHVl5Kd5G+qdkdJEaxmJd7Wek=; b=Qask
	6whjhM9PLBYE/ynTRWBdUStjMezPrP9uqEBYzzI9uT78rjDJ1MHI29FTInfu80cZ
	YQ+dVHPRuS+w6J2bAudT9/ZJPE+sKI8urK+3Q7zWjYRzdoCUG6v0MN8LN6/DOM5z
	EkZC2JxP08EWZSWNLH6S1iqKK1pHSeIyi8qjXuQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DED9938CC4;
	Sat,  8 Jun 2024 14:37:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4CCCD38CC3;
	Sat,  8 Jun 2024 14:37:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/4] varargs functions with __attributes__(())
Date: Sat,  8 Jun 2024 11:37:43 -0700
Message-ID: <20240608183747.2084294-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-445-g1b76f06508
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 3451BAB0-25C6-11EF-B367-6488940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

There are several varargs functions that take either NULL-terminated
list of parameters, or printf-like format followed by list of
parameters, that are not declared as such with __attributes__(()).

Adding such a missing attribute to trace2_region_enter_printf()
revealed that an existing call to it was trying to format a value of
type size_t using "%d", which is not such an excellent idea.  Other
functions that were lacking attributes fortunately did not have any
broken existing callers.

Junio C Hamano (4):
  __attribute__: trace2_region_enter_printf() is like "printf"
  __attribute__: remove redundant __attribute__ declaration for
    git_die_config()
  __attribute__: mark some functions with LAST_ARG_MUST_BE_NULL
  __attribute__: add a few missing format attributes

 add-patch.c   | 1 +
 attr.h        | 2 ++
 config.c      | 1 -
 hook.h        | 1 +
 mem-pool.h    | 1 +
 run-command.c | 3 ++-
 scalar.c      | 2 ++
 trace2.h      | 1 +
 wt-status.c   | 1 +
 9 files changed, 11 insertions(+), 2 deletions(-)

--=20
2.45.2-445-g1b76f06508

