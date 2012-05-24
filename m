From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH] checkout: default to quiet if !isatty(2).
Date: Thu, 24 May 2012 02:05:34 -0400
Message-ID: <1337839534-7760-1-git-send-email-apenwarr@gmail.com>
References: <20120524054506.GA3440@sigill.intra.peff.net>
Cc: Avery Pennarun <apenwarr@gmail.com>
To: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 24 08:05:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXRBG-0002Do-46
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 08:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448Ab2EXGFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 02:05:45 -0400
Received: from mail-wi0-f202.google.com ([209.85.212.202]:50688 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012Ab2EXGFn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 02:05:43 -0400
Received: by wibhn6 with SMTP id hn6so333150wib.1
        for <git@vger.kernel.org>; Wed, 23 May 2012 23:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=nP/WQm3A+5P/7M/02FQPNPrdfKF9v+/4TrbMt2YzQ7g=;
        b=LOHebMhNZUyFsuOOFBvPl4X3DM9VA0fusuB42BtX+ZCNA5NMvfdFxTN9ooNxEW74DS
         6dtgGnMb59T7i5oQFBRHLTBtbWS/4jsBJpuq3Clalj/qrbhdXxFx7Y2Wjy2T6A/cTBY4
         B1KqIk2znDXsETWJWP2R/CY8qwIU6t4p0q0ZEe40RIZ4pBjoW5vnI15Nw/Bgt1JONFsp
         /MSCe38u6TsiARYuJB3Qrhik8htors6xfs1IQ68pSlemWYbOTO8Ppd3k4uyf47YS8KUr
         9SZaoOkfXZtCRmNz9ux+nYebosQsSPUUgNO607loNu8rEJjWCc8MpO8NZhyX8Pqkf0d/
         6TkA==
Received: by 10.14.185.140 with SMTP id u12mr8167106eem.0.1337839542580;
        Wed, 23 May 2012 23:05:42 -0700 (PDT)
Received: by 10.14.185.140 with SMTP id u12mr8167099eem.0.1337839542492;
        Wed, 23 May 2012 23:05:42 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id b16si26731174eeg.3.2012.05.23.23.05.42
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 23 May 2012 23:05:42 -0700 (PDT)
Received: from emphatic.nyc.corp.google.com (emphatic.nyc.corp.google.com [172.29.18.158])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 5ECF95C0716;
	Wed, 23 May 2012 23:05:42 -0700 (PDT)
Received: by emphatic.nyc.corp.google.com (Postfix, from userid 133661)
	id 8CE191C0722; Thu, 24 May 2012 02:05:41 -0400 (EDT)
X-Mailer: git-send-email 1.7.9.dirty
In-Reply-To: <20120524054506.GA3440@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQkmcq0x2+a6VXDoxOm2VZP4t5XyJ7XJurWm7Cmpl8zjlsRO1zyjbUl3HkuiBUm5ciIMLj/EmZg6I28U/KWFFD/XeCYNZJZMON43y+y4bzgNvvOzZQ2AWwpt+Eh5YsVQ5v8xdKANH6k52AcZfUjcewcmafUknA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198357>

It would probably be better to have progress.c check isatty(2) all the time,
but that wouldn't allow things like 'git push --progress' to force progress
reporting to on, so I won't try to solve the general case right now.

Actual fix suggested by Jeff King.

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 builtin/checkout.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f1984d9..4ee833a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -343,7 +343,7 @@ static int reset_tree(struct tree *tree, struct checkout_opts *o, int worktree)
 	opts.reset = 1;
 	opts.merge = 1;
 	opts.fn = oneway_merge;
-	opts.verbose_update = !o->quiet;
+	opts.verbose_update = !o->quiet && isatty(2);
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	parse_tree(tree);
@@ -420,7 +420,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.update = 1;
 		topts.merge = 1;
 		topts.gently = opts->merge && old->commit;
-		topts.verbose_update = !opts->quiet;
+		topts.verbose_update = !opts->quiet && isatty(2);
 		topts.fn = twoway_merge;
 		if (opts->overwrite_ignore) {
 			topts.dir = xcalloc(1, sizeof(*topts.dir));
-- 
1.7.9.dirty
