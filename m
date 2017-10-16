Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8121E20437
	for <e@80x24.org>; Mon, 16 Oct 2017 13:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbdJPN5a (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 09:57:30 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:39349 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbdJPN5a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 09:57:30 -0400
Received: from [193.96.224.22] (helo=book.hvoigt.net)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1e45tS-0002Y2-OB; Mon, 16 Oct 2017 15:57:26 +0200
Date:   Mon, 16 Oct 2017 15:57:15 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     sbeller@google.com, jrnieder@gmail.com, Jens.Lehmann@web.de,
        bmwill@google.com, git@vger.kernel.org
Subject: [PATCH v4 1/3] fetch: add test to make sure we stay backwards
 compatible
Message-ID: <20171016135715.GB12756@book.hvoigt.net>
References: <20171016135623.GA12756@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016135623.GA12756@book.hvoigt.net>
User-Agent: Mutt/1.9.0 (2017-09-02)
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
index 42251f7f3a..43a22f680f 100755
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
2.14.1.145.gb3622a4

