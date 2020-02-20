Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTTP_EXCESSIVE_ESCAPES,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC80C11D42
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 02:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D9824670
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 02:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZWSHy/Ha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgBTCYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:24:39 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36870 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727476AbgBTCYi (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Feb 2020 21:24:38 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EA4BF609CF;
        Thu, 20 Feb 2020 02:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582165477;
        bh=Zbi7iUCs9WhQX0Liy/cCTUqWMrsXcVXnsNcCJQuTdeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ZWSHy/HaiMErvAodZAU4rL2fr+YjoNrIfSWupSwaV3FDBQNZGSA9eSed7yl7S+0Gm
         aAg80zHXxOK0ftPUTd9fNCPsCYUFm5XV8FZrAo11EcTTxGeH6/K83/2vhqyifBGohy
         r1seke7ZsXRrNLUH/15w1g6QUwItFDDsb1X4jfWzbWlfEKViW0UE6S2Sl0n2fDrtrv
         x6ig6XQGSPp0kEDlaNcGxuMYK52MTzElXgq6wptojEelm8ull6qjsR+3cSpFk9wRkl
         FzN/hQR0G3Zqn2TMss5OND0M4JEB0zvi7xzuJj0M4f37W3aeWurq5x8tuiDhYXhYjN
         k3hPy3TYQjQgbhEG2pX1LgPkdjDXAOciVui9HFICI6l209lRDRDJIS3suxnW0gMbtF
         f/42dU+UiolRDjjA3m+hZXOhLd2TlWNW3ZFO/Xa8p5ekgQwwut05rcCHgtDeJWhYHJ
         fc18TfT8BCCYwS4dtXThw6/nlEcLdkj7rbQapgqpiHMaATwckxN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 3/5] t0300: add tests for some additional cases
Date:   Thu, 20 Feb 2020 02:24:11 +0000
Message-Id: <20200220022413.258026-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200220022413.258026-1-sandals@crustytoothpaste.net>
References: <20200220022413.258026-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: brian m. carlson <bk2204@github.com>

There are some tricky cases in our credential helpers that we don't have
test cases for.  To help prevent regressions, let's add some for these
cases:

* If there are multiple configured credential helpers, one without a
  path and one with a path, we want to invoke both of them.
* If there are percent-encoded values in the URL, we handle them
  properly.
* And finally, if there is a username in the remote URL, we want to
  honor that over what the configuration tells us.

Finally, there's an additional case that we'd like to test for as well,
but that currently fails.  In all other situations in our configuration,
we pick the last configuration setting that's provided.  However, we
fail to do that for credential.username, where we pick the first setting
instead.  Let's add a failing test that we have the consistent behavior
here, since that's the documented, expected behavior.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 t/t0300-credentials.sh | 108 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 82eaaea0f4..4593a0cd3d 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -240,6 +240,57 @@ test_expect_success 'do not match configured credential' '
 	EOF
 '
 
+test_expect_success 'match multiple configured helpers' '
+	test_config credential.helper "verbatim \"\" \"\"" &&
+	test_config credential.https://example.com.helper "$HELPER" &&
+	check fill <<-\EOF
+	protocol=https
+	host=example.com
+	path=repo.git
+	--
+	protocol=https
+	host=example.com
+	username=foo
+	password=bar
+	--
+	verbatim: get
+	verbatim: protocol=https
+	verbatim: host=example.com
+	EOF
+'
+
+test_expect_success 'match multiple configured helpers with URLs' '
+	test_config credential.https://example.com/repo.git.helper "verbatim \"\" \"\"" &&
+	test_config credential.https://example.com.helper "$HELPER" &&
+	check fill <<-\EOF
+	protocol=https
+	host=example.com
+	path=repo.git
+	--
+	protocol=https
+	host=example.com
+	username=foo
+	password=bar
+	--
+	verbatim: get
+	verbatim: protocol=https
+	verbatim: host=example.com
+	EOF
+'
+
+test_expect_success 'match percent-encoded values' '
+	test_config credential.https://example.com/%2566.git.helper "$HELPER" &&
+	check fill <<-\EOF
+	url=https://example.com/%2566.git
+	--
+	protocol=https
+	host=example.com
+	username=foo
+	password=bar
+	--
+	EOF
+'
+
 test_expect_success 'pull username from config' '
 	test_config credential.https://example.com.username foo &&
 	check fill <<-\EOF
@@ -255,6 +306,63 @@ test_expect_success 'pull username from config' '
 	EOF
 '
 
+test_expect_success 'honors username from URL over helper (URL)' '
+	test_config credential.https://example.com.username bob &&
+	test_config credential.https://example.com.helper "verbatim \"\" bar" &&
+	check fill <<-\EOF
+	url=https://alice@example.com
+	--
+	protocol=https
+	host=example.com
+	username=alice
+	password=bar
+	--
+	verbatim: get
+	verbatim: protocol=https
+	verbatim: host=example.com
+	verbatim: username=alice
+	EOF
+'
+
+test_expect_success 'honors username from URL over helper (components)' '
+	test_config credential.https://example.com.username bob &&
+	test_config credential.https://example.com.helper "verbatim \"\" bar" &&
+	check fill <<-\EOF
+	protocol=https
+	host=example.com
+	username=alice
+	--
+	protocol=https
+	host=example.com
+	username=alice
+	password=bar
+	--
+	verbatim: get
+	verbatim: protocol=https
+	verbatim: host=example.com
+	verbatim: username=alice
+	EOF
+'
+
+test_expect_failure 'last matching username wins' '
+	test_config credential.https://example.com/path.git.username bob &&
+	test_config credential.https://example.com.username alice &&
+	test_config credential.https://example.com.helper "verbatim \"\" bar" &&
+	check fill <<-\EOF
+	url=https://example.com/path.git
+	--
+	protocol=https
+	host=example.com
+	username=alice
+	password=bar
+	--
+	verbatim: get
+	verbatim: protocol=https
+	verbatim: host=example.com
+	verbatim: username=alice
+	EOF
+'
+
 test_expect_success 'http paths can be part of context' '
 	check fill "verbatim foo bar" <<-\EOF &&
 	protocol=https
