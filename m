Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427C2C388F2
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 03:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4E121481
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 03:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895349AbgJVDYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 23:24:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:39068 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443787AbgJVDYD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 23:24:03 -0400
Received: (qmail 14099 invoked by uid 109); 22 Oct 2020 03:24:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Oct 2020 03:24:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23760 invoked by uid 111); 22 Oct 2020 03:24:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Oct 2020 23:24:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Oct 2020 23:24:00 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Nikos Chantziaras <realnc@gmail.com>
Subject: Re: [PATCH] svn: use correct variable name for short OID
Message-ID: <20201022032400.GC1480820@coredump.intra.peff.net>
References: <rmpve5$q2s$1@ciao.gmane.io>
 <20201022011811.853465-1-sandals@crustytoothpaste.net>
 <20201022030051.GB1480820@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022030051.GB1480820@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 21, 2020 at 11:00:51PM -0400, Jeff King wrote:

> None of that changes the fix, which is obviously correct, but I wondered
> if we ought to have better test coverage here. And I've convinced myself
> the answer is "no"; there's no reasonable-to-test functional impact of
> this bug or its fix (aside from generating the warning, but it would be
> silly to write a test for this one warning; if we do anything it should
> be to complain about any warnings during the test run).

We talked about it enough that I was curious how bad the patch would
look. So here it is. It does catch the problem in DEVELOPER=1 mode, but
not otherwise.

The fact that we have to touch every perl file is a bit ugly. So I
dunno. Maybe worth it, or maybe too nasty.

-- >8 --
Subject: [PATCH] perl: check for perl warnings while running tests

We set "use warnings" in most of our perl code to catch problems. But as
the name implies, warnings just emit a message to stderr and don't
otherwise affect the program. So our tests are quite likely to miss that
warnings are being spewed, as most of them do not look at stderr.

We could ask perl to make all warnings fatal, but this is likely
annoying for non-developers, who would rather have a running program
with a warning than something that refuses to work at all.

So instead, let's teach the perl code to respect an environment variable
(GIT_PERL_FATAL_WARNINGS) to increase the severity of the warnings. This
can be set for day-to-day running if people want to be really pedantic,
but the primary use is to trigger it within the test suite.

We could also trigger that for every test run, but likewise even the
tests failing may be annoying to distro builders, etc (just as -Werror
would be for compiling C code). So we'll tie it to a special test-mode
variable (GIT_TEST_PERL_FATAL_WARNINGS) that can be set in the
environment or as a Makefile knob, and we'll automatically turn the knob
when DEVELOPER=1 is set. That should give developers and CI the more
careful view without disrupting normal users or packagers.

Note that the mapping from the GIT_TEST_* form to the GIT_* form in
test-lib.sh is necessary even if they had the same name: the perl
scripts need it to be normalized to a perl truth value, and we also have
to make sure it's exported (we might have gotten it from the
environment, but we might also have gotten it from GIT-BUILD-OPTIONS
directly).

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile                          | 3 +++
 config.mak.dev                    | 2 ++
 git-svn.perl                      | 2 +-
 perl/FromCPAN/Error.pm            | 2 +-
 perl/Git.pm                       | 2 +-
 perl/Git/I18N.pm                  | 2 +-
 perl/Git/IndexInfo.pm             | 2 +-
 perl/Git/LoadCPAN.pm              | 2 +-
 perl/Git/LoadCPAN/Error.pm        | 2 +-
 perl/Git/LoadCPAN/Mail/Address.pm | 2 +-
 perl/Git/Packet.pm                | 2 +-
 perl/Git/SVN.pm                   | 2 +-
 perl/Git/SVN/Editor.pm            | 2 +-
 perl/Git/SVN/Fetcher.pm           | 2 +-
 perl/Git/SVN/GlobSpec.pm          | 2 +-
 perl/Git/SVN/Log.pm               | 2 +-
 perl/Git/SVN/Memoize/YAML.pm      | 2 +-
 perl/Git/SVN/Migration.pm         | 2 +-
 perl/Git/SVN/Prompt.pm            | 2 +-
 perl/Git/SVN/Ra.pm                | 2 +-
 perl/Git/SVN/Utils.pm             | 2 +-
 t/test-lib.sh                     | 6 ++++++
 22 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 95571ee3fc..4d6f6dc16f 100644
