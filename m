Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F220BC433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9B920663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="el0m2iP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgGJCtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:49:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40418 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727083AbgGJCso (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 13A0060A6D;
        Fri, 10 Jul 2020 02:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349317;
        bh=TSK3EyFb9gLxAncM/y0Qf09Vg6wOjl7Fp2RPB1WOXy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=el0m2iP5sM6fGs67GsPIOG4gQYyDLjGlczjpny2olo8lZFIGB1AdXC7QqwmmpsiEr
         k0/iKJ797GFjIol85dIKDNFPpJ9vB96yxmccbjlsZyedIgEf2iAmSXbl9VHu+U7THx
         vCXCKryv+PUdNJnKs6zVDR30X3U0AZSjdLbRVsCwR5pErrGm+nNvao/GglTFflQmmA
         4Xa6lUvCm8CwR776AtbSCIOMFdcOoxwJDHX+FYBycmjRvugX8ULI0sKaD4wpN8ZxfZ
         Kk4XXgY91XB90pGQSeYJZDcA4fPLQDRnKmI2W48xDXSDtgYWJ/60L1tFzsc2lrERyb
         2S4rbPxjf8iyhd6qteOisW0lAgP/caIlNK70+sea803l5WVm+2KhyFUiuRgNj46bgf
         ahdskAWA3yDXgm9pDM2Q9F5gsCS+nmw6R4rhraIIZUB4RisPaxSoemreUHELvGrmRC
         5c1LC05PDLgjSOhbMCEZr3ufpbucOwTO+SUv2O6qFLkstKJXs8W
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 31/38] setup: add support for reading extensions.objectformat
Date:   Fri, 10 Jul 2020 02:47:21 +0000
Message-Id: <20200710024728.3100527-32-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
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
 
