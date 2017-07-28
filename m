Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8912089D
	for <e@80x24.org>; Fri, 28 Jul 2017 20:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbdG1UII (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 16:08:08 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34633 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752505AbdG1UIH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 16:08:07 -0400
Received: by mail-pf0-f172.google.com with SMTP id q85so99452389pfq.1
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 13:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m6Rti/eeuVlQTdfDi9pAyZj1/WV1uJhW6jbdjQD/OPk=;
        b=MLOOBQeo0pLG78lqq+gPX6U5rmL4sc6WVbIjF6d/uyO7rrfyqrsGPM0spxzfO4H6oh
         dPkJg4qI2aMy8feCwC/ShUIAagkGWpxj6eRu+aqgdfF4Vcc3H0EiRn4L+evDQ3Sd5wpZ
         4819fW17HmuUw2qWKXQlPQC4ENTlVoQTrFCbEwdlc+KfGasbnZu4ayg2hkbEF4bqc/LX
         S4JN2fWjGskc78WQnr7qu1pgHKNVS/PIYgmM1IfEdzj/OAZW4f7MkPsQb0wstNfJ25a2
         cAfB+KmBIqqCNjbodmBFOpwaY29pj7BwOzexcCvxlaLC6PjTWkmlINiUauPAcjzM3Qf8
         pWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m6Rti/eeuVlQTdfDi9pAyZj1/WV1uJhW6jbdjQD/OPk=;
        b=fBGXi8Q1hnhCvlxLbbLFAg89KMkBJQ/XSEXAiPfljZc11Lz5iDob8eskqQW6INy5MG
         1bXoQFGGwyl543B78N8IxP6/ETYiF6qRA+EQyhESdC+UTE86nhWn5rhH5odfg3flPOsp
         4J1e/mEJ/9C3X9UYTKlznQqV+AoDqV5RJ8I5ox1sgNHkGTIz0GMGFAxITYi2I0cHfnln
         YT3D7/ncOjB39m48dse20FY3MUJHfWdxCePMdaTCTPnkt/n3/5t+NWlJ3hBYzMFSAZcT
         J3r+SPHEBqKILayn7brQI4QpIg444vZsdu6EcUN6qVu7l9zUlfEcEv8sBVg/CxlNQ8xz
         i0gw==
X-Gm-Message-State: AIVw110VLFUDgKblxeglbHKS+QRAsald/WBMAG6uVKhGLz50zpxTrCr/
        Flzb/3b+hsSRCS8uF0ZNRw==
X-Received: by 10.98.111.194 with SMTP id k185mr8416883pfc.235.1501272486477;
        Fri, 28 Jul 2017 13:08:06 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id j14sm47782041pgt.7.2017.07.28.13.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Jul 2017 13:08:05 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peartben@gmail.com,
        gitster@pobox.com
Subject: [PATCH] tests: ensure fsck fails on corrupt packfiles
Date:   Fri, 28 Jul 2017 13:08:02 -0700
Message-Id: <20170728200802.12496-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <dc3c12fb-38e1-7c62-0d51-cca2f9883927@gmail.com>
References: <dc3c12fb-38e1-7c62-0d51-cca2f9883927@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t1450-fsck.sh does not have a test that checks fsck's behavior when a
packfile is invalid. It does have a test for when an object in a
packfile is invalid, but in that test, the packfile itself is valid.

Add such a test.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I think the existing packfile corruption test (t5303) is good enough
that we would notice such things, but just in case we want to test fsck
specifically, here's a patch.
---
 t/t1450-fsck.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index bb89e1a5d..4087150db 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -608,6 +608,22 @@ test_expect_success 'fsck errors in packed objects' '
 	! grep corrupt out
 '
 
+test_expect_success 'fsck fails on corrupt packfile' '
+	hsh=$(git commit-tree -m mycommit HEAD^{tree}) &&
+	pack=$(echo $hsh | git pack-objects .git/objects/pack/pack) &&
+
+	# Corrupt the first byte of the first object. (It contains 3 type bits,
+	# at least one of which is not zero, so setting the first byte to 0 is
+	# sufficient.)
+	chmod a+w .git/objects/pack/pack-$pack.pack &&
+	printf '\0' | dd of=.git/objects/pack/pack-$pack.pack bs=1 conv=notrunc seek=12 &&
+
+	test_when_finished "rm -f .git/objects/pack/pack-$pack.*" &&
+	remove_object $hsh &&
+	test_must_fail git fsck 2>out &&
+	test_i18ngrep "checksum mismatch" out
+'
+
 test_expect_success 'fsck finds problems in duplicate loose objects' '
 	rm -rf broken-duplicate &&
 	git init broken-duplicate &&
-- 
2.14.0.rc0.400.g1c36432dff-goog

