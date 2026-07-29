Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977DF3E0C66
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785367941; cv=none; b=lZGnRWkZrlPGldJkOBtBeHxSaW8b2lMwbbG6f/jLNwVoaDgh6dllkU8xCMuU6CvTO35o0E/idxedFJdL1K6LU199otWeAQitPXLzKrwpQqdAAsqZ/CwsUnsuP9FXSML8B3vTLrS38S3HBjkbB+wnCvKmQcc4RMWP791qS0qD3ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785367941; c=relaxed/simple;
	bh=hgES4o+x7qfP7e1MvRkZIpNETJg4Ie2NOBsYNmUM6Wg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WlbYErROutUGmBPewuHcIWpbzrk/BEZbGZbH4CslcYJS3K3M9axHQFId8I3yhU0oHSqQMZBezbEMHRqd50EGlYYWxvFdSqLhHKhHee+c6NLZDcRFlScIbkKPrAOoAn5TzlSt1/LRWkcUAyUfKztqDubSmx40BtOtgXymMy9UpSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uNSW4bip; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uNSW4bip"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1785367938;
	bh=hgES4o+x7qfP7e1MvRkZIpNETJg4Ie2NOBsYNmUM6Wg=;
	h=From:To:Subject:Date:From:Reply-To:Subject:Date:To:CC:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uNSW4bip3cQDrNXOcBQlaGyRDjOCK9lanDsQPQCid/yl/BwwKhcZS8Fu/uaf9LLQ2
	 W/mEdhSzd8hwBO+npElZF0ojqXy9A8rb8Qp1u6zczn0hltS+LELJZM8PypAdV7Iq4h
	 IQ/pBy6Q1ZNF9YFhEr9mguHEpexW2qe4gH0JexZlBVnpX9XiOAZrUNsCuUnPZQ+Ybm
	 lbr61RmJU/DTvIX+XYnP3zn6Ef+t78xQyJhbxQpX5qP6iV71ZM5OYn7bXUN9EBNm0D
	 Iso63/nuuv4CNa7n5Dkax17FPdbpX0F8tIwwtViqz32+jGyDOJVNAPE7Y4ndpoA7op
	 oUNLji3NtxxgKTDmzKT3AxmrDFZwOXv6HA5FDTTv2J1MD36ZWCN5ugFY52RzCkUIkU
	 iKYMEejpDjJz8rFbw0qdVh5GjrSHf/C1H5A1y2OZMXPpgTRjG6Yy/sRqc9njSzI3OW
	 HwgUutg6hxC7EMXUyYghvI+NZlQqvXCzef+Fl+bv8r/01awcInL
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:c292:4852:9051:fdce])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9335C20083
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 23:32:18 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Subject: [RFC PATCH 0/6] Git 3.0: restrict hex object IDs to lowercase only
Date: Wed, 29 Jul 2026 23:32:09 +0000
Message-ID: <20260729233215.398654-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As far as I can tell, Git has always emitted hex object IDs in
lowercase, but our object ID parser accepts both uppercase and
lowercase.  This leads to much software relying on hex object IDs being
broken because it doesn't handle uppercase object IDs and this can even
lead to security problems when people assume that an object ID has a
unique hex form.

This series proposes to remove the ability to use uppercase hex in
object IDs in Git 3.0.  It is RFC simply because it's not clear if
there's the desire to do this, although the series should be fully
functional.

As further evidence of why we should do this, I'll note that there is
exactly one testcase in our testsuite that fails due to this change
(fixed in the last patch) and it's not clear that it fails
intentionally.  If we decide not to adopt this series, it would probably
be prudent to add some additional tests for the uppercase variant of hex
object IDs.

brian m. carlson (6):
  hex: add functionality for lowercase-only hex
  hex: allow specifying hex type with hex2chr
  hex: make hex_to_bytes accept kind of hex to use
  hex: label usages of hex parsing for object IDs
  object-name: use hexval
  hex: allow only lowercase object IDs in breaking changes mode

 Documentation/BreakingChanges.adoc |  5 ++++
 builtin/index-pack.c               |  2 +-
 color.c                            |  2 +-
 diagnose.c                         |  2 +-
 hex-ll.c                           | 39 ++++++++++++++++++++++++++++--
 hex-ll.h                           | 24 +++++++++++++-----
 hex.c                              |  2 +-
 http-push.c                        |  5 ++--
 mailinfo.c                         |  2 +-
 notes.c                            |  5 ++--
 object-file.c                      |  2 +-
 object-name.c                      | 13 +++-------
 pkt-line.c                         |  8 +++---
 ref-filter.c                       |  2 +-
 strbuf.c                           |  2 +-
 t/t1503-rev-parse-verify.sh        |  5 ++++
 t/t5324-split-commit-graph.sh      |  4 +--
 url.c                              |  2 +-
 urlmatch.c                         |  2 +-
 19 files changed, 90 insertions(+), 38 deletions(-)

