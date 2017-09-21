Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5479C2047F
	for <e@80x24.org>; Thu, 21 Sep 2017 07:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbdIUHtl (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 03:49:41 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:43240 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751531AbdIUHtj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Sep 2017 03:49:39 -0400
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net ([81.98.98.104] helo=celaeno.hellion.org.uk)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ijc-relay-phiayoh8@benson.default.arb33.uk0.bigv.io>)
        id 1duwEr-0005Og-Kw; Thu, 21 Sep 2017 08:49:38 +0100
Received: from dagon.hellion.org.uk ([192.168.1.7])
        by celaeno.hellion.org.uk with smtp (Exim 4.84_2)
        (envelope-from <ijc@hellion.org.uk>)
        id 1duwEq-0000hr-1Z; Thu, 21 Sep 2017 08:49:37 +0100
Received: by dagon.hellion.org.uk (sSMTP sendmail emulation); Thu, 21 Sep 2017 08:49:36 +0100
From:   Ian Campbell <ijc@hellion.org.uk>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Ian Campbell <ijc@hellion.org.uk>
Subject: [PATCH v3 4/4] filter-branch: use hash-object instead of mktag
Date:   Thu, 21 Sep 2017 08:49:32 +0100
Message-Id: <20170921074932.5490-4-ijc@hellion.org.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1505980146.4636.9.camel@hellion.org.uk>
References: <1505980146.4636.9.camel@hellion.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows us to recreate even historical tags which would now be consider
invalid, such as v2.6.12-rc2..v2.6.13-rc3 in the Linux kernel source tree which
lack the `tagger` header.

    $ git rev-parse v2.6.12-rc2
    9e734775f7c22d2f89943ad6c745571f1930105f
    $ git cat-file tag v2.6.12-rc2 | git mktag
    error: char76: could not find "tagger "
    fatal: invalid tag signature file
    $ git cat-file tag v2.6.12-rc2 | git hash-object -t tag -w --stdin
    9e734775f7c22d2f89943ad6c745571f1930105f

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
---
 git-filter-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 956869b8e..3365a3b86 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -561,7 +561,7 @@ if [ "$filter_tag_name" ]; then
 					}' \
 				    -e '/^-----BEGIN PGP SIGNATURE-----/q' \
 				    -e 'p' ) |
-				git mktag) ||
+				git hash-object -t tag -w --stdin) ||
 				die "Could not create new tag object for $ref"
 			if git cat-file tag "$ref" | \
 			   sane_grep '^-----BEGIN PGP SIGNATURE-----' >/dev/null 2>&1
-- 
2.11.0

