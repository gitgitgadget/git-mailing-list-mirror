Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED54C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 14:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D846108F
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 14:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhJ1OjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 10:39:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:48774 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhJ1OjT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 10:39:19 -0400
Received: (qmail 16664 invoked by uid 109); 28 Oct 2021 14:36:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Oct 2021 14:36:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4574 invoked by uid 111); 28 Oct 2021 14:35:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Oct 2021 10:35:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Oct 2021 10:35:36 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Documentation/Makefile: fix lint-docs mkdir dependency
Message-ID: <YXq1OE/p5VoPR3WZ@coredump.intra.peff.net>
References: <YXeu4Hl2cmIPqobd@coredump.intra.peff.net>
 <xmqqlf2et3r3.fsf@gitster.g>
 <211028.861r45y3pt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211028.861r45y3pt.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 28, 2021 at 09:48:51AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I wonder if we can somehow avoid this unwieldy chain of commands,
> > perhaps with using "mkdir -p" somewhere, or make the lint scripts
> > create the necessary leading paths.  From the looks of the tail end
> > of Documentation/Makefile, the latter may be the cleaner solution.
> 
> Simplest would be to simply do the "mkdir -p" unconditionally, which we
> do in some other places. The diff below on top of next would do that.
> 
> I didn't do it because it slows things down quite a bit. Here HEAD is
> the diff below:

There's an in-between, I'd think, where the many "foo/bar/baz/$@"
targets have an order-dependency on "foo/bar/baz", and that single rule
uses "mkdir -p" to create all of the directories.

It doesn't buy us much simplification in this case, though, because
various rules independently depend on .build/gitlink/lint-docs/howto,
.built/gitlink/lint-docs, and .build/gitlink, etc. So we still end up
with roughly the same number of rules, though the directory rules don't
have to depend on one another.

It also means that these "mkdir -p" may race with each other, though in
general I'd hope that most "mkdir" implements could handle this.

Something like this works, I think:

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 911b6bf79c..a70e418af6 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -463,19 +463,13 @@ quick-install-html: require-htmlrepo
 print-man1:
 	@for i in $(MAN1_TXT); do echo $$i; done
 
-## Lint: Common
-.build:
-	$(QUIET)mkdir $@
-.build/lint-docs: | .build
-	$(QUIET)mkdir $@
-
 ## Lint: gitlink
-.build/lint-docs/gitlink: | .build/lint-docs
-	$(QUIET)mkdir $@
-.build/lint-docs/gitlink/howto: | .build/lint-docs
-	$(QUIET)mkdir $@
-.build/lint-docs/gitlink/config: | .build/lint-docs
-	$(QUIET)mkdir $@
+.build/lint-docs/gitlink:
+	$(QUIET)mkdir -p $@
+.build/lint-docs/gitlink/howto:
+	$(QUIET)mkdir -p $@
+.build/lint-docs/gitlink/config:
+	$(QUIET)mkdir -p $@
 LINT_DOCS_GITLINK = $(patsubst %.txt,.build/lint-docs/gitlink/%.ok,$(HOWTO_TXT) $(DOC_DEP_TXT))
 $(LINT_DOCS_GITLINK): | .build/lint-docs/gitlink
 $(LINT_DOCS_GITLINK): | .build/lint-docs/gitlink/howto
@@ -492,8 +486,8 @@ $(LINT_DOCS_GITLINK): .build/lint-docs/gitlink/%.ok: %.txt
 lint-docs-gitlink: $(LINT_DOCS_GITLINK)
 
 ## Lint: man-end-blurb
-.build/lint-docs/man-end-blurb: | .build/lint-docs
-	$(QUIET)mkdir $@
+.build/lint-docs/man-end-blurb:
+	$(QUIET)mkdir -p $@
 LINT_DOCS_MAN_END_BLURB = $(patsubst %.txt,.build/lint-docs/man-end-blurb/%.ok,$(MAN_TXT))
 $(LINT_DOCS_MAN_END_BLURB): | .build/lint-docs/man-end-blurb
 $(LINT_DOCS_MAN_END_BLURB): lint-man-end-blurb.perl
@@ -503,8 +497,8 @@ $(LINT_DOCS_MAN_END_BLURB): .build/lint-docs/man-end-blurb/%.ok: %.txt
 lint-docs-man-end-blurb: $(LINT_DOCS_MAN_END_BLURB)
 
 ## Lint: man-section-order
-.build/lint-docs/man-section-order: | .build/lint-docs
-	$(QUIET)mkdir $@
+.build/lint-docs/man-section-order:
+	$(QUIET)mkdir -p $@
 LINT_DOCS_MAN_SECTION_ORDER = $(patsubst %.txt,.build/lint-docs/man-section-order/%.ok,$(MAN_TXT))
 $(LINT_DOCS_MAN_SECTION_ORDER): | .build/lint-docs/man-section-order
 $(LINT_DOCS_MAN_SECTION_ORDER): lint-man-section-order.perl

 We could technically even drop the .build/lint-docs/gitlink rule,
 because it's a parent of other directories built by the same rule. But
 that's a bit too clever and magical for my tastes.

 All that said, I'm not that unhappy with the current state, and I think
 with my patch it should be correct / robust.

> You can do this with make macros via $(eval) calling a $(foreach) loop,
> i.e. just generate the boilerplate we have now. For this case I thought
> it wasn't worth it, but figured I could eventually loop back to it
> if/when we use a nested structure inside a ".build directory more
> widely.

Yeah, I think for the scope of the problem here (remembering that "mkdir
foo/bar" needs to depend on "mkdir foo") that a macro would probably
just confuse things. IMHO the more subtle maintenance trap is that
LINT_DOCS_GITLINK needs to remember to depend on the "config/" and
"howto/" directories, because that's where we keep source files. It
would be easy to add a source file to DOC_DEP_TXT that mentions a new
subdirectory, but not realize it needs an extra rule.

If the macro magic went as far as actually mapping all of
LINT_DOCS_GITLINK into their .build/ dirname counterparts, and then
automatically generated the right rules, that would make it truly
turnkey. It would probably also be a pretty gross macro, but maybe worth
it if nobody ever needed to touch it. :)

At any rate, I don't think there's any urgency on that.

-Peff
