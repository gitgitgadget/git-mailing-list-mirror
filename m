Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D189B1F744
	for <e@80x24.org>; Tue, 12 Jul 2016 03:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbcGLD5Y (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 23:57:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:43270 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932161AbcGLD5X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 23:57:23 -0400
Received: (qmail 10576 invoked by uid 102); 12 Jul 2016 03:57:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jul 2016 23:57:24 -0400
Received: (qmail 4883 invoked by uid 107); 12 Jul 2016 03:57:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jul 2016 23:57:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jul 2016 23:57:19 -0400
Date:	Mon, 11 Jul 2016 23:57:19 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
Message-ID: <20160712035719.GA30281@sigill.intra.peff.net>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
 <87lh17kgdy.fsf@linux-m68k.org>
 <20160711235417.GA26163@sigill.intra.peff.net>
 <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 11, 2016 at 06:59:51PM -0700, Junio C Hamano wrote:

> > diff --git a/help.c b/help.c
> > index 19328ea..0cea240 100644
> > --- a/help.c
> > +++ b/help.c
> > @@ -419,6 +419,13 @@ int cmd_version(int argc, const char **argv, const char *prefix)
> >  	 * with external projects that rely on the output of "git version".
> >  	 */
> >  	printf("git version %s\n", git_version_string);
> > +	while (*++argv) {
> > +		if (!strcmp(*argv, "--build-options")) {
> > +			printf("sizeof-unsigned-long: %d",
> > +			       (int)sizeof(unsigned long));
> > +			/* maybe also save and output GIT-BUILD_OPTIONS? */
> > +		}
> > +	}
> >  	return 0;
> >  }
> 
> I had the same thought, except that I would have expected this to go
> to one of these test-* helpers, and then a lazy prereq for 64-bit
> time_t would be written on top of it to skip these new tests.

Yeah, that would certainly work.

However, I was thinking that it might be handy to have this and some
other information available for helping with debugging. E.g., that we
could ask bug reporters for "git version --build-options" when we
suspect something related to their config.

Something along the lines of the patch below, which lets you do:

  $ ./git version --build-options
  git version 2.9.0.243.g5c589a7.dirty
  sizeof-unsigned-long: 8
  SHELL_PATH: /bin/sh
  PERL_PATH: /usr/bin/perl
  DIFF: diff
  PYTHON_PATH: /usr/bin/python
  TAR: tar
  NO_CURL: 
  NO_EXPAT: 
  USE_LIBPCRE: YesPlease
  NO_PERL: 
  NO_PYTHON: 
  NO_UNIX_SOCKETS: 
  GIT_TEST_OPTS: --root=/var/ram/git-tests
  NO_GETTEXT: Nope
  GETTEXT_POISON: 

That's not all of the knobs, though; it's just what we stick in
BUILD-OPTIONS to trigger script rebuilds and communicate with the test
scripts. So I think there would potentially be further work to do. But
it's at least a start. I dunno.

> It is somewhat disturbing that nobody seems to be regularly building
> on 32-bit platforms these days, which is the only reason I can think
> of why this was never reported until it hit a maintenance track.
> This should have been caught last week at f6a729f3 (Merge branch
> 'jk/tzoffset-fix', 2016-07-06) when the topic hit 'master' at the
> latest, and more preferrably it should have already been caught last
> month at 08ec8c5e (Merge branch 'jk/tzoffset-fix' into next,
> 2016-06-28).

I dream of a world where there are no 32-bit platforms at all, but sadly
we are stuck in the middle ground where they are rare enough that nobody
bothers to test on them early, but not rare enough that somebody doesn't
complain within 24 hours of making a release. :-/

-Peff

---
diff --git a/Makefile b/Makefile
index de5a030..78d96a0 100644
--- a/Makefile
+++ b/Makefile
@@ -669,6 +669,7 @@ XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
 
 GENERATED_H += common-cmds.h
+GENERATED_H += build-options.h
 
 LIB_H = $(shell $(FIND) . \
 	-name .git -prune -o \
@@ -1711,7 +1712,7 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) git.o \
 		$(BUILTIN_OBJS) $(LIBS)
 
-help.sp help.s help.o: common-cmds.h
+help.sp help.s help.o: common-cmds.h build-options.h
 
 builtin/help.sp builtin/help.s builtin/help.o: common-cmds.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
@@ -1735,6 +1736,9 @@ common-cmds.h: generate-cmdlist.sh command-list.txt
 common-cmds.h: $(wildcard Documentation/git-*.txt)
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt >$@+ && mv $@+ $@
 
+build-options.h: generate-build-options.sh GIT-BUILD-OPTIONS
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-build-options.sh GIT-BUILD-OPTIONS >$@+ && mv $@+ $@
+
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
 	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP)
diff --git a/generate-build-options.sh b/generate-build-options.sh
new file mode 100644
index 0000000..250728f
--- /dev/null
+++ b/generate-build-options.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+c_quote () {
+	printf '%s' "$1" |
+	sed -e 's/\\/\\\\/g' -e 's/"/\\"/g'
+}
+
+echo '#ifndef BUILD_OPTIONS_H'
+echo '#define BUILD_OPTIONS_H'
+echo "/* Automatically generated by $0 */"
+echo
+echo '#define BUILD_OPTIONS \'
+
+for source in "$@"; do
+	# source/eval trickery is there to unquote the values
+	. "./$source"
+	for var in $(cut -d= -f1 "$source"); do
+		printf '"%s: ' "$var"
+		eval "c_quote \"\$$var\""
+		printf '\\n" \\\n'
+	done
+done
+
+echo
+echo '#endif /* BUILD_OPTIONS_H */'
diff --git a/help.c b/help.c
index 19328ea..1cbee86 100644
--- a/help.c
+++ b/help.c
@@ -8,6 +8,7 @@
 #include "column.h"
 #include "version.h"
 #include "refs.h"
+#include "build-options.h"
 
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
@@ -419,6 +420,13 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 	 * with external projects that rely on the output of "git version".
 	 */
 	printf("git version %s\n", git_version_string);
+	while (*++argv) {
+		if (!strcmp(*argv, "--build-options")) {
+			printf("sizeof-unsigned-long: %d\n",
+			       (int)sizeof(unsigned long));
+			printf("%s", BUILD_OPTIONS);
+		}
+	}
 	return 0;
 }
 
