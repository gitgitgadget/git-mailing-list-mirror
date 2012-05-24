From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH v2] checkout: no progress messages if !isatty(2).
Date: Thu, 24 May 2012 02:12:24 -0400
Message-ID: <1337839944-4651-1-git-send-email-apenwarr@gmail.com>
References: <20120524061000.GA14035@sigill.intra.peff.net>
Cc: Avery Pennarun <apenwarr@gmail.com>
To: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 24 08:12:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXRHk-0005Hd-St
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 08:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973Ab2EXGM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 02:12:28 -0400
Received: from mail-yw0-f74.google.com ([209.85.213.74]:40069 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678Ab2EXGM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 02:12:27 -0400
Received: by yhgm50 with SMTP id m50so1161749yhg.1
        for <git@vger.kernel.org>; Wed, 23 May 2012 23:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=nP/WQm3A+5P/7M/02FQPNPrdfKF9v+/4TrbMt2YzQ7g=;
        b=E2uw3Jslf5H2+3sK+KWtKmBp2VWeLdN+Bm/uvDBe9lgOXe0KaemIqgfgbGCdRkJQ8u
         IaSPhoS/dglQMPw3cLyYAJgMN1hVuBU/7c3VjZhDw7i8afo4SvXDbjlNm3qtwgdQsPo/
         +oANTw3olY6PiU85rkFP0lskR3u/MMN9X0h9Ctwr5WB07dF3PA1O/CadZ8oAuILRGrxB
         Iyc5dT/k/MNOYdFXYMqvnz/3Jgkbf+U1vA6fRvHoxYWFE4+6aQPuEPpOsv6Fz0TJR++D
         qIx4Km8zTD7Wt7coOH+m5l8mBCoIiOjeM5lZ6Vlnq/NX3A8ev1Z9hHYJmWcwXG7MFNE5
         dj9A==
Received: by 10.236.73.131 with SMTP id v3mr49074411yhd.6.1337839946358;
        Wed, 23 May 2012 23:12:26 -0700 (PDT)
Received: by 10.236.73.131 with SMTP id v3mr49074404yhd.6.1337839946317;
        Wed, 23 May 2012 23:12:26 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id d5si784399yhj.7.2012.05.23.23.12.26
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 23 May 2012 23:12:26 -0700 (PDT)
Received: from emphatic.nyc.corp.google.com (emphatic.nyc.corp.google.com [172.29.18.158])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 437EA1009F1;
	Wed, 23 May 2012 23:12:26 -0700 (PDT)
Received: by emphatic.nyc.corp.google.com (Postfix, from userid 133661)
	id EA2551C0722; Thu, 24 May 2012 02:12:25 -0400 (EDT)
X-Mailer: git-send-email 1.7.9.dirty
In-Reply-To: <20120524061000.GA14035@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQk3VCAF7IpDoW0LhWj4kvuH9aNSgy8lgWWDiXTH9qZMshGQ1/bRO9YgVzUBDvbgmaBypcUm+DxP6MGnRGXJE45HQ51/0d7vxcqHaZZiUwms1iid7zsLjF9z1DyYF+jpLX2YYRF/FurpdIacVBX3gWdqOyPRyA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198359>

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
