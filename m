Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 377CB20248
	for <e@80x24.org>; Fri,  1 Mar 2019 22:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbfCAWBP (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 17:01:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:35060 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725905AbfCAWBO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 17:01:14 -0500
Received: (qmail 26825 invoked by uid 109); 1 Mar 2019 22:01:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Mar 2019 22:01:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2063 invoked by uid 111); 1 Mar 2019 22:01:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Mar 2019 17:01:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2019 17:01:12 -0500
Date:   Fri, 1 Mar 2019 17:01:12 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files,
 if possible
Message-ID: <20190301220112.GA14966@sigill.intra.peff.net>
References: <pull.130.git.gitgitgadget@gmail.com>
 <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com>
 <20190301213619.GA1518@sigill.intra.peff.net>
 <20190301215414.GB1518@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190301215414.GB1518@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 01, 2019 at 04:54:15PM -0500, Jeff King wrote:

> The one thing we do lose, though, is make's parallelization. It would
> probably be possible to actually shove this into a sub-make which
> defined the hdr-check rules, but I don't know how complicated that would
> become.

This seems to work, though it's kind of horrid.

It costs at least one extra process to run "make hdr-check", and
probably more for things like $(GIT_VERSION) that the Makefile include
likely triggers. But when you're not running hdr-check (which is the
norm), it's zero-cost.

-Peff

diff --git a/Makefile b/Makefile
index c5240942f2..ab6ecf450e 100644
--- a/Makefile
+++ b/Makefile
@@ -2735,16 +2735,8 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
 
-GEN_HDRS := command-list.h unicode-width.h
-EXCEPT_HDRS := $(GEN_HDRS) compat% xdiff%
-CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
-HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
-
-$(HCO): %.hco: %.h FORCE
-	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $<
-
-.PHONY: hdr-check $(HCO)
-hdr-check: $(HCO)
+hdr-check:
+	$(MAKE) -f hdr-check.mak hdr-check
 
 .PHONY: style
 style:
diff --git a/hdr-check.mak b/hdr-check.mak
new file mode 100644
index 0000000000..b8924afa90
--- /dev/null
+++ b/hdr-check.mak
@@ -0,0 +1,12 @@
+include Makefile
+
+GEN_HDRS := command-list.h unicode-width.h
+EXCEPT_HDRS := $(GEN_HDRS) compat% xdiff%
+CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
+HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
+
+$(HCO): %.hco: %.h FORCE
+	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $<
+
+.PHONY: hdr-check $(HCO)
+hdr-check: $(HCO)
