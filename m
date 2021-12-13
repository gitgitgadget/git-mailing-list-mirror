Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17525C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 10:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241202AbhLMKgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 05:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbhLMKfk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 05:35:40 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66545C0A88E7
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 02:09:46 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v11so26045572wrw.10
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 02:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5qaQFxJ0GgcxjEafWDxIv1TBAqZdjJjOzJgrLF0dqMQ=;
        b=NtBFJIKrChQF4H+cm0VqTwaS76RnMyJU8nm57v48CoFFsDUgUIcQkXGlntOJQ3CSiW
         3BprSY/KQgnqM7sykY0VDOCP9kMKslFXeVegf1qK6sBOQVmtZiiBFVyJmH7XEJVG3VIy
         7MktChyiTju31JqvS6UWGQCzXqePD+C66QKaUmmv1HWKlnep9sb/vddZ94nsidsFCtBm
         bR2F50ayOwR81e0NCX2Q0XfPL7RjCRNHpy1NCc8uM07twowhK4j2PdumztqIqGmjztg8
         wxHu7C4zvWGdmJkAKRBYkso4TFNnSxCVUI0RJvDsZyUHDrg0Sj9o1X746QZEpNrGqNMj
         3CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5qaQFxJ0GgcxjEafWDxIv1TBAqZdjJjOzJgrLF0dqMQ=;
        b=cdUq05Puv8KLiHfBRjF2rrh46leLn8Br/Zuv7xzv+/Dih4xfQPFoR8mwOiWzrpXow9
         3mP1CEwR3QZqtqXUZVwX30dhKj5uY6//7XlRsNwdsOCi7pEeu87+0DkNFe0On2UVO264
         MIjd/UxBuSUfzaSKCzNXAkvQZppgotv0dKM7a3tFsKm1eqIRsgszwIDSvJgYbSHX+jJE
         V996MXOR708tHBUXmdwHblbLArAu9tYrkbW2vSLH7bzrhGewXs50IUu1yIRfZIBks6DK
         wXYct6JnFbmH65ou9PTx5Xmd7wBxl7XvE/AJkaaXWqaiQrkNiU4guH5BoN+PoSZC3Jso
         s8+Q==
X-Gm-Message-State: AOAM531XLW12TEO3sJPJaBEvfCsTqoSB/A9qDOFVAaqbTJ946y+oMzKi
        Gw7ZsIed+VEV5Emb65V+JWo9PyesyOOMjw==
X-Google-Smtp-Source: ABdhPJwZ5zdIjY2lfv+olGAfEQu6EPRrbtmzWrVOhuEQrvolpHD07PiaHvzuWpL294iPcGttazD4ow==
X-Received: by 2002:a5d:584c:: with SMTP id i12mr30632378wrf.95.1639390184700;
        Mon, 13 Dec 2021 02:09:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t17sm7032157wmq.15.2021.12.13.02.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 02:09:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH] t/Makefile: use dependency graph for "check-chainlint"
Date:   Mon, 13 Dec 2021 11:09:42 +0100
Message-Id: <RFC-patch-1.1-bb3f1577829-20211213T095456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1025.g9a0c3a30920
In-Reply-To: <20211213063059.19424-6-sunshine@sunshineco.com>
References: <20211213063059.19424-6-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This gets rid of this fixed cost when running "make T=<name>":

$ git hyperfine -L rev HEAD~1,HEAD~0 -s 'make -C t check-chainlint' 'make -C t check-chainlint'
Benchmark 1: make -C t check-chainlint' in 'HEAD~1
  Time (mean ± σ):     111.3 ms ±   0.5 ms    [User: 116.9 ms, System: 26.2 ms]
  Range (min … max):   110.5 ms … 112.5 ms    26 runs

Benchmark 2: make -C t check-chainlint' in 'HEAD~0
  Time (mean ± σ):      12.5 ms ±   0.2 ms    [User: 11.5 ms, System: 1.0 ms]
  Range (min … max):    12.1 ms …  13.2 ms    223 runs

Summary
  'make -C t check-chainlint' in 'HEAD~0' ran
    8.92 ± 0.16 times faster than 'make -C t check-chainlint' in 'HEAD~1'
---
On Mon, Dec 13 2021, Eric Sunshine wrote:

> Rather than running `chainlint` and `diff` once per self-test -- which
> may become expensive as more tests are added -- instead run `chainlint`
> a single time over all tests bodies collectively and compare the result
> to the collective "expected" output.

I think that "optimizing" things like this is an anti-pattern. I.e. we
have N chainlint test files, and N potential outputs from that (ok or
not, and with/without error). If one of the chainlint tests changes
we'd like to re-run it, if not we can re-use an earlier run.

This is something make's dependency logic is perfectly suited for, and
will be faster than any optimization of turning a for-loop into a
"sed" command we run every time, since we'll only need to "stat" a few
things to see that there's nothing to do.

I've had the below as part of my local build for a while. It
conflicts/would be improved by my in-flight ab/make-dependency, which
you also ran into conflicts with.

This also has the advantage that you'll see what specific test failed
from the Makefile output. Aside from the ".build" rule needing to be
fixed up to use the "mkdir" trick in ab/make-dependency it should also
use $(QUIET_GEN) or whatever.

I'm not quite happy with the below, the wildcard/patsubst is a bit
messy, and it doesn't properly work around "make test" and how it runs
"clean" after its run, but you'll find that "make chainlint" will
properly cache things with this.

 t/.gitignore |  1 +
 t/Makefile   | 29 +++++++++++++++--------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/t/.gitignore b/t/.gitignore
index 91cf5772fe5..f142d6d42fd 100644
--- a/t/.gitignore
+++ b/t/.gitignore
@@ -1,3 +1,4 @@
+/.build/
 /trash directory*
 /test-results
 /.prove
diff --git a/t/Makefile b/t/Makefile
index 882d26eee30..9bac0e683c9 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -18,10 +18,8 @@ TEST_LINT ?= test-lint
 
 ifdef TEST_OUTPUT_DIRECTORY
 TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
-CHAINLINTTMP = $(TEST_OUTPUT_DIRECTORY)/chainlinttmp
 else
 TEST_RESULTS_DIRECTORY = test-results
-CHAINLINTTMP = chainlinttmp
 endif
 
 # Shell quote;
@@ -29,13 +27,12 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 TEST_SHELL_PATH_SQ = $(subst ','\'',$(TEST_SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
-CHAINLINTTMP_SQ = $(subst ','\'',$(CHAINLINTTMP))
 
 T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
 TGITWEB = $(sort $(wildcard t95[0-9][0-9]-*.sh))
 THELPERS = $(sort $(filter-out $(T),$(wildcard *.sh)))
 TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
-CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
+CHAINLINTTESTS = $(wildcard chainlint/*.test)
 CHAINLINT = sed -f chainlint.sed
 
 all: $(DEFAULT_TEST_TARGET)
@@ -67,16 +64,20 @@ clean: clean-except-prove-cache
 	$(RM) .prove
 
 clean-chainlint:
-	$(RM) -r '$(CHAINLINTTMP_SQ)'
-
-check-chainlint:
-	@mkdir -p '$(CHAINLINTTMP_SQ)' && \
-	err=0 && \
-	for i in $(CHAINLINTTESTS); do \
-		$(CHAINLINT) <chainlint/$$i.test | \
-		sed -e '/^# LINT: /d' >'$(CHAINLINTTMP_SQ)'/$$i.actual && \
-		diff -u chainlint/$$i.expect '$(CHAINLINTTMP_SQ)'/$$i.actual || err=1; \
-	done && exit $$err
+	$(RM) -r .build/chainlint
+
+BUILT_CHAINLINTTESTS = $(patsubst %,.build/%.actual,$(CHAINLINTTESTS))
+
+.build/chainlint:
+	mkdir -p $@
+
+$(BUILT_CHAINLINTTESTS): | .build/chainlint
+$(BUILT_CHAINLINTTESTS): .build/%.actual: %
+	$(CHAINLINT) <$< | \
+	sed -e '/^# LINT: /d' >$@ && \
+	diff -u $(basename $<).expect $@
+
+check-chainlint: $(BUILT_CHAINLINTTESTS)
 
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax \
 	test-lint-filenames
-- 
2.34.1.1025.g9a0c3a30920

