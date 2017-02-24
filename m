Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3D20201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 21:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbdBXVOq (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 16:14:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:33629 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbdBXVOp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 16:14:45 -0500
Received: (qmail 12780 invoked by uid 109); 24 Feb 2017 21:08:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 21:08:04 +0000
Received: (qmail 32464 invoked by uid 111); 24 Feb 2017 21:08:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 16:08:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2017 16:08:02 -0500
Date:   Fri, 24 Feb 2017 16:08:02 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: [PATCH 2/3] parse_config_key: allow matching single-level config
Message-ID: <20170224210802.rpr5vdpqhsp3pt5v@sigill.intra.peff.net>
References: <20170224210643.max6z2ykm3gbg7lw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170224210643.max6z2ykm3gbg7lw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parse_config_key() function was introduced to make it
easier to match "section.subsection.key" variables. It also
handles the simpler "section.key", and the caller is
responsible for distinguishing the two from its
out-parameters.

Most callers who _only_ want "section.key" would just use a
strcmp(var, "section.key"), since there is no parsing
required. However, they may still use parse_config_key() if
their "section" variable isn't a constant (an example of
this is in parse_hide_refs_config).

Using the parse_config_key is a bit clunky, though:

  const char *subsection;
  int subsection_len;
  const char *key;

  if (!parse_config_key(var, section, &subsection, &subsection_len, &key) &&
      !subsection) {
	  /* matched! */
  }

Instead, let's treat a NULL subsection as an indication that
the caller does not expect one. That lets us write:

  const char *key;

  if (!parse_config_key(var, section, NULL, NULL, &key)) {
	  /* matched! */
  }

Existing callers should be unaffected, as passing a NULL
subsection would currently segfault.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h  | 5 ++++-
 config.c | 8 ++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 61fc86e6d..647a78f3f 100644
--- a/cache.h
+++ b/cache.h
@@ -1819,8 +1819,11 @@ extern int git_config_include(const char *name, const char *value, void *data);
  *
  * (i.e., what gets handed to a config_fn_t). The caller provides the section;
  * we return -1 if it does not match, 0 otherwise. The subsection and key
- * out-parameters are filled by the function (and subsection is NULL if it is
+ * out-parameters are filled by the function (and *subsection is NULL if it is
  * missing).
+ *
+ * If the subsection pointer-to-pointer passed in is NULL, returns 0 only if
+ * there is no subsection at all.
  */
 extern int parse_config_key(const char *var,
 			    const char *section,
diff --git a/config.c b/config.c
index 1b08a75a7..13c8b21ea 100644
--- a/config.c
+++ b/config.c
@@ -2552,10 +2552,14 @@ int parse_config_key(const char *var,
 
 	/* Did we have a subsection at all? */
 	if (dot == var) {
-		*subsection = NULL;
-		*subsection_len = 0;
+		if (subsection) {
+			*subsection = NULL;
+			*subsection_len = 0;
+		}
 	}
 	else {
+		if (!subsection)
+			return -1;
 		*subsection = var + 1;
 		*subsection_len = dot - *subsection;
 	}
-- 
2.12.0.616.g5f622f3b1

