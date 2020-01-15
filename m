Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD96C32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 20:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BD22084D
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 20:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgAOUVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:21:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:37284 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726018AbgAOUVr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 15:21:47 -0500
Received: (qmail 19089 invoked by uid 109); 15 Jan 2020 20:21:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Jan 2020 20:21:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32722 invoked by uid 111); 15 Jan 2020 20:28:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Jan 2020 15:28:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Jan 2020 15:21:46 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH] dir: point treat_leading_path() warning to the right place
Message-ID: <20200115202146.GA4091171@coredump.intra.peff.net>
References: <pull.692.git.git.1579019532809.gitgitgadget@gmail.com>
 <pull.692.v2.git.git.1579098078501.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.692.v2.git.git.1579098078501.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 15, 2020 at 02:21:18PM +0000, Elijah Newren via GitGitGadget wrote:

> From: Jeff King <peff@peff.net>
> 
> Restructure the code slightly to avoid passing around a struct dirent
> anywhere, which also enables us to avoid trying to manufacture one.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Elijah Newren <newren@gmail.com>

Thanks, this looks good.

I wondered briefly whether this:

> @@ -2374,12 +2362,13 @@ static int treat_leading_path(struct dir_struct *dir,
>  			break;
>  		strbuf_reset(&sb);
>  		strbuf_add(&sb, path, prevlen);
> -		memcpy(de->d_name, path+prevlen, baselen-prevlen);
> -		de->d_name[baselen-prevlen] = '\0';
> +		strbuf_reset(&subdir);
> +		strbuf_add(&subdir, path+prevlen, baselen-prevlen);
> +		cdir.d_name = subdir.buf;

...could avoid the extra strbuf by pointing into an existing string
(since d_name is now a pointer, and not part of a dirent). But I think
the answer is "no", because in a path like "a/b/c", the loop may see
just "b" (so offsetting into path isn't sufficient, because we also have
to cut off the trailing part).

I did notice one other small thing while looking at this code:

-- >8 --
Subject: [PATCH] dir: point treat_leading_path() warning to the right place

Commit 777b420347 (dir: synchronize treat_leading_path() and
read_directory_recursive(), 2019-12-19) tried to add two warning
comments in those functions, pointing at each other. But the one in
treat_leading_path() just points at itself.

Let's fix that. Since the comment also redirects the reader for more
details to "the commit that added this warning", and since we're now
modifying the warning (creating a new commit without those details),
let's mention the actual commit id.

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 7d255227b1..31e83d982a 100644
--- a/dir.c
+++ b/dir.c
@@ -2308,9 +2308,9 @@ static int treat_leading_path(struct dir_struct *dir,
 	 * WARNING WARNING WARNING:
 	 *
 	 * Any updates to the traversal logic here may need corresponding
-	 * updates in treat_leading_path().  See the commit message for the
-	 * commit adding this warning as well as the commit preceding it
-	 * for details.
+	 * updates in read_directory_recursive().  See 777b420347 (dir:
+	 * synchronize treat_leading_path() and read_directory_recursive(),
+	 * 2019-12-19) and its parent commit for details.
 	 */
 
 	struct strbuf sb = STRBUF_INIT;
-- 
2.25.0.639.gb9b1511416

