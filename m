Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BA5C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 20:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239943AbhLHUIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 15:08:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64747 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbhLHUIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 15:08:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61E9CF2A32;
        Wed,  8 Dec 2021 15:04:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FaRQ76OCMRsPKwNabAFmfj6wdCXQapUVGNegMp
        bp37k=; b=HMYMLZfF1VLhWFgschyHfifsyXCIybBQhFwzqLy4FdBziEw37YXEYJ
        cmE4zBx4q62DAua/3hIhLqO5KZgtx4XAYgvZPgcHLzbDdVnci80Q+4p95F9UJQi+
        cOESRiKrd6oTcdyo3iu7jzcn1XxXfWSevRVC920rTEaNCVoTNg+nw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56A00F2A31;
        Wed,  8 Dec 2021 15:04:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B3BE4F2A30;
        Wed,  8 Dec 2021 15:04:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [RFC/PATCH] Makefile: add test-all target
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
        <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
        <xmqq4k7nmksi.fsf@gitster.g>
        <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
        <xmqqh7bi27o9.fsf@gitster.g>
Date:   Wed, 08 Dec 2021 12:04:50 -0800
In-Reply-To: <xmqqh7bi27o9.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        08 Dec 2021 11:55:18 -0800")
Message-ID: <xmqq8rwu278d.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A934D98-5862-11EC-A0F9-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We ship contrib/ stuff within our primary source tree but except for
the completion scripts that are tested from our primary test suite,
their test suites are not run in the CI.

Teach the main Makefile a "test-extra" target, which goes into each
package in contrib/ whose Makefile has its own "test" target and
runs "make test" there.  Add a "test-all" target to make it easy to
drive both the primary tests and these contrib tests from CI and use
it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Junio C Hamano <gitster@pobox.com> writes:

> That is an interesting way to demonstrate how orthogonal the issues
> are, which in turn means that it is not such a big deal to add back
> the coverage to the part that goes to contrib/scalar/.  As the actual
> implementation, it is a bit too icky, though.

So, how about doing it this way?  This is based on 'master' and does
not cover contrib/scalar, but if we want to go this route, it should
be trivial to do it on top of a merge of ab/ci-updates and js/scalar
into 'master'.  Good idea?  Terrible idea?  Not good enough?

 Makefile                  | 12 +++++++++++-
 ci/run-build-and-tests.sh | 10 +++++-----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git i/Makefile w/Makefile
index d56c0e4aad..ca14558e3c 100644
--- i/Makefile
+++ w/Makefile
@@ -2878,10 +2878,20 @@ export TEST_NO_MALLOC_CHECK
 test: all
 	$(MAKE) -C t/ all
 
+# Additional tests from places in contrib/ that are prepared to take
+# "make -C $there test", but expects that the primary build is done
+# already.
+test-extra: all
+	$(MAKE) -C contrib/diff-highlight test
+	$(MAKE) -C contrib/mw-to-git test
+	$(MAKE) -C contrib/subtree test
+
+test-all:: test test-extra
+
 perf: all
 	$(MAKE) -C t/perf/ all
 
-.PHONY: test perf
+.PHONY: test test-extra test-all perf
 
 .PRECIOUS: $(TEST_OBJS)
 
diff --git i/ci/run-build-and-tests.sh w/ci/run-build-and-tests.sh
index cc62616d80..9da0f26665 100755
--- i/ci/run-build-and-tests.sh
+++ w/ci/run-build-and-tests.sh
@@ -19,7 +19,7 @@ make
 case "$jobname" in
 linux-gcc)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
-	make test
+	make test-all
 	export GIT_TEST_SPLIT_INDEX=yes
 	export GIT_TEST_MERGE_ALGORITHM=recursive
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true
@@ -33,20 +33,20 @@ linux-gcc)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
-	make test
+	make test-all
 	;;
 linux-clang)
 	export GIT_TEST_DEFAULT_HASH=sha1
-	make test
+	make test-all
 	export GIT_TEST_DEFAULT_HASH=sha256
-	make test
+	make test-all
 	;;
 linux-gcc-4.8|pedantic)
 	# Don't run the tests; we only care about whether Git can be
 	# built with GCC 4.8 or with pedantic
 	;;
 *)
-	make test
+	make test-all
 	;;
 esac
 
