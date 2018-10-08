Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6461F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 21:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeJIFLK (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:11:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49354 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726607AbeJIFLK (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 01:11:10 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7A54260789;
        Mon,  8 Oct 2018 21:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539035837;
        bh=afA0DkEh9YgMBNUvx6855l6VhkWaEq+tcfJfnRC08EI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=tk9g/wk1IaG1WJaTusPDaahNkfw/oPcDyQ2J52waHMTUZ1CI6VY9nHMWEh53j5O06
         1zkr8kzficpzSxyZ+qSadCdQZT4nyI8JToWAFt3yD9tAevCy6+I+IvAav+MvhO4k1Y
         4zPLbGZpEqkEetdD+GL7AAs+6RmIg4r9jifgAJgAOv8z2kAEAS+eChXaN+jPPIFdQm
         vE2fintGMnsN51vhSHoZlnklRKJiENQxrn3JbRk9tN86YduBj52xS8hfj27WTtKVVD
         I6tlh+aJkFX19q5T5lBlY8Rv9jBcw5SvkAUisCfzvlGncP7tcWFcOe03J4BHwjPLvK
         LSWg+5xrYmUi+HqpLYtxYGBV05JdyN/27+Sf0LFGywWTmwkIa39dEs2Tic4p7C3KlQ
         a+ajwXk60DR5fP5iDxw4yBOCzEGzeP/elhCstaIyG7+5wJ2zvcG235lb+BI/Ngs4r+
         Nm8DiAwnfWGnx/rUsJ5+v+D3GSIrDaOBjo7DjrV3MXvujY48EeI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/14] apply: replace hard-coded constants
Date:   Mon,  8 Oct 2018 21:56:58 +0000
Message-Id: <20181008215701.779099-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c
In-Reply-To: <20181008215701.779099-1-sandals@crustytoothpaste.net>
References: <20181008215701.779099-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace several 40-based constants with references to GIT_MAX_HEXSZ or
the_hash_algo, as appropriate.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 apply.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/apply.c b/apply.c
index e485fbc6bc..792ecea36a 100644
--- a/apply.c
+++ b/apply.c
@@ -223,8 +223,8 @@ struct patch {
 	struct fragment *fragments;
 	char *result;
 	size_t resultsize;
-	char old_sha1_prefix[41];
-	char new_sha1_prefix[41];
+	char old_sha1_prefix[GIT_MAX_HEXSZ + 1];
+	char new_sha1_prefix[GIT_MAX_HEXSZ + 1];
 	struct patch *next;
 
 	/* three-way fallback result */
@@ -1093,9 +1093,10 @@ static int gitdiff_index(struct apply_state *state,
 	 */
 	const char *ptr, *eol;
 	int len;
+	const unsigned hexsz = the_hash_algo->hexsz;
 
 	ptr = strchr(line, '.');
-	if (!ptr || ptr[1] != '.' || 40 < ptr - line)
+	if (!ptr || ptr[1] != '.' || hexsz < ptr - line)
 		return 0;
 	len = ptr - line;
 	memcpy(patch->old_sha1_prefix, line, len);
@@ -1109,7 +1110,7 @@ static int gitdiff_index(struct apply_state *state,
 		ptr = eol;
 	len = ptr - line;
 
-	if (40 < len)
+	if (hexsz < len)
 		return 0;
 	memcpy(patch->new_sha1_prefix, line, len);
 	patch->new_sha1_prefix[len] = 0;
@@ -3142,13 +3143,14 @@ static int apply_binary(struct apply_state *state,
 {
 	const char *name = patch->old_name ? patch->old_name : patch->new_name;
 	struct object_id oid;
+	const unsigned hexsz = the_hash_algo->hexsz;
 
 	/*
 	 * For safety, we require patch index line to contain
-	 * full 40-byte textual SHA1 for old and new, at least for now.
+	 * full hex textual object ID for old and new, at least for now.
 	 */
-	if (strlen(patch->old_sha1_prefix) != 40 ||
-	    strlen(patch->new_sha1_prefix) != 40 ||
+	if (strlen(patch->old_sha1_prefix) != hexsz ||
+	    strlen(patch->new_sha1_prefix) != hexsz ||
 	    get_oid_hex(patch->old_sha1_prefix, &oid) ||
 	    get_oid_hex(patch->new_sha1_prefix, &oid))
 		return error(_("cannot apply binary patch to '%s' "
@@ -4055,7 +4057,7 @@ static int preimage_oid_in_gitlink_patch(struct patch *p, struct object_id *oid)
 	    starts_with(++preimage, heading) &&
 	    /* does it record full SHA-1? */
 	    !get_oid_hex(preimage + sizeof(heading) - 1, oid) &&
-	    preimage[sizeof(heading) + GIT_SHA1_HEXSZ - 1] == '\n' &&
+	    preimage[sizeof(heading) + the_hash_algo->hexsz - 1] == '\n' &&
 	    /* does the abbreviated name on the index line agree with it? */
 	    starts_with(preimage + sizeof(heading) - 1, p->old_sha1_prefix))
 		return 0; /* it all looks fine */
