Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A95C352A2
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD1821741
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="CKYrUK69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBGAxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:45 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55540 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727453AbgBGAxl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:41 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7722760456;
        Fri,  7 Feb 2020 00:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036819;
        bh=gQ7BGVSvHA5TjKCdHIyKmIlh+T/wWkIIeGZoPz/7VHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=CKYrUK69TrkbTCXIqlXQxkFPNqq3VXjXhY7jMCb6YjZ/KjSXseZcB258FF+0nQ7Am
         AY2AAiIVaXVrL/MZFjxQVuUuctUgoDQ6pd0KvB3pJ8OrGrrcfSHQlxSlVmVZD0l83U
         13kehk2CM9smB2AALqJsLZkSJheqlZg16BOggKGPqPi6VfISTxV1Dmt5LNTv14Vyx3
         olxqXyhRTOpNW2wglKzTk7K2r+SWo/O2S26YT+/813F75KZrx3YVmm8GCFTnJ7jakB
         7jAqKPgvzXWGIYJdGBq4V48vsz165zeXAFZp5mGIWq6YH0IP/9byp4EN2sb2frCUqL
         jAHekZELYbfkdGhCaSCLEs15JSiafVGqzfPptgsPie8ZzfHBqrXMjnozZehOjHRfo1
         Njvs73piqjvy6LRu4WpoQUN4tqllq54tL1ahOUeiUliKDTGiIFBwDklbgqNqFiLpAZ
         77T8tm7N7B+UzDIGXw+kc8HmUdn2wm5iPVwzauFw/SWn1Q756d6
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 15/21] t5515: make test hash independent
Date:   Fri,  7 Feb 2020 00:52:48 +0000
Message-Id: <20200207005254.1495851-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7
In-Reply-To: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
References: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test contains a large number of data files, mostly using the same
object ID values for refs. Instead of producing two separate sets of
test files, keep the test files using SHA-1 and translate them on the
fly by replacing the SHA-1 values with the values for the current hash
algorithm in use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5515-fetch-merge-logic.sh | 59 +++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 961eb35c99..b1582a625f 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -12,11 +12,55 @@ GIT_TEST_PROTOCOL_VERSION=
 
 . ./test-lib.sh
 
+build_script () {
+	script="$1" &&
+	for i in one three_file master master2 one_tree three two two2 three2
+	do
+		echo "s/$(test_oid --hash=sha1 "$i")/$(test_oid "$i")/g" >>"$script"
+	done
+}
+
+convert_expected () {
+	file="$1" &&
+	script="$2" &&
+	sed -f "$script" "$file" >"$file.tmp" &&
+	mv "$file.tmp" "$file"
+}
+
 test_expect_success setup '
 	GIT_AUTHOR_DATE="2006-06-26 00:00:00 +0000" &&
 	GIT_COMMITTER_DATE="2006-06-26 00:00:00 +0000" &&
 	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
 
+	test_oid_cache <<-EOF &&
+	one sha1:8e32a6d901327a23ef831511badce7bf3bf46689
+	one sha256:8739546433ab1ac72ee93088dce611210effee072b2b586ceac6dde43ebec9ce
+
+	three_file sha1:0e3b14047d3ee365f4f2a1b673db059c3972589c
+	three_file sha256:bc4447d50c07497a8bfe6eef817f2364ecca9d471452e43b52756cc1a908bd32
+
+	master sha1:6c9dec2b923228c9ff994c6cfe4ae16c12408dc5
+	master sha256:8521c3072461fcfe8f32d67f95cc6e6b832a2db2fa29769ffc788bce85ebcd75
+
+	one_tree sha1:22feea448b023a2d864ef94b013735af34d238ba
+	one_tree sha256:6e4743f4ef2356b881dda5e91f5c7cdffe870faf350bf7b312f80a20935f5d83
+
+	three sha1:c61a82b60967180544e3c19f819ddbd0c9f89899
+	three sha256:0cc6d1eda617ded715170786e31ba4e2d0185404ec5a3508dd0d73b324860c6a
+
+	two sha1:525b7fb068d59950d185a8779dc957c77eed73ba
+	two sha256:3b21de3440cd38c2a9e9b464adb923f7054949ed4c918e1a0ac4c95cd52774db
+
+	master2 sha1:754b754407bf032e9a2f9d5a9ad05ca79a6b228f
+	master2 sha256:6c7abaea8a6d8ef4d89877e68462758dc6774690fbbbb0e6d7dd57415c9abde0
+
+	two2 sha1:6134ee8f857693b96ff1cc98d3e2fd62b199e5a8
+	two2 sha256:87a2d3ee29c83a3dc7afd41c0606b11f67603120b910a7be7840accdc18344d4
+
+	three2 sha1:0567da4d5edd2ff4bb292a465ba9e64dcad9536b
+	three2 sha256:cceb3e8eca364fa9a0a39a1efbebecacc664af86cbbd8070571f5faeb5f0e8c3
+	EOF
+
 	echo >file original &&
 	git add file &&
 	git commit -a -m One &&
@@ -86,7 +130,8 @@ test_expect_success setup '
 		git config branch.br-$remote-octopus.remote $remote &&
 		git config branch.br-$remote-octopus.merge refs/heads/one &&
 		git config --add branch.br-$remote-octopus.merge two
-	done
+	done &&
+	build_script sed_script
 '
 
 # Merge logic depends on branch properties and Pull: or .fetch lines
@@ -137,6 +182,10 @@ do
 	actual_r="$pfx-refs.$test"
 
 	test_expect_success "$cmd" '
+		cp "$expect_f" expect_f &&
+		convert_expected expect_f sed_script &&
+		cp "$expect_r" expect_r &&
+		convert_expected expect_r sed_script &&
 		{
 			echo "# $cmd"
 			set x $cmd; shift
@@ -152,18 +201,18 @@ do
 			cat .git/FETCH_HEAD
 		} >"$actual_f" &&
 		git show-ref >"$actual_r" &&
-		if test -f "$expect_f"
+		if test -f "expect_f"
 		then
-			test_cmp "$expect_f" "$actual_f" &&
+			test_cmp "expect_f" "$actual_f" &&
 			rm -f "$actual_f"
 		else
 			# this is to help developing new tests.
 			cp "$actual_f" "$expect_f"
 			false
 		fi &&
-		if test -f "$expect_r"
+		if test -f "expect_r"
 		then
-			test_cmp "$expect_r" "$actual_r" &&
+			test_cmp "expect_r" "$actual_r" &&
 			rm -f "$actual_r"
 		else
 			# this is to help developing new tests.
