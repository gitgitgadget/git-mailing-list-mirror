From: Jeff King <peff@peff.net>
Subject: [RFC PATCH 1/5] add valgrind support in test scripts
Date: Wed, 22 Oct 2008 16:29:15 -0400
Message-ID: <20081022202915.GA4547@coredump.intra.peff.net>
References: <20081022202810.GA4439@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 22:30:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KskLf-0007PS-8n
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 22:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbYJVU3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 16:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752343AbYJVU3S
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 16:29:18 -0400
Received: from peff.net ([208.65.91.99]:3568 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752298AbYJVU3R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 16:29:17 -0400
Received: (qmail 4129 invoked by uid 111); 22 Oct 2008 20:29:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 22 Oct 2008 16:29:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 16:29:15 -0400
Content-Disposition: inline
In-Reply-To: <20081022202810.GA4439@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98899>

This patch adds the ability to use valgrind's memcheck tool
to diagnose memory problems in git while running the test
scripts. It works by placing a "fake" git in the front of
the test script's PATH; this fake git runs the real git
under valgrind. It also points the exec-path such that any
stand-alone dashed git programs are run using the same
script. In this way we avoid having to modify the actual git
code in any way.

The memcheck tool can be used by specifying
"GIT_TEST_OPTS=--memcheck" in the make invocation. Any
invocation of git that finds any errors under valgrind will
exit with failure code 126. Any valgrind output will go to
the usual stderr channel for tests (i.e., /dev/null, unless
-v has been specified).

A few default suppressions are included, since libz seems to
trigger quite a few false positives. We'll assume that libz
works and that we can ignore any errors which are reported
there.

Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore              |    1 +
 Makefile                |   12 ++++++++++--
 t/test-lib.sh           |   11 +++++++++++
 t/valgrind/.gitignore   |    1 +
 t/valgrind/default.supp |   21 +++++++++++++++++++++
 test-valgrind.sh        |   24 ++++++++++++++++++++++++
 6 files changed, 68 insertions(+), 2 deletions(-)
 create mode 100644 t/valgrind/.gitignore
 create mode 100644 t/valgrind/default.supp
 create mode 100755 test-valgrind.sh

diff --git a/.gitignore b/.gitignore
index bbaf9de..45045cb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -151,6 +151,7 @@ test-match-trees
 test-parse-options
 test-path-utils
 test-sha1
+test-valgrind
 common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index d6f3695..68f0172 100644
--- a/Makefile
+++ b/Makefile
@@ -279,6 +279,8 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	  git-instaweb
 
+VALGRIND_SH += test-valgrind.sh
+
 # Empty...
 EXTRA_PROGRAMS =
 
@@ -1139,7 +1141,7 @@ common-cmds.h: ./generate-cmdlist.sh command-list.txt
 common-cmds.h: $(wildcard Documentation/git-*.txt)
 	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
 
-$(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
+$(patsubst %.sh,%,$(SCRIPT_SH) $(VALGRIND_SH)) : % : %.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
@@ -1343,7 +1345,12 @@ all:: $(TEST_PROGRAMS)
 
 export NO_SVN_TESTS
 
-test: all
+valgrind-setup: $(patsubst %.sh,%,$(VALGRIND_SH))
+	rm -rf t/valgrind/bin
+	mkdir t/valgrind/bin
+	for i in git $(PROGRAMS); do cp test-valgrind t/valgrind/bin/$$i; done
+
+test: all valgrind-setup
 	$(MAKE) -C t/ all
 
 test-date$X: date.o ctype.o
@@ -1501,6 +1508,7 @@ endif
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: .FORCE-GIT-VERSION-FILE TAGS tags cscope .FORCE-GIT-CFLAGS
 .PHONY: .FORCE-GIT-BUILD-OPTIONS
+.PHONY: valgrind-setup
 
 ### Check documentation
 #
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8936173..e753654 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -94,6 +94,8 @@ do
 	--no-python)
 		# noop now...
 		shift ;;
+	-m|--m|--me|--mem|--memc|--memch|--memche|--memchec|--memcheck)
+		memcheck=t shift ;;
 	*)
 		break ;;
 	esac
@@ -468,6 +470,15 @@ test_done () {
 # t/ subdirectory and are run in 'trash directory' subdirectory.
 TEST_DIRECTORY=$(pwd)
 PATH=$TEST_DIRECTORY/..:$PATH
+if test -n "$memcheck"; then
+	PATH=$TEST_DIRECTORY/valgrind/bin:$PATH
+	GIT_VALGRIND=$TEST_DIRECTORY/valgrind; export GIT_VALGRIND
+	if ! test -f "$GIT_VALGRIND/bin/git"; then
+		echo >&2 'You need to setup the valgrind bin:'
+		echo >&2 'Run "make valgrind-setup" in the (toplevel) directory'
+		exit 1
+	fi
+fi
 GIT_EXEC_PATH=$(pwd)/..
 GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
 unset GIT_CONFIG
diff --git a/t/valgrind/.gitignore b/t/valgrind/.gitignore
new file mode 100644
index 0000000..ba077a4
--- /dev/null
+++ b/t/valgrind/.gitignore
@@ -0,0 +1 @@
+bin
diff --git a/t/valgrind/default.supp b/t/valgrind/default.supp
new file mode 100644
index 0000000..2482b3b
--- /dev/null
+++ b/t/valgrind/default.supp
@@ -0,0 +1,21 @@
+{
+	ignore-zlib-errors-cond
+	Memcheck:Cond
+	obj:*libz.so*
+}
+
+{
+	ignore-zlib-errors-value4
+	Memcheck:Value4
+	obj:*libz.so*
+}
+
+{
+	writing-data-from-zlib-triggers-errors
+	Memcheck:Param
+	write(buf)
+	obj:/lib/ld-*.so
+	fun:write_in_full
+	fun:write_buffer
+	fun:write_loose_object
+}
diff --git a/test-valgrind.sh b/test-valgrind.sh
new file mode 100755
index 0000000..61c1428
--- /dev/null
+++ b/test-valgrind.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+base=`echo $0 | sed 's,.*/,,'`
+case "$base" in
+git-*)
+	set -- "$GIT_EXEC_PATH/$base" "$@"
+	;;
+git)
+	set -- "$GIT_EXEC_PATH/git" --exec-path="$GIT_VALGRIND/bin" "$@"
+	;;
+*)
+	echo >&2 "test-valgrind invoked on non-git command: $0"
+	exit 1
+esac
+
+exec valgrind -q --error-exitcode=126 \
+	--leak-check=no \
+	--suppressions="$GIT_VALGRIND/default.supp" \
+	--gen-suppressions=all \
+	--log-fd=4 \
+	--input-fd=4 \
+	${GIT_VALGRIND_DEBUG:+--db-attach=yes} \
+	${GIT_VALGRIND_DEBUGCMD:+--db-command="$GIT_VALGRIND_DEBUGCMD"} \
+	"$@"
-- 
1.6.0.2.825.g6d19d
