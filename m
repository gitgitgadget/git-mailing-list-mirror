Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEBE42022D
	for <e@80x24.org>; Sat, 25 Feb 2017 09:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbdBYJo4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 04:44:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:33953 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751625AbdBYJoz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 04:44:55 -0500
Received: (qmail 27726 invoked by uid 109); 25 Feb 2017 09:37:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 09:37:08 +0000
Received: (qmail 19396 invoked by uid 111); 25 Feb 2017 09:37:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 04:37:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Feb 2017 04:37:07 -0500
Date:   Sat, 25 Feb 2017 04:37:07 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] t: add an interoperability test harness
Message-ID: <20170225093707.egv3vc7szn57rhy4@sigill.intra.peff.net>
References: <20170225093231.k7jtvx47jieka7qm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170225093231.k7jtvx47jieka7qm@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current test suite is good at letting you test a
particular version of Git. But it's not very good at letting
you test _two_ versions and seeing how they interact (e.g.,
one cloning from the other).

This commit adds a test harness that will build two
arbitrary versions of git and make it easy to call them from
inside your tests. See the README and the example script for
details.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile                 |  3 ++
 t/interop/.gitignore     |  4 +++
 t/interop/Makefile       | 16 +++++++++
 t/interop/README         | 85 ++++++++++++++++++++++++++++++++++++++++++++
 t/interop/i0000-basic.sh | 27 ++++++++++++++
 t/interop/interop-lib.sh | 92 ++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 227 insertions(+)
 create mode 100644 t/interop/.gitignore
 create mode 100644 t/interop/Makefile
 create mode 100644 t/interop/README
 create mode 100755 t/interop/i0000-basic.sh
 create mode 100644 t/interop/interop-lib.sh

diff --git a/Makefile b/Makefile
index 8e4081e06..7156b051e 100644
--- a/Makefile
+++ b/Makefile
@@ -2254,6 +2254,9 @@ endif
 ifdef GIT_PERF_MAKE_OPTS
 	@echo GIT_PERF_MAKE_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_MAKE_OPTS)))'\' >>$@+
 endif
+ifdef GIT_INTEROP_MAKE_OPTS
+	@echo GIT_INTEROP_MAKE_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_INTEROP_MAKE_OPTS)))'\' >>$@+
+endif
 ifdef TEST_GIT_INDEX_VERSION
 	@echo TEST_GIT_INDEX_VERSION=\''$(subst ','\'',$(subst ','\'',$(TEST_GIT_INDEX_VERSION)))'\' >>$@+
 endif
