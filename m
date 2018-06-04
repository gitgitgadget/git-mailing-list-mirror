Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105D61F517
	for <e@80x24.org>; Mon,  4 Jun 2018 23:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeFDXwq (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 19:52:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33176 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751000AbeFDXwo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Jun 2018 19:52:44 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EA00860741;
        Mon,  4 Jun 2018 23:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528156363;
        bh=keX/CC0r7KiRvN5lAu2AQnZ/YEbkIx4DVHiST/WGMgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=AzBLpeiTKBm67Gqow+ZqLseT00JXXCgZqVZ5+MBBThRTI6IJG/bAvOcEBRkc86pio
         Poz1tFCUdRs43syiC1UTwFqn3oLhHXGTGMESbQrUMMPKAAX/N/fjoJ+GoUQGX2psy/
         sK0W0xHpVYcetAqG3Z7/WqLTHY3C9Mc+L5WqNj0BzGLyy5nbv5DfdX1ZHUEgrVbW6o
         bM5XLbAuiNidzqNLNOFsI3TpGFyVtbqHQH6tRi7o2BD80b/d8eRrlyADGSbZdniaqY
         sVsk6pjj3DRneRbOfQLRFQJ3tncx9y8DETHq1J9XpNmM6xAW7LHxwszBlVuL94yi5/
         c2Lr1lb4KlaxlfhW1YZWGhl7d5Ngzyl/gJcj6e+SWEevC2dC6hlYcG+mTW1vCrrCCg
         pthz9PBVLGch1hbTOlLO0i88arCMtcq3DOZ4DWAODc4/fACfkfepLmr/F+BzFjWWYX
         AKMHc5BvG+357uDmhTUPex+vkvgjRLoSWtu/Gpg/622m2o5qRlW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 01/10] t: add tool to translate hash-related values
Date:   Mon,  4 Jun 2018 23:52:20 +0000
Message-Id: <20180604235229.279814-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.1.1185.g55be947832
In-Reply-To: <20180604235229.279814-1-sandals@crustytoothpaste.net>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test function helper, test_translate, that will produce its first
argument if the hash in use is SHA-1 and the second if its argument is
NewHash.  Implement a mode that can read entries from a file as well for
reusability across tests.

For the moment, use the length of the empty blob to determine the hash
in use.  In the future, we can change this code so that it can use the
configuration and learn about the difference in input, output, and
on-disk formats.

Implement two basic lookup charts, one for common invalid or synthesized
object IDs, and one for various facts about the hash function in use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib-functions.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 t/translate/hash-info   |  9 +++++++++
 t/translate/oid         | 15 +++++++++++++++
 3 files changed, 64 insertions(+)
 create mode 100644 t/translate/hash-info
 create mode 100644 t/translate/oid

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2b2181dca0..0e7067460b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1147,3 +1147,43 @@ depacketize () {
 		}
 	'
 }
+
+test_translate_f_ () {
+	local file="$TEST_DIRECTORY/translate/$2" &&
+	perl -e '
+		$delim = "\t";
+		($hoidlen, $file, $arg) = @ARGV;
+		open($fh, "<", $file) or die "open: $!";
+		while (<$fh>) {
+			# Allow specifying other delimiters.
+			$delim = $1 if /^#!\sdelimiter\s(.)/;
+			next if /^#/;
+			@fields = split /$delim/, $_, 3;
+			if ($fields[0] eq $arg) {
+				print($hoidlen == 40 ? $fields[1] : $fields[2]);
+				last;
+			}
+		}
+	' "$1" "$file" "$3"
+}
+
+# Without -f, print the first argument if we are using SHA-1 and the second if
+# we're using NewHash.
+# With -f FILE ARG, read the (by default) tab-delimited file from
+# t/translate/FILE, finding the first field matching ARG and printing either the
+# second or third field depending on the hash in use.
+test_translate () {
+	local hoidlen=$(printf "%s" "$EMPTY_BLOB" | wc -c) &&
+	if [ "$1" = "-f" ]
+	then
+		shift &&
+		test_translate_f_ "$hoidlen" "$@"
+	else
+		if [ "$hoidlen" -eq 40 ]
+		then
+			printf "%s" "$1"
+		else
+			printf "%s" "$2"
+		fi
+	fi
+}
diff --git a/t/translate/hash-info b/t/translate/hash-info
new file mode 100644
index 0000000000..36cbd9a8eb
--- /dev/null
+++ b/t/translate/hash-info
@@ -0,0 +1,9 @@
+# Various facts about the hash algorithm in use for easy access in tests.
+#
+# Several aliases are provided for easy recall.
+rawsz	20	32
+oidlen	20	32
+hexsz	40	64
+hexoidlen	40	64
+zero	0000000000000000000000000000000000000000	0000000000000000000000000000000000000000000000000000000000000000
+zero-oid	0000000000000000000000000000000000000000	0000000000000000000000000000000000000000000000000000000000000000
diff --git a/t/translate/oid b/t/translate/oid
new file mode 100644
index 0000000000..8de0fd64af
--- /dev/null
+++ b/t/translate/oid
@@ -0,0 +1,15 @@
+# These are some common invalid and partial object IDs used in tests.
+001	0000000000000000000000000000000000000001	0000000000000000000000000000000000000000000000000000000000000001
+002	0000000000000000000000000000000000000002	0000000000000000000000000000000000000000000000000000000000000002
+003	0000000000000000000000000000000000000003	0000000000000000000000000000000000000000000000000000000000000003
+004	0000000000000000000000000000000000000004	0000000000000000000000000000000000000000000000000000000000000004
+005	0000000000000000000000000000000000000005	0000000000000000000000000000000000000000000000000000000000000005
+006	0000000000000000000000000000000000000006	0000000000000000000000000000000000000000000000000000000000000006
+007	0000000000000000000000000000000000000007	0000000000000000000000000000000000000000000000000000000000000007
+# All zeros or Fs missing one or two hex segments.
+zero-1	000000000000000000000000000000000000000	000000000000000000000000000000000000000000000000000000000000000
+zero-2	00000000000000000000000000000000000000	00000000000000000000000000000000000000000000000000000000000000
+ff-1	fffffffffffffffffffffffffffffffffffffff	fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
+ff-2	ffffffffffffffffffffffffffffffffffffff	ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
+numeric	0123456789012345678901234567890123456789	0123456789012345678901234567890123456789012345678901234567890123
+deadbeef	deadbeefdeadbeefdeadbeefdeadbeefdeadbeef	deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef
