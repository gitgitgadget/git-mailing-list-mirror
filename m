Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD78D17F4F4
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719357184; cv=none; b=EtU9UZpmJFdDf5jr3h0yg9YE23JsQI60taTC7AZ5GA27bF4emZWaKY8dF7WFYyIFBIJx9HfSyOshAAkK+1SwaBtiFksI56EN+dXfntPCurKORnM9FKK40b09BxAQbUFB4f+SOsSfo1675JiKiFoe4xTlVj35gP3RCM5uUqEDybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719357184; c=relaxed/simple;
	bh=ZNts+Gg4s237emX9c87KmMQB0pU0helnnov/KhA1je8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDvI9v+KauFgi5F/jx/hQhTxHp0HTmhPYnTVZ1l6evlkkeYiczNqb4kF4H3qNKLXMVy8KqShY167i1m8h1UoxQk+HuJph7oXB82Vwinl6FwRrFEriunr/s5nZPWUiUACF2QrqWJNSz5G4WMfRGGpR+0ADIG2THBl2HfKpG09mtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=e1XaiYmx; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="e1XaiYmx"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C3E112C964;
	Tue, 25 Jun 2024 19:12:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=ZNts+Gg4s237emX9c87KmMQB0
	pU0helnnov/KhA1je8=; b=e1XaiYmxGmUhtdvoc3lqOI0QiXUg1XZzIBOgqWi6O
	1BAeVZ7usKJxDz40JNMopY4FHtam0d00xBBusVS4rd2lAa4aCZKYeD3wqwpM2VU4
	vcgiS30cRLcF63ze1liHZq+hucKd61U2NbgPHrfMbMH6ui7Ry5kwfpjn4JZ0evro
	A0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BCC572C963;
	Tue, 25 Jun 2024 19:12:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5F0712C960;
	Tue, 25 Jun 2024 19:12:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Darcy Burke <acednes@gmail.com>
Subject: [PATCH v4 2/2] date: detect underflow/overflow when parsing dates with timezone offset
Date: Tue, 25 Jun 2024 16:12:48 -0700
Message-ID: <20240625231248.4070257-3-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-796-g2ef7a3d713
In-Reply-To: <20240625231248.4070257-1-gitster@pobox.com>
References: <pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com> <xmqq1q58ejnw.fsf@gitster.g> <xmqqtthzrraw.fsf@gitster.g>
 <20240625231248.4070257-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 7321F040-3348-11EF-9F18-C38742FD603B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Darcy Burke <acednes@gmail.com>

Overriding the date of a commit to be close to "1970-01-01 00:00:00"
with a large enough positive timezone for the equivelant GMT time to be
before the epoch is considered valid by `parse_date_basic`. Similar
behaviour occurs when using a date close to "2099-12-31 23:59:59" (the
maximum date allowed by `tm_to_time_t`) with a large enough negative
timezone offset.

This leads to an integer underflow or underflow respectively in the
commit timestamp, which is not caught by `git-commit`, but will cause
other services to fail, such as `git-fsck`, which, for the first case,
reports "badDateOverflow: invalid author/committer line - date causes
integer overflow".

Instead check the timezone offset and fail if the resulting time comes
before the epoch "1970-01-01T00:00:00Z" or after the maximum date
"2099-12-31T23:59:59Z".

Using the REQUIRE_64BIT_TIME prerequisite, make sure that the tests
near the end of Git time (aka end of year 2099) are not attempted on
purely 32-bit systems, as they cannot express timestamp beyond 2038
anyway.

Signed-off-by: Darcy Burke <acednes@gmail.com>
[jc: fixups for 32-bit platforms]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 date.c          | 12 +++++++++++-
 t/t0006-date.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/date.c b/date.c
index 7365a4ad24..bee9fe8f10 100644
--- a/date.c
+++ b/date.c
@@ -868,6 +868,10 @@ static int match_object_header_date(const char *date=
, timestamp_t *timestamp, in
 	return 0;
 }
