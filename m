Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE416C433FC
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD822080D
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="BnaJH4J+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387625AbgGWBKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40498 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387608AbgGWBKE (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:10:04 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9660461011
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466603;
        bh=HkneMgZLTAdXgA8gNNuOhVNAwlHJ7abUKjddmrETEQ0=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=BnaJH4J+jgSqbLzzqgec/glBn3RDe8Vt66TScSUEE8qRlBdAsOLYo+wymvGPNu1j9
         eZMUe0dTUVfL7/C8YIK2ByQsajqydOqujDzTidnWUsVEJSBq+2Xv1M0u0z4yFGX3Qs
         bAwathrwtHKEVee9PILfVPquJTk2O8YlzXxPpyGLKWHnc+CS6leciFeWCBAlpulLz4
         3vjwuIU0FT8I0Uw5BW1PHTXtExVWArorY7g14FP+fuoJ/SBrqmQb/0fiyFATXy+um4
         6Od5wmn2NygBWcJVs/Yg+abgWY0NNJVfBkNpOI4W+OhHGk5yvtwMNFBE1DzZGGSP2f
         hwQhend5GKphlL2/Dv92thyX7yXpMQdm7rDrQXZ3Oy8h6x5BIFE7e4IOg3fYhb71/l
         PRShabGt6mdgZCajCdNr46GOiX+w/EcWtQEsulJM4to/6wf/dbPuc4/eM0MSsab5Ux
         mGrMolPRvhx0rmZqWSjOOiezap7LxqpWqBCPho1jrpNtehSA0fd
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 32/39] setup: add support for reading extensions.objectformat
Date:   Thu, 23 Jul 2020 01:09:36 +0000
Message-Id: <20200723010943.2329634-33-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
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
 
