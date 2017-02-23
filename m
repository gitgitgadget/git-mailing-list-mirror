Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF417201A9
	for <e@80x24.org>; Thu, 23 Feb 2017 08:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbdBWIQA (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 03:16:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:60526 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751251AbdBWIP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 03:15:59 -0500
Received: (qmail 31986 invoked by uid 109); 23 Feb 2017 08:15:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 08:15:57 +0000
Received: (qmail 10679 invoked by uid 111); 23 Feb 2017 08:16:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 03:16:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 03:15:55 -0500
Date:   Thu, 23 Feb 2017 03:15:55 -0500
From:   Jeff King <peff@peff.net>
To:     bs.x.ttp@recursor.net
Cc:     git@vger.kernel.org
Subject: [PATCH 3/4] ident: reject all-crud ident name
Message-ID: <20170223081555.3yfgm2l7dsjbk4y5@sigill.intra.peff.net>
References: <20170223081157.hwfn3msfux5udmng@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170223081157.hwfn3msfux5udmng@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An ident name consisting of only "crud" characters (like
whitespace or punctuation) is effectively the same as an
empty one, because our strbuf_addstr_without_crud() will
remove those characters.

We reject an empty name when formatting a strict ident, but
don't notice an all-crud one because our check happens
before the crud-removal step.

We could skip past the crud before checking for an empty
name, but let's make it a separate code path, for two
reasons. One is that we can give a more specific error
message. And two is that unlike a blank name, we probably
don't want to kick in the fallback-to-username behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
 ident.c                       | 11 +++++++++++
 t/t7518-ident-corner-cases.sh |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/ident.c b/ident.c
index ea6034581..ead09ff7f 100644
--- a/ident.c
+++ b/ident.c
@@ -203,6 +203,15 @@ static int crud(unsigned char c)
 		c == '\'';
 }
 
+static int has_non_crud(const char *str)
+{
+	for (; *str; str++) {
+		if (!crud(*str))
+			return 1;
+	}
+	return 0;
+}
+
 /*
  * Copy over a string to the destination, but avoid special
  * characters ('\n', '<' and '>') and remove crud at the end
@@ -389,6 +398,8 @@ const char *fmt_ident(const char *name, const char *email,
 			pw = xgetpwuid_self(NULL);
 			name = pw->pw_name;
 		}
+		if (strict && !has_non_crud(name))
+			die(_("name consists only of disallowed characters: %s"), name);
 	}
 
 	strbuf_reset(&ident);
diff --git a/t/t7518-ident-corner-cases.sh b/t/t7518-ident-corner-cases.sh
index 6c057afc1..3d2560c3c 100755
--- a/t/t7518-ident-corner-cases.sh
+++ b/t/t7518-ident-corner-cases.sh
@@ -17,4 +17,9 @@ test_expect_success 'empty name and missing email' '
 	)
 '
 
+test_expect_success 'commit rejects all-crud name' '
+	test_must_fail env GIT_AUTHOR_NAME=" .;<>" \
+		git commit --allow-empty -m foo
+'
+
 test_done
-- 
2.12.0.rc2.597.g959f68882

