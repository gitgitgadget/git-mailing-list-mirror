Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 165BA1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 20:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfAXUgt (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 15:36:49 -0500
Received: from kitenet.net ([66.228.36.95]:57754 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfAXUgs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 15:36:48 -0500
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1548362199; bh=Xe4dnqujMmrsjiCogFCJo/UpRwrROXnpYu332qtMrYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ByXzyXnDpIjVdl3r12eYRgWIHsHGMzyty8rMH0xyWKAdA3X0HjMyUcgjU+bum3kzY
         K5hOcnV/UjN3U6h2vuma2P6ZNJI+UmaTnKF1s5v+UyrQeg1n8CRjnTEHa1wHlMIWMj
         vLYEer17PYsRsu2LpGMhmwzzQ8YrusKCi2e+AojM=
Date:   Thu, 24 Jan 2019 16:36:39 -0400
From:   Joey Hess <id@joeyh.name>
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Subject: [PATCH] avoid unncessary malloc of whole file size
Message-ID: <20190124203639.GA17595@kitenet.net>
References: <20190122220714.GA6176@kitenet.net>
 <20190124121037.GA4949@sigill.intra.peff.net>
 <20190124183810.GC29200@kitenet.net>
 <20190124191836.GA31073@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124191836.GA31073@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a worktree file is larger than the available memory, and a clean
filter is in use, this avoids mallocing a buffer the whole size of the
file when reading from the clean filter, which caused commands like git
status and git commit to OOM.

Often in this situation the clean filter will produce a short identifier
for the file, so such a large buffer is not needed.

When the clean filter does output something around the same size as the
worktree file, the buffer will need to be reallocated until it fits,
starting at 8192 and doubling in size. Benchmarking indicates that
reallocation is not a significant overhead for outputs up to a
few MB in size.

Signed-off-by: Joey Hess <id@joeyh.name>
---
 convert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index 0d89ae7c23..85aebe2ed3 100644
--- a/convert.c
+++ b/convert.c
@@ -732,7 +732,7 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le
 	if (start_async(&async))
 		return 0;	/* error was already reported */
 
-	if (strbuf_read(&nbuf, async.out, len) < 0) {
+	if (strbuf_read(&nbuf, async.out, 0) < 0) {
 		err = error(_("read from external filter '%s' failed"), cmd);
 	}
 	if (close(async.out)) {
-- 
2.20.1

