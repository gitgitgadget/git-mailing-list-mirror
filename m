Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 870711F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 15:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfJBPcI (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 11:32:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:37994 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725875AbfJBPcI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 11:32:08 -0400
Received: (qmail 24776 invoked by uid 109); 2 Oct 2019 15:32:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Oct 2019 15:32:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22565 invoked by uid 111); 2 Oct 2019 15:34:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Oct 2019 11:34:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Oct 2019 11:32:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com, cb@hashpling.org,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5] wrapper: use a loop instead of repetitive statements
Message-ID: <20191002153207.GA6116@sigill.intra.peff.net>
References: <20191001022936.1757141-1-alexhenrie24@gmail.com>
 <20191001022936.1757141-3-alexhenrie24@gmail.com>
 <xmqqbluzfzql.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbluzfzql.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 02, 2019 at 03:06:10PM +0900, Junio C Hamano wrote:

> All three patches looked sensible.
> 
> Even though there is no dependency or relationships among them
> (beyond that they got written at the same time by the same person),
> I'll just queue them on a single ah/cleanups topic and get them
> advance together, as I do not expect any one of them to be blocking
> the other two.

Just re-posting this follow-on from the earlier thread (it goes on top
of the third one):

-- >8 --
Subject: git_mkstemps_mode(): replace magic numbers with computed value

The magic number "6" appears several times in the function, and is
related to the size of the "XXXXXX" string we expect to find in the
template. Let's pull that "XXXXXX" into a constant array, whose size we
can get at compile time with ARRAY_SIZE().

Note that we probably can't just change this value, since callers will
be feeding us a certain number of X's, but it hopefully makes the
function itself easier to follow.

While we're here, let's do the same with the "letters" array (which we
_could_ modify if we wanted to include more characters).

Signed-off-by: Jeff King <peff@peff.net>
---
 wrapper.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 54541386c1..75992cff02 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -478,7 +478,9 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 		"abcdefghijklmnopqrstuvwxyz"
 		"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 		"0123456789";
-	static const int num_letters = 62;
+	static const int num_letters = ARRAY_SIZE(letters) - 1;
+	static const char x_pattern[] = "XXXXXX";
+	static const int num_x = ARRAY_SIZE(x_pattern) - 1;
 	uint64_t value;
 	struct timeval tv;
 	char *filename_template;
@@ -487,12 +489,12 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 
 	len = strlen(pattern);
 
-	if (len < 6 + suffix_len) {
+	if (len < num_x + suffix_len) {
 		errno = EINVAL;
 		return -1;
 	}
 
-	if (strncmp(&pattern[len - 6 - suffix_len], "XXXXXX", 6)) {
+	if (strncmp(&pattern[len - num_x - suffix_len], x_pattern, num_x)) {
 		errno = EINVAL;
 		return -1;
 	}
@@ -503,12 +505,12 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 	 */
 	gettimeofday(&tv, NULL);
 	value = ((uint64_t)tv.tv_usec << 16) ^ tv.tv_sec ^ getpid();
-	filename_template = &pattern[len - 6 - suffix_len];
+	filename_template = &pattern[len - num_x - suffix_len];
 	for (count = 0; count < TMP_MAX; ++count) {
 		uint64_t v = value;
 		int i;
 		/* Fill in the random bits. */
-		for (i = 0; i < 6; i++) {
+		for (i = 0; i < num_x; i++) {
 			filename_template[i] = letters[v % num_letters];
 			v /= num_letters;
 		}
-- 
2.23.0.926.g3dc922fbbc