--- a/Makefile
+++ b/Makefile
@@ -2767,6 +2767,9 @@ ifdef GIT_INTEROP_MAKE_OPTS
 endif
 ifdef GIT_TEST_INDEX_VERSION
 	@echo GIT_TEST_INDEX_VERSION=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_INDEX_VERSION)))'\' >>$@+
+endif
+ifdef GIT_TEST_PERL_FATAL_WARNINGS
+	@echo GIT_TEST_PERL_FATAL_WARNINGS=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_PERL_FATAL_WARNINGS)))'\' >>$@+
 endif
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
 
diff --git a/config.mak.dev b/config.mak.dev
index 89b218d11a..89db543534 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -45,3 +45,5 @@ ifeq ($(filter gcc5,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS += -Wno-uninitialized
 endif
 endif
+
+GIT_TEST_PERL_FATAL_WARNINGS = YesPlease
diff --git a/git-svn.perl b/git-svn.perl
index 58f5a7ac8f..70cb5e2a83 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2,7 +2,7 @@
 # Copyright (C) 2006, Eric Wong <normalperson@yhbt.net>
 # License: GPL v2 or later
 use 5.008;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use strict;
 use vars qw/	$AUTHOR $VERSION
 		$oid $oid_short $oid_length
diff --git a/perl/FromCPAN/Error.pm b/perl/FromCPAN/Error.pm
index 8b95e2d73d..d82b71325c 100644
--- a/perl/FromCPAN/Error.pm
+++ b/perl/FromCPAN/Error.pm
@@ -12,7 +12,7 @@
 package Error;
 
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 
 use vars qw($VERSION);
 use 5.004;
diff --git a/perl/Git.pm b/perl/Git.pm
index 10df990959..02eacef0c2 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -9,7 +9,7 @@ package Git;
 
 use 5.008;
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 
 use File::Temp ();
 use File::Spec ();
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index bfb4fb67a1..2037f387c8 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -1,7 +1,7 @@
 package Git::I18N;
 use 5.008;
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 BEGIN {
 	require Exporter;
 	if ($] < 5.008003) {
diff --git a/perl/Git/IndexInfo.pm b/perl/Git/IndexInfo.pm
index 2a7b4908f3..9ee054f854 100644
--- a/perl/Git/IndexInfo.pm
+++ b/perl/Git/IndexInfo.pm
@@ -1,6 +1,6 @@
 package Git::IndexInfo;
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use Git qw/command_input_pipe command_close_pipe/;
 
 sub new {
diff --git a/perl/Git/LoadCPAN.pm b/perl/Git/LoadCPAN.pm
index e5585e75e8..0c360bc799 100644
--- a/perl/Git/LoadCPAN.pm
+++ b/perl/Git/LoadCPAN.pm
@@ -1,7 +1,7 @@
 package Git::LoadCPAN;
 use 5.008;
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 
 =head1 NAME
 
diff --git a/perl/Git/LoadCPAN/Error.pm b/perl/Git/LoadCPAN/Error.pm
index c6d2c45d80..5d84c20288 100644
--- a/perl/Git/LoadCPAN/Error.pm
+++ b/perl/Git/LoadCPAN/Error.pm
@@ -1,7 +1,7 @@
 package Git::LoadCPAN::Error;
 use 5.008;
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use Git::LoadCPAN (
 	module => 'Error',
 	import => 1,
diff --git a/perl/Git/LoadCPAN/Mail/Address.pm b/perl/Git/LoadCPAN/Mail/Address.pm
index f70a4f064c..340e88a7a5 100644
--- a/perl/Git/LoadCPAN/Mail/Address.pm
+++ b/perl/Git/LoadCPAN/Mail/Address.pm
@@ -1,7 +1,7 @@
 package Git::LoadCPAN::Mail::Address;
 use 5.008;
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use Git::LoadCPAN (
 	module => 'Mail::Address',
 	import => 0,
diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
index b75738bed4..d144f5168f 100644
--- a/perl/Git/Packet.pm
+++ b/perl/Git/Packet.pm
@@ -1,7 +1,7 @@
 package Git::Packet;
 use 5.008;
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 BEGIN {
 	require Exporter;
 	if ($] < 5.008003) {
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index d1c352f92b..f6f1dc03c6 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1,6 +1,6 @@
 package Git::SVN;
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use Fcntl qw/:DEFAULT :seek/;
 use constant rev_map_fmt => 'NH*';
 use vars qw/$_no_metadata
diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index c961444d4c..47fd048bf2 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -1,7 +1,7 @@
 package Git::SVN::Editor;
 use vars qw/@ISA $_rmdir $_cp_similarity $_find_copies_harder $_rename_limit/;
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use SVN::Core;
 use SVN::Delta;
 use Carp qw/croak/;
diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 729e5337df..968309e6d6 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -3,7 +3,7 @@ package Git::SVN::Fetcher;
             $_placeholder_filename @deleted_gpath %added_placeholder
             $repo_id/;
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use SVN::Delta;
 use Carp qw/croak/;
 use File::Basename qw/dirname/;
diff --git a/perl/Git/SVN/GlobSpec.pm b/perl/Git/SVN/GlobSpec.pm
index a0a8d17621..f2c1e1f6fb 100644
--- a/perl/Git/SVN/GlobSpec.pm
+++ b/perl/Git/SVN/GlobSpec.pm
@@ -1,6 +1,6 @@
 package Git::SVN::GlobSpec;
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 
 sub new {
 	my ($class, $glob, $pattern_ok) = @_;
diff --git a/perl/Git/SVN/Log.pm b/perl/Git/SVN/Log.pm
index 3858fcf27d..6cd4cdfceb 100644
--- a/perl/Git/SVN/Log.pm
+++ b/perl/Git/SVN/Log.pm
@@ -1,6 +1,6 @@
 package Git::SVN::Log;
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use Git::SVN::Utils qw(fatal);
 use Git qw(command
            command_oneline
diff --git a/perl/Git/SVN/Memoize/YAML.pm b/perl/Git/SVN/Memoize/YAML.pm
index 9676b8f2f7..8fcf6644a1 100644
--- a/perl/Git/SVN/Memoize/YAML.pm
+++ b/perl/Git/SVN/Memoize/YAML.pm
@@ -1,5 +1,5 @@
 package Git::SVN::Memoize::YAML;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use strict;
 use YAML::Any ();
 
diff --git a/perl/Git/SVN/Migration.pm b/perl/Git/SVN/Migration.pm
index dc90f6a621..ed96ac593e 100644
--- a/perl/Git/SVN/Migration.pm
+++ b/perl/Git/SVN/Migration.pm
@@ -33,7 +33,7 @@ package Git::SVN::Migration;
 #              possible if noMetadata or useSvmProps are set; but should
 #              be no problem for users that use the (sensible) defaults.
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use Carp qw/croak/;
 use File::Path qw/mkpath/;
 use File::Basename qw/dirname basename/;
diff --git a/perl/Git/SVN/Prompt.pm b/perl/Git/SVN/Prompt.pm
index e940b08505..de158e848f 100644
--- a/perl/Git/SVN/Prompt.pm
+++ b/perl/Git/SVN/Prompt.pm
@@ -1,6 +1,6 @@
 package Git::SVN::Prompt;
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 require SVN::Core;
 use vars qw/$_no_auth_cache $_username/;
 
diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 2cfe055a9a..912e035040 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -1,7 +1,7 @@
 package Git::SVN::Ra;
 use vars qw/@ISA $config_dir $_ignore_refs_regex $_log_window_size/;
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use Memoize;
 use Git::SVN::Utils qw(
 	canonicalize_url
diff --git a/perl/Git/SVN/Utils.pm b/perl/Git/SVN/Utils.pm
index 3d1a0933a2..5ca09ab448 100644
--- a/perl/Git/SVN/Utils.pm
+++ b/perl/Git/SVN/Utils.pm
@@ -1,7 +1,7 @@
 package Git::SVN::Utils;
 
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 
 use SVN::Core;
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ef31f40037..dfad820dd4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -499,6 +499,12 @@ then
 	export GIT_INDEX_VERSION
 fi
 
+if test -n "$GIT_TEST_PERL_FATAL_WARNINGS"
+then
+	GIT_PERL_FATAL_WARNINGS=1
+	export GIT_PERL_FATAL_WARNINGS
+fi
+
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
 if test -n "$valgrind" ||
-- 
2.29.0.579.g559558a5ea

