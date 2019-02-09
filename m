Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD0F51F453
	for <e@80x24.org>; Sat,  9 Feb 2019 20:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfBIUIT (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 15:08:19 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34004 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726836AbfBIUIT (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Feb 2019 15:08:19 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:d42:63e7:5548:1ee8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7826F60737;
        Sat,  9 Feb 2019 20:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549742896;
        bh=9LVKoqKzzq50MAOLT5jI4t2rUjK3uJlUYy3EKf00HJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=cCXT0BkkPJfNtZN58J+ZyXyQ0G14EEe65jZwWXIHbcTP03q5ASlqWDbr9GBWR7cem
         J/ejUax3kwhFo6jok/6cvepC+uLqUa6fHUwc/1yz8heogyOrJ1VnmfOn6CCUWRMk79
         VZHXTND+veBZNPZjXOm+edocdhZRwA5HeufcqkrHpbz+HiQsaY6UjOdgD8mCjEFx0H
         Kdxg6KwG07ejznUOYU3WuJz64FgsrBnH94lXWeF2OAglNJZIPXzdd2TYWkBdBo5bWF
         eQ8vIqPp5gH8R9SiN7D8YRIuctBGnwf/XhoSQOMoHNGNXs3CS0HvkwP/YUMHwQodBf
         VquShHqQIr99Qr+tvWJgnLNX3ouW3Jc2gCMmti6oOWsQ+cS0yWm7xuaKGS3NCMpi7+
         Hvuk7gFZwkSnwgK3a8/gBISJunHU/Dw7ACrAQtUwFpZJPPyS1FuBhPY7UpvgTnYVOd
         tO5lfg4pz6R87RA2qsgkNRLaJcHgaPBuuZq4mEkx6JNsQilH7+x
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     larsxschneider@gmail.com, Rich Felker <dalias@libc.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>
Subject: [PATCH] utf8: handle systems that don't write BOM for UTF-16
Date:   Sat,  9 Feb 2019 20:08:01 +0000
Message-Id: <20190209200802.277139-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190209145732.GA14229@alpha>
References: <20190209145732.GA14229@alpha>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When serializing UTF-16 (and UTF-32), there are three possible ways to
write the stream. One can write the data with a BOM in either big-endian
or little-endian format, or one can write the data without a BOM in
big-endian format.

Most systems' iconv implementations choose to write it with a BOM in
some endianness, since this is the most foolproof, and it is resistant
to misinterpretation on Windows, where UTF-16 and the little-endian
serialization are very common. For compatibility with Windows and to
avoid accidental misuse there, Git always wants to write UTF-16 with a
BOM, and will refuse to read UTF-16 without it.

However, musl's iconv implementation writes UTF-16 without a BOM,
relying on the user to interpret it as big-endian. This causes t0028 and
the related functionality to fail, since Git won't read the file without
a BOM.

Add a Makefile and #define knob, ICONV_NEEDS_BOM, that can be set if the
iconv implementation has this behavior. When set, Git will write a BOM
manually for UTF-16 and UTF-32 and then force the data to be written in
UTF-16BE or UTF-32BE. We choose big-endian behavior here because the
tests use the raw "UTF-16" encoding, which will be big-endian when the
implementation requires this knob to be set.

Update the tests to detect this case and write test data with an added
BOM if necessary. Always write the BOM in the tests in big-endian
format, since all iconv implementations that omit a BOM must use
big-endian serialization according to the Unicode standard.

Preserve the existing behavior for systems which do not have this knob
enabled, since they may use optimized implementations, including
defaulting to the native endianness, to gain improved performance, which
can be significant with large checkouts.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile                         |  6 ++++++
 t/t0028-working-tree-encoding.sh | 25 ++++++++++++++++++++++---
 utf8.c                           | 10 ++++++++++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 571160a2c4..b2a4765e5f 100644
--- a/Makefile
+++ b/Makefile
@@ -259,6 +259,9 @@ all::
 # Define OLD_ICONV if your library has an old iconv(), where the second
 # (input buffer pointer) parameter is declared with type (const char **).
 #
+# Define ICONV_NEEDS_BOM if your iconv implementation does not write a
+# byte-order mark (BOM) when writing UTF-16 or UTF-32.
+#
 # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
 #
 # Define NO_R_TO_GCC_LINKER if your gcc does not like "-R/path/lib"
@@ -1415,6 +1418,9 @@ ifndef NO_ICONV
 		EXTLIBS += $(ICONV_LINK) -liconv
 	endif
 endif
+ifdef ICONV_NEEDS_BOM
+	BASIC_CFLAGS += -DICONV_NEEDS_BOM
+endif
 ifdef NEEDS_LIBGEN
 	EXTLIBS += -lgen
 endif
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index e58ecbfc44..bfc4a9d4dd 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -6,6 +6,25 @@ test_description='working-tree-encoding conversion via gitattributes'
 
 GIT_TRACE_WORKING_TREE_ENCODING=1 && export GIT_TRACE_WORKING_TREE_ENCODING
 
+test_lazy_prereq NO_UTF16_BOM '
+	test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) = 6
+'
+
+test_lazy_prereq NO_UTF32_BOM '
+	test $(printf abc | iconv -f UTF-8 -t UTF-32 | wc -c) = 12
+'
+
+write_utf16 () {
+	test_have_prereq NO_UTF16_BOM && printf '\xfe\xff'
+	iconv -f UTF-8 -t UTF-16
+
+}
+
+write_utf32 () {
+	test_have_prereq NO_UTF32_BOM && printf '\x00\x00\xfe\xff'
+	iconv -f UTF-8 -t UTF-32
+}
+
 test_expect_success 'setup test files' '
 	git config core.eol lf &&
 
@@ -13,8 +32,8 @@ test_expect_success 'setup test files' '
 	echo "*.utf16 text working-tree-encoding=utf-16" >.gitattributes &&
 	echo "*.utf16lebom text working-tree-encoding=UTF-16LE-BOM" >>.gitattributes &&
 	printf "$text" >test.utf8.raw &&
-	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
-	printf "$text" | iconv -f UTF-8 -t UTF-32 >test.utf32.raw &&
+	printf "$text" | write_utf16 >test.utf16.raw &&
+	printf "$text" | write_utf32 >test.utf32.raw &&
 	printf "\377\376"                         >test.utf16lebom.raw &&
 	printf "$text" | iconv -f UTF-8 -t UTF-32LE >>test.utf16lebom.raw &&
 
@@ -223,7 +242,7 @@ test_expect_success ICONV_SHIFT_JIS 'check roundtrip encoding' '
 
 	text="hallo there!\nroundtrip test here!" &&
 	printf "$text" | iconv -f UTF-8 -t SHIFT-JIS >roundtrip.shift &&
-	printf "$text" | iconv -f UTF-8 -t UTF-16 >roundtrip.utf16 &&
+	printf "$text" | write_utf16 >roundtrip.utf16 &&
 	echo "*.shift text working-tree-encoding=SHIFT-JIS" >>.gitattributes &&
 
 	# SHIFT-JIS encoded files are round-trip checked by default...
diff --git a/utf8.c b/utf8.c
index 83824dc2f4..133199de0e 100644
--- a/utf8.c
+++ b/utf8.c
@@ -568,6 +568,16 @@ char *reencode_string_len(const char *in, size_t insz,
 		bom_str = utf16_be_bom;
 		bom_len = sizeof(utf16_be_bom);
 		out_encoding = "UTF-16BE";
+#ifdef ICONV_NEEDS_BOM
+	} else if (same_utf_encoding("UTF-16", out_encoding)) {
+		bom_str = utf16_be_bom;
+		bom_len = sizeof(utf16_be_bom);
+		out_encoding = "UTF-16BE";
+	} else if (same_utf_encoding("UTF-32", out_encoding)) {
+		bom_str = utf32_be_bom;
+		bom_len = sizeof(utf32_be_bom);
+		out_encoding = "UTF-32BE";
+#endif
 	}
 
 	conv = iconv_open(out_encoding, in_encoding);
