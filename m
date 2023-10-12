Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CAACDB482
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 17:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379625AbjJLRfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347388AbjJLRfL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 13:35:11 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CF772B1
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 10:28:22 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A350A239DB;
        Thu, 12 Oct 2023 13:28:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=yT/QlrTxkG2mXT1rAJSlkEsyAjZo5Zc3yRTlN3
        o+1P4=; b=aT/yZd4XHLUImwbOrvv0nyalfrMvPb+zorHIHBoDo9kW9hPIGFnG6V
        bgpIlZjwgE6FWOzt0rL7pJ/9QBarNmxlBGvVFT/QUnFJ83xZRckGn+rhc5pAgXNx
        ZUjIrUhFzMvJLkOSvdhM1PUYW2dYzxYaEYupXrbt29cI8tCwmlGnA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B897239DA;
        Thu, 12 Oct 2023 13:28:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 20450239D9;
        Thu, 12 Oct 2023 13:28:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug: Git grep -f reads the filename relative to the repository
 root
In-Reply-To: <CA+JQ7M_htKUv5=GRQEUqWmJrQmFQNfZkPjr8n12CU6x0Khr4dw@mail.gmail.com>
        (Erik Cervin Edin's message of "Thu, 12 Oct 2023 14:38:00 +0200")
References: <CA+JQ7M_htKUv5=GRQEUqWmJrQmFQNfZkPjr8n12CU6x0Khr4dw@mail.gmail.com>
Date:   Thu, 12 Oct 2023 10:28:16 -0700
Message-ID: <xmqqedhzg37z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB8E74C8-6924-11EE-B793-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Erik Cervin Edin <erik@cervined.in> writes:

> In the Git repository, I ran
>
>     echo tig > pattern-file &&
>         echo git > xdiff/pattern-file &&
>         cd xdfiff &&
>         git grep -f pattern-file
>
> What did you expect to happen? (Expected behavior)
>
> Git grep -f to read the pattern-file, in the xdiff directory and
> search for lines matching `git` in the xdiff directory.

That does sound like a bug.  It should use the original directory as
the base of the relative path computation, similar to the way how
OPT_FILENAME() options are handled.

Perhaps something along this line, but this is not even compile
tested yet.

----- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] grep: -f <path> is relative to $cwd

Just like OPT_FILENAME() does, "git grep -f <path>" should treat
the <path> relative to the original $cwd by paying attention to the
prefix the command is given.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/grep.c  | 13 +++++++++++--
 t/t7810-grep.sh | 13 +++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index b71222330a..fe78d4c98b 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2006 Junio C Hamano
  */
 #include "builtin.h"
+#include "abspath.h"
 #include "gettext.h"
 #include "hex.h"
 #include "repository.h"
@@ -812,14 +813,20 @@ static int file_callback(const struct option *opt, const char *arg, int unset)
 {
 	struct grep_opt *grep_opt = opt->value;
 	int from_stdin;
+	const char *filename = arg;
 	FILE *patterns;
 	int lno = 0;
 	struct strbuf sb = STRBUF_INIT;
 
 	BUG_ON_OPT_NEG(unset);
 
-	from_stdin = !strcmp(arg, "-");
-	patterns = from_stdin ? stdin : fopen(arg, "r");
+	if (!*filename)
+		; /* leave it as-is */
+	else
+		filename = prefix_filename_except_for_dash(grep_prefix, filename);
+
+	from_stdin = !strcmp(filename, "-");
+	patterns = from_stdin ? stdin : fopen(filename, "r");
 	if (!patterns)
 		die_errno(_("cannot open '%s'"), arg);
 	while (strbuf_getline(&sb, patterns) == 0) {
@@ -833,6 +840,8 @@ static int file_callback(const struct option *opt, const char *arg, int unset)
 	if (!from_stdin)
 		fclose(patterns);
 	strbuf_release(&sb);
+	if (filename != arg)
+		free((void *)filename);
 	return 0;
 }
 
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 39d6d713ec..91ac66935f 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -808,6 +808,19 @@ test_expect_success 'grep -f, ignore empty lines, read patterns from stdin' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep -f, use cwd relative file' '
+	test_when_finished "git rm -f sub/dir/file" &&
+	mkdir -p sub/dir &&
+	echo hit >sub/dir/file &&
+	git add sub/dir/file &&
+	echo hit >sub/dir/pattern &&
+	echo miss >pattern &&
+	(
+		cd sub/dir && git grep -f pattern file
+	) &&
+	git -C sub/dir grep -f pattern file
+'
+
 cat >expected <<EOF
 y:y yy
 --
-- 
2.42.0-345-gaab89be2eb

