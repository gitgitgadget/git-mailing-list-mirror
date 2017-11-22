Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CC8420954
	for <e@80x24.org>; Wed, 22 Nov 2017 13:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdKVNgv (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 08:36:51 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:42790 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbdKVNgu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 08:36:50 -0500
Received: by mail-wm0-f66.google.com with SMTP id l188so8659502wma.1
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 05:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h3Ogjp1tcZMY1QjzgxWtPRduFQ5FCV9sae4OCzjUj3I=;
        b=R21vtnMHSongsjk0z42l7LpRT5orMZVeuUToNe3ymhbseSDP1ugEV0unvfoqJr3P0s
         y/KIHmg9yTsyNqtJUt5BoQKmnorA+RFf6+e9S12uiw3B/XHdmO7t2HWyw1v3iCRb15wZ
         wMyiBMaohLhgWcVzNjBv3greTcz7zJvw4gIpH9BIruxP4fr+iIIqNbd2s//QeyQ0dU/Z
         HSDkozOQkl6Y21zhNsuAJFK73W5hLZdxtYKAOjoNogUb6Dso0fdzTQuBJR/VnX7CwBpG
         o0NPYNjwtr+SuqnbHJkVrqCLcM28VmLjipN4tYoPSkfMIwV9PhkmEb0B9ZdHLCYOvoqu
         ijDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h3Ogjp1tcZMY1QjzgxWtPRduFQ5FCV9sae4OCzjUj3I=;
        b=Qsu7KvbO45pB51OPkczmI46dZ1ojjT5/kJfSomzp2zKTEOTloiqnO/5YHuXkE7QL7Z
         ioEEJ+ChAtelMDaFErKmN9E+kEHZFpYBe2rSI1qzNYsvE+5DnUnzAf0YLv1RDjYSo5Fc
         6QofouynzmTO5KxwYZAGtxG64knPfGQXCwdsu2/lqEkG4uIdDf5HVaZRHMQWSHEr7yFv
         3Ihia0+CzWBrctnhGqGMUhPS4jTKBkl6Jasj9dmeKD+BtsgxXnIRGp3SEMmqrJN8Oo5i
         5PdM2HfCzXpvLJ1tExPtDrnnGZsSu0N9cvtPCPbDlPBsQkIs3JYdE6W6I6FdbswxAdX7
         LNcg==
X-Gm-Message-State: AJaThX5nIg+M1WDOcY00qj3WG4pNjEmT8jihlzhclfE+FC6Y41vpAaLL
        5dfaMvKegk/Msz1LI8BQ6md3gaBI
X-Google-Smtp-Source: AGs4zMbSy7ajv690IFDiKle3JziGb/kmC+uwhC4AJrsmEc5IEP7f6B30KY/xJ6mhApWlibSRot/2YA==
X-Received: by 10.80.142.178 with SMTP id w47mr6717966edw.251.1511357808481;
        Wed, 22 Nov 2017 05:36:48 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k19sm12068426ede.35.2017.11.22.05.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 05:36:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] grep: fix segfault under -P + PCRE2 + (*NO_JIT)
Date:   Wed, 22 Nov 2017 13:36:30 +0000
Message-Id: <20171122133630.18931-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6
In-Reply-To: <20171122133630.18931-1-avarab@gmail.com>
References: <20171122133630.18931-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in the compilation of PCRE2 patterns under JIT (the most
common runtime configuration), any pattern with a (*NO_JIT) verb would
segfault. This bug dates back to my 94da9193a6 ("grep: add support for
PCRE v2", 2017-06-01):

    $ git grep -P '(*NO_JIT)hi.*there'
    Segmentation fault

As explained ad more length in the comment being added here it isn't
sufficient to just check pcre2_config() to see whether the JIT should
be used, pcre2_pattern_info() also has to be asked.

This is something I discovered myself when fiddling around with PCRE2
verbs in patterns passed to git. I don't expect that any user of git
has encountered this given the obscurity of passing PCRE2 verbs
through to the library, along with the relative obscurity of (*NO_JIT)
itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c          | 25 +++++++++++++++++++++++++
 t/t7810-grep.sh |  6 ++++++
 2 files changed, 31 insertions(+)

diff --git a/grep.c b/grep.c
index d0b9b6cdfa..f3139e867c 100644
--- a/grep.c
+++ b/grep.c
@@ -477,6 +477,8 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	int options = PCRE2_MULTILINE;
 	const uint8_t *character_tables = NULL;
 	int jitret;
+	int patinforet;
+	size_t jitsizearg;
 
 	assert(opt->pcre2);
 
@@ -511,6 +513,29 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
 		if (jitret)
 			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
+
+		/*
+		 * The pcre2_config(PCRE2_CONFIG_JIT, ...) call just
+		 * tells us whether the library itself supports JIT,
+		 * but to see whether we're going to be actually using
+		 * JIT we need to extract PCRE2_INFO_JITSIZE from the
+		 * pattern *after* we do pcre2_jit_compile() above.
+		 *
+		 * This is because if the pattern contains the
+		 * (*NO_JIT) verb (see pcre2syntax(3))
+		 * pcre2_jit_compile() will exit early with 0. If we
+		 * then proceed to call pcre2_jit_match() further down
+		 * the line instead of pcre2_match() we'll segfault.
+		 */
+		patinforet = pcre2_pattern_info(p->pcre2_pattern, PCRE2_INFO_JITSIZE, &jitsizearg);
+		if (patinforet)
+			die("BUG: The patinforet variable should be 0 after the pcre2_pattern_info() call, not %d",
+			    patinforet);
+		if (jitsizearg == 0) {
+			p->pcre2_jit_on = 0;
+			return;
+		}
+
 		p->pcre2_jit_stack = pcre2_jit_stack_create(1, 1024 * 1024, NULL);
 		if (!p->pcre2_jit_stack)
 			die("Couldn't allocate PCRE2 JIT stack");
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 2a6679c2f5..c8ff50cc30 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1110,6 +1110,12 @@ test_expect_success PCRE 'grep -P pattern' '
 	test_cmp expected actual
 '
 
+test_expect_success LIBPCRE2 "grep -P with (*NO_JIT) doesn't error out" '
+	git grep -P "(*NO_JIT)\p{Ps}.*?\p{Pe}" hello.c >actual &&
+	test_cmp expected actual
+
+'
+
 test_expect_success !PCRE 'grep -P pattern errors without PCRE' '
 	test_must_fail git grep -P "foo.*bar"
 '
-- 
2.15.0.403.gc27cc4dac6

