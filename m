Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E7A0201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 23:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbdBXXva (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 18:51:30 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35035 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbdBXXv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 18:51:29 -0500
Received: by mail-pg0-f43.google.com with SMTP id b129so17226052pgc.2
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 15:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AUyEjBXwRaotLuxCkc1KmZ9/hmYKrP8Pg/l6jcfETdA=;
        b=O+B11yG1pK15lSDvao6aq4+fiJBX7vTfXg0xYhVM+NeVoeqsXzaQc67snHs2Efqfkz
         ktX0XAiX+E8nm+ETY+cYelWbZR9035UlpfHLXSoH9ZseuKJm+tlia1M3AF3/T8glEYUq
         oK/JnaDZ5CiTqwj2nUNUhXbrsJTSO2vf5ontEozCMaHYCWWLmnkMRlBpES3NBpUBLGcV
         +rjEAMxXJMxyzxUYkVEdweXG0WRzUz8w55tOv/xqXXLZ0Zloq680ZoN5yinIVqf2lShi
         U57x96MQz8NflxicYgm4alA7Qi3TxgGtRIVlkNYRHzxaQ6wchQQZucAG09lnH237Gq+L
         URkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AUyEjBXwRaotLuxCkc1KmZ9/hmYKrP8Pg/l6jcfETdA=;
        b=QY9fLe/gi06yTdM7Wv6ETHSF7lXJNCZ1/r2CAxjQAeAzBwH74O8pSOLNz3COxAHHl9
         QJ4LCuKqnZu+GQo+MjAeDee5xNMTyrhF64cUHh/ghMh+PM3t9+dv8ihtDPqK5HGG5iDB
         su6aS/cBUD7CnDNZG2tjPwOd17mivkUAHMWT6Y1aPrkGvenw8my0opduHvvD54Nh6Ya+
         l8LN5yiplAE5EHrgtmRmKk+ur0Pc06UuTkv1Hr6znZVbNZLZu77uoITQvlXxotzZJcqc
         aZWH7OFPffNBPbNUamGbVy7hMp8VTZfWcIlBSGs5Q/6npqTWO+Fk52Z9/SznZtA3TnKW
         P9lw==
X-Gm-Message-State: AMke39k7gt8YdqqzwK7Vb+pSbnrwnsNvA4+WvWn4eD9shP7y7SjwhhddAcGc1kWtNe7k5FUt
X-Received: by 10.84.225.146 with SMTP id u18mr7573793plj.157.1487980273638;
        Fri, 24 Feb 2017 15:51:13 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id v69sm17048236pgd.18.2017.02.24.15.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 15:51:12 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com
Subject: [PATCH 4/5] ls-files: illustrate bug when recursing with relative pathspec
Date:   Fri, 24 Feb 2017 15:50:59 -0800
Message-Id: <20170224235100.52627-5-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170224235100.52627-1-bmwill@google.com>
References: <20170224235100.52627-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the --recurse-submodules flag with a relative pathspec which
includes "..", an error is produced inside the child process spawned for a
submodule.  When creating the pathspec struct in the child, the ".." is
interpreted to mean "go up a directory" which causes an error stating that the
path ".." is outside of the repository.

While it is true that ".." is outside the scope of the submodule, it is
confusing to a user who originally invoked the command where ".." was indeed
still inside the scope of the superproject.  Since the child process luanched
for the submodule has some context that it is operating underneath a
superproject, this error could be avoided.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/t3007-ls-files-recurse-submodules.sh | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index a5426171d..d8ab10866 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -188,6 +188,56 @@ test_expect_success '--recurse-submodules and pathspecs' '
 	test_cmp expect actual
 '
 
+test_expect_failure '--recurse-submodules and relative paths' '
+	# From top works
+	cat >expect <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	h.txt
+	sib/file
+	sub/file
+	submodule/.gitmodules
+	submodule/c
+	submodule/f.TXT
+	submodule/g.txt
+	submodule/subsub/d
+	submodule/subsub/e.txt
+	EOF
+	git ls-files --recurse-submodules >actual &&
+	test_cmp expect actual &&
+
+	# Relative path to top errors out
+	cat >expect <<-\EOF &&
+	../.gitmodules
+	../a
+	b
+	../h.txt
+	../sib/file
+	../sub/file
+	../submodule/.gitmodules
+	../submodule/c
+	../submodule/f.TXT
+	../submodule/g.txt
+	../submodule/subsub/d
+	../submodule/subsub/e.txt
+	EOF
+	git -C b ls-files --recurse-submodules -- .. >actual &&
+	test_cmp expect actual &&
+
+	# Relative path to submodule errors out
+	cat >expect <<-\EOF &&
+	../submodule/.gitmodules
+	../submodule/c
+	../submodule/f.TXT
+	../submodule/g.txt
+	../submodule/subsub/d
+	../submodule/subsub/e.txt
+	EOF
+	git -C b ls-files --recurse-submodules -- ../submodule >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--recurse-submodules does not support --error-unmatch' '
 	test_must_fail git ls-files --recurse-submodules --error-unmatch 2>actual &&
 	test_i18ngrep "does not support --error-unmatch" actual
-- 
2.11.0.483.g087da7b7c-goog

