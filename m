Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FAEC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 10:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2258F6102A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 10:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbhIAKnj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 06:43:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:36260 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235353AbhIAKni (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 06:43:38 -0400
Received: (qmail 16536 invoked by uid 109); 1 Sep 2021 10:42:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Sep 2021 10:42:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6053 invoked by uid 111); 1 Sep 2021 10:42:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Sep 2021 06:42:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Sep 2021 06:42:40 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/8] add a test mode for SANITIZE=leak, run it in CI
Message-ID: <YS9ZIDpANfsh7N+S@coredump.intra.peff.net>
References: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <cover-v3-0.8-00000000000-20210831T132546Z-avarab@gmail.com>
 <YS9OT/pn5rRK9cGB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YS9OT/pn5rRK9cGB@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 01, 2021 at 05:56:31AM -0400, Jeff King wrote:

> +else
> +	# The test script has possible LSAN failures. Just disable
> +	# leak-checking entirely. Another option would be to log the failures
> +	# with:
> +	#
> +	#   LSAN_OPTIONS=exitcode=0:log_path=$TEST_DIRECTORY/lsan/out
> +	#
> +	# The results are rather confusing, though, as the logs are
> +	# per-process; you have no idea which one came from which test script.
> +	# Ideally we'd send them to descriptor 4 along with the rest of the
> +	# script log, but there's no LSAN_OPTION for that (recent versions of
> +	# libsanitizer do have a public function to do so, so we could hook it
> +	# ourselves via common-main).
> +	LSAN_OPTIONS=detect_leaks=0
> +fi

I was curious about the fd thing. The patch below implements it, and
lets t0203 (for example) pass while including its sanitizer output in a
--verbose-log.

But this is exactly the kind of gross complexity I was suggesting to
avoid. :)

diff --git a/Makefile b/Makefile
index d1feab008f..ba2174fb79 100644
--- a/Makefile
+++ b/Makefile
@@ -1260,6 +1260,7 @@ ifdef SANITIZE
 SANITIZERS := $(foreach flag,$(subst $(comma),$(space),$(SANITIZE)),$(flag))
 BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
 BASIC_CFLAGS += -fno-omit-frame-pointer
+BASIC_CFLAGS += -DENABLE_CUSTOM_SANITIZER_OPTIONS
 ifneq ($(filter undefined,$(SANITIZERS)),)
 BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
 endif
diff --git a/common-main.c b/common-main.c
index 71e21dd20a..bff594ac04 100644
--- a/common-main.c
+++ b/common-main.c
@@ -2,6 +2,10 @@
 #include "exec-cmd.h"
 #include "attr.h"
 
+#ifdef ENABLE_CUSTOM_SANITIZER_OPTIONS
+#include <sanitizer/asan_interface.h>
+#endif
+
 /*
  * Many parts of Git have subprograms communicate via pipe, expect the
  * upstream of a pipe to die with SIGPIPE when the downstream of a
@@ -23,6 +27,18 @@ static void restore_sigpipe_to_default(void)
 	signal(SIGPIPE, SIG_DFL);
 }
 
+static void handle_custom_sanitizer_options(void)
+{
+#ifdef ENABLE_CUSTOM_SANITIZER_OPTIONS
+	const char *v;
+	v = getenv("GIT_SANITIZER_FD");
+	if (v) {
+		/* weird int-as-void interface from libsanitizer */
+		__sanitizer_set_report_fd((void *)(intptr_t)atoi(v));
+	}
+#endif
+}
+
 int main(int argc, const char **argv)
 {
 	int result;
@@ -37,6 +53,8 @@ int main(int argc, const char **argv)
 	sanitize_stdfds();
 	restore_sigpipe_to_default();
 
+	handle_custom_sanitizer_options();
+
 	git_resolve_executable_dir(argv[0]);
 
 	git_setup_gettext();
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 62627afeaf..674bd30c44 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -54,22 +54,16 @@ then
 	# checking.
 	LSAN_OPTIONS=abort_on_error=1
 else
-	# The test script has possible LSAN failures. Just disable
-	# leak-checking entirely. Another option would be to log the failures
-	# with:
-	#
-	#   LSAN_OPTIONS=exitcode=0:log_path=$TEST_DIRECTORY/lsan/out
-	#
-	# The results are rather confusing, though, as the logs are
-	# per-process; you have no idea which one came from which test script.
-	# Ideally we'd send them to descriptor 4 along with the rest of the
-	# script log, but there's no LSAN_OPTION for that (recent versions of
-	# libsanitizer do have a public function to do so, so we could hook it
-	# ourselves via common-main).
-	LSAN_OPTIONS=detect_leaks=0
+	# The test script has possible LSAN failures. Just log them but don't
+	# touch the exit code.
+	LSAN_OPTIONS=exitcode=0
 fi
 export LSAN_OPTIONS
 
+# If we do generate output, try to avoid it getting tangled up with stderr.
+GIT_SANITIZER_FD=4
+export GIT_SANITIZER_FD
+
 if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
 then
 	echo >&2 'error: GIT-BUILD-OPTIONS missing (has Git been built?).'
@@ -463,6 +457,7 @@ unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
 		PERF_
 		CURL_VERBOSE
 		TRACE_CURL
+		SANITIZER_.*
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
