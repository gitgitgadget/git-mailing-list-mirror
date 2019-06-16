Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6B21F462
	for <e@80x24.org>; Sun, 16 Jun 2019 18:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfFPSxw (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 14:53:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60116 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbfFPSxv (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Jun 2019 14:53:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:159e:486:c87b:cfd7])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8A74160734;
        Sun, 16 Jun 2019 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560711230;
        bh=THkXpYsWQaFWlRkTvkgkbl/qnwONG7PXumiGdx2GvBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=tqaGJaESzE4Z2u4i9wECc8DwG8zIky3BdFZgFg4EDg/RWUnK2f3EhrwHDZ7gQ5Wq1
         edu6+F2/u50CDWkGmLeMUd48jF19ZVn9gWWivzKEisX6t1y5FgR45csW28B2DYBFBQ
         guJmPKy2NGLSCUI6iSZZ2s40IG1+YgJM/nsGRwC/ui8aF2aTlacdW4lPumm2JkQ719
         kVYNQwgM+z49P5FpSjKoRu2FdpNDcXE1bpsY5Fv78LXPkEEx/q2fXBq/udH+l67rGe
         Epsx/IPSuCW0kV22+oSckdcHahmw4FCEKZOK9cWPyDlGTeqIt3vH+w9XE8xEMp8mAq
         H4z7mQ4xsbAuQOR4y207198ysVpUmyZ4tJSoZNAeTl5I8OMjqf8r5E5i1EoAcDuBWr
         bZiUcrzjmR7J/872a91DYjYHXsa//8tyVlWhM83wzjUQoaJZNSN2CQ8DIeP8SJt1hO
         aELm+mFgR2NYKteaNmfT6RQCJmLBTCodl6bjgpvB7/GwVrripP0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/10] t: add helper to convert object IDs to paths
Date:   Sun, 16 Jun 2019 18:53:21 +0000
Message-Id: <20190616185330.549436-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5
In-Reply-To: <20190616185330.549436-1-sandals@crustytoothpaste.net>
References: <20190616185330.549436-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are several places in our testsuite where we want to insert a
slash after an object ID to make it into a path we can reference under
.git/objects, and we have various ways of doing so.  Add a helper to
provide a standard way of doing this that works for all size hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib-functions.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8270de74be..11a6abca2e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1314,6 +1314,12 @@ test_oid () {
 	eval "printf '%s' \"\${$var}\""
 }
 
+# Insert a slash into an object ID so it can be used to reference a location
+# under ".git/objects".  For example, "deadbeef..." becomes "de/adbeef..".
+test_oid_to_path () {
+	echo "$1" | sed -e 's!^..!&/!'
+}
+
 # Choose a port number based on the test script's number and store it in
 # the given variable name, unless that variable already contains a number.
 test_set_port () {