diff --git a/t/interop/.gitignore b/t/interop/.gitignore
new file mode 100644
index 000000000..49c78d3db
--- /dev/null
+++ b/t/interop/.gitignore
@@ -0,0 +1,4 @@
+/trash directory*/
+/test-results/
+/.prove/
+/build/
diff --git a/t/interop/Makefile b/t/interop/Makefile
new file mode 100644
index 000000000..31a4bbc71
--- /dev/null
+++ b/t/interop/Makefile
@@ -0,0 +1,16 @@
+-include ../../config.mak
+export GIT_TEST_OPTIONS
+
+SHELL_PATH ?= $(SHELL)
+SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
+T = $(sort $(wildcard i[0-9][0-9][0-9][0-9]-*.sh))
+
+all: $(T)
+
+$(T):
+	@echo "*** $@ ***"; '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
+
+clean:
+	rm -rf build "trash directory".* test-results
+
+.PHONY: all clean $(T)
diff --git a/t/interop/README b/t/interop/README
new file mode 100644
index 000000000..72d42bd85
--- /dev/null
+++ b/t/interop/README
@@ -0,0 +1,85 @@
+Git version interoperability tests
+==================================
+
+This directory has interoperability tests for git. Each script is
+similar to the normal test scripts found in t/, but with the added twist
+that two special versions of git, "git.a" and "git.b", are available in
+the PATH. Individual tests can then check the interaction between the
+two versions.
+
+When you add a feature that handles backwards compatibility between git
+versions, it's encouraged to add a test here to make sure it behaves as
+you expect.
+
+
+Running Tests
+-------------
+
+The easiest way to run tests is to say "make".  This runs all
+the tests against their default versions.
+
+You can run a single test like:
+
+    $ ./i0000-basic.sh
+    ok 1 - bare git is forbidden
+    ok 2 - git.a version (v1.6.6.3)
+    ok 3 - git.b version (v2.11.1)
+    # passed all 3 test(s)
+    1..3
+
+Each test contains default versions to run against. You may override
+these by setting `GIT_TEST_VERSION_A` and `GIT_TEST_VERSION_B` in the
+environment. Note that not all combinations will give sensible outcomes
+for all tests (e.g., a test checking for a specific old/new interaction
+may want something "old" enough" and something "new" enough; see
+individual tests for details).
+
+Version names should be resolvable as revisions in the current
+repository. They will be exported and built as needed using the
+config.mak files found at the root of your working tree.
+
+The exception is the special version "." which uses the currently-built
+contents of your working tree.
+
+You can set the following variables (in the environment or in your config.mak):
+
+    GIT_INTEROP_MAKE_OPTS
+	Options to pass to `make` when building a git version (e.g.,
+	`-j8`).
+
+You can also pass any command-line options taken by ordinary git tests (e.g.,
+"-v").
+
+
+Naming Tests
+------------
+
+The interop test files are named like:
+
+	iNNNN-short-description.sh
+
+where N is a decimal digit.  The same conventions for choosing NNNN as
+for normal tests apply.
+
+
+Writing Tests
+-------------
+
+An interop test script starts like a normal script, declaring a few
+variables and then including interop-lib.sh (which includes test-lib.sh).
+Besides test_description, you should also set the $VERSION_A and $VERSION_B
+variables to give the default versions to test against. See t0000-basic.sh for
+an example.
+
+You can then use test_expect_success as usual, with a few differences:
+
+  1. The special commands "git.a" and "git.b" correspond to the
+     two versions.
+
+  2. You cannot call a bare "git". This is to prevent accidents where
+     you meant "git.a" or "git.b".
+
+  3. The trash directory is _not_ a git repository by default. You
+     should create one with the appropriate version of git.
+
+At the end of the script, call test_done as usual.
diff --git a/t/interop/i0000-basic.sh b/t/interop/i0000-basic.sh
new file mode 100755
index 000000000..903e9193f
--- /dev/null
+++ b/t/interop/i0000-basic.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+# Note that this test only works on real version numbers,
+# as it depends on matching the output to "git version".
+VERSION_A=v1.6.6.3
+VERSION_B=v2.11.1
+
+test_description='sanity test interop library'
+. ./interop-lib.sh
+
+test_expect_success 'bare git is forbidden' '
+	test_must_fail git version
+'
+
+test_expect_success "git.a version ($VERSION_A)" '
+	echo git version ${VERSION_A#v} >expect &&
+	git.a version >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "git.b version ($VERSION_B)" '
+	echo git version ${VERSION_B#v} >expect &&
+	git.b version >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/t/interop/interop-lib.sh b/t/interop/interop-lib.sh
new file mode 100644
index 000000000..7f31d9cc6
--- /dev/null
+++ b/t/interop/interop-lib.sh
@@ -0,0 +1,92 @@
+# Interoperability testing framework. Each script should source
+# this after setting default $VERSION_A and $VERSION_B variables.
+
+. ../../GIT-BUILD-OPTIONS
+INTEROP_ROOT=$(pwd)
+BUILD_ROOT=$INTEROP_ROOT/build
+
+build_version() {
+	if test -z "$1"
+	then
+		echo >&2 "error: test script did not set default versions"
+		return 1
+	fi
+
+	if test "$1" = "."
+	then
+		git rev-parse --show-toplevel
+		return 0
+	fi
+
+	sha1=$(git rev-parse "$1^{tree}") || return 1
+	dir=$BUILD_ROOT/$sha1
+
+	if test -e "$dir/.built"
+	then
+		echo "$dir"
+		return 0
+	fi
+
+	echo >&2 "==> Building $1..."
+
+	mkdir -p "$dir" || return 1
+
+	(cd "$(git rev-parse --show-cdup)" && git archive --format=tar "$sha1") |
+	(cd "$dir" && tar x) ||
+	return 1
+
+	for config in config.mak config.mak.autogen config.status
+	do
+		if test -e "$INTEROP_ROOT/../../$config"
+		then
+			cp "$INTEROP_ROOT/../../$config" "$dir/" || return 1
+		fi
+	done
+
+	(
+		cd "$dir" &&
+		make $GIT_INTEROP_MAKE_OPTS >&2 &&
+		touch .built
+	) || return 1
+
+	echo "$dir"
+}
+
+# Old versions of git don't have bin-wrappers, so let's give a rough emulation.
+wrap_git() {
+	write_script "$1" <<-EOF
+	GIT_EXEC_PATH="$2"
+	export GIT_EXEC_PATH
+	PATH="$2:\$PATH"
+	export GIT_EXEC_PATH
+	exec git "\$@"
+	EOF
+}
+
+generate_wrappers() {
+	mkdir -p .bin &&
+	wrap_git .bin/git.a "$DIR_A" &&
+	wrap_git .bin/git.b "$DIR_B" &&
+	write_script .bin/git <<-\EOF &&
+	echo >&2 fatal: test tried to run generic git
+	exit 1
+	EOF
+	PATH=$(pwd)/.bin:$PATH
+}
+
+VERSION_A=${GIT_TEST_VERSION_A:-$VERSION_A}
+VERSION_B=${GIT_TEST_VERSION_B:-$VERSION_B}
+
+if ! DIR_A=$(build_version "$VERSION_A") ||
+   ! DIR_B=$(build_version "$VERSION_B")
+then
+	echo >&2 "fatal: unable to build git versions"
+	exit 1
+fi
+
+TEST_DIRECTORY=$INTEROP_ROOT/..
+TEST_OUTPUT_DIRECTORY=$INTEROP_ROOT
+TEST_NO_CREATE_REPO=t
+. "$TEST_DIRECTORY"/test-lib.sh
+
+generate_wrappers || die "unable to set up interop test environment"
-- 
2.12.0.616.g5f622f3b1

