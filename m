Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44273202C1
	for <e@80x24.org>; Sun, 12 Mar 2017 13:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932746AbdCLNCD (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 09:02:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:42840 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932241AbdCLNCC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 09:02:02 -0400
Received: (qmail 31357 invoked by uid 109); 12 Mar 2017 13:01:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 13:01:51 +0000
Received: (qmail 12584 invoked by uid 111); 12 Mar 2017 13:02:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 09:02:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Mar 2017 09:01:49 -0400
Date:   Sun, 12 Mar 2017 09:01:49 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] Move SHA-1 implementation selection into a header
 file
Message-ID: <20170312130149.czir5hcbosqlmkhb@sigill.intra.peff.net>
References: <20170311222818.518541-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170311222818.518541-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 11, 2017 at 10:28:18PM +0000, brian m. carlson wrote:

> Many developers use functionality in their editors that allows for quick
> syntax checks, including warning about questionable constructs.  This
> functionality allows rapid development with fewer errors.  However, such
> functionality generally does not allow the specification of
> project-specific defines or command-line options.
> 
> Since the SHA1_HEADER include is not defined in such a case, developers
> see spurious errors when using these tools.  Furthermore, while using a
> macro as the argument to #include is permitted by C11, it isn't
> permitted by C89 and C99, and there are known implementations which
> reject it.
> 
> Instead of using SHA1_HEADER, create a hash.h header and use #if
> and #elif to select the desired header.  Have the Makefile pass an
> appropriate option to help the header select the right implementation to
> use.

This has bit me once or twice in the past[1], too, so I'm happy to see
somebody tackling it.

Your solution does mean that your tool, whatever it is, that runs
without the same CFLAGS as the Makefile may get a _different_ sha1
implementation, though. That's probably good enough for some purposes
but perhaps not for others.

The "most correct" solution, I think, would be to stop using "-D" flags
in favor of actually generating hash.h. Something like the patch
below[2] (though I think it there are some rough edges with the
dependencies).

Of course the sha1 header is just one of many such defines. It's the one
that is most visible because the result is syntactically valid without
it, but anything you compile without the Makefile's CFLAGS may be subtly
different than what the Makefile would produce. So arguably the Makefile
should be writing out a build-options.h with all of the values, and that
should get pulled in by git-compat-util.h.

I don't know if we want to go down that rabbit hole or not. I offer it
merely as an alternative. I'm OK with your patch as-is if you don't want
to dump any more time into it.

-Peff

[1] I think I hit the problem when trying to debug some internal part of
    git and writing a one-off "foo.c" that calls the code I want. You
    can't compile it with "gcc foo.c".

[2] Here's what a patch for the generated-header might look like:

diff --git a/Makefile b/Makefile
index 9f0eae428..0d65d50e9 100644
--- a/Makefile
+++ b/Makefile
@@ -690,6 +690,7 @@ XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
 
 GENERATED_H += common-cmds.h
+GENERATED_H += hash.h
 
 LIB_H = $(shell $(FIND) . \
 	-name .git -prune -o \
@@ -1639,8 +1640,7 @@ PERLLIB_EXTRA_SQ = $(subst ','\'',$(PERLLIB_EXTRA))
 # from the dependency list, that would make each entry appear twice.
 LIBS = $(filter-out %.o, $(GITLIBS)) $(EXTLIBS)
 
-BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' \
-	$(COMPAT_CFLAGS)
+BASIC_CFLAGS += $(COMPAT_CFLAGS)
 LIB_OBJS += $(COMPAT_OBJS)
 
 # Quote for C
@@ -1781,7 +1781,7 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
-help.sp help.s help.o: common-cmds.h
+help.sp help.s help.o: common-cmds.h hash.h
 
 builtin/help.sp builtin/help.s builtin/help.o: common-cmds.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
@@ -1805,6 +1805,10 @@ common-cmds.h: generate-cmdlist.sh command-list.txt
 common-cmds.h: $(wildcard Documentation/git-*.txt)
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt >$@+ && mv $@+ $@
 
+hash.h:
+	$(QUIET_GEN)echo '#include $(SHA1_HEADER)' >$@+ && \
+	{ cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@; }
+
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
 	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV)
diff --git a/cache.h b/cache.h
index 0a14141fc..345104849 100644
--- a/cache.h
+++ b/cache.h
@@ -11,7 +11,7 @@
 #include "string-list.h"
 #include "pack-revindex.h"
 
-#include SHA1_HEADER
+#include "hash.h"
 #ifndef platform_SHA_CTX
 /*
  * platform's underlying implementation of SHA-1; could be OpenSSL,
