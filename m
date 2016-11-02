Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D180420193
	for <e@80x24.org>; Wed,  2 Nov 2016 13:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbcKBNGd (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 09:06:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:37451 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751075AbcKBNGc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 09:06:32 -0400
Received: (qmail 22623 invoked by uid 109); 2 Nov 2016 13:06:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 13:06:31 +0000
Received: (qmail 2668 invoked by uid 111); 2 Nov 2016 13:06:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 09:06:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 09:06:30 -0400
Date:   Wed, 2 Nov 2016 09:06:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/5] add open_nofollow() helper
Message-ID: <20161102130629.ijpugqeawbkj3s57@sigill.intra.peff.net>
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some callers of open() would like to optionally use
O_NOFOLLOW, but it is not available on all platforms. We
could abstract this by publicly defining O_NOFOLLOW to 0 on
those platforms, but that leaves us no room for any
workarounds (e.g., by checking the file type via lstat()).

Instead, let's abstract it into its own function. We don't
implement any workarounds here, but it it would be easy to
add them later.

Signed-off-by: Jeff King <peff@peff.net>
---
I didn't add the workaround because I think the current callers are OK
with "best effort", and doing it non-racily is quite tricky (though we
might also be OK with a racy version; we are not trying to beat
/tmp races, but just making sure a checkout that we did is sane).

 git-compat-util.h | 3 +++
 wrapper.c         | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 87237b092..a2cc33ebc 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1080,6 +1080,9 @@ int access_or_die(const char *path, int mode, unsigned flag);
 /* Warn on an inaccessible file that ought to be accessible */
 void warn_on_inaccessible(const char *path);
 
+/* Open with O_NOFOLLOW, if available on this platform */
+int open_nofollow(const char *path, int flags);
+
 #ifdef GMTIME_UNRELIABLE_ERRORS
 struct tm *git_gmtime(const time_t *);
 struct tm *git_gmtime_r(const time_t *, struct tm *);
diff --git a/wrapper.c b/wrapper.c
index e7f197996..6bc7f24f5 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -679,3 +679,11 @@ void sleep_millisec(int millisec)
 {
 	poll(NULL, 0, millisec);
 }
+
+#ifndef O_NOFOLLOW
+#define O_NOFOLLOW 0
+#endif
+int open_nofollow(const char *path, int flags)
+{
+	return open(path, flags | O_NOFOLLOW);
+}
-- 
2.11.0.rc0.258.gf434c15

