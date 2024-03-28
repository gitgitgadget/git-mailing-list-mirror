Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF808121F
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642422; cv=none; b=lijMyRLRL8P7Hg0bwIoHGfaq96O5w8FZB7FwP7cohNJLsxow88gDIPZ0ZANBT34a7LxW1IOTDqVW+hZBX5aRAJ1nq/NtrcTELvlNs+AOjS/CFLlcpxnidgf1NGTeP2e+zk4tj+ZHTkDsmZy0aDcF+5+eWOOMluFo5CK8sUMUc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642422; c=relaxed/simple;
	bh=2mlnm3mD9xe09JVurqvdZiqVBYNpgZepdezzMgLx48Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g3siMwDChfGPMoYHnnfYF/jD9CqqswD/EtM8BW5P2suCLOHGIN+n112bnLkbxUdR7bsk3iQmotR7LZYbHehQAJ5cCZs2h+NMTLy/wcCamMIHc0CCWeSirYADeEgR6yjrQpzuZ9YbgKFJ/GNDaXIPfku21nyp0CE883mBWOLq8vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CVqcivz1; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CVqcivz1"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C111B1EB1CE;
	Thu, 28 Mar 2024 12:13:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2mlnm3mD9xe09JVurqvdZiqVBYNpgZepdezzMg
	Lx48Y=; b=CVqcivz1jLAQO7h7tWD9SDLbdGNML+NlQHaqU+ZvBleL6wrrH1SZVh
	T65HhuLPyUzm6onsMO5SRrZkt3E3DMSD4n32+dpqyV5kw8shksRCIHNjrMZwdPab
	L9P2oUBS1HHG+195aYLsF3blmIhR8OJb6Mdhj8biEP9uA/EOsNhI4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B9B511EB1CC;
	Thu, 28 Mar 2024 12:13:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2614F1EB1CB;
	Thu, 28 Mar 2024 12:13:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Matthew John Cheetham <mjcheetham@outlook.com>,  M Hickford
 <mirth.hickford@gmail.com>
Subject: Re: [PATCH 05/13] credential: gate new fields on capability
In-Reply-To: <20240328102053.GA890906@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 28 Mar 2024 06:20:53 -0400")
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
	<20240324011301.1553072-6-sandals@crustytoothpaste.net>
	<20240328102053.GA890906@coredump.intra.peff.net>
Date: Thu, 28 Mar 2024 09:13:38 -0700
Message-ID: <xmqq7chmwczx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2347879E-ED1E-11EE-B4B4-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> It doesn't show up elsewhere because only bash complains, but not dash.
> Even running the test script with bash isn't enough, because
> write_script uses $SHELL_PATH under the hood. But building with "make
> SHELL_PATH=/bin/bash test" shows the problem on other platforms.

Can we sneak it in to the GitHub Actions CI, I wonder, so that we
can catch tests that only fail with bash.  Would this be sufficient,
or can we just export it without using $use_bash to place it on the
command line of make?

 ci/run-build-and-tests.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git i/ci/run-build-and-tests.sh w/ci/run-build-and-tests.sh
index c192bd613c..8fb1114bc5 100755
--- i/ci/run-build-and-tests.sh
+++ w/ci/run-build-and-tests.sh
@@ -11,6 +11,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
 esac
 
 run_tests=t
+use_bash=
 
 case "$jobname" in
 linux-gcc)
@@ -30,6 +31,7 @@ linux-TEST-vars)
 	export GIT_TEST_NO_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
 	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
+	use_bash=/bin/bash
 	;;
 linux-clang)
 	export GIT_TEST_DEFAULT_HASH=sha1
@@ -51,7 +53,8 @@ esac
 group Build make
 if test -n "$run_tests"
 then
-	group "Run tests" make test ||
+	group "Run tests" \
+		make ${use_bash:+SHELL_PATH="$use_bash"} test ||
 	handle_failed_tests
 	group "Run unit tests" \
 		make DEFAULT_UNIT_TEST_TARGET=unit-tests-prove unit-tests

