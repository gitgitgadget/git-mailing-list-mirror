Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35854C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 01:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbiCHBJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 20:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344243AbiCHBJT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 20:09:19 -0500
Received: from box.jasonyundt.email (box.jasonyundt.email [206.189.182.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F353CFE7
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 17:08:23 -0800 (PST)
Received: from authenticated-user (box.jasonyundt.email [206.189.182.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.jasonyundt.email (Postfix) with ESMTPSA id 788FC8129A;
        Mon,  7 Mar 2022 20:08:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jasonyundt.email;
        s=mail; t=1646701702;
        bh=l+y3PSPwjUzsA1ymF+45+Nf4kH9hP7iTX5N+LclbHCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gUS/gM/MSawrAnDmpVZRg2ZLFzVuLVku80XDI62bMDdSXz+lV5tGY664tvFf1vUSi
         UGOZ3kx2iUy8nCgVjiPrExlvAy+yjiDVZTQ//QaDc1NDXGsQbmCjMufWn0xqFDM2/K
         EgFwBN9YX1AfDIIE9d7QglCjjulWdRVMiPZUieQoVnBWgyAVXdKlmSgZfmVfcbOsae
         L77tw5jzIIl34L2OYOWBu4YMsuCcmku1Fku/9ukqGmzu3igK/8f8qEGo2M3Aqt7WwU
         PLkync9H0BqGRuEx+FVXIryaSGQLqyu9ISNVcdr7QXRenYMUlZ4PKEHNF4lL5NqARB
         eaQOAl+MuovXw==
From:   Jason Yundt <jason@jasonyundt.email>
To:     git@vger.kernel.org
Cc:     Jason Yundt <jason@jasonyundt.email>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] gitweb: remove invalid http-equiv="content-type"
Date:   Mon,  7 Mar 2022 20:07:11 -0500
Message-Id: <20220308010711.61817-3-jason@jasonyundt.email>
In-Reply-To: <20220307033723.175553-1-jason@jasonyundt.email>
References: <20220307033723.175553-1-jason@jasonyundt.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this change, gitweb would generate pages which included:

	<meta http-equiv="content-type" content="application/xhtml+xml; charset=utf-8"/>

A meta element with http-equiv="content-type" is said to be in the
"Encoding declaration state". According to the HTML Standard,

	The Encoding declaration state may be used in HTML documents,
	but elements with an http-equiv attribute in that state must not
	be used in XML documents.

	Source: <https://html.spec.whatwg.org/multipage/semantics.html#attr-meta-http-equiv-content-type>

Gitweb always generates XML documents, so its use of
http-equiv="content-type" was invalid. This change replaces that tag
with

	<meta charset="utf-8"/>

which is equivalent [1] and allowed in XML documents [2].

[1]: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/meta#attr-http-equiv>
[2]: <https://html.spec.whatwg.org/multipage/semantics.html#attr-meta-charset>

Signed-off-by: Jason Yundt <jason@jasonyundt.email>
---
 gitweb/gitweb.perl                        |  2 +-
 t/t9502-gitweb-standalone-parse-output.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fbd1c20a23..59457c1004 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4225,7 +4225,7 @@ sub git_header_html {
 <!-- git web interface version $version, (C) 2005-2006, Kay Sievers <kay.sievers\@vrfy.org>, Christian Gierke -->
 <!-- git core binaries version $git_version -->
 <head>
-<meta http-equiv="content-type" content="$content_type; charset=utf-8"/>
+<meta charset="utf-8"/>
 <meta name="generator" content="gitweb/$version git/$git_version$mod_perl_version"/>
 <meta name="robots" content="index, nofollow"/>
 <title>$title</title>
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index e7363511dd..0b06e2d6b0 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -207,4 +207,20 @@ test_expect_success 'xss checks' '
 	xss "" "$TAG+"
 '
 
+check_encoding_meta_element() {
+	gitweb_run "$@" &&
+	! grep -E "http-equiv=['\"]?content-type" gitweb.body &&
+	grep -F '<meta charset="utf-8"/>' gitweb.body
+}
+
+# One of those can be used in XHTML, the other one can't. See:
+# <https://html.spec.whatwg.org/dev/semantics.html#attr-meta-charset>
+# <https://html.spec.whatwg.org/dev/semantics.html#attr-meta-http-equiv-content-type>
+test_expect_success 'no http-equiv="content-type", yes charset="utf-8"' '
+	check_encoding_meta_element &&
+	check_encoding_meta_element "p=.git" &&
+	check_encoding_meta_element "p=.git;a=log" &&
+	check_encoding_meta_element "p=.git;a=tree"
+'
+
 test_done
-- 
2.35.1

