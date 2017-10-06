Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 672DB20372
	for <e@80x24.org>; Fri,  6 Oct 2017 22:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbdJFWaw (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 18:30:52 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.109]:42903 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752095AbdJFWav (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 18:30:51 -0400
Received: from [89.246.212.34] (helo=sandbox)
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1e0b8q-0001O2-SK; Sat, 07 Oct 2017 00:30:48 +0200
Date:   Sat, 7 Oct 2017 00:30:47 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, Jens.Lehmann@web.de,
        bmwill@google.com
Subject: [RFC PATCH 1/4] fetch: add test to make sure we stay backwards
 compatible
Message-ID: <20171006223047.GB26642@sandbox>
References: <20171006222544.GA26642@sandbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171006222544.GA26642@sandbox>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current implementation of submodules supports on-demand fetch if
there is no .gitmodules entry for a submodule. Let's add a test to
document this behavior.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 t/t5526-fetch-submodules.sh | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 42251f7..43a22f6 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -478,7 +478,47 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	! test -s actual.out &&
-	test_i18ncmp expect.err actual.err
+	test_i18ncmp expect.err actual.err &&
+	(
+		cd submodule &&
+		git checkout -q master
+	)
+'
+
+test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .gitmodule entry" '
+	(
+		cd downstream &&
+		git fetch --recurse-submodules
+	) &&
+	add_upstream_commit &&
+	head1=$(git rev-parse --short HEAD) &&
+	git add submodule &&
+	git rm .gitmodules &&
+	git commit -m "new submodule without .gitmodules" &&
+	printf "" >expect.out &&
+	head2=$(git rev-parse --short HEAD) &&
+	echo "From $pwd/." >expect.err.2 &&
+	echo "   $head1..$head2  master     -> origin/master" >>expect.err.2 &&
+	head -3 expect.err >>expect.err.2 &&
+	(
+		cd downstream &&
+		rm .gitmodules &&
+		git config fetch.recurseSubmodules on-demand &&
+		# fake submodule configuration to avoid skipping submodule handling
+		git config -f .gitmodules submodule.fake.path fake &&
+		git config -f .gitmodules submodule.fake.url fakeurl &&
+		git add .gitmodules &&
+		git config --unset submodule.submodule.url &&
+		git fetch >../actual.out 2>../actual.err &&
+		# cleanup
+		git config --unset fetch.recurseSubmodules &&
+		git reset --hard
+	) &&
+	test_i18ncmp expect.out actual.out &&
+	test_i18ncmp expect.err.2 actual.err &&
+	git checkout HEAD^ -- .gitmodules &&
+	git add .gitmodules &&
+	git commit -m "new submodule restored .gitmodules"
 '
 
 test_expect_success 'fetching submodules respects parallel settings' '
-- 
2.10.0.129.g35f6318

