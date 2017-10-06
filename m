Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1274F1FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 05:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751491AbdJFFn2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 01:43:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61422 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751484AbdJFFn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 01:43:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE489AAABB;
        Fri,  6 Oct 2017 01:43:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b1K+BAltBvFfSbk6kz0fVOBuEaQ=; b=xtqmdz
        uXHkqb/PWebm4ME8RmahV3Z6Ng6an0/1PRRXTbN7hdXwmNxSoPvp3LiI0HMsZaHX
        q62OB9s+yhPO1o41aKqKJhRBU1qtj7aE8vIB7hTZGeLBUi1dKg3upDjDAGSXIVDe
        H0ExszC6sRd1buzqwlrboOPq0p0y23Q6RKBCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CxNR/mDu5dW8bdq9eluvE1hYav2zJZx0
        tSRF8RHDmtS3IPIOg5XaF0kAejStNDMILmvWjJiVhNxYMnIyM2wxZHuUPAtDAmZy
        xAY92HhEQfYiw93wydTLRZJ8/yjRL6q7wSOgzpZp6UdELpS28IeHvSUYh7EVMLGn
        vf+o0M+1ACM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5C3CAAABA;
        Fri,  6 Oct 2017 01:43:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 23668AAAB7;
        Fri,  6 Oct 2017 01:43:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien =?utf-8?Q?Mari=C3=A9?= <damien@dam.io>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] run-command: add hint when a hook is ignored
References: <0102015ee1e41f17-927a8da1-ac14-4399-8424-fee8a82c2b0a-000000@eu-west-1.amazonses.com>
        <0102015eee503678-52126849-7580-4832-9d46-0f5ac7a52336-000000@eu-west-1.amazonses.com>
        <xmqq4lrcyj1p.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 06 Oct 2017 14:43:24 +0900
In-Reply-To: <xmqq4lrcyj1p.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 06 Oct 2017 13:52:34 +0900")
Message-ID: <xmqqmv54x24j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 460452F8-AA59-11E7-8D38-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a suggested rewrite of t7519 (I used t7520 to avoid crashing
with another topic in flight).

 - use unused/unallocated 7520 to avoid crashes with bp/fsmonitor
   topic

 - use setup inside test_expect_success

 - use test_i18ngrep to avoid gettext-poison build gotchas

 - look for specific advise message to make the test more robust

 - do not run Git on LHS of a pipe when we do not have to

 - use test_config and test_unconfig


 t/t7520-ignored-hook-warning.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100755 t/t7520-ignored-hook-warning.sh

diff --git a/t/t7520-ignored-hook-warning.sh b/t/t7520-ignored-hook-warning.sh
new file mode 100755
index 0000000000..634fb7f23a
--- /dev/null
+++ b/t/t7520-ignored-hook-warning.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='ignored hook warning'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	hookdir="$(git rev-parse --git-dir)/hooks" &&
+	hook="$hookdir/pre-commit" &&
+	mkdir -p "$hookdir" &&
+	write_script "$hook" <<-\EOF
+	exit 0
+	EOF
+'
+
+test_expect_success 'no warning if hook is not ignored' '
+	git commit --allow-empty -m "more" 2>message &&
+	test_i18ngrep ! -e "hook was ignored" message
+'
+
+test_expect_success POSIXPERM 'warning if hook is ignored' '
+	chmod -x "$hook" &&
+	git commit --allow-empty -m "even more" 2>message &&
+	test_i18ngrep -e "hook was ignored" message
+'
+
+test_expect_success POSIXPERM 'no warning if advice.ignoredHook set to false' '
+	test_config advice.ignoredHook false &&
+	chmod -x "$hook" &&
+	git commit --allow-empty -m "even more" 2>message &&
+	test_i18ngrep ! -e "hook was ignored" message
+'
+
+test_expect_success 'no warning if unset advice.ignoredHook and hook removed' '
+	rm -f "$hook" &&
+	test_unconfig advice.ignoredHook &&
+	git commit --allow-empty -m "even more" 2>message &&
+	test_i18ngrep ! -e "hook was ignored" message
+'
+
+test_done
-- 
2.15.0-rc0-155-g07e9c1a78d

