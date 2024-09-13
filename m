Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A7B140360
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 19:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255606; cv=none; b=Ws2RndXo/b/VNz46wnl5lExMfn7NDIOPx6gquBkx4R1wIu5bXGTdjN96me3zx0qlET2x/6IsyPZVgZwJjOVAnTSmOYWuEoRInEIQwTOY2HuZfWTjmsVn2BU1Nh/YM9FzEaVr2RKVB9GfPn7oSONKM1j0pNdv/w0yN/m7/h8TDG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255606; c=relaxed/simple;
	bh=7PHUwBVOXsAn4vQpfoVmEVzW8OAgJgk/lqn5mUOaQo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cEEDK5nzHa1tI2S+fSCJbxir7GP9IHtadMWbfJ+dJQ65NWQhK1jVF6pOLI6a/bJx1XHVEUP48j/645z15bqXCCXa2pWPMZp8cCIXDAiDbnyQjFR71EX5ZMFqm0emhYw4rWm7Bo+tqDbBeGQ3211doiBWee+9MaibeNJLqJ3r1Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iIsCJUvC; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iIsCJUvC"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8335D28EEF;
	Fri, 13 Sep 2024 15:26:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=7
	PHUwBVOXsAn4vQpfoVmEVzW8OAgJgk/lqn5mUOaQo0=; b=iIsCJUvCBbgSmHfJj
	l0KenRiBNHTvZAagYH71riPwIgaIVkIkcHmTmUNZmbMcZZlnC8r8XVOUZf117bkz
	n5ouCL1fAULRnGzEynvFtlFDNkGE7Lak/PJwEaErLQTMDisGAQYbXD6+nE5T3HgF
	zjpoOrCQVUJjqwssKckse2mzp8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A6E428EEE;
	Fri, 13 Sep 2024 15:26:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D9EF228EED;
	Fri, 13 Sep 2024 15:26:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Subject: [PATCH] t5512.40 sometimes dies by SIGPIPE
Date: Fri, 13 Sep 2024 12:26:41 -0700
Message-ID: <xmqqmskbwe1a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1B892306-7206-11EF-8592-9B0F950A682E-77302942!pb-smtp2.pobox.com

The last test in t5512 we recently added seems to be flaky.
Running

    $ make && cd t && sh ./t5512-ls-remote.sh --stress

shows that "git ls-remote foo::bar" exited with status 141, which
means we got a SIGPIPE.  This test piece was introduced by 9e89dcb6
(builtin/ls-remote: fall back to SHA1 outside of a repo, 2024-08-02)
and is pretty much independent from all other tests in the script
(it can even run standalone with everything before it removed).

The transport-helper.c:get_helper() function tries to write to the
helper.  As we can see the helper script is very short and can exit
even before it reads anything, when get_helper() tries to give the
first command, "capabilities", the helper may already be gone.

A trivial fix, presented here, os to make sure that the helper reads
the first command it is given, as what it writes later is a response
to that command.

I however would wonder if the interactions with the helper initiated
by get_helper() should be done on a non-blocking I/O (we do check
the return value from our write(2) system calls, do we?).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5512-ls-remote.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git c/t/t5512-ls-remote.sh w/t/t5512-ls-remote.sh
index d64b40e408..64b3491e4e 100755
--- c/t/t5512-ls-remote.sh
+++ w/t/t5512-ls-remote.sh
@@ -406,6 +406,7 @@ test_expect_success 'v0 clients can handle multiple symrefs' '
 test_expect_success 'helper with refspec capability fails gracefully' '
 	mkdir test-bin &&
 	write_script test-bin/git-remote-foo <<-EOF &&
+	read capabilities
 	echo import
 	echo refspec ${SQ}*:*${SQ}
 	EOF
