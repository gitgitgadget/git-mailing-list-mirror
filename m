Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C4131F463
	for <e@80x24.org>; Fri, 27 Sep 2019 02:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfI0CpE (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 22:45:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:33576 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727505AbfI0CpE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 22:45:04 -0400
Received: (qmail 23744 invoked by uid 109); 27 Sep 2019 02:45:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Sep 2019 02:45:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5906 invoked by uid 111); 27 Sep 2019 02:47:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Sep 2019 22:47:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Sep 2019 22:45:03 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        davvid@gmail.com
Subject: Re: [PATCH 3/3] wrapper: use a loop instead of repetitive statements
Message-ID: <20190927024502.GC23736@sigill.intra.peff.net>
References: <20190925020158.751492-1-alexhenrie24@gmail.com>
 <20190925020158.751492-4-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925020158.751492-4-alexhenrie24@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 24, 2019 at 08:01:58PM -0600, Alex Henrie wrote:

> diff --git a/wrapper.c b/wrapper.c
> index c55d7722d7..c23ac6adcd 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -469,13 +469,12 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
>  	filename_template = &pattern[len - 6 - suffix_len];
>  	for (count = 0; count < TMP_MAX; ++count) {
>  		uint64_t v = value;
> +		int i;
>  		/* Fill in the random bits. */
> -		filename_template[0] = letters[v % num_letters]; v /= num_letters;
> -		filename_template[1] = letters[v % num_letters]; v /= num_letters;
> -		filename_template[2] = letters[v % num_letters]; v /= num_letters;
> -		filename_template[3] = letters[v % num_letters]; v /= num_letters;
> -		filename_template[4] = letters[v % num_letters]; v /= num_letters;
> -		filename_template[5] = letters[v % num_letters]; v /= num_letters;
> +		for (i = 0; i < 6; i++) {
> +			filename_template[i] = letters[v % num_letters];
> +			v /= num_letters;
> +		}

I'm not sure the readability is changed much either way. But it does
enable this additional cleanup on top:

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
index c23ac6adcd..e1eaef2e16 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -441,7 +441,9 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
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
@@ -450,12 +452,12 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 
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
@@ -466,12 +468,12 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
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
2.23.0.765.g1fc3e247e7

