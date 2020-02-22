Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08741C35674
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D641E206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="f5Yobt3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgBVUSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39082 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726730AbgBVUSG (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:06 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 06DA7609D3
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402686;
        bh=JhFw1kr1hRK5pA2YM24867jb+2LzRJ5VsXh5VtRYvDA=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=f5Yobt3SKJduk84ItWlt+Yfpkw1rS9TjDw2+yOLBhw/qI784rKk146okfQvuomGtM
         TfuSs3qOppeAwMNcy1mwFoQse8a5fi+4qWe/+UXOa3IxNXFOYY65n5h4ivdw7JpasK
         tSGkN/sXJPuiXKBAYsNpJ/YrHuKthwW1QlgbB1Rcl52CB/UHrAP8Jg/iX4PfMIot9R
         Bq1mXutyJ29lvE5MPctIzzbg6B4N2JltDcIs/LgYYKgSspfAnxXN8+KovVqZhM3ivB
         vuOCprHVWQnFfZq3mAD2wyymBiViE7AMp18MI69oG4LTv+WdMSQ+ZJH6CiYB0G8+hI
         pd0fFTDQTpIoGzp0XLGxfz3VyO6I5tCHCvqTyEBa2voZ7xjs2lyU1eQLbdXrjYzoSp
         mlLnq0sUQUPcn6p9z54rtlovzdZYO9nincnU9qiD9zTlTtdSEQvpdeaRs3KzVpkiHo
         ONge9kj67tBwl1pqAxGClqKwSmUwwegEg1iFd1Eh9aUKllr/gwD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 06/24] t: use hash-specific lookup tables to define test constants
Date:   Sat, 22 Feb 2020 20:17:31 +0000
Message-Id: <20200222201749.937983-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we'll allow developers to run the testsuite with a hash
algorithm of their choice.  To make this easier, compute the fixed
constants using test_oid. Move the constant initialization down below
the point where test-lib-functions.sh is loaded so the functions are
defined.

Note that we don't provide a value for the OID_REGEX value directly
because writing a large number of instances of "[0-9a-f]" in the
oid-info files is unwieldy and there isn't a way to compute it based on
those values. Instead, compute it based on ZERO_OID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib.sh | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0ea1e5a05e..9fe390bd5a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -494,21 +494,6 @@ case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
 	;;
 esac
 
-# Convenience
-#
-# A regexp to match 5, 35 and 40 hexdigits
-_x05='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x35="$_x05$_x05$_x05$_x05$_x05$_x05$_x05"
-_x40="$_x35$_x05"
-
-# Zero SHA-1
-_z40=0000000000000000000000000000000000000000
-
-OID_REGEX="$_x40"
-ZERO_OID=$_z40
-EMPTY_TREE=4b825dc642cb6eb9a060e54bf8d69288fbee4904
-EMPTY_BLOB=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
-
 # Line feed
 LF='
 '
@@ -1383,6 +1368,20 @@ then
 	fi
 fi
 
+# Convenience
+# A regexp to match 5, 35 and 40 hexdigits
+_x05='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x35="$_x05$_x05$_x05$_x05$_x05$_x05$_x05"
+_x40="$_x35$_x05"
+
+test_oid_init
+
+ZERO_OID=$(test_oid zero)
+OID_REGEX=$(echo $ZERO_OID | sed -e 's/0/[0-9a-f]/g')
+EMPTY_TREE=$(test_oid empty_tree)
+EMPTY_BLOB=$(test_oid empty_blob)
+_z40=$ZERO_OID
+
 # Provide an implementation of the 'yes' utility; the upper bound
 # limit is there to help Windows that cannot stop this loop from
 # wasting cycles when the downstream stops reading, so do not be
