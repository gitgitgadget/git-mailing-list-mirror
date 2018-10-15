Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAC791F97E
	for <e@80x24.org>; Mon, 15 Oct 2018 00:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeJOHpY (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 03:45:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50628 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbeJOHpY (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 03:45:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6EEA261B8C;
        Mon, 15 Oct 2018 00:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539561746;
        bh=KMHOFhDhs+e8XG79HA2fwqObXCKP54IxtSABSA7ldwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gG+144CspDjRBcPrGeebJx/lRT2UaZ7i55PTQhgLt4KXNA0OHcpQMSUBkxxlprCsr
         fqb/IsDtP0pPO2INgtH483kFpme3Sl66EMaULS2efygSGk/Qtmnw1DyiMRQ0wWQOwM
         0+/U1DTulAP3fDwehv7fYmELOwypqIQJ5p5Ed7glOYvvepZeJyNuOJloChHMWjCG3R
         rl77VOfI10STm2oiRJkrY3Ril1rZhty+5ez6QYeVRepLk1mz+hfE7HRkzICZd+GiOA
         6a9lOjOTg5dOhV87Dg/xnI+o2imrZzO2hvnPMb6ers3lPI9pcCU1TyMcXh0OTuX55v
         iYJctnLQWeZXHsbE1jrGVUIbvsiJolBi4Vc0hXwscsl+QAmvdjiJurM6qyMuarDL6g
         jlhJRsl7o8kmS4r6WHF/osiIySH/CVTCW0GKZ3zOod7pLSWcOf6ehudWWXjNcW3pLo
         Yw5wJBpZLHs+OAQf1/X1hYtAI3hI6+SBSYCPwbXf3e7tTabQ8pi
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 14/15] submodule: make zero-oid comparison hash function agnostic
Date:   Mon, 15 Oct 2018 00:02:01 +0000
Message-Id: <20181015000202.951965-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181015000202.951965-1-sandals@crustytoothpaste.net>
References: <20181015000202.951965-1-sandals@crustytoothpaste.net>
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
