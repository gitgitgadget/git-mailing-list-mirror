Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14AF41F97E
	for <e@80x24.org>; Mon, 15 Oct 2018 00:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbeJOHpK (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 03:45:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50608 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726444AbeJOHpJ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 03:45:09 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8894C61B86;
        Mon, 15 Oct 2018 00:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539561744;
        bh=afA0DkEh9YgMBNUvx6855l6VhkWaEq+tcfJfnRC08EI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=fmYaFij1ZL+SWyuiPVyhu6b2NU7jRlx9OyYvdqRDCmV49kzOdNaaXoruW1/xlt5qL
         eBkJJOEB5koq6Nj9/oYMeIMYMUXrMaaYQFNafjcmwVD8PI1eHx6SMFihoa4oSru+dS
         qfkKN6TCZsayaO4P0LHbvcsr1xk17FpyxgzaTxLiztpcN12DLlJojNGrb+KFCMdwH0
         iTHIN7sATFRFVsN6SX9bk+oLtmnRUWJCRz3Ff+iODubrSo/7hg/ORcFdUYy3QFhXSd
         tb6C5WZ+hz7ekYKrBCIm1kR/REHeG7eig3CHQYYVnz7aMdxkS/Fipj/21QNB1NOzSj
         BzmAUlAkAUXqp/y3acRjdoZZtlOQJ25SlO8KDfjXetiRJ6SIjvMAz901jSy2Dgkflj
         UZfaay6XCV5cScaEogGaMm7McuojBUj99nFVO0rOXZdUmerXsGD/gEGb53FWwsxfO8
         jacncaeAZtfPVD1TnQSW+4BzLmWul6QvmgKCfBrWxxXBttKubRc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 12/15] apply: replace hard-coded constants
Date:   Mon, 15 Oct 2018 00:01:59 +0000
Message-Id: <20181015000202.951965-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181015000202.951965-1-sandals@crustytoothpaste.net>
References: <20181015000202.951965-1-sandals@crustytoothpaste.net>
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
