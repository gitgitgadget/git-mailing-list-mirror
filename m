Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FF5C433FE
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 07:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B36C760F0F
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 07:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhJZHeJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 03:34:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:46490 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhJZHeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 03:34:09 -0400
Received: (qmail 8367 invoked by uid 109); 26 Oct 2021 07:31:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Oct 2021 07:31:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4263 invoked by uid 111); 26 Oct 2021 07:31:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Oct 2021 03:31:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Oct 2021 03:31:44 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation/Makefile: fix lint-docs mkdir dependency
Message-ID: <YXeu4Hl2cmIPqobd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 8650c6298c (doc lint: make "lint-docs" non-.PHONY, 2021-10-15), we
put the output for gitlink linter into .build/lint-docs/gitlink. There
are order-only dependencies to create the sequence of subdirs like:

  .build/lint-docs: | .build
          $(QUIET)mkdir $@
  .build/lint-docs/gitlink: | .build/lint-docs
          $(QUIET)mkdir $@

where each level has to depend on the prior one (since the parent
directory must exist for us to create something inside it). But the
"howto" and "config" subdirectories of gitlink have the wrong
dependency; they depend on "lint-docs", not "lint-docs/gitlink".

This usually works out, because the LINT_DOCS_GITLINK targets which
depend on "gitlink/howto" also depend on just "gitlink", so the
directory gets created anyway. But since we haven't given make an
explicit ordering, things can racily happen out of order.

If you stick a "sleep 1" in the rule to build "gitlink" like this:

   ## Lint: gitlink
   .build/lint-docs/gitlink: | .build/lint-docs
  -	$(QUIET)mkdir $@
  +	$(QUIET)sleep 1 && mkdir $@

then "make clean; make lint-docs" will fail reliably. Or you can see it
as-is just by building the directory in isolation:

  $ make clean
  [...]
  $ make .build/lint-docs/gitlink/howto
      GEN mergetools-list.made
      GEN cmd-list.made
      GEN doc.dep
      SUBDIR ../
  make[1]: 'GIT-VERSION-FILE' is up to date.
      SUBDIR ../
  make[1]: 'GIT-VERSION-FILE' is up to date.
  mkdir: cannot create directory ‘.build/lint-docs/gitlink/howto’: No such file or directory
  make: *** [Makefile:476: .build/lint-docs/gitlink/howto] Error 1

The fix is easy: we just need to depend on the correct parent directory.

Signed-off-by: Jeff King <peff@peff.net>
---
The problem starts in ab/fix-make-lint-docs, which is in master.

I wasn't able to trigger the problem locally even with running 'make
clean; make lint-docs' in a loop, but I did see it in the wild in a CI
documentation job:

  https://github.com/peff/git/runs/4005766641?check_suite_focus=true#step:4:60

It would have been a lot easier to diagnose from the CI output if the
mkdir lines weren't silent. I.e., if we had a $(QUIET_MKDIR) which
printed "MKDIR $@" rather than nothing at all.

 Documentation/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 911b6bf79c..ed656db2ae 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -472,9 +472,9 @@ print-man1:
 ## Lint: gitlink
 .build/lint-docs/gitlink: | .build/lint-docs
 	$(QUIET)mkdir $@
-.build/lint-docs/gitlink/howto: | .build/lint-docs
+.build/lint-docs/gitlink/howto: | .build/lint-docs/gitlink
 	$(QUIET)mkdir $@
-.build/lint-docs/gitlink/config: | .build/lint-docs
+.build/lint-docs/gitlink/config: | .build/lint-docs/gitlink
 	$(QUIET)mkdir $@
 LINT_DOCS_GITLINK = $(patsubst %.txt,.build/lint-docs/gitlink/%.ok,$(HOWTO_TXT) $(DOC_DEP_TXT))
 $(LINT_DOCS_GITLINK): | .build/lint-docs/gitlink
-- 
2.33.1.1387.g97d4a0c3a8