=20
+
+/* timestamp of 2099-12-31T23:59:59Z, including 32 leap days */
+static const timestamp_t timestamp_max =3D (((timestamp_t)2100 - 1970) *=
 365 + 32) * 24 * 60 * 60 - 1;
+
 /* Gr. strptime is crap for this; it doesn't have a way to require RFC28=
22
    (i.e. English) day/month names, and it doesn't work correctly with %z=
. */
 int parse_date_basic(const char *date, timestamp_t *timestamp, int *offs=
et)
@@ -937,8 +941,14 @@ int parse_date_basic(const char *date, timestamp_t *=
timestamp, int *offset)
 		}
 	}
=20
-	if (!tm_gmt)
+	if (!tm_gmt) {
+		if (*offset > 0 && *offset * 60 > *timestamp)
+			return -1;
+		if (*offset < 0 && -*offset * 60 > timestamp_max - *timestamp)
+			return -1;
 		*timestamp -=3D *offset * 60;
+	}
+
 	return 0; /* success */
 }
=20
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 24e8647f26..fd373e1b39 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -123,6 +123,39 @@ check_parse '2008-02-14 20:30:45 -05:00' '2008-02-14=
 20:30:45 -0500'
 check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 -0500' EST5
 check_parse 'Thu, 7 Apr 2005 15:14:13 -0700' '2005-04-07 15:14:13 -0700'
=20
+check_parse '1970-01-01 00:00:00' '1970-01-01 00:00:00 +0000'
+check_parse '1970-01-01 00:00:00 +00' '1970-01-01 00:00:00 +0000'
+check_parse '1970-01-01 00:00:00 Z' '1970-01-01 00:00:00 +0000'
+check_parse '1970-01-01 00:00:00 -01' '1970-01-01 00:00:00 -0100'
+check_parse '1970-01-01 00:00:00 +01' bad
+check_parse '1970-01-01 00:00:00 +11' bad
+check_parse '1970-01-01 00:59:59 +01' bad
+check_parse '1970-01-01 01:00:00 +01' '1970-01-01 01:00:00 +0100'
+check_parse '1970-01-01 01:00:00 +11' bad
+check_parse '1970-01-02 00:00:00 +11' '1970-01-02 00:00:00 +1100'
+check_parse '1969-12-31 23:59:59' bad
+check_parse '1969-12-31 23:59:59 +00' bad
+check_parse '1969-12-31 23:59:59 Z' bad
+check_parse '1969-12-31 23:59:59 +11' bad
+check_parse '1969-12-31 23:59:59 -11' bad
+
+REQUIRE_64BIT_TIME=3DHAVE_64BIT_TIME
+check_parse '2099-12-31 23:59:59' '2099-12-31 23:59:59 +0000'
+check_parse '2099-12-31 23:59:59 +00' '2099-12-31 23:59:59 +0000'
+check_parse '2099-12-31 23:59:59 Z' '2099-12-31 23:59:59 +0000'
+check_parse '2099-12-31 23:59:59 +01' '2099-12-31 23:59:59 +0100'
+check_parse '2099-12-31 23:59:59 -01' bad
+check_parse '2099-12-31 23:59:59 -11' bad
+check_parse '2099-12-31 23:00:00 -01' bad
+check_parse '2099-12-31 22:59:59 -01' '2099-12-31 22:59:59 -0100'
+check_parse '2100-00-00 00:00:00' bad
+check_parse '2099-12-30 00:00:00 -11' '2099-12-30 00:00:00 -1100'
+check_parse '2100-00-00 00:00:00 +00' bad
+check_parse '2100-00-00 00:00:00 Z' bad
+check_parse '2100-00-00 00:00:00 -11' bad
+check_parse '2100-00-00 00:00:00 +11' bad
+REQUIRE_64BIT_TIME=3D
+
 check_approxidate() {
 	echo "$1 -> $2 +0000" >expect
 	test_expect_${3:-success} "parse approxidate ($1)" "
--=20
2.45.2-796-g2ef7a3d713

