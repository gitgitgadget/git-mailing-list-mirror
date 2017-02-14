Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 590701FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 06:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbdBNGEV (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 01:04:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:54887 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751089AbdBNGEU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 01:04:20 -0500
Received: (qmail 11718 invoked by uid 109); 14 Feb 2017 06:04:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 06:04:20 +0000
Received: (qmail 715 invoked by uid 111); 14 Feb 2017 06:04:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 01:04:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 01:04:17 -0500
Date:   Tue, 14 Feb 2017 01:04:17 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH 4/7] grep: re-order rev-parsing loop
Message-ID: <20170214060417.yq27zdcgmrckjmua@sigill.intra.peff.net>
References: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We loop over the arguments, but every branch of the loop
hits either a "continue" or a "break". Surely we can make
this simpler.

The final conditional is:

  if (arg is a rev) {
	  ... handle rev ...
	  continue;
  }
  break;

We can rewrite this as:

  if (arg is not a rev)
	  break;

  ... handle rev ...

That makes the flow a little bit simpler, and will make
things much easier to follow when we add more logic in
future patches.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/grep.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 081e1b57a..461347adb 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1154,20 +1154,22 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 		unsigned char sha1[20];
 		struct object_context oc;
+		struct object *object;
+
 		if (!strcmp(arg, "--")) {
 			i++;
 			seen_dashdash = 1;
 			break;
 		}
-		/* Is it a rev? */
-		if (!get_sha1_with_context(arg, 0, sha1, &oc)) {
-			struct object *object = parse_object_or_die(sha1, arg);
-			if (!seen_dashdash)
-				verify_non_filename(prefix, arg);
-			add_object_array_with_path(object, arg, &list, oc.mode, oc.path);
-			continue;
-		}
-		break;
+
+		/* Stop at the first non-rev */
+		if (get_sha1_with_context(arg, 0, sha1, &oc))
+			break;
+
+		object = parse_object_or_die(sha1, arg);
+		if (!seen_dashdash)
+			verify_non_filename(prefix, arg);
+		add_object_array_with_path(object, arg, &list, oc.mode, oc.path);
 	}
 
 	/* The rest are paths */
-- 
2.12.0.rc1.471.ga79ec8999

