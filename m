Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF1F51F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 21:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeJIFLM (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:11:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49368 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726607AbeJIFLM (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 01:11:12 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 90D0A60795;
        Mon,  8 Oct 2018 21:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539035842;
        bh=KMHOFhDhs+e8XG79HA2fwqObXCKP54IxtSABSA7ldwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=p26fCrdI+J145aIthnaMHfvKDmYkRTdI8ybs+gR6PqEP0nQIkyioGqqDhQ5Ti1rEh
         aI3MDhghtC/hYFOkbD4F8Ui+13I98WsfTSj8RKw76A0NFd+xPYkTlTcHiKtaIT9SSH
         YRWQFcVQEwd6tdBumGv06TRlvgLi0aAj0Urn5oXyqbUgYGxGAEH11xi74ySblBnx/f
         b2pWy3p9ZbaMkUu1rrh3dWd2/cdVUpoMwV9wM7RO7DDsG/q4x8GiWiCTs+bjHfvk73
         R8+lHNNnVFap1c7lPnTjtzj5DIozSm4KozXNmBjAMbNfVdo1E345JzerfdvTGzD+rC
         4HQMH+nGwIGpxyWbp3Fpkup52xz0xgphDxF32Q+Bd3g1EVo0PJ537s8lS9jlMwkE+H
         VlNzFFpmqw1rod2zXCvVi6LDuu94lOywR/k/jIHeMU1fW6xeykI60+aPPtXHCYtYES
         m5pZpdee+pOLb0973kicGd3sIk8lVClBRNAxg2SVA31o4w6ARMP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/14] submodule: make zero-oid comparison hash function agnostic
Date:   Mon,  8 Oct 2018 21:57:00 +0000
Message-Id: <20181008215701.779099-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c
In-Reply-To: <20181008215701.779099-1-sandals@crustytoothpaste.net>
References: <20181008215701.779099-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With SHA-256, the length of the all-zeros object ID is longer.  Add a
function to git-submodule.sh to check if a full hex object ID is the
all-zeros value, and use it to check the output we're parsing from git
diff-files or diff-index.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-submodule.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 1b568e29b9..c09eb3e03d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -82,6 +82,11 @@ isnumber()
 	n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
 }
 
+# Given a full hex object ID, is this the zero OID?
+is_zero_oid () {
+	echo "$1" | sane_egrep '^0+$' >/dev/null 2>&1
+}
+
 # Sanitize the local git environment for use within a submodule. We
 # can't simply use clear_local_git_env since we want to preserve some
 # of the settings from GIT_CONFIG_PARAMETERS.
@@ -780,7 +785,7 @@ cmd_summary() {
 	while read -r mod_src mod_dst sha1_src sha1_dst status name
 	do
 		if test -z "$cached" &&
-			test $sha1_dst = 0000000000000000000000000000000000000000
+			is_zero_oid $sha1_dst
 		then
 			case "$mod_dst" in
 			160000)
