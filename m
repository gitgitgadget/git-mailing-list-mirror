Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9F626AD8
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709406235; cv=none; b=CXhLOBI4QLaoCggN6amhZ4vrWfcifNpnpix2ogENcVZ7H4CpRv7zRD1KvMQ4ilpHS3oB5HBwS6GyPxjCUuEgE19SGyS9WUuez2orRzjkD5lpG2ZPq9DUzObbuSMKm0maTvONh2XrTyJwH6mkParq3kJ6nmmhrMA0VsysPD7sAv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709406235; c=relaxed/simple;
	bh=9XyoqXFCJjdwVZGaB+Z6RD8J2Ir9IZTHc2Bk9pshYp8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NG2X3OOW6QgoTwws3FVsbYi3l7+dTX3nqf3t3YM2birSl+sG2HE5P50qfrdaBZVfim/ksfFshRiq+xsU5yiSLddE7BUBv6c2fn6eJW9dLZk1/AmDQeeRikSE/v0/owpoy/nCGnQn5397xUFx++2RgplEXEHYZLltwkO1lmhYLVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kVvFEXG3; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kVvFEXG3"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1BE1926D08;
	Sat,  2 Mar 2024 14:03:53 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=9XyoqXFCJjdwVZGaB+Z6RD8J2Ir9IZTHc2Bk9pshYp8=; b=kVvF
	EXG3o+zW4U23AizAkOm3vLwNRl6Y9VvH8xDmPd/KdG7Bd4xaVCYe/vEPhuOji20D
	tIulZN79eIdm7KMgOwcSf9xyhElfpE387N2G3An1P+OMBJWe4ZK26zjd0ng3sLoP
	027fG/nzCQTheX77v6jPVAQAbiO12kU4Xra6tRk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1490F26D07;
	Sat,  2 Mar 2024 14:03:53 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AAE8226D05;
	Sat,  2 Mar 2024 14:03:49 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/3] Auditing use of xwrite()
Date: Sat,  2 Mar 2024 11:03:45 -0800
Message-ID: <20240302190348.3946569-1-gitster@pobox.com>
X-Mailer: git-send-email 2.44.0-84-gb387623c12
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 9A7E80A8-D8C7-11EE-97D2-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

The xwrite() helper relieves us from having to worry about an
interrupted write(2) system call that returns an EINTR error without
writing any, in which case we need to retry the system call.  It,
just as the underlying write(2) system call, however can return
without writing the bytes requested to be written fully.  A code
that uses xwrite() and wants to write the full contents of the
buffer needs to take care of such a "short write" situation,
typically by calling xwrite() in a loop.

We recently audited all the calls to xwrite(), and have found two
classes of potential "problems".  This miniseries is about fixing them.

 * There are such loops around xwrite() as described above, which
   were written long time ago.  The write_in_full() helper does
   implement such a loop in a reusable way, and we should just call
   it instead.

 * There are xwrite() calls whose return value is ignored.  We would
   not be able to detect (and complete) "short write" in such callers,
   of course, but more importantly, we would not notice I/O failures.
   Again, use write_in_full() to deal with short writes, and check
   the return value from it to detect errors.

Junio C Hamano (3):
  unpack: rewrite hand-rolled loop of xwrite()s with write_in_full()
  sideband: avoid short write(2)
  repack: check error writing to pack-objects subprocess

 builtin/index-pack.c     | 17 +++--------------
 builtin/repack.c         |  5 +++--
 builtin/unpack-objects.c |  8 +-------
 sideband.c               |  4 ++--
 4 files changed, 9 insertions(+), 25 deletions(-)

--=20
2.44.0-84-gb387623c12

