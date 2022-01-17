Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974C8C433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 21:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243419AbiAQV4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 16:56:24 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:35368 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiAQV4X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 16:56:23 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D51BB5B27E;
        Mon, 17 Jan 2022 21:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1642456582;
        bh=5tcSeRws+FPWHA9PPK/oyQ3KxCkCZT2X+03wvATI5Gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=DI6H3+rjY8qT9StQrZ71JXrMuxML3hNjAUKqAM34fzdQjCvuU+iB0un287hAQoMbl
         Sm/P1qEROF+Mj992Pdc05ATdUUlYxypSWz6gePc5cWCBp0RuiCV1q/6lHuOI6WVGRY
         GGa8RY5dWD1uudI6OXjJcnvKWxPNzNVZjOZztDFa7CW8Yqu1/DCSfOYFaTIVMgOW1L
         L8tqmaUFxfFB6S3A663bA1vFwXwqSpk0rP+K0jU6ro8x7STn+YsSWwWJO3YbaqKtuF
         qN/8lxEyBlW03B/pNnoSG7116qY9Ufs+Ry49fWUmHbbhTdoY3U0L8kc+5e0Fy+Stie
         9D6igd4Sbh8u1gdGfx2XnI6Ew+ofgRnqOShB3g4TCjHo1oHQKnOa62EKUZmlQn2q65
         vwTJCAiJEeQ4Dh59Jf4/W4NVFAAi8hDvgK16lCnzrNqP15tJ9PsyFLHd0j0o5aksWj
         gKwd6kCsI/pqfMxSYnwuNewEMLG8oo2k9W3k/G9dbJHBRDcIO3y
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 2/2] wrapper: use a CSPRNG to generate random file names
Date:   Mon, 17 Jan 2022 21:56:17 +0000
Message-Id: <20220117215617.843190-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb
In-Reply-To: <20220117215617.843190-1-sandals@crustytoothpaste.net>
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-1-sandals@crustytoothpaste.net>
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
