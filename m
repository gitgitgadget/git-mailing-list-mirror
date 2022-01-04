Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1EFC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 02:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiADCJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 21:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiADCJE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 21:09:04 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798B5C061784
        for <git@vger.kernel.org>; Mon,  3 Jan 2022 18:09:04 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B328C5B24C;
        Tue,  4 Jan 2022 02:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1641262143;
        bh=5tcSeRws+FPWHA9PPK/oyQ3KxCkCZT2X+03wvATI5Gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=p/1kef03AXZByRepXCFY/VJM6JO6z93m0N00sww20O1xXjDlbfObuDG3P+0yihZbu
         ZKDDa7sIy+jsLALCEwzgh2O4fbxpsfubFliUSC96rL1f4V48HOKPJ+gceeg45CXpXF
         2byUWRm0jXY+UvotuGLgaAN/9BxABGzBvDFUKm3deSXAnEHac1p2Sz7iy9qhQTcPRZ
         9MhVSc0v5PGxQsZa4ukM5zYB8uX5HKm0Tq93hm9UsFwTHF3wUlH55+Nj71xln2mgIm
         Cq7fEpoNKbsw4UfYZfRMcZsoI1NWcM3nOqCp4b317bivrQd8s7f8fJjeiBdllXnLX2
         aKXu/6ZenzB67TeIUvCpDTDdJdNiZirK4EKM26wV9FvlEblqR9YBcVH9CRVXHPvKVx
         aF131KrESXkZSf+K72gxeypqq8QPBTomS5EQ0IPDqe9FxCIMdtTVb2n1GZj2Azcx7R
         6FuP+ZKh1ohmIbzCYIPKCwA3u5Wv9cjt3gcz9Bspo+ZpYmj6+xw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 2/2] wrapper: use a CSPRNG to generate random file names
Date:   Tue,  4 Jan 2022 01:55:55 +0000
Message-Id: <20220104015555.3387101-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb
In-Reply-To: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current way we generate random file names is by taking the seconds
and microseconds, plus the PID, and mixing them together, then encoding
them.  If this fails, we increment the value by 7777, and try again up
to TMP_MAX times.

Unfortunately, this is not the best idea from a security perspective.
If we're writing into TMPDIR, an attacker can guess these values easily
and prevent us from creating any temporary files at all by creating them
all first.  Even though we set TMP_MAX to 16384, this may be achievable
in some contexts, even if unlikely to occur in practice.

Fortunately, we can simply solve this by using the system
cryptographically secure pseudorandom number generator (CSPRNG) to
generate a random 64-bit value, and use that as before.  Note that there
is still a small bias here, but because a six-character sequence chosen
out of 62 characters provides about 36 bits of entropy, the bias here is
less than 2^-28, which is acceptable, especially considering we'll retry
several times.

Note that the use of a CSPRNG in generating temporary file names is also
used in many libcs.  glibc recently changed from an approach similar to
ours to using a CSPRNG, and FreeBSD and OpenBSD also use a CSPRNG in
this case.  Even if the likelihood of an attack is low, we should still
be at least as responsible in creating temporary files as libc is.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 wrapper.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 1052356703..3258cdb171 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -463,8 +463,6 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 	static const int num_letters = ARRAY_SIZE(letters) - 1;
 	static const char x_pattern[] = "XXXXXX";
 	static const int num_x = ARRAY_SIZE(x_pattern) - 1;
-	uint64_t value;
-	struct timeval tv;
 	char *filename_template;
 	size_t len;
 	int fd, count;
@@ -485,12 +483,13 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 	 * Replace pattern's XXXXXX characters with randomness.
 	 * Try TMP_MAX different filenames.
 	 */
-	gettimeofday(&tv, NULL);
-	value = ((uint64_t)tv.tv_usec << 16) ^ tv.tv_sec ^ getpid();
 	filename_template = &pattern[len - num_x - suffix_len];
 	for (count = 0; count < TMP_MAX; ++count) {
-		uint64_t v = value;
 		int i;
+		uint64_t v;
+		if (csprng_bytes(&v, sizeof(v)) < 0)
+			return error_errno("unable to get random bytes for temporary file");
+
 		/* Fill in the random bits. */
 		for (i = 0; i < num_x; i++) {
 			filename_template[i] = letters[v % num_letters];
@@ -506,12 +505,6 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 		 */
 		if (errno != EEXIST)
 			break;
-		/*
-		 * This is a random value.  It is only necessary that
-		 * the next TMP_MAX values generated by adding 7777 to
-		 * VALUE are different with (module 2^32).
-		 */
-		value += 7777;
 	}
 	/* We return the null string if we can't find a unique file name.  */
 	pattern[0] = '\0';
