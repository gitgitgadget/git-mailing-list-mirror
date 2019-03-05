Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D55820248
	for <e@80x24.org>; Tue,  5 Mar 2019 23:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfCEXH0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 18:07:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:40106 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726217AbfCEXH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 18:07:26 -0500
Received: (qmail 27950 invoked by uid 109); 5 Mar 2019 23:07:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Mar 2019 23:07:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3642 invoked by uid 111); 5 Mar 2019 23:07:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 05 Mar 2019 18:07:42 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2019 18:07:23 -0500
Date:   Tue, 5 Mar 2019 18:07:23 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files,
 if possible
Message-ID: <20190305230723.GB22901@sigill.intra.peff.net>
References: <pull.130.git.gitgitgadget@gmail.com>
 <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com>
 <20190301213619.GA1518@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903022058230.45@tvgsbejvaqbjf.bet>
 <20190303171951.GD23811@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903041206300.45@tvgsbejvaqbjf.bet>
 <20190304214155.GB3347@sigill.intra.peff.net>
 <xmqqzhq9vpik.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhq9vpik.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 05, 2019 at 02:50:11PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This makes sense to me, though as you noted elsewhere, it doesn't fix
> > the gcrypt problem, since that file unconditionally wants to look at the
> > system gcrypt.h (and we control at the Makefile level whether we
> > actually look at sha256/gcrypt.h).
> 
> Hmm, is that because the header check target does not know which *.h
> files we ship are actually used in a particular build?

Yes, exactly.

> After a normal build, with dynamic dependency checking on, we would
> have sufficient information to figure it out.  Would that help?

Yeah, that's what I was hinting at earlier in the thread. Here it is
sketched out to an actual working patch. The sub-make bits could
actually be a shell script instead of a Makefile; the only point in
using make is to use the parent "-j" for parallelism.

Note also that by including compat/ headers, I noticed that bswap.h
fails its hdr-check. :)

So do command-list.h (it needs gettext.h to handle the _() markings, but
that only comes in via cache.h), and all of xdiff (which is probably
fixable, but I didn't bother here).

---
 Makefile       | 23 ++++++++++++-----------
 compat/bswap.h |  5 +++++
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index c5240942f2..283e934d7b 100644
--- a/Makefile
+++ b/Makefile
@@ -1852,7 +1852,6 @@ ifndef V
 	QUIET_MSGFMT   = @echo '   ' MSGFMT $@;
 	QUIET_GCOV     = @echo '   ' GCOV $@;
 	QUIET_SP       = @echo '   ' SP $<;
-	QUIET_HDR      = @echo '   ' HDR $<;
 	QUIET_RC       = @echo '   ' RC $@;
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
@@ -2735,16 +2734,18 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
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
+.PHONY: hdr-check
+hdr-check: all
+ifdef USE_COMPUTED_HEADER_DEPENDENCIES
+	@$(MAKE) -f hdr-check.mak CC="$(CC)" V=$(V) \
+		$$(sed -n 's/^\([^ ]*\)\.h:/\1.hco/p' .depend/* | \
+		   sort -u | \
+		   egrep -v '^(xdiff/|unicode-width.h|command-list.h)' \
+		)
+else
+	@echo >&2 "error: hdr-check supported only on platforms with computed dependencies"
+	@false
+endif
 
 .PHONY: style
 style:
diff --git a/compat/bswap.h b/compat/bswap.h
index 5078ce5ecc..e4e25735ce 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -1,3 +1,6 @@
+#ifndef COMPAT_BSWAP_H
+#define COMPAT_BSWAP_H
+
 /*
  * Let's make sure we always have a sane definition for ntohl()/htonl().
  * Some libraries define those as a function call, just to perform byte
@@ -210,3 +213,5 @@ static inline void put_be64(void *ptr, uint64_t value)
 }
 
 #endif
+
+#endif /* COMPAT_BSWAP_H */
-- 
2.21.0.684.gc9dc8b89c9

