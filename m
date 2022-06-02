Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C4EC43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 11:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbiFBLn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 07:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiFBLn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 07:43:56 -0400
Received: from box.jasonyundt.email (box.jasonyundt.email [206.189.182.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AD51207CE
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 04:43:55 -0700 (PDT)
Received: from authenticated-user (box.jasonyundt.email [206.189.182.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.jasonyundt.email (Postfix) with ESMTPSA id AB32D7E67E;
        Thu,  2 Jun 2022 07:43:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jasonyundt.email;
        s=mail; t=1654170232;
        bh=cbtWKOssdfIScTdSmgdxAxnqGTqwYh6NdmKu70Ku9yI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rn3O1mhBQThxpoSjX0BW3y6xOwXlh9eZ+ek5sqvbSJSo0FV8htdiq3MqDRJEdk6/R
         C6AXLzdWeRuHYO9V1YMyIgJoAFqm7DKD/lVkQ4IAl73m3nnYueaDC/aTdqpwZAbHKH
         fZ6Ah28VOsJjCMXdoWACqFJZKlYyf0gbImiAytAd0kpH8LQHGs7RQQXYU78kQOy93a
         a/lebi7DgByadD/k8hiMVwIZ22mRlDKpdFUhZ6MM2POJP1OMGVY1gMcItPtGbyljrx
         9u87ApLEMi53y42jxuWdWeth8rBqObPNHf1tVityv4oa1m2XjvvrT6vp4EEO6whLg3
         tGK9q79bitGhg==
From:   Jason Yundt <jason@jasonyundt.email>
To:     git@vger.kernel.org
Cc:     Jason Yundt <jason@jasonyundt.email>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] gitweb: switch to an XHTML5 DOCTYPE
Date:   Thu,  2 Jun 2022 07:43:05 -0400
Message-Id: <20220602114305.5915-1-jason@jasonyundt.email>
In-Reply-To: <20220601012647.1439480-1-jason@jasonyundt.email>
References: <20220601012647.1439480-1-jason@jasonyundt.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to the HTML Standard FAQ:

	“What is the DOCTYPE for modern HTML documents?

	In text/html documents:

		<!DOCTYPE html>

	In documents delivered with an XML media type: no DOCTYPE is required
	and its use is generally unnecessary. However, you may use one if you
	want (see the following question). Note that the above is well-formed
	XML.”

	Source: [1]

Gitweb uses an XHTML 1.0 DOCTYPE:

	<!DOCTYPE html PUBLIC
	"-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

While that DOCTYPE is still valid [2], it has several disadvantages:

1. It’s misleading. If an XML parser uses the DTD at the given link,
   then the entities &nbsp; and &sdot; won’t get declared. Instead, the
   parser has to use a DTD from the HTML Standard that has nothing to do
   with XHTML 1.0 [2].
2. It’s obsolete. XHTML 1.0 was last revised in 2002 and was superseded in
   2018 [3].
3. It’s unreliable. Gitweb uses &nbsp; and &sdot; but lets an external file
   define them. “[…U]using entity references for characters in XML documents
   is unsafe if they are defined in an external file (except for &lt;, &gt;,
   &amp;, &quot;, and &apos;).” [4]

[1]: <https://github.com/whatwg/html/blob/main/FAQ.md#what-is-the-doctype-for-modern-html-documents>
[2]: <https://html.spec.whatwg.org/multipage/xhtml.html#parsing-xhtml-documents>
[3]: <https://www.w3.org/TR/xhtml1/#xhtml>
[4]: <https://html.spec.whatwg.org/multipage/xhtml.html#writing-xhtml-documents>

Signed-off-by: Jason Yundt <jason@jasonyundt.email>
---
Compared to the first version of this patch, this version:
1. makes it clear that XML parsers may used the linked DTD like brian
   mentioned.
2. mentions HTML5 like Bagas suggested.

 gitweb/gitweb.perl                        |  5 ++++-
 t/t9502-gitweb-standalone-parse-output.sh | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 606b50104c..1835487ab2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4219,7 +4219,10 @@ sub git_header_html {
 	my $mod_perl_version = $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
 	print <<EOF;
 <?xml version="1.0" encoding="utf-8"?>
-<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
+<!DOCTYPE html [
+	<!ENTITY nbsp "&#xA0;">
+	<!ENTITY sdot "&#x22C5;">
+]>
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
 <!-- git web interface version $version, (C) 2005-2006, Kay Sievers <kay.sievers\@vrfy.org>, Christian Gierke -->
 <!-- git core binaries version $git_version -->
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index 8cb582f0e6..81d5625557 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -220,4 +220,18 @@ test_expect_success 'no http-equiv="content-type" in XHTML' '
 	no_http_equiv_content_type "p=.git;a=tree"
 '
 
+proper_doctype() {
+	gitweb_run "$@" &&
+	grep -F "<!DOCTYPE html [" gitweb.body &&
+	grep "<!ENTITY nbsp" gitweb.body &&
+	grep "<!ENTITY sdot" gitweb.body
+}
+
+test_expect_success 'Proper DOCTYPE with entity declarations' '
+	proper_doctype &&
+	proper_doctype "p=.git" &&
+	proper_doctype "p=.git;a=log" &&
+	proper_doctype "p=.git;a=tree"
+'
+
 test_done
-- 
2.36.1

