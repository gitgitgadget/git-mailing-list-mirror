Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13D4C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FAA6207F5
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Gnw8B5iX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgG2XPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:15:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41130 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727072AbgG2XPE (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:15:04 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2A25A60CF7;
        Wed, 29 Jul 2020 23:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064500;
        bh=HkneMgZLTAdXgA8gNNuOhVNAwlHJ7abUKjddmrETEQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Gnw8B5iXiNXCw7t8Ks3Yo6XeQmEWDfekLzsDwbkIUIDTWlAZWYaTLKNWTVL+REQ+4
         J28cab+ea/NPz0pZRfLOs88MNW9y60xoEag7WecBs+SmamPnavDSSEYwKl4H8YUKHe
         7diE1Q2Jpnz1VjdXKBoV9FJq7YGwHf6aYRw0XAJiWcDOienn6zX8hV9i3rsE1FMXXV
         V3cTjYf9oXfcpVZk7ave93HrXzCAWkmmM2vEZO1hTUiUrfdFavysdFQXXBawIY0WXV
         mxVOFGiOkhX8ZRJcCs1eV9n7oul57SBGIJJ3UlSrKrW37BI0oIGbuYgkx27ZDnPScc
         VyzBIWJsb5Ojqkwe2roJ/oNV4ZF5p0vJ7h59oZasvC/f9goUIspdNaiw9VHflVV5BI
         Muo2wk6QHlMNTnK71XaYBCT3aqDbutdjpxkHMRDKOQnsG9uaNXXQUwtwNWd2oRjkJP
         /tbP8Pv3ObdZH8m31KPjSJsBPvCM4ZkpWcBDbHiTFTl74pBKO6M
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 32/39] setup: add support for reading extensions.objectformat
Date:   Wed, 29 Jul 2020 23:14:21 +0000
Message-Id: <20200729231428.3658647-33-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200729231428.3658647-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The transition plan specifies extensions.objectFormat as the indication
that we're using a given hash in a certain repo.  Read this as one of
the extensions we support.  If the user has specified an invalid value,
fail.

Ensure that we reject the extension if the repository format version is
0.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 setup.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 3a81307602..94e68bb4f4 100644
--- a/setup.c
+++ b/setup.c
@@ -470,7 +470,16 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			data->partial_clone = xstrdup(value);
 		} else if (!strcmp(ext, "worktreeconfig"))
 			data->worktree_config = git_config_bool(var, value);
-		else
+		else if (!strcmp(ext, "objectformat")) {
+			int format;
+
+			if (!value)
+				return config_error_nonbool(var);
+			format = hash_algo_by_name(value);
+			if (format == GIT_HASH_UNKNOWN)
+				return error("invalid value for 'extensions.objectformat'");
+			data->hash_algo = format;
+		} else
 			string_list_append(&data->unknown_extensions, ext);
 	}
 
@@ -613,6 +622,11 @@ int verify_repository_format(const struct repository_format *format,
 		return -1;
 	}
 
+	if (format->version <= 0 && format->hash_algo != GIT_HASH_SHA1) {
+		strbuf_addstr(err, _("extensions.objectFormat is not valid in repo v0"));
+		return -1;
+	}
+
 	return 0;
 }
 
