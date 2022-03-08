Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EF4C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 15:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348059AbiCHP7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 10:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348901AbiCHP6t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 10:58:49 -0500
Received: from box.jasonyundt.email (box.jasonyundt.email [206.189.182.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D06BC81
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 07:57:51 -0800 (PST)
Received: from authenticated-user (box.jasonyundt.email [206.189.182.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.jasonyundt.email (Postfix) with ESMTPSA id 764CA7E750;
        Tue,  8 Mar 2022 10:57:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jasonyundt.email;
        s=mail; t=1646755040;
        bh=FuOnXb8KScr1/NHpF2ybAY9UsDefTEcbtqLu1BTn41w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJ/FG7kfDNWTUZC4BAAEkrUCNDh9+kWGjWrfRoyYYIQPOfi669XhPTgU46LaADzp7
         RPSoGzrslGf9OQcVVoQl31i5aEBukhzNMsE73t475usMrcms3jIaCq9BzfvSEgEMht
         wZ/J2vxjEiQCA/N9B6plx0mnyrvRvXeX9mVpIUeRMpIuqvVuTvSiit0BPTWdjlmXzJ
         uRIArT142jiDt3qG/9tpiX54Fu4Vw3V0t6yE3mdyvZmvjglmOUWz3HEcgADKUVKgap
         Bsg0Dw5eyGqWo0lr/XVGMOWhCpqc+9k1hwg6hIESWGvYnYYJ8VcKkidpM8t4cKDNMH
         FW3GoA6GpZrcA==
From:   Jason Yundt <jason@jasonyundt.email>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jason Yundt <jason@jasonyundt.email>
Subject: [PATCH v3 2/2] gitweb: remove invalid http-equiv="content-type"
Date:   Tue,  8 Mar 2022 10:56:12 -0500
Message-Id: <20220308155612.105957-3-jason@jasonyundt.email>
In-Reply-To: <20220308155612.105957-1-jason@jasonyundt.email>
References: <20220308010711.61817-1-jason@jasonyundt.email>
 <20220308155612.105957-1-jason@jasonyundt.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this change, gitweb would generate pages which included:

	<meta http-equiv="content-type" content="application/xhtml+xml; charset=utf-8"/>

When a meta's http-equiv equals "content-type", the http-equiv is said
to be in the "Encoding declaration state". According to the HTML
Standard,

	The Encoding declaration state may be used in HTML documents,
	but elements with an http-equiv attribute in that state must not
	be used in XML documents.

	Source: <https://html.spec.whatwg.org/multipage/semantics.html#attr-meta-http-equiv-content-type>

This change removes that meta element since gitweb always generates XML
documents.

Signed-off-by: Jason Yundt <jason@jasonyundt.email>
---
 gitweb/gitweb.perl                        |  4 +---
 t/t9502-gitweb-standalone-parse-output.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fbd1c20a23..606b50104c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4213,8 +4213,7 @@ sub git_header_html {
 	my %opts = @_;
 
 	my $title = get_page_title();
-	my $content_type = get_content_type_html();
-	print $cgi->header(-type=>$content_type, -charset => 'utf-8',
+	print $cgi->header(-type=>get_content_type_html(), -charset => 'utf-8',
 	                   -status=> $status, -expires => $expires)
 		unless ($opts{'-no_http_header'});
 	my $mod_perl_version = $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
@@ -4225,7 +4224,6 @@ sub git_header_html {
 <!-- git web interface version $version, (C) 2005-2006, Kay Sievers <kay.sievers\@vrfy.org>, Christian Gierke -->
 <!-- git core binaries version $git_version -->
 <head>
-<meta http-equiv="content-type" content="$content_type; charset=utf-8"/>
 <meta name="generator" content="gitweb/$version git/$git_version$mod_perl_version"/>
 <meta name="robots" content="index, nofollow"/>
 <title>$title</title>
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index e7363511dd..8cb582f0e6 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -207,4 +207,17 @@ test_expect_success 'xss checks' '
 	xss "" "$TAG+"
 '
 
+no_http_equiv_content_type() {
+	gitweb_run "$@" &&
+	! grep -E "http-equiv=['\"]?content-type" gitweb.body
+}
+
+# See: <https://html.spec.whatwg.org/dev/semantics.html#attr-meta-http-equiv-content-type>
+test_expect_success 'no http-equiv="content-type" in XHTML' '
+	no_http_equiv_content_type &&
+	no_http_equiv_content_type "p=.git" &&
+	no_http_equiv_content_type "p=.git;a=log" &&
+	no_http_equiv_content_type "p=.git;a=tree"
+'
+
 test_done
-- 
2.35.1

