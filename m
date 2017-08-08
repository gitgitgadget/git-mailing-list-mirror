Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D63B51F991
	for <e@80x24.org>; Tue,  8 Aug 2017 08:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbdHHIsH (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 04:48:07 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:36135 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752529AbdHHIsE (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 Aug 2017 04:48:04 -0400
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net ([81.98.98.104] helo=celaeno.hellion.org.uk)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ijc-relay-phiayoh8@benson.default.arb33.uk0.bigv.io>)
        id 1dezWx-00010Z-MI; Tue, 08 Aug 2017 09:06:23 +0100
Received: from dagon.hellion.org.uk ([192.168.1.7])
        by celaeno.hellion.org.uk with smtp (Exim 4.84_2)
        (envelope-from <ijc@hellion.org.uk>)
        id 1dezWw-0006Em-2o; Tue, 08 Aug 2017 09:06:23 +0100
Received: by dagon.hellion.org.uk (sSMTP sendmail emulation); Tue, 08 Aug 2017 09:06:22 +0100
From:   Ian Campbell <ijc@hellion.org.uk>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Ian Campbell <ijc@hellion.org.uk>
Subject: [PATCH 2/2] filter-branch: Handle rewritting (very) old style tags which lack tagger
Date:   Tue,  8 Aug 2017 09:06:20 +0100
Message-Id: <20170808080620.9536-2-ijc@hellion.org.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1502179560.2735.22.camel@hellion.org.uk>
References: <1502179560.2735.22.camel@hellion.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Such as v2.6.12-rc2..v2.6.13-rc3 in the Linux kernel source tree.

Insert a fake tag header, since newer `git mktag` wont accept the input
otherwise:

    $ git cat-file tag v2.6.12-rc2
    object 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
    type commit
    tag v2.6.12-rc2

    Linux v2.6.12-rc2 release
    -----BEGIN PGP SIGNATURE-----
    Version: GnuPG v1.2.4 (GNU/Linux)

    iD8DBQBCbW8ZF3YsRnbiHLsRAgFRAKCq/TkuDaEombFABkPqYgGCgWN2lQCcC0qc
    wznDbFU45A54dZC8RZ5JxyE=
    =ESRP
    -----END PGP SIGNATURE-----

    $ git cat-file tag v2.6.12-rc2 | git mktag
    error: char76: could not find "tagger "
    fatal: invalid tag signature file
    $ git cat-file tag v2.6.13-rc4 | git mktag
    7eab951de91d95875ba34ec4c599f37e1208db93

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
---
 git-filter-branch.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index d07db3fee..6927aa2da 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -540,6 +540,9 @@ if [ "$filter_tag_name" ]; then
 			new_sha1=$( ( printf 'object %s\ntype commit\ntag %s\n' \
 						"$new_sha1" "$new_ref"
 				git cat-file tag "$ref" |
+				awk '/^tagger/	{ tagged=1 }
+				     /^$/	{ if (!tagged && !done) { print "tagger Unknown <unknown@example.com> 0 +0000" } ; done=1 }
+				     //		{ print }' |
 				sed -n \
 				    -e '1,/^$/{
 					  /^object /d
-- 
2.11.0

