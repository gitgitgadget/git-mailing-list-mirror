Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505CCC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3084360EE2
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhKPDjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 22:39:39 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:43242 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbhKPDir (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 22:38:47 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 0425E5D46A
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 03:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637033749;
        bh=2JeXvsnncHOXu0NMBnx+8WStbxyQQ4O7ysUd30OUcV0=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=nxF4XLEffHXAoeUVxLzC7SiVx3F7qEnm0E1jtjRnnkc5kT9jEa+Bu0eTwhTywFEmr
         F1xkmHwDxjWKp63oTEr5ErF+1XXic+oONsoeJIcsGgGMeqsNlU00UbVpNvl3Moq3GJ
         ytCB6mIDAnI1OWKmE+XC22HgbFa42P2XHa/UNbyHZkksouFiVb33T3t54dEtFZfiMs
         9/owZYu5Tt+uCZDbcn6bjseyhEshfanTvXCNoVgWuJxTYj3J16FrrC/0icLrdiTs6J
         Fbov1Mjr235pJjsGifaLhdJZAWw55ttdsn6ZM/PKdIYA+u9PjzNf8VjovmJIv4yc95
         UQ3AJArG1L9ThMYV581tPjt4EM6x6WIswBZ+kcRUniiWKz3UgPQu9OEi6JeCM6Bk+b
         Hq2LPJ5dCIMDfU1iK6Z36JdhG2QqsJs/lLKEVeZpDuKf8pR8jmlGYNz3fkgCqbPnAj
         cLwsGBvYdg07y+pdRX+NFBxFGJ6h7pl0bDzbUpjialgzXsai5Ra
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH 2/2] wrapper: use a CSPRNG to generate random file names
Date:   Tue, 16 Nov 2021 03:35:42 +0000
Message-Id: <20211116033542.3247094-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f
In-Reply-To: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
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
all first.  POSIX only requires TMP_MAX to be 25, so this is achievable
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
index 0046f32e46..0cdb5b18ff 100644
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
+			return -1;
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
