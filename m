Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038DDECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 20:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiH3UlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 16:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiH3Uk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 16:40:59 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B81823151
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 13:40:57 -0700 (PDT)
Received: (qmail 7720 invoked by uid 109); 30 Aug 2022 20:40:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Aug 2022 20:40:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29437 invoked by uid 111); 30 Aug 2022 20:40:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Aug 2022 16:40:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Aug 2022 16:40:56 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Renato Botelho <garga@freebsd.org>
Subject: [PATCH] test-crontab: minor memory and error handling fixes
Message-ID: <Yw512HXz/SV50ckc@coredump.intra.peff.net>
References: <20220823010120.25388-1-sandals@crustytoothpaste.net>
 <20220828214143.754759-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220828214143.754759-1-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 28, 2022 at 09:41:43PM +0000, brian m. carlson wrote:

> diff --git a/t/helper/test-crontab.c b/t/helper/test-crontab.c
> index e7c0137a47..2942543046 100644
> --- a/t/helper/test-crontab.c
> +++ b/t/helper/test-crontab.c
> @@ -17,8 +17,8 @@ int cmd__crontab(int argc, const char **argv)
>  		if (!from)
>  			return 0;
>  		to = stdout;
> -	} else if (argc == 2) {
> -		from = stdin;
> +	} else if (argc == 3) {
> +		from = fopen(argv[2], "r");
>  		to = fopen(argv[1], "w");
>  	} else
>  		return error("unknown arguments");

After this commit we know that argc must be 3, so that makes the "else"
in the cleanup section dead code:

  if (argc == 3)
	fclose(from);
  else
	fclose(to);

While fixing that, I noticed a ton of other small problems, so I just
lumped them all together (which I think is OK given the relative
insignificance of this program). I do have to wonder if this really
could be replaced by a call to "cp". ;)

-- >8 --
Subject: [PATCH] test-crontab: minor memory and error handling fixes

Since ee69e7884e (gc: use temporary file for editing crontab,
2022-08-28), we now insist that "argc == 3" (and otherwise return an
error). Coverity notes that this causes some dead code:

    if (argc == 3)
          fclose(from);
    else
          fclose(to);

as we will never trigger the else. This also causes a memory leak, since
we'll never close "to".

Now that all paths require 2 arguments, we can just reorganize the
function to check argc up front, and tweak the cleanup to do the right
thing for all cases.

While we're here, we can also notice some minor problems:

  - we return a negative int via error() from what is essentially a
    main() function; we should return a positive non-zero value for
    error. Or better yet, we can just use usage(), which gives a better
    message.

  - while writing the usage message, we can note the one in the comment
    was made out of date by ee69e7884e. But it also had a typo already,
    calling the subcommand "cron" and not "crontab"

  - we didn't check for an error from fopen(), meaning we would segfault
    if the to-be-read file was missing. We can use xfopen() to catch
    this.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-crontab.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/t/helper/test-crontab.c b/t/helper/test-crontab.c
index 2942543046..e6c1b1e22b 100644
--- a/t/helper/test-crontab.c
+++ b/t/helper/test-crontab.c
@@ -2,33 +2,34 @@
 #include "cache.h"
 
 /*
- * Usage: test-tool cron <file> [-l]
+ * Usage: test-tool crontab <file> -l|<input>
  *
  * If -l is specified, then write the contents of <file> to stdout.
- * Otherwise, write from stdin into <file>.
+ * Otherwise, copy the contents of <input> into <file>.
  */
 int cmd__crontab(int argc, const char **argv)
 {
 	int a;
 	FILE *from, *to;
 
-	if (argc == 3 && !strcmp(argv[2], "-l")) {
+	if (argc != 3)
+		usage("test-tool crontab <file> -l|<input>");
+
+	if (!strcmp(argv[2], "-l")) {
 		from = fopen(argv[1], "r");
 		if (!from)
 			return 0;
 		to = stdout;
-	} else if (argc == 3) {
-		from = fopen(argv[2], "r");
-		to = fopen(argv[1], "w");
-	} else
-		return error("unknown arguments");
+	} else {
+		from = xfopen(argv[2], "r");
+		to = xfopen(argv[1], "w");
+	}
 
 	while ((a = fgetc(from)) != EOF)
 		fputc(a, to);
 
-	if (argc == 3)
-		fclose(from);
-	else
+	fclose(from);
+	if (to != stdout)
 		fclose(to);
 
 	return 0;
-- 
2.37.3.1051.g85dc4064ac

