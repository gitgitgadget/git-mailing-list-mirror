Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5F02F3B
	for <git@vger.kernel.org>; Sat, 22 Jun 2024 05:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719032930; cv=none; b=Ne4dQ+tcaEAQWQflLIw2wPg99f5G3nSdjN5NaPPssSUS8SbuipRFp8Mn5ZMaVN+qdJgb1CblwiJ6+q1J+pBXDnjYL6lWYRxBuftCLUrsAU5jmgg9jvC9vpuRAi2J5JdJtgYXBI+Rk3w+YptHqZBZy2xM1OBMVS/F1Fl7tTfCWwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719032930; c=relaxed/simple;
	bh=G0QMXo7hvkrp+ShtssxK1X7XN3dVDRBqpQztrKIkplg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SpsAeY/6eU4voTAibBc1jJ+5YW2ttNb9q6oEeDoT8QT9DmKwE0kcI4MovCFZcIp8oCrm5hKiWX7MAA93PsjkOxZuOteUd4cMBbdPAOEkDr5vZsy398GWx5F4UIhKmr0dDmMmsJS2SVemWtC/bB5ZTckIkZ1WeSOa/OjACud5xaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KeiE8kXj; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KeiE8kXj"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 174503B25A;
	Sat, 22 Jun 2024 01:08:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=G
	0QMXo7hvkrp+ShtssxK1X7XN3dVDRBqpQztrKIkplg=; b=KeiE8kXjHSEdi5wR3
	5ALB7BGRmg0wuWSTB8Su1rZg/xaX6TA0pqYwvy4AxTv4I5mNngi4KY2HaI9y70S/
	oZr5Bmb6NnvwLJYwSm6aEpXVzNNvQCC1+/Q4ys8UBPx/2hw//r5uMuRJc/6YWW8A
	UvXr0iJ+wt/yI/OpXdiE6TekNk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 10F893B259;
	Sat, 22 Jun 2024 01:08:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3815A3B258;
	Sat, 22 Jun 2024 01:08:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] fuzz: minimum fuzzers environment lacks libcURL
Date: Fri, 21 Jun 2024 22:08:42 -0700
Message-ID: <xmqqwmmhimxx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7F92ADA6-3055-11EF-ACF2-C38742FD603B-77302942!pb-smtp20.pobox.com

The "fuzz smoke test" job compiles various .o files to create
libgit.a and others, but the final build product of the fuzzer build
is *not* "git".  Since the job is not interested in building a
working "git", it does not define any build flags, and among the
notable ones that are missing is NO_CURL---even though the CI
environment that runs the job does not have libcURL development
package installed.

This obviously leads to a build failure.

Pass NO_CURL=NoThanks to "make" to make sure things will build
correctly, if we add any conditional compilation with "#ifdef
NO_CURL ... #endif" in the codebase.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/run-build-and-minimal-fuzzers.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/run-build-and-minimal-fuzzers.sh b/ci/run-build-and-minimal-fuzzers.sh
index a51076d18d..bcf2ed54d2 100755
--- a/ci/run-build-and-minimal-fuzzers.sh
+++ b/ci/run-build-and-minimal-fuzzers.sh
@@ -6,6 +6,7 @@
 . ${0%/*}/lib.sh
 
 group "Build fuzzers" make \
+	NO_CURL=NoThanks \
 	CC=clang \
 	CXX=clang++ \
 	CFLAGS="-fsanitize=fuzzer-no-link,address" \
-- 
2.45.2-789-g52a439864c

