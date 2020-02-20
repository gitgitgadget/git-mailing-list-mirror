Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529A0C761A1
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 02:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A39A24656
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 02:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="1hQzxZnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgBTCYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:24:39 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36874 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727370AbgBTCYi (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Feb 2020 21:24:38 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5E748609D3;
        Thu, 20 Feb 2020 02:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582165477;
        bh=cyN8Yrdhl1vk3x6bkWZcXAjr2EMB4rP/WfmINvg/Dbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=1hQzxZntai33pMZQQl6zs1gve3lO+jpiecOuxdlVDyLO1dWnhv6OHU3UWBamABYj7
         lPIUZgJG7Fv6tEN5+y5VbekAHkLeD9spmHm5lrR68M0/cZNRklVktaFdxKLg+kS0wy
         TT1szCJktVnvIoOIYvGzHwjAsq5jd8k2T/xZ7BH+U8z5+krrJEkLKsWjTvFM4PVDxo
         puhIdK5rKBeAjxQFYvv3Ovr0528yZ92+Sxo9YC+v8PxGVR95Zt0J3TDdw5135Kh4Cl
         NhMoIrMykJPKXvVtGWZxfCY+Dv7Rh/XasmbvE7UQ2Ew7owlkh6p+/6oztiWZ5ExsbT
         fhtltpqdKmqwaGOunDccVFa3EysNdZJYYTrfZt5i3YZjDMErxSx7wSgLrta7E+61Be
         CGFvqvi75VxyehEdZescz5QmTikYBGkcK9TGwXuvTG6vPYxMDm5MrjU4B2WCyS0hQB
         gv0/Hh5w4MfMtbIarlj7Y/AVRlwJbhv2JKOf2KdBsq6euLu2l0t
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 4/5] credential: use the last matching username in the config
Date:   Thu, 20 Feb 2020 02:24:12 +0000
Message-Id: <20200220022413.258026-5-sandals@crustytoothpaste.net>
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

Everywhere else in the codebase, we use the rule that the last matching
configuration option is the one that takes effect.  This is helpful
because it allows more specific configuration settings (e.g., per-repo
configuration) to override less specific settings (e.g., per-user
configuration).

However, in the credential code, we didn't honor this setting, and
instead picked the first setting we had, and stuck with it.  This was
likely to ensure we picked the value from the URL, which we want to
honor over the configuration.

It's possible to do both, though, so let's check if the value is the one
we've gotten over our protocol connection, which if present will have
come from the URL, and keep it if so.  Otherwise, let's overwrite the
value with the latest version we've got from the configuration, so we
keep the last configuration value.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 credential.c           | 9 ++++++++-
 credential.h           | 3 ++-
 t/t0300-credentials.sh | 2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/credential.c b/credential.c
index 62be651b03..5701e32792 100644
--- a/credential.c
+++ b/credential.c
@@ -71,8 +71,10 @@ static int credential_config_callback(const char *var, const char *value,
 		else
 			string_list_clear(&c->helpers, 0);
 	} else if (!strcmp(key, "username")) {
-		if (!c->username)
+		if (!c->username_from_proto) {
+			free(c->username);
 			c->username = xstrdup(value);
+		}
 	}
 	else if (!strcmp(key, "usehttppath"))
 		c->use_http_path = git_config_bool(var, value);
@@ -163,6 +165,7 @@ int credential_read(struct credential *c, FILE *fp)
 		if (!strcmp(key, "username")) {
 			free(c->username);
 			c->username = xstrdup(value);
+			c->username_from_proto = 1;
 		} else if (!strcmp(key, "password")) {
 			free(c->password);
 			c->password = xstrdup(value);
@@ -349,10 +352,14 @@ void credential_from_url(struct credential *c, const char *url)
 	else if (!colon || at <= colon) {
 		/* Case (2) */
 		c->username = url_decode_mem(cp, at - cp);
+		if (c->username && *c->username)
+			c->username_from_proto = 1;
 		host = at + 1;
 	} else {
 		/* Case (3) */
 		c->username = url_decode_mem(cp, colon - cp);
+		if (c->username && *c->username)
+			c->username_from_proto = 1;
 		c->password = url_decode_mem(colon + 1, at - (colon + 1));
 		host = at + 1;
 	}
diff --git a/credential.h b/credential.h
index a5a3ee9bb8..fec7815dd0 100644
--- a/credential.h
+++ b/credential.h
@@ -118,7 +118,8 @@ struct credential {
 	unsigned approved:1,
 		 configured:1,
 		 quit:1,
-		 use_http_path:1;
+		 use_http_path:1,
+		 username_from_proto:1;
 
 	char *username;
 	char *password;
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 4593a0cd3d..8f87599056 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -344,7 +344,7 @@ test_expect_success 'honors username from URL over helper (components)' '
 	EOF
 '
 
-test_expect_failure 'last matching username wins' '
+test_expect_success 'last matching username wins' '
 	test_config credential.https://example.com/path.git.username bob &&
 	test_config credential.https://example.com.username alice &&
 	test_config credential.https://example.com.helper "verbatim \"\" bar" &&
