Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE972C43467
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 997E2206B6
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pb8aIcgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgGMCuT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:50:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40762 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728492AbgGMCtm (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:49:42 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CAEB060A74;
        Mon, 13 Jul 2020 02:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608579;
        bh=TSK3EyFb9gLxAncM/y0Qf09Vg6wOjl7Fp2RPB1WOXy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=pb8aIcgZLlWyV/r50l6IJIPbhMLRNyaDyLX6mecCuNXEgkCVdU/XTUdZHPlC/lryr
         vLePxPUuW4OxPk5YkgU5ODa7FlnBgfy87KmS5bWMsNVT2sgQq5jMNwbwKIfrBE0kiK
         QcxDPBC19Yb5K4852FVFk8isoErIG4AgAIq/Fsyd3v14NrRJhNT4m/OKaMC9wR0mjG
         ey0q28VnWT85/GIj+xMDHj5tMQMBUMTEK1uyJnhw+NEb7PXymtEPicp2u90TEjgdvT
         dmLhAXEsP+KwXalVXPm3+F1VsJnauN59J79v6LnWFPsS3319CB9QnsHrEM0UwN9U3C
         MLdltY8cIs5TitUToaOO5HiS1RHaHKwGRLm2ayfx99h6Zl4p8Y2TUHiWeL5SlQCpTa
         k50vLsMJgr+fjAGRD6oqdLQpw2VcJA5DMo6vkfjCOkzfwveNJXoflglCXFRdbv1ofl
         YeikfmnHSbuHvVkG+ZItKZNRtsDEDQj+rpV5fYcErWP5kj/I7LB
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 32/39] setup: add support for reading extensions.objectformat
Date:   Mon, 13 Jul 2020 02:49:02 +0000
Message-Id: <20200713024909.3714837-33-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
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

Ensure that we don't use the value of the extension if the repository
format version is 0.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 setup.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index dbac2eabe8..4dbfe34c03 100644
--- a/setup.c
+++ b/setup.c
@@ -471,7 +471,16 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
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
 
@@ -515,6 +524,7 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 		repository_format_precious_objects = 0;
 		set_repository_format_partial_clone(NULL);
 		repository_format_worktree_config = 0;
+		candidate->hash_algo = GIT_HASH_SHA1;
 	}
 	string_list_clear(&candidate->unknown_extensions, 0);
 
