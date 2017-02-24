Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F349A201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 23:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbdBXXvL (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 18:51:11 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33137 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbdBXXvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 18:51:09 -0500
Received: by mail-pg0-f52.google.com with SMTP id z128so17263397pgb.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 15:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7nmBWCYF87TeOqACV+SB+zX80N5hyMzQQp0XN/VPGmc=;
        b=v+heDqL6Pjk2aDZGvks2O4OBT8L6C8NLO3eMHth/ZfPmTcle8eC9uz7pIr8wYqO9uK
         70KHqpC8+UUHUS0HPW9ydphDDv9/T+YcHyegdfziTrWhxwpUdp8Wn61rlp+PonknIbuz
         vi0ese7ocyhVFCkEhDWj0xr/mPKs0Y0pMo+Sn4XNnyrA3bv+lvR+dh84Vtt3kNTS03wr
         JCv+eqRajYpiKKGjYGr915MJm6i7hpxV9fw7SWhPJISDZaJ/r/0KUauVwzLyPq0Ypjuw
         oNtAsBjymR8POgGqi8y1sg68BWVkx2d8e5ZKpT7XHpxy1Hdtu4UXtyVgiS3qPmQabL2s
         d1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7nmBWCYF87TeOqACV+SB+zX80N5hyMzQQp0XN/VPGmc=;
        b=r3pHuWNkssxPlPx1DP/Xy/VsqzyrMKy9uA8FqQPtvVtrGMrCokZKq1X4Jg9fryVJ5y
         VAjar9pJB36sbPLRsqyz8hw7wpKpNn+jPkZPCJYuEywvZOvDdgydY52kPHrdlMQflxEl
         tB9ixQCy6hKxpaASQ1KOwC07HATH/LefIVsTo7uZ6NsDWmXL62Z4Ibp2WGFurWgwbAhB
         QQ5shJj8oTcwv2XapxMiLRT7mIKrpQxb5ZUKZRPsGfy1VA6veisg/TSaBBWb/2y9NQCD
         HDsk9ufhiMfoRGaMD7gzSdGD8QAFn/tcW7TyR0npy0746t/8+DAehX2EXAIWkp/Qq/sn
         XayQ==
X-Gm-Message-State: AMke39lY2lRXpMIW6jAH8P6htm9yf4FAhpb1S5qonRI41klJhdAgA8An7TC6kcX+uF58azcQ
X-Received: by 10.98.184.1 with SMTP id p1mr6846513pfe.127.1487980268895;
        Fri, 24 Feb 2017 15:51:08 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id v69sm17048236pgd.18.2017.02.24.15.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 15:51:07 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com
Subject: [PATCH 1/5] grep: illustrate bug when recursing with relative pathspec
Date:   Fri, 24 Feb 2017 15:50:56 -0800
Message-Id: <20170224235100.52627-2-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170224235100.52627-1-bmwill@google.com>
References: <20170224235100.52627-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the --recurse-submodules flag with a relative pathspec which
includes "..", an error is produced inside the child process spawned for
a submodule.  When creating the pathspec struct in the child, the ".."
is interpreted to mean "go up a directory" which causes an error stating
that the path ".." is outside of the repository.

While it is true that ".." is outside the scope of the submodule, it is
confusing to a user who originally invoked the command where ".." was
indeed still inside the scope of the superproject.  Since the child
process luanched for the submodule has some context that it is operating
underneath a superproject, this error could be avoided.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/t7814-grep-recurse-submodules.sh | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 67247a01d..418ba68fe 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -227,6 +227,48 @@ test_expect_success 'grep history with moved submoules' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'grep using relative path' '
+	test_when_finished "rm -rf parent sub" &&
+	git init sub &&
+	echo "foobar" >sub/file &&
+	git -C sub add file &&
+	git -C sub commit -m "add file" &&
+
+	git init parent &&
+	echo "foobar" >parent/file &&
+	git -C parent add file &&
+	mkdir parent/src &&
+	echo "foobar" >parent/src/file2 &&
+	git -C parent add src/file2 &&
+	git -C parent submodule add ../sub &&
+	git -C parent commit -m "add files and submodule" &&
+
+	# From top works
+	cat >expect <<-\EOF &&
+	file:foobar
+	src/file2:foobar
+	sub/file:foobar
+	EOF
+	git -C parent grep --recurse-submodules -e "foobar" >actual &&
+	test_cmp expect actual &&
+
+	# Relative path to top errors out
+	cat >expect <<-\EOF &&
+	../file:foobar
+	file2:foobar
+	../sub/file:foobar
+	EOF
+	git -C parent/src grep --recurse-submodules -e "foobar" -- .. >actual &&
+	test_cmp expect actual &&
+
+	# Relative path to submodule errors out
+	cat >expect <<-\EOF &&
+	../sub/file:foobar
+	EOF
+	git -C parent/src grep --recurse-submodules -e "foobar" -- ../sub >actual &&
+	test_cmp expect actual
+'
+
 test_incompatible_with_recurse_submodules ()
 {
 	test_expect_success "--recurse-submodules and $1 are incompatible" "
-- 
2.11.0.483.g087da7b7c-goog

