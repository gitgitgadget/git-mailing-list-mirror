Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB4741F954
	for <e@80x24.org>; Fri, 17 Aug 2018 19:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeHQWHu (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 18:07:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:59090 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727995AbeHQWHu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 18:07:50 -0400
Received: (qmail 4401 invoked by uid 109); 17 Aug 2018 19:03:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Aug 2018 19:03:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27616 invoked by uid 111); 17 Aug 2018 19:03:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 17 Aug 2018 15:03:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Aug 2018 15:03:10 -0400
Date:   Fri, 17 Aug 2018 15:03:10 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] drop vcs-svn experiment
Message-ID: <20180817190310.GA5360@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code in vcs-svn was started in 2010 as an attempt to
build a remote-helper for interacting with svn repositories
(as opposed to git-svn). However, we never got as far as
shipping a mature remote helper, and the last substantive
commit was e99d012a6bc in 2012.

We do have a git-remote-testsvn, and it is even installed as
part of "make install". But given the name, it seems
unlikely to be used by anybody (you'd have to explicitly
"git clone testsvn::$url", and there have been zero mentions
of that on the mailing list since 2013, and even that
includes the phrase "you might need to hack a bit to get it
working properly"[1]).

We also ship contrib/svn-fe, which builds on the vcs-svn
work. However, it does not seem to build out of the box for
me, as the link step misses some required libraries for
using libgit.a. Curiously, the original build breakage
bisects for me to eff80a9fd9 (Allow custom "comment char",
2013-01-16), which seems unrelated. There was an attempt to
fix it in da011cb0e7 (contrib/svn-fe: fix Makefile,
2014-08-28), but on my system that only switches the error
message.

So it seems like the result is not really usable by anybody
in practice. It would be wonderful if somebody wanted to
pick up the topic again, and potentially it's worth carrying
around for that reason. But the flip side is that people
doing a tree-wide operations have to deal with this code.
And you can see the list with (replace "HEAD" with this
commit as appropriate):

  {
    echo "--"
    git diff-tree --diff-filter=D -r --name-only HEAD^ HEAD
  } |
  git log e99d012a6bc.. --stdin

which shows 58 times somebody had to deal with the code,
generally due to a compile or test failure, or a tree-wide
style fix or API change. Let's drop it and let anybody who
wants to pick it up do so by resurrecting it from the git
history.

[1] https://public-inbox.org/git/CALkWK0mPHzKfzFKKpZkfAus3YVC9NFYDbFnt+5JQYVKipk3bQQ@mail.gmail.com/

Signed-off-by: Jeff King <peff@peff.net>
---
Of course, I could be completely wrong about people using this. Maybe
svn-fe builds are just completely broken on my system, and maybe people
really do use testsvn::. But if so, they certainly aren't talking about
it on the mailing list. :)

I'm cc-ing Jonathan as the only currently-active developer who seems to
have put significant work into this code. Maybe you have a more informed
opinion.

 .gitignore                     |   1 -
 Makefile                       |  22 --
 contrib/svn-fe/.gitignore      |   4 -
 contrib/svn-fe/Makefile        | 105 -------
 contrib/svn-fe/svn-fe.c        |  18 --
 contrib/svn-fe/svn-fe.txt      |  71 -----
 contrib/svn-fe/svnrdump_sim.py |  68 -----
 remote-testsvn.c               | 337 --------------------
 t/helper/test-line-buffer.c    |  81 -----
 t/helper/test-svn-fe.c         |  52 ----
 t/t9020-remote-svn.sh          |  89 ------
 vcs-svn/LICENSE                |  32 --
 vcs-svn/fast_export.c          | 365 ----------------------
 vcs-svn/fast_export.h          |  34 ---
 vcs-svn/line_buffer.c          | 126 --------
 vcs-svn/line_buffer.h          |  30 --
 vcs-svn/line_buffer.txt        |  77 -----
 vcs-svn/sliding_window.c       |  79 -----
 vcs-svn/sliding_window.h       |  18 --
 vcs-svn/svndiff.c              | 309 -------------------
 vcs-svn/svndiff.h              |  10 -
 vcs-svn/svndump.c              | 540 ---------------------------------
 vcs-svn/svndump.h              |  10 -
 23 files changed, 2478 deletions(-)
 delete mode 100644 contrib/svn-fe/.gitignore
 delete mode 100644 contrib/svn-fe/Makefile
 delete mode 100644 contrib/svn-fe/svn-fe.c
 delete mode 100644 contrib/svn-fe/svn-fe.txt
 delete mode 100755 contrib/svn-fe/svnrdump_sim.py
 delete mode 100644 remote-testsvn.c
 delete mode 100644 t/helper/test-line-buffer.c
 delete mode 100644 t/helper/test-svn-fe.c
 delete mode 100755 t/t9020-remote-svn.sh
 delete mode 100644 vcs-svn/LICENSE
 delete mode 100644 vcs-svn/fast_export.c
 delete mode 100644 vcs-svn/fast_export.h
 delete mode 100644 vcs-svn/line_buffer.c
 delete mode 100644 vcs-svn/line_buffer.h
 delete mode 100644 vcs-svn/line_buffer.txt
 delete mode 100644 vcs-svn/sliding_window.c
 delete mode 100644 vcs-svn/sliding_window.h
 delete mode 100644 vcs-svn/svndiff.c
 delete mode 100644 vcs-svn/svndiff.h
 delete mode 100644 vcs-svn/svndump.c
 delete mode 100644 vcs-svn/svndump.h

diff --git a/.gitignore b/.gitignore
index 3524803da5..fe022dbeb0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -131,7 +131,6 @@
 /git-remote-ext
 /git-remote-testgit
 /git-remote-testpy
-/git-remote-testsvn
 /git-repack
 /git-replace
 /git-request-pull
diff --git a/Makefile b/Makefile
index e3364a42a5..8a890e28e9 100644
--- a/Makefile
+++ b/Makefile
@@ -695,7 +695,6 @@ PROGRAM_OBJS += http-backend.o
 PROGRAM_OBJS += imap-send.o
 PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += shell.o
-PROGRAM_OBJS += remote-testsvn.o
 
 # Binary suffix, set to .exe for Windows builds
 X =
@@ -743,10 +742,8 @@ TEST_BUILTINS_OBJS += test-write-cache.o
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
-TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-pkt-line
-TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-tool
 
 TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
@@ -800,7 +797,6 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
-VCSSVN_LIB = vcs-svn/lib.a
 
 GENERATED_H += command-list.h
 
@@ -2229,16 +2225,9 @@ XDIFF_OBJS += xdiff/xmerge.o
 XDIFF_OBJS += xdiff/xpatience.o
 XDIFF_OBJS += xdiff/xhistogram.o
 
-VCSSVN_OBJS += vcs-svn/line_buffer.o
-VCSSVN_OBJS += vcs-svn/sliding_window.o
-VCSSVN_OBJS += vcs-svn/fast_export.o
-VCSSVN_OBJS += vcs-svn/svndiff.o
-VCSSVN_OBJS += vcs-svn/svndump.o
-
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
 	$(XDIFF_OBJS) \
-	$(VCSSVN_OBJS) \
 	common-main.o \
 	git.o
 ifndef NO_CURL
@@ -2352,10 +2341,6 @@ git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
-git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) $(VCSSVN_LIB)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
-	$(VCSSVN_LIB)
-
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	$(QUIET_LNCP)$(RM) $@ && \
 	ln $< $@ 2>/dev/null || \
@@ -2372,9 +2357,6 @@ $(LIB_FILE): $(LIB_OBJS)
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
-$(VCSSVN_LIB): $(VCSSVN_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
-
 export DEFAULT_EDITOR DEFAULT_PAGER
 
 .PHONY: doc man man-perl html info pdf
@@ -2642,10 +2624,6 @@ perf: all
 
 .PHONY: test perf
 
-t/helper/test-line-buffer$X: $(VCSSVN_LIB)
-
-t/helper/test-svn-fe$X: $(VCSSVN_LIB)
-
 .PRECIOUS: $(TEST_OBJS)
 
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
diff --git a/contrib/svn-fe/.gitignore b/contrib/svn-fe/.gitignore
deleted file mode 100644
index 02a7791585..0000000000
--- a/contrib/svn-fe/.gitignore
+++ /dev/null
@@ -1,4 +0,0 @@
-/*.xml
-/*.1
-/*.html
-/svn-fe
diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
deleted file mode 100644
index e8651aaf4b..0000000000
--- a/contrib/svn-fe/Makefile
+++ /dev/null
@@ -1,105 +0,0 @@
-all:: svn-fe$X
-
-CC = cc
-RM = rm -f
-MV = mv
-
-CFLAGS = -g -O2 -Wall
-LDFLAGS =
-EXTLIBS = -lz
-
-include ../../config.mak.uname
--include ../../config.mak.autogen
--include ../../config.mak
-
-ifeq ($(uname_S),Darwin)
-	ifndef NO_FINK
-		ifeq ($(shell test -d /sw/lib && echo y),y)
-			CFLAGS += -I/sw/include
-			LDFLAGS += -L/sw/lib
-		endif
-	endif
-	ifndef NO_DARWIN_PORTS
-		ifeq ($(shell test -d /opt/local/lib && echo y),y)
-			CFLAGS += -I/opt/local/include
-			LDFLAGS += -L/opt/local/lib
-		endif
-	endif
-endif
-
-ifndef NO_OPENSSL
-	EXTLIBS += -lssl
-	ifdef NEEDS_CRYPTO_WITH_SSL
-		EXTLIBS += -lcrypto
-	endif
-endif
-
-ifndef NO_PTHREADS
-	CFLAGS += $(PTHREADS_CFLAGS)
-	EXTLIBS += $(PTHREAD_LIBS)
-endif
-
-ifdef HAVE_CLOCK_GETTIME
-	CFLAGS += -DHAVE_CLOCK_GETTIME
-	EXTLIBS += -lrt
-endif
-
-ifdef NEEDS_LIBICONV
-	EXTLIBS += -liconv
-endif
-
-GIT_LIB = ../../libgit.a
-VCSSVN_LIB = ../../vcs-svn/lib.a
-XDIFF_LIB = ../../xdiff/lib.a
-
-LIBS = $(VCSSVN_LIB) $(GIT_LIB) $(XDIFF_LIB)
-
-QUIET_SUBDIR0 = +$(MAKE) -C # space to separate -C and subdir
-QUIET_SUBDIR1 =
-
-ifneq ($(findstring $(MAKEFLAGS),w),w)
-PRINT_DIR = --no-print-directory
-else # "make -w"
-NO_SUBDIR = :
-endif
-
-ifneq ($(findstring $(MAKEFLAGS),s),s)
-ifndef V
-	QUIET_CC      = @echo '   ' CC $@;
-	QUIET_LINK    = @echo '   ' LINK $@;
-	QUIET_SUBDIR0 = +@subdir=
-	QUIET_SUBDIR1 = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
-	                $(MAKE) $(PRINT_DIR) -C $$subdir
-endif
-endif
-
-svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(XDIFF_LIB) $(GIT_LIB)
-	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(EXTLIBS) -o $@ svn-fe.o $(LIBS)
-
-svn-fe.o: svn-fe.c ../../vcs-svn/svndump.h
-	$(QUIET_CC)$(CC) $(CFLAGS) -I../../vcs-svn -o $*.o -c $<
-
-svn-fe.html: svn-fe.txt
-	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
-		MAN_TXT=../contrib/svn-fe/svn-fe.txt \
-		../contrib/svn-fe/$@
-
-svn-fe.1: svn-fe.txt
-	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
-		MAN_TXT=../contrib/svn-fe/svn-fe.txt \
-		../contrib/svn-fe/$@
-	$(MV) ../../Documentation/svn-fe.1 .
-
-../../vcs-svn/lib.a: FORCE
-	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) vcs-svn/lib.a
-
-../../xdiff/lib.a: FORCE
-	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) xdiff/lib.a
-
-../../libgit.a: FORCE
-	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) libgit.a
-
-clean:
-	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1
-
-.PHONY: all clean FORCE
diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
deleted file mode 100644
index f363505abb..0000000000
--- a/contrib/svn-fe/svn-fe.c
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * This file is in the public domain.
- * You may freely use, modify, distribute, and relicense it.
- */
-
-#include <stdlib.h>
-#include "svndump.h"
-
-int main(int argc, char **argv)
-{
-	if (svndump_init(NULL))
-		return 1;
-	svndump_read((argc > 1) ? argv[1] : NULL, "refs/heads/master",
-			"refs/notes/svn/revs");
-	svndump_deinit();
-	svndump_reset();
-	return 0;
-}
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
deleted file mode 100644
index a3425f4770..0000000000
--- a/contrib/svn-fe/svn-fe.txt
+++ /dev/null
@@ -1,71 +0,0 @@
-svn-fe(1)
-=========
-
-NAME
-----
-svn-fe - convert an SVN "dumpfile" to a fast-import stream
-
-SYNOPSIS
---------
-[verse]
-mkfifo backchannel &&
-svnadmin dump --deltas REPO |
-	svn-fe [url] 3<backchannel |
-	git fast-import --cat-blob-fd=3 3>backchannel
-
-DESCRIPTION
------------
-
-Converts a Subversion dumpfile into input suitable for
-git-fast-import(1) and similar importers. REPO is a path to a
-Subversion repository mirrored on the local disk. Remote Subversion
-repositories can be mirrored on local disk using the `svnsync`
-command.
-
-Note: this tool is very young.  The details of its commandline
-interface may change in backward incompatible ways.
-
-INPUT FORMAT
-------------
-Subversion's repository dump format is documented in full in
-`notes/dump-load-format.txt` from the Subversion source tree.
-Files in this format can be generated using the 'svnadmin dump' or
-'svk admin dump' command.
-
-OUTPUT FORMAT
--------------
-The fast-import format is documented by the git-fast-import(1)
-manual page.
-
-NOTES
------
-Subversion dumps do not record a separate author and committer for
-each revision, nor do they record a separate display name and email
-address for each author.  Like git-svn(1), 'svn-fe' will use the name
-
----------
-user <user@UUID>
----------
-
-as committer, where 'user' is the value of the `svn:author` property
-and 'UUID' the repository's identifier.
-
-To support incremental imports, 'svn-fe' puts a `git-svn-id` line at
-the end of each commit log message if passed a URL on the command
-line.  This line has the form `git-svn-id: URL@REVNO UUID`.
-
-The resulting repository will generally require further processing
-to put each project in its own repository and to separate the history
-of each branch.  The 'git filter-branch --subdirectory-filter' command
-may be useful for this purpose.
-
-BUGS
-----
-Empty directories and unknown properties are silently discarded.
-
-The exit status does not reflect whether an error was detected.
-
-SEE ALSO
---------
-git-svn(1), svn2git(1), svk(1), git-filter-branch(1), git-fast-import(1),
-https://svn.apache.org/repos/asf/subversion/trunk/notes/dump-load-format.txt
diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
deleted file mode 100755
index 11ac6f6927..0000000000
--- a/contrib/svn-fe/svnrdump_sim.py
+++ /dev/null
@@ -1,68 +0,0 @@
-#!/usr/bin/python
-"""
-Simulates svnrdump by replaying an existing dump from a file, taking care
-of the specified revision range.
-To simulate incremental imports the environment variable SVNRMAX can be set
-to the highest revision that should be available.
-"""
-import sys
-import os
-
-if sys.hexversion < 0x02040000:
-    # The limiter is the ValueError() calls. This may be too conservative
-    sys.stderr.write("svnrdump-sim.py: requires Python 2.4 or later.\n")
-    sys.exit(1)
-
-
-def getrevlimit():
-    var = 'SVNRMAX'
-    if var in os.environ:
-        return os.environ[var]
-    return None
-
-
-def writedump(url, lower, upper):
-    if url.startswith('sim://'):
-        filename = url[6:]
-        if filename[-1] == '/':
-            filename = filename[:-1]  # remove terminating slash
-    else:
-        raise ValueError('sim:// url required')
-    f = open(filename, 'r')
-    state = 'header'
-    wroterev = False
-    while(True):
-        l = f.readline()
-        if l == '':
-            break
-        if state == 'header' and l.startswith('Revision-number: '):
-            state = 'prefix'
-        if state == 'prefix' and l == 'Revision-number: %s\n' % lower:
-            state = 'selection'
-        if not upper == 'HEAD' and state == 'selection' and \
-                l == 'Revision-number: %s\n' % upper:
-            break
-
-        if state == 'header' or state == 'selection':
-            if state == 'selection':
-                wroterev = True
-            sys.stdout.write(l)
-    return wroterev
-
-if __name__ == "__main__":
-    if not (len(sys.argv) in (3, 4, 5)):
-        print("usage: %s dump URL -rLOWER:UPPER")
-        sys.exit(1)
-    if not sys.argv[1] == 'dump':
-        raise NotImplementedError('only "dump" is suppported.')
-    url = sys.argv[2]
-    r = ('0', 'HEAD')
-    if len(sys.argv) == 4 and sys.argv[3][0:2] == '-r':
-        r = sys.argv[3][2:].lstrip().split(':')
-    if not getrevlimit() is None:
-        r[1] = getrevlimit()
-    if writedump(url, r[0], r[1]):
-        ret = 0
-    else:
-        ret = 1
-    sys.exit(ret)
diff --git a/remote-testsvn.c b/remote-testsvn.c
deleted file mode 100644
index 3af708c5b6..0000000000
--- a/remote-testsvn.c
+++ /dev/null
@@ -1,337 +0,0 @@
-#include "cache.h"
-#include "refs.h"
-#include "remote.h"
-#include "object-store.h"
-#include "strbuf.h"
-#include "url.h"
-#include "exec-cmd.h"
-#include "run-command.h"
-#include "vcs-svn/svndump.h"
-#include "notes.h"
-#include "argv-array.h"
-
-static const char *url;
-static int dump_from_file;
-static const char *private_ref;
-static const char *remote_ref = "refs/heads/master";
-static const char *marksfilename, *notes_ref;
-struct rev_note { unsigned int rev_nr; };
-
-static int cmd_capabilities(const char *line);
-static int cmd_import(const char *line);
-static int cmd_list(const char *line);
-
-typedef int (*input_command_handler)(const char *);
-struct input_command_entry {
-	const char *name;
-	input_command_handler fn;
-	unsigned char batchable;	/* whether the command starts or is part of a batch */
-};
-
-static const struct input_command_entry input_command_list[] = {
-	{ "capabilities", cmd_capabilities, 0 },
-	{ "import", cmd_import, 1 },
-	{ "list", cmd_list, 0 },
-	{ NULL, NULL }
-};
-
-static int cmd_capabilities(const char *line)
-{
-	printf("import\n");
-	printf("bidi-import\n");
-	printf("refspec %s:%s\n\n", remote_ref, private_ref);
-	fflush(stdout);
-	return 0;
-}
-
-static void terminate_batch(void)
-{
-	/* terminate a current batch's fast-import stream */
-	printf("done\n");
-	fflush(stdout);
-}
-
-/* NOTE: 'ref' refers to a git reference, while 'rev' refers to a svn revision. */
-static char *read_ref_note(const struct object_id *oid)
-{
-	const struct object_id *note_oid;
-	char *msg = NULL;
-	unsigned long msglen;
-	enum object_type type;
-
-	init_notes(NULL, notes_ref, NULL, 0);
-	if (!(note_oid = get_note(NULL, oid)))
-		return NULL;	/* note tree not found */
-	if (!(msg = read_object_file(note_oid, &type, &msglen)))
-		error("Empty notes tree. %s", notes_ref);
-	else if (!msglen || type != OBJ_BLOB) {
-		error("Note contains unusable content. "
-			"Is something else using this notes tree? %s", notes_ref);
-		FREE_AND_NULL(msg);
-	}
-	free_notes(NULL);
-	return msg;
-}
-
-static int parse_rev_note(const char *msg, struct rev_note *res)
-{
-	const char *key, *value, *end;
-	size_t len;
-
-	while (*msg) {
-		end = strchrnul(msg, '\n');
-		len = end - msg;
-
-		key = "Revision-number: ";
-		if (starts_with(msg, key)) {
-			long i;
-			char *end;
-			value = msg + strlen(key);
-			i = strtol(value, &end, 0);
-			if (end == value || i < 0 || i > UINT32_MAX)
-				return -1;
-			res->rev_nr = i;
-			return 0;
-		}
-		msg += len + 1;
-	}
-	/* didn't find it */
-	return -1;
-}
-
-static int note2mark_cb(const struct object_id *object_oid,
-		const struct object_id *note_oid, char *note_path,
-		void *cb_data)
-{
-	FILE *file = (FILE *)cb_data;
-	char *msg;
-	unsigned long msglen;
-	enum object_type type;
-	struct rev_note note;
-
-	if (!(msg = read_object_file(note_oid, &type, &msglen)) ||
-			!msglen || type != OBJ_BLOB) {
-		free(msg);
-		return 1;
-	}
-	if (parse_rev_note(msg, &note))
-		return 2;
-	if (fprintf(file, ":%d %s\n", note.rev_nr, oid_to_hex(object_oid)) < 1)
-		return 3;
-	return 0;
-}
-
-static void regenerate_marks(void)
-{
-	int ret;
-	FILE *marksfile = xfopen(marksfilename, "w+");
-
-	ret = for_each_note(NULL, 0, note2mark_cb, marksfile);
-	if (ret)
-		die("Regeneration of marks failed, returned %d.", ret);
-	fclose(marksfile);
-}
-
-static void check_or_regenerate_marks(int latestrev)
-{
-	FILE *marksfile;
-	struct strbuf sb = STRBUF_INIT;
-	struct strbuf line = STRBUF_INIT;
-	int found = 0;
-
-	if (latestrev < 1)
-		return;
-
-	init_notes(NULL, notes_ref, NULL, 0);
-	marksfile = fopen(marksfilename, "r");
-	if (!marksfile) {
-		regenerate_marks();
-		marksfile = xfopen(marksfilename, "r");
-		fclose(marksfile);
-	} else {
-		strbuf_addf(&sb, ":%d ", latestrev);
-		while (strbuf_getline_lf(&line, marksfile) != EOF) {
-			if (starts_with(line.buf, sb.buf)) {
-				found++;
-				break;
-			}
-		}
-		fclose(marksfile);
-		if (!found)
-			regenerate_marks();
-	}
-	free_notes(NULL);
-	strbuf_release(&sb);
-	strbuf_release(&line);
-}
-
-static int cmd_import(const char *line)
-{
-	int code;
-	int dumpin_fd;
-	char *note_msg;
-	struct object_id head_oid;
-	unsigned int startrev;
-	struct child_process svndump_proc = CHILD_PROCESS_INIT;
-	const char *command = "svnrdump";
-
-	if (read_ref(private_ref, &head_oid))
-		startrev = 0;
-	else {
-		note_msg = read_ref_note(&head_oid);
-		if(note_msg == NULL) {
-			warning("No note found for %s.", private_ref);
-			startrev = 0;
-		} else {
-			struct rev_note note = { 0 };
-			if (parse_rev_note(note_msg, &note))
-				die("Revision number couldn't be parsed from note.");
-			startrev = note.rev_nr + 1;
-			free(note_msg);
-		}
-	}
-	check_or_regenerate_marks(startrev - 1);
-
-	if (dump_from_file) {
-		dumpin_fd = open(url, O_RDONLY);
-		if(dumpin_fd < 0)
-			die_errno("Couldn't open svn dump file %s.", url);
-	} else {
-		svndump_proc.out = -1;
-		argv_array_push(&svndump_proc.args, command);
-		argv_array_push(&svndump_proc.args, "dump");
-		argv_array_push(&svndump_proc.args, url);
-		argv_array_pushf(&svndump_proc.args, "-r%u:HEAD", startrev);
-
-		code = start_command(&svndump_proc);
-		if (code)
-			die("Unable to start %s, code %d", command, code);
-		dumpin_fd = svndump_proc.out;
-	}
-	/* setup marks file import/export */
-	printf("feature import-marks-if-exists=%s\n"
-			"feature export-marks=%s\n", marksfilename, marksfilename);
-
-	svndump_init_fd(dumpin_fd, STDIN_FILENO);
-	svndump_read(url, private_ref, notes_ref);
-	svndump_deinit();
-	svndump_reset();
-
-	close(dumpin_fd);
-	if (!dump_from_file) {
-		code = finish_command(&svndump_proc);
-		if (code)
-			warning("%s, returned %d", command, code);
-	}
-
-	return 0;
-}
-
-static int cmd_list(const char *line)
-{
-	printf("? %s\n\n", remote_ref);
-	fflush(stdout);
-	return 0;
-}
-
-static int do_command(struct strbuf *line)
-{
-	const struct input_command_entry *p = input_command_list;
-	static struct string_list batchlines = STRING_LIST_INIT_DUP;
-	static const struct input_command_entry *batch_cmd;
-	/*
-	 * commands can be grouped together in a batch.
-	 * Batches are ended by \n. If no batch is active the program ends.
-	 * During a batch all lines are buffered and passed to the handler function
-	 * when the batch is terminated.
-	 */
-	if (line->len == 0) {
-		if (batch_cmd) {
-			struct string_list_item *item;
-			for_each_string_list_item(item, &batchlines)
-				batch_cmd->fn(item->string);
-			terminate_batch();
-			batch_cmd = NULL;
-			string_list_clear(&batchlines, 0);
-			return 0;	/* end of the batch, continue reading other commands. */
-		}
-		return 1;	/* end of command stream, quit */
-	}
-	if (batch_cmd) {
-		if (!starts_with(batch_cmd->name, line->buf))
-			die("Active %s batch interrupted by %s", batch_cmd->name, line->buf);
-		/* buffer batch lines */
-		string_list_append(&batchlines, line->buf);
-		return 0;
-	}
-
-	for (p = input_command_list; p->name; p++) {
-		if (starts_with(line->buf, p->name) && (strlen(p->name) == line->len ||
-				line->buf[strlen(p->name)] == ' ')) {
-			if (p->batchable) {
-				batch_cmd = p;
-				string_list_append(&batchlines, line->buf);
-				return 0;
-			}
-			return p->fn(line->buf);
-		}
-	}
-	die("Unknown command '%s'\n", line->buf);
-	return 0;
-}
-
-int cmd_main(int argc, const char **argv)
-{
-	struct strbuf buf = STRBUF_INIT, url_sb = STRBUF_INIT,
-			private_ref_sb = STRBUF_INIT, marksfilename_sb = STRBUF_INIT,
-			notes_ref_sb = STRBUF_INIT;
-	static struct remote *remote;
-	const char *url_in;
-
-	setup_git_directory();
-	if (argc < 2 || argc > 3) {
-		usage("git-remote-svn <remote-name> [<url>]");
-		return 1;
-	}
-
-	remote = remote_get(argv[1]);
-	url_in = (argc == 3) ? argv[2] : remote->url[0];
-
-	if (starts_with(url_in, "file://")) {
-		dump_from_file = 1;
-		url = url_decode(url_in + sizeof("file://")-1);
-	} else {
-		dump_from_file = 0;
-		end_url_with_slash(&url_sb, url_in);
-		url = url_sb.buf;
-	}
-
-	strbuf_addf(&private_ref_sb, "refs/svn/%s/master", remote->name);
-	private_ref = private_ref_sb.buf;
-
-	strbuf_addf(&notes_ref_sb, "refs/notes/%s/revs", remote->name);
-	notes_ref = notes_ref_sb.buf;
-
-	strbuf_addf(&marksfilename_sb, "%s/info/fast-import/remote-svn/%s.marks",
-		get_git_dir(), remote->name);
-	marksfilename = marksfilename_sb.buf;
-
-	while (1) {
-		if (strbuf_getline_lf(&buf, stdin) == EOF) {
-			if (ferror(stdin))
-				die("Error reading command stream");
-			else
-				die("Unexpected end of command stream");
-		}
-		if (do_command(&buf))
-			break;
-		strbuf_reset(&buf);
-	}
-
-	strbuf_release(&buf);
-	strbuf_release(&url_sb);
-	strbuf_release(&private_ref_sb);
-	strbuf_release(&notes_ref_sb);
-	strbuf_release(&marksfilename_sb);
-	return 0;
-}
diff --git a/t/helper/test-line-buffer.c b/t/helper/test-line-buffer.c
deleted file mode 100644
index 078dd7e29d..0000000000
--- a/t/helper/test-line-buffer.c
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
- * test-line-buffer.c: code to exercise the svn importer's input helper
- */
-
-#include "git-compat-util.h"
-#include "strbuf.h"
-#include "vcs-svn/line_buffer.h"
-
-static uint32_t strtouint32(const char *s)
-{
-	char *end;
-	uintmax_t n = strtoumax(s, &end, 10);
-	if (*s == '\0' || *end != '\0')
-		die("invalid count: %s", s);
-	return (uint32_t) n;
-}
-
-static void handle_command(const char *command, const char *arg, struct line_buffer *buf)
-{
-	if (starts_with(command, "binary ")) {
-		struct strbuf sb = STRBUF_INIT;
-		strbuf_addch(&sb, '>');
-		buffer_read_binary(buf, &sb, strtouint32(arg));
-		fwrite(sb.buf, 1, sb.len, stdout);
-		strbuf_release(&sb);
-	} else if (starts_with(command, "copy ")) {
-		buffer_copy_bytes(buf, strtouint32(arg));
-	} else if (starts_with(command, "skip ")) {
-		buffer_skip_bytes(buf, strtouint32(arg));
-	} else {
-		die("unrecognized command: %s", command);
-	}
-}
-
-static void handle_line(const char *line, struct line_buffer *stdin_buf)
-{
-	const char *arg = strchr(line, ' ');
-	if (!arg)
-		die("no argument in line: %s", line);
-	handle_command(line, arg + 1, stdin_buf);
-}
-
-int cmd_main(int argc, const char **argv)
-{
-	struct line_buffer stdin_buf = LINE_BUFFER_INIT;
-	struct line_buffer file_buf = LINE_BUFFER_INIT;
-	struct line_buffer *input = &stdin_buf;
-	const char *filename;
-	char *s;
-
-	if (argc == 1)
-		filename = NULL;
-	else if (argc == 2)
-		filename = argv[1];
-	else
-		usage("test-line-buffer [file | &fd] < script");
-
-	if (buffer_init(&stdin_buf, NULL))
-		die_errno("open error");
-	if (filename) {
-		if (*filename == '&') {
-			if (buffer_fdinit(&file_buf, strtouint32(filename + 1)))
-				die_errno("error opening fd %s", filename + 1);
-		} else {
-			if (buffer_init(&file_buf, filename))
-				die_errno("error opening %s", filename);
-		}
-		input = &file_buf;
-	}
-
-	while ((s = buffer_read_line(&stdin_buf)))
-		handle_line(s, input);
-
-	if (filename && buffer_deinit(&file_buf))
-		die("error reading from %s", filename);
-	if (buffer_deinit(&stdin_buf))
-		die("input error");
-	if (ferror(stdout))
-		die("output error");
-	return 0;
-}
diff --git a/t/helper/test-svn-fe.c b/t/helper/test-svn-fe.c
deleted file mode 100644
index 7667c0803f..0000000000
--- a/t/helper/test-svn-fe.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * test-svn-fe: Code to exercise the svn import lib
- */
-
-#include "git-compat-util.h"
-#include "vcs-svn/svndump.h"
-#include "vcs-svn/svndiff.h"
-#include "vcs-svn/sliding_window.h"
-#include "vcs-svn/line_buffer.h"
-
-static const char test_svnfe_usage[] =
-	"test-svn-fe (<dumpfile> | [-d] <preimage> <delta> <len>)";
-
-static int apply_delta(int argc, const char **argv)
-{
-	struct line_buffer preimage = LINE_BUFFER_INIT;
-	struct line_buffer delta = LINE_BUFFER_INIT;
-	struct sliding_view preimage_view = SLIDING_VIEW_INIT(&preimage, -1);
-
-	if (argc != 5)
-		usage(test_svnfe_usage);
-
-	if (buffer_init(&preimage, argv[2]))
-		die_errno("cannot open preimage");
-	if (buffer_init(&delta, argv[3]))
-		die_errno("cannot open delta");
-	if (svndiff0_apply(&delta, (off_t) strtoumax(argv[4], NULL, 0),
-					&preimage_view, stdout))
-		return 1;
-	if (buffer_deinit(&preimage))
-		die_errno("cannot close preimage");
-	if (buffer_deinit(&delta))
-		die_errno("cannot close delta");
-	strbuf_release(&preimage_view.buf);
-	return 0;
-}
-
-int cmd_main(int argc, const char **argv)
-{
-	if (argc == 2) {
-		if (svndump_init(argv[1]))
-			return 1;
-		svndump_read(NULL, "refs/heads/master", "refs/notes/svn/revs");
-		svndump_deinit();
-		svndump_reset();
-		return 0;
-	}
-
-	if (argc >= 2 && !strcmp(argv[1], "-d"))
-		return apply_delta(argc, argv);
-	usage(test_svnfe_usage);
-}
diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
deleted file mode 100755
index 6fca08e5e3..0000000000
--- a/t/t9020-remote-svn.sh
+++ /dev/null
@@ -1,89 +0,0 @@
-#!/bin/sh
-
-test_description='tests remote-svn'
-
-. ./test-lib.sh
-
-MARKSPATH=.git/info/fast-import/remote-svn
-
-if ! test_have_prereq PYTHON
-then
-	skip_all='skipping remote-svn tests, python not available'
-	test_done
-fi
-
-# Override svnrdump with our simulator
-PATH="$HOME:$PATH"
-export PATH PYTHON_PATH GIT_BUILD_DIR
-
-write_script "$HOME/svnrdump" <<\EOF
-exec "$PYTHON_PATH" "$GIT_BUILD_DIR/contrib/svn-fe/svnrdump_sim.py" "$@"
-EOF
-
-init_git () {
-	rm -fr .git &&
-	git init &&
-	#git remote add svnsim testsvn::sim:///$TEST_DIRECTORY/t9020/example.svnrdump
-	# let's reuse an existing dump file!?
-	git remote add svnsim "testsvn::sim://$TEST_DIRECTORY/t9154/svn.dump"
-	git remote add svnfile "testsvn::file://$TEST_DIRECTORY/t9154/svn.dump"
-}
-
-if test -e "$GIT_BUILD_DIR/git-remote-testsvn"
-then
-	test_set_prereq REMOTE_SVN
-fi
-
-test_debug '
-	git --version
-	type git
-	type svnrdump
-'
-
-test_expect_success REMOTE_SVN 'simple fetch' '
-	init_git &&
-	git fetch svnsim &&
-	test_cmp .git/refs/svn/svnsim/master .git/refs/remotes/svnsim/master  &&
-	cp .git/refs/remotes/svnsim/master master.good
-'
-
-test_debug '
-	cat .git/refs/svn/svnsim/master
-	cat .git/refs/remotes/svnsim/master
-'
-
-test_expect_success REMOTE_SVN 'repeated fetch, nothing shall change' '
-	git fetch svnsim &&
-	test_cmp master.good .git/refs/remotes/svnsim/master
-'
-
-test_expect_success REMOTE_SVN 'fetch from a file:// url gives the same result' '
-	git fetch svnfile
-'
-
-test_expect_failure REMOTE_SVN 'the sha1 differ because the git-svn-id line in the commit msg contains the url' '
-	test_cmp .git/refs/remotes/svnfile/master .git/refs/remotes/svnsim/master
-'
-
-test_expect_success REMOTE_SVN 'mark-file regeneration' '
-	# filter out any other marks, that can not be regenerated. Only up to 3 digit revisions are allowed here
-	grep ":[0-9]\{1,3\} " $MARKSPATH/svnsim.marks > $MARKSPATH/svnsim.marks.old &&
-	rm $MARKSPATH/svnsim.marks &&
-	git fetch svnsim &&
-	test_cmp $MARKSPATH/svnsim.marks.old $MARKSPATH/svnsim.marks
-'
-
-test_expect_success REMOTE_SVN 'incremental imports must lead to the same head' '
-	SVNRMAX=3 &&
-	export SVNRMAX &&
-	init_git &&
-	git fetch svnsim &&
-	test_cmp .git/refs/svn/svnsim/master .git/refs/remotes/svnsim/master  &&
-	unset SVNRMAX &&
-	git fetch svnsim &&
-	test_cmp master.good .git/refs/remotes/svnsim/master
-'
-
-test_debug 'git branch -a'
-
-test_done
diff --git a/vcs-svn/LICENSE b/vcs-svn/LICENSE
deleted file mode 100644
index eb91858b82..0000000000
--- a/vcs-svn/LICENSE
+++ /dev/null
@@ -1,32 +0,0 @@
-Copyright (C) 2010 David Barr <david.barr@cordelta.com>.
-All rights reserved.
-
-Copyright (C) 2010 Jonathan Nieder <jrnieder@gmail.com>.
-
-Copyright (C) 2005 Stefan Hegny, hydrografix Consulting GmbH,
-Frankfurt/Main, Germany
-and others, see http://svn2cc.sarovar.org
-
-Redistribution and use in source and binary forms, with or without
-modification, are permitted provided that the following conditions
-are met:
-1. Redistributions of source code must retain the above copyright
-   notice(s), this list of conditions and the following disclaimer
-   unmodified other than the allowable addition of one or more
-   copyright notices.
-2. Redistributions in binary form must reproduce the above copyright
-   notice(s), this list of conditions and the following disclaimer in
-   the documentation and/or other materials provided with the
-   distribution.
-
-THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER(S) ``AS IS'' AND ANY
-EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
-PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) BE
-LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
-BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
-WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
-OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
-EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
deleted file mode 100644
index b5b8913cb0..0000000000
--- a/vcs-svn/fast_export.c
+++ /dev/null
@@ -1,365 +0,0 @@
-/*
- * Licensed under a two-clause BSD-style license.
- * See LICENSE for details.
- */
-
-#include "cache.h"
-#include "quote.h"
-#include "fast_export.h"
-#include "strbuf.h"
-#include "svndiff.h"
-#include "sliding_window.h"
-#include "line_buffer.h"
-
-#define MAX_GITSVN_LINE_LEN 4096
-
-static uint32_t first_commit_done;
-static struct line_buffer postimage = LINE_BUFFER_INIT;
-static struct line_buffer report_buffer = LINE_BUFFER_INIT;
-
-/* NEEDSWORK: move to fast_export_init() */
-static int init_postimage(void)
-{
-	static int postimage_initialized;
-	if (postimage_initialized)
-		return 0;
-	postimage_initialized = 1;
-	return buffer_tmpfile_init(&postimage);
-}
-
-void fast_export_init(int fd)
-{
-	first_commit_done = 0;
-	if (buffer_fdinit(&report_buffer, fd))
-		die_errno("cannot read from file descriptor %d", fd);
-}
-
-void fast_export_deinit(void)
-{
-	if (buffer_deinit(&report_buffer))
-		die_errno("error closing fast-import feedback stream");
-}
-
-void fast_export_delete(const char *path)
-{
-	putchar('D');
-	putchar(' ');
-	quote_c_style(path, NULL, stdout, 0);
-	putchar('\n');
-}
-
-static void fast_export_truncate(const char *path, uint32_t mode)
-{
-	fast_export_modify(path, mode, "inline");
-	printf("data 0\n\n");
-}
-
-void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
-{
-	/* Mode must be 100644, 100755, 120000, or 160000. */
-	if (!dataref) {
-		fast_export_truncate(path, mode);
-		return;
-	}
-	printf("M %06"PRIo32" %s ", mode, dataref);
-	quote_c_style(path, NULL, stdout, 0);
-	putchar('\n');
-}
-
-void fast_export_begin_note(uint32_t revision, const char *author,
-		const char *log, timestamp_t timestamp, const char *note_ref)
-{
-	static int firstnote = 1;
-	size_t loglen = strlen(log);
-	printf("commit %s\n", note_ref);
-	printf("committer %s <%s@%s> %"PRItime" +0000\n", author, author, "local", timestamp);
-	printf("data %"PRIuMAX"\n", (uintmax_t)loglen);
-	fwrite(log, loglen, 1, stdout);
-	if (firstnote) {
-		if (revision > 1)
-			printf("from %s^0", note_ref);
-		firstnote = 0;
-	}
-	fputc('\n', stdout);
-}
-
-void fast_export_note(const char *committish, const char *dataref)
-{
-	printf("N %s %s\n", dataref, committish);
-}
-
-static char gitsvnline[MAX_GITSVN_LINE_LEN];
-void fast_export_begin_commit(uint32_t revision, const char *author,
-			const struct strbuf *log,
-			const char *uuid, const char *url,
-			timestamp_t timestamp, const char *local_ref)
-{
-	static const struct strbuf empty = STRBUF_INIT;
-	if (!log)
-		log = &empty;
-	if (*uuid && *url) {
-		snprintf(gitsvnline, MAX_GITSVN_LINE_LEN,
-				"\n\ngit-svn-id: %s@%"PRIu32" %s\n",
-				 url, revision, uuid);
-	} else {
-		*gitsvnline = '\0';
-	}
-	printf("commit %s\n", local_ref);
-	printf("mark :%"PRIu32"\n", revision);
-	printf("committer %s <%s@%s> %"PRItime" +0000\n",
-		   *author ? author : "nobody",
-		   *author ? author : "nobody",
-		   *uuid ? uuid : "local", timestamp);
-	printf("data %"PRIuMAX"\n",
-		(uintmax_t) (log->len + strlen(gitsvnline)));
-	fwrite(log->buf, log->len, 1, stdout);
-	printf("%s\n", gitsvnline);
-	if (!first_commit_done) {
-		if (revision > 1)
-			printf("from :%"PRIu32"\n", revision - 1);
-		first_commit_done = 1;
-	}
-}
-
-void fast_export_end_commit(uint32_t revision)
-{
-	printf("progress Imported commit %"PRIu32".\n\n", revision);
-}
-
-static void ls_from_rev(uint32_t rev, const char *path)
-{
-	/* ls :5 path/to/old/file */
-	printf("ls :%"PRIu32" ", rev);
-	quote_c_style(path, NULL, stdout, 0);
-	putchar('\n');
-	fflush(stdout);
-}
-
-static void ls_from_active_commit(const char *path)
-{
-	/* ls "path/to/file" */
-	printf("ls \"");
-	quote_c_style(path, NULL, stdout, 1);
-	printf("\"\n");
-	fflush(stdout);
-}
-
-static const char *get_response_line(void)
-{
-	const char *line = buffer_read_line(&report_buffer);
-	if (line)
-		return line;
-	if (buffer_ferror(&report_buffer))
-		die_errno("error reading from fast-import");
-	die("unexpected end of fast-import feedback");
-}
-
-static void die_short_read(struct line_buffer *input)
-{
-	if (buffer_ferror(input))
-		die_errno("error reading dump file");
-	die("invalid dump: unexpected end of file");
-}
-
-static int parse_cat_response_line(const char *header, off_t *len)
-{
-	uintmax_t n;
-	const char *type;
-	const char *end;
-
-	if (ends_with(header, " missing"))
-		return error("cat-blob reports missing blob: %s", header);
-	type = strstr(header, " blob ");
-	if (!type)
-		return error("cat-blob header has wrong object type: %s", header);
-	n = strtoumax(type + strlen(" blob "), (char **) &end, 10);
-	if (end == type + strlen(" blob "))
-		return error("cat-blob header does not contain length: %s", header);
-	if (memchr(type + strlen(" blob "), '-', end - type - strlen(" blob ")))
-		return error("cat-blob header contains negative length: %s", header);
-	if (n == UINTMAX_MAX || n > maximum_signed_value_of_type(off_t))
-		return error("blob too large for current definition of off_t");
-	*len = n;
-	if (*end)
-		return error("cat-blob header contains garbage after length: %s", header);
-	return 0;
-}
-
-static void check_preimage_overflow(off_t a, off_t b)
-{
-	if (signed_add_overflows(a, b))
-		die("blob too large for current definition of off_t");
-}
-
-static long apply_delta(off_t len, struct line_buffer *input,
-			const char *old_data, uint32_t old_mode)
-{
-	long ret;
-	struct sliding_view preimage = SLIDING_VIEW_INIT(&report_buffer, 0);
-	FILE *out;
-
-	if (init_postimage() || !(out = buffer_tmpfile_rewind(&postimage)))
-		die("cannot open temporary file for blob retrieval");
-	if (old_data) {
-		const char *response;
-		printf("cat-blob %s\n", old_data);
-		fflush(stdout);
-		response = get_response_line();
-		if (parse_cat_response_line(response, &preimage.max_off))
-			die("invalid cat-blob response: %s", response);
-		check_preimage_overflow(preimage.max_off, 1);
-	}
-	if (old_mode == S_IFLNK) {
-		strbuf_addstr(&preimage.buf, "link ");
-		check_preimage_overflow(preimage.max_off, strlen("link "));
-		preimage.max_off += strlen("link ");
-		check_preimage_overflow(preimage.max_off, 1);
-	}
-	if (svndiff0_apply(input, len, &preimage, out))
-		die("cannot apply delta");
-	if (old_data) {
-		/* Read the remainder of preimage and trailing newline. */
-		assert(!signed_add_overflows(preimage.max_off, 1));
-		preimage.max_off++;	/* room for newline */
-		if (move_window(&preimage, preimage.max_off - 1, 1))
-			die("cannot seek to end of input");
-		if (preimage.buf.buf[0] != '\n')
-			die("missing newline after cat-blob response");
-	}
-	ret = buffer_tmpfile_prepare_to_read(&postimage);
-	if (ret < 0)
-		die("cannot read temporary file for blob retrieval");
-	strbuf_release(&preimage.buf);
-	return ret;
-}
-
-void fast_export_buf_to_data(const struct strbuf *data)
-{
-	printf("data %"PRIuMAX"\n", (uintmax_t)data->len);
-	fwrite(data->buf, data->len, 1, stdout);
-	fputc('\n', stdout);
-}
-
-void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input)
-{
-	assert(len >= 0);
-	if (mode == S_IFLNK) {
-		/* svn symlink blobs start with "link " */
-		if (len < 5)
-			die("invalid dump: symlink too short for \"link\" prefix");
-		len -= 5;
-		if (buffer_skip_bytes(input, 5) != 5)
-			die_short_read(input);
-	}
-	printf("data %"PRIuMAX"\n", (uintmax_t) len);
-	if (buffer_copy_bytes(input, len) != len)
-		die_short_read(input);
-	fputc('\n', stdout);
-}
-
-static int parse_ls_response(const char *response, uint32_t *mode,
-					struct strbuf *dataref)
-{
-	const char *tab;
-	const char *response_end;
-
-	assert(response);
-	response_end = response + strlen(response);
-
-	if (*response == 'm') {	/* Missing. */
-		errno = ENOENT;
-		return -1;
-	}
-
-	/* Mode. */
-	if (response_end - response < (signed) strlen("100644") ||
-	    response[strlen("100644")] != ' ')
-		die("invalid ls response: missing mode: %s", response);
-	*mode = 0;
-	for (; *response != ' '; response++) {
-		char ch = *response;
-		if (ch < '0' || ch > '7')
-			die("invalid ls response: mode is not octal: %s", response);
-		*mode *= 8;
-		*mode += ch - '0';
-	}
-
-	/* ' blob ' or ' tree ' */
-	if (response_end - response < (signed) strlen(" blob ") ||
-	    (response[1] != 'b' && response[1] != 't'))
-		die("unexpected ls response: not a tree or blob: %s", response);
-	response += strlen(" blob ");
-
-	/* Dataref. */
-	tab = memchr(response, '\t', response_end - response);
-	if (!tab)
-		die("invalid ls response: missing tab: %s", response);
-	strbuf_add(dataref, response, tab - response);
-	return 0;
-}
-
-int fast_export_ls_rev(uint32_t rev, const char *path,
-				uint32_t *mode, struct strbuf *dataref)
-{
-	ls_from_rev(rev, path);
-	return parse_ls_response(get_response_line(), mode, dataref);
-}
-
-int fast_export_ls(const char *path, uint32_t *mode, struct strbuf *dataref)
-{
-	ls_from_active_commit(path);
-	return parse_ls_response(get_response_line(), mode, dataref);
-}
-
-const char *fast_export_read_path(const char *path, uint32_t *mode_out)
-{
-	int err;
-	static struct strbuf buf = STRBUF_INIT;
-
-	strbuf_reset(&buf);
-	err = fast_export_ls(path, mode_out, &buf);
-	if (err) {
-		if (errno != ENOENT)
-			BUG("unexpected fast_export_ls error: %s",
-			    strerror(errno));
-		/* Treat missing paths as directories. */
-		*mode_out = S_IFDIR;
-		return NULL;
-	}
-	return buf.buf;
-}
-
-void fast_export_copy(uint32_t revision, const char *src, const char *dst)
-{
-	int err;
-	uint32_t mode;
-	static struct strbuf data = STRBUF_INIT;
-
-	strbuf_reset(&data);
-	err = fast_export_ls_rev(revision, src, &mode, &data);
-	if (err) {
-		if (errno != ENOENT)
-			BUG("unexpected fast_export_ls_rev error: %s",
-			    strerror(errno));
-		fast_export_delete(dst);
-		return;
-	}
-	fast_export_modify(dst, mode, data.buf);
-}
-
-void fast_export_blob_delta(uint32_t mode,
-				uint32_t old_mode, const char *old_data,
-				off_t len, struct line_buffer *input)
-{
-	long postimage_len;
-
-	assert(len >= 0);
-	postimage_len = apply_delta(len, input, old_data, old_mode);
-	if (mode == S_IFLNK) {
-		buffer_skip_bytes(&postimage, strlen("link "));
-		postimage_len -= strlen("link ");
-	}
-	printf("data %ld\n", postimage_len);
-	buffer_copy_bytes(&postimage, postimage_len);
-	fputc('\n', stdout);
-}
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
deleted file mode 100644
index 60b79c35b9..0000000000
--- a/vcs-svn/fast_export.h
+++ /dev/null
@@ -1,34 +0,0 @@
-#ifndef FAST_EXPORT_H_
-#define FAST_EXPORT_H_
-
-struct strbuf;
-struct line_buffer;
-
-void fast_export_init(int fd);
-void fast_export_deinit(void);
-
-void fast_export_delete(const char *path);
-void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
-void fast_export_note(const char *committish, const char *dataref);
-void fast_export_begin_note(uint32_t revision, const char *author,
-		const char *log, timestamp_t timestamp, const char *note_ref);
-void fast_export_begin_commit(uint32_t revision, const char *author,
-			const struct strbuf *log, const char *uuid,const char *url,
-			timestamp_t timestamp, const char *local_ref);
-void fast_export_end_commit(uint32_t revision);
-void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input);
-void fast_export_buf_to_data(const struct strbuf *data);
-void fast_export_blob_delta(uint32_t mode,
-			uint32_t old_mode, const char *old_data,
-			off_t len, struct line_buffer *input);
-
-/* If there is no such file at that rev, returns -1, errno == ENOENT. */
-int fast_export_ls_rev(uint32_t rev, const char *path,
-			uint32_t *mode_out, struct strbuf *dataref_out);
-int fast_export_ls(const char *path,
-			uint32_t *mode_out, struct strbuf *dataref_out);
-
-void fast_export_copy(uint32_t revision, const char *src, const char *dst);
-const char *fast_export_read_path(const char *path, uint32_t *mode_out);
-
-#endif
diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
deleted file mode 100644
index e416caf8a4..0000000000
--- a/vcs-svn/line_buffer.c
+++ /dev/null
@@ -1,126 +0,0 @@
-/*
- * Licensed under a two-clause BSD-style license.
- * See LICENSE for details.
- */
-
-#include "git-compat-util.h"
-#include "line_buffer.h"
-#include "strbuf.h"
-
-#define COPY_BUFFER_LEN 4096
-
-int buffer_init(struct line_buffer *buf, const char *filename)
-{
-	buf->infile = filename ? fopen(filename, "r") : stdin;
-	if (!buf->infile)
-		return -1;
-	return 0;
-}
-
-int buffer_fdinit(struct line_buffer *buf, int fd)
-{
-	buf->infile = fdopen(fd, "r");
-	if (!buf->infile)
-		return -1;
-	return 0;
-}
-
-int buffer_tmpfile_init(struct line_buffer *buf)
-{
-	buf->infile = tmpfile();
-	if (!buf->infile)
-		return -1;
-	return 0;
-}
-
-int buffer_deinit(struct line_buffer *buf)
-{
-	int err;
-	if (buf->infile == stdin)
-		return ferror(buf->infile);
-	err = ferror(buf->infile);
-	err |= fclose(buf->infile);
-	return err;
-}
-
-FILE *buffer_tmpfile_rewind(struct line_buffer *buf)
-{
-	rewind(buf->infile);
-	return buf->infile;
-}
-
-long buffer_tmpfile_prepare_to_read(struct line_buffer *buf)
-{
-	long pos = ftell(buf->infile);
-	if (pos < 0)
-		return error_errno("ftell error");
-	if (fseek(buf->infile, 0, SEEK_SET))
-		return error_errno("seek error");
-	return pos;
-}
-
-int buffer_ferror(struct line_buffer *buf)
-{
-	return ferror(buf->infile);
-}
-
-int buffer_read_char(struct line_buffer *buf)
-{
-	return fgetc(buf->infile);
-}
-
-/* Read a line without trailing newline. */
-char *buffer_read_line(struct line_buffer *buf)
-{
-	char *end;
-	if (!fgets(buf->line_buffer, sizeof(buf->line_buffer), buf->infile))
-		/* Error or data exhausted. */
-		return NULL;
-	end = buf->line_buffer + strlen(buf->line_buffer);
-	if (end[-1] == '\n')
-		end[-1] = '\0';
-	else if (feof(buf->infile))
-		; /* No newline at end of file.  That's fine. */
-	else
-		/*
-		 * Line was too long.
-		 * There is probably a saner way to deal with this,
-		 * but for now let's return an error.
-		 */
-		return NULL;
-	return buf->line_buffer;
-}
-
-size_t buffer_read_binary(struct line_buffer *buf,
-				struct strbuf *sb, size_t size)
-{
-	return strbuf_fread(sb, size, buf->infile);
-}
-
-off_t buffer_copy_bytes(struct line_buffer *buf, off_t nbytes)
-{
-	char byte_buffer[COPY_BUFFER_LEN];
-	off_t done = 0;
-	while (done < nbytes && !feof(buf->infile) && !ferror(buf->infile)) {
-		off_t len = nbytes - done;
-		size_t in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
-		in = fread(byte_buffer, 1, in, buf->infile);
-		done += in;
-		fwrite(byte_buffer, 1, in, stdout);
-		if (ferror(stdout))
-			return done + buffer_skip_bytes(buf, nbytes - done);
-	}
-	return done;
-}
-
-off_t buffer_skip_bytes(struct line_buffer *buf, off_t nbytes)
-{
-	char byte_buffer[COPY_BUFFER_LEN];
-	off_t done = 0;
-	while (done < nbytes && !feof(buf->infile) && !ferror(buf->infile)) {
-		off_t len = nbytes - done;
-		size_t in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
-		done += fread(byte_buffer, 1, in, buf->infile);
-	}
-	return done;
-}
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
deleted file mode 100644
index ee23b4f490..0000000000
--- a/vcs-svn/line_buffer.h
+++ /dev/null
@@ -1,30 +0,0 @@
-#ifndef LINE_BUFFER_H_
-#define LINE_BUFFER_H_
-
-#include "strbuf.h"
-
-#define LINE_BUFFER_LEN 10000
-
-struct line_buffer {
-	char line_buffer[LINE_BUFFER_LEN];
-	FILE *infile;
-};
-#define LINE_BUFFER_INIT { "", NULL }
-
-int buffer_init(struct line_buffer *buf, const char *filename);
-int buffer_fdinit(struct line_buffer *buf, int fd);
-int buffer_deinit(struct line_buffer *buf);
-
-int buffer_tmpfile_init(struct line_buffer *buf);
-FILE *buffer_tmpfile_rewind(struct line_buffer *buf);	/* prepare to write. */
-long buffer_tmpfile_prepare_to_read(struct line_buffer *buf);
-
-int buffer_ferror(struct line_buffer *buf);
-char *buffer_read_line(struct line_buffer *buf);
-int buffer_read_char(struct line_buffer *buf);
-size_t buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, size_t len);
-/* Returns number of bytes read (not necessarily written). */
-off_t buffer_copy_bytes(struct line_buffer *buf, off_t len);
-off_t buffer_skip_bytes(struct line_buffer *buf, off_t len);
-
-#endif
diff --git a/vcs-svn/line_buffer.txt b/vcs-svn/line_buffer.txt
deleted file mode 100644
index 8e139eb22d..0000000000
--- a/vcs-svn/line_buffer.txt
+++ /dev/null
@@ -1,77 +0,0 @@
-line_buffer API
-===============
-
-The line_buffer library provides a convenient interface for
-mostly-line-oriented input.
-
-Each line is not permitted to exceed 10000 bytes.  The provided
-functions are not thread-safe or async-signal-safe, and like
-`fgets()`, they generally do not function correctly if interrupted
-by a signal without SA_RESTART set.
-
-Calling sequence
-----------------
-
-The calling program:
-
- - initializes a `struct line_buffer` to LINE_BUFFER_INIT
- - specifies a file to read with `buffer_init`
- - processes input with `buffer_read_line`, `buffer_skip_bytes`,
-   and `buffer_copy_bytes`
- - closes the file with `buffer_deinit`, perhaps to start over and
-   read another file.
-
-When finished, the caller can use `buffer_reset` to deallocate
-resources.
-
-Using temporary files
----------------------
-
-Temporary files provide a place to store data that should not outlive
-the calling program.  A program
-
- - initializes a `struct line_buffer` to LINE_BUFFER_INIT
- - requests a temporary file with `buffer_tmpfile_init`
- - acquires an output handle by calling `buffer_tmpfile_rewind`
- - uses standard I/O functions like `fprintf` and `fwrite` to fill
-   the temporary file
- - declares writing is over with `buffer_tmpfile_prepare_to_read`
- - can re-read what was written with `buffer_read_line`,
-   `buffer_copy_bytes`, and so on
- - can reuse the temporary file by calling `buffer_tmpfile_rewind`
-   again
- - removes the temporary file with `buffer_deinit`, perhaps to
-   reuse the line_buffer for some other file.
-
-When finished, the calling program can use `buffer_reset` to deallocate
-resources.
-
-Functions
----------
-
-`buffer_init`, `buffer_fdinit`::
-	Open the named file or file descriptor for input.
-	buffer_init(buf, NULL) prepares to read from stdin.
-	On failure, returns -1 (with errno indicating the nature
-	of the failure).
-
-`buffer_deinit`::
-	Stop reading from the current file (closing it unless
-	it was stdin).  Returns nonzero if `fclose` fails or
-	the error indicator was set.
-
-`buffer_read_line`::
-	Read a line and strip off the trailing newline.
-	On failure or end of file, returns NULL.
-
-`buffer_copy_bytes`::
-	Read `len` bytes of input and dump them to the standard output
-	stream.  Returns early for error or end of file.
-
-`buffer_skip_bytes`::
-	Discards `len` bytes from the input stream (stopping early
-	if necessary because of an error or eof).  Return value is
-	the number of bytes successfully read.
-
-`buffer_reset`::
-	Deallocates non-static buffers.
diff --git a/vcs-svn/sliding_window.c b/vcs-svn/sliding_window.c
deleted file mode 100644
index 06d273c9e8..0000000000
--- a/vcs-svn/sliding_window.c
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- * Licensed under a two-clause BSD-style license.
- * See LICENSE for details.
- */
-
-#include "git-compat-util.h"
-#include "sliding_window.h"
-#include "line_buffer.h"
-#include "strbuf.h"
-
-static int input_error(struct line_buffer *file)
-{
-	if (!buffer_ferror(file))
-		return error("delta preimage ends early");
-	return error_errno("cannot read delta preimage");
-}
-
-static int skip_or_whine(struct line_buffer *file, off_t gap)
-{
-	if (buffer_skip_bytes(file, gap) != gap)
-		return input_error(file);
-	return 0;
-}
-
-static int read_to_fill_or_whine(struct line_buffer *file,
-				struct strbuf *buf, size_t width)
-{
-	buffer_read_binary(file, buf, width - buf->len);
-	if (buf->len != width)
-		return input_error(file);
-	return 0;
-}
-
-static int check_offset_overflow(off_t offset, uintmax_t len)
-{
-	if (len > maximum_signed_value_of_type(off_t))
-		return error("unrepresentable length in delta: "
-				"%"PRIuMAX" > OFF_MAX", len);
-	if (signed_add_overflows(offset, (off_t) len))
-		return error("unrepresentable offset in delta: "
-				"%"PRIuMAX" + %"PRIuMAX" > OFF_MAX",
-				(uintmax_t) offset, len);
-	return 0;
-}
-
-int move_window(struct sliding_view *view, off_t off, size_t width)
-{
-	off_t file_offset;
-	assert(view);
-	assert(view->width <= view->buf.len);
-	assert(!check_offset_overflow(view->off, view->buf.len));
-
-	if (check_offset_overflow(off, width))
-		return -1;
-	if (off < view->off || off + width < view->off + view->width)
-		return error("invalid delta: window slides left");
-	if (view->max_off >= 0 && view->max_off < off + (off_t) width)
-		return error("delta preimage ends early");
-
-	file_offset = view->off + view->buf.len;
-	if (off < file_offset) {
-		/* Move the overlapping region into place. */
-		strbuf_remove(&view->buf, 0, off - view->off);
-	} else {
-		/* Seek ahead to skip the gap. */
-		if (skip_or_whine(view->file, off - file_offset))
-			return -1;
-		strbuf_setlen(&view->buf, 0);
-	}
-
-	if (view->buf.len > width)
-		; /* Already read. */
-	else if (read_to_fill_or_whine(view->file, &view->buf, width))
-		return -1;
-
-	view->off = off;
-	view->width = width;
-	return 0;
-}
diff --git a/vcs-svn/sliding_window.h b/vcs-svn/sliding_window.h
deleted file mode 100644
index b43a825cba..0000000000
--- a/vcs-svn/sliding_window.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef SLIDING_WINDOW_H_
-#define SLIDING_WINDOW_H_
-
-#include "strbuf.h"
-
-struct sliding_view {
-	struct line_buffer *file;
-	off_t off;
-	size_t width;
-	off_t max_off;	/* -1 means unlimited */
-	struct strbuf buf;
-};
-
-#define SLIDING_VIEW_INIT(input, len)	{ (input), 0, 0, (len), STRBUF_INIT }
-
-extern int move_window(struct sliding_view *view, off_t off, size_t width);
-
-#endif
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
deleted file mode 100644
index 75c753162a..0000000000
--- a/vcs-svn/svndiff.c
+++ /dev/null
@@ -1,309 +0,0 @@
-/*
- * Licensed under a two-clause BSD-style license.
- * See LICENSE for details.
- */
-
-#include "git-compat-util.h"
-#include "sliding_window.h"
-#include "line_buffer.h"
-#include "svndiff.h"
-
-/*
- * svndiff0 applier
- *
- * See http://svn.apache.org/repos/asf/subversion/trunk/notes/svndiff.
- *
- * svndiff0 ::= 'SVN\0' window*
- * window ::= int int int int int instructions inline_data;
- * instructions ::= instruction*;
- * instruction ::= view_selector int int
- *   | copyfrom_data int
- *   | packed_view_selector int
- *   | packed_copyfrom_data
- *   ;
- * view_selector ::= copyfrom_source
- *   | copyfrom_target
- *   ;
- * copyfrom_source ::= # binary 00 000000;
- * copyfrom_target ::= # binary 01 000000;
- * copyfrom_data ::= # binary 10 000000;
- * packed_view_selector ::= # view_selector OR-ed with 6 bit value;
- * packed_copyfrom_data ::= # copyfrom_data OR-ed with 6 bit value;
- * int ::= highdigit* lowdigit;
- * highdigit ::= # binary 1000 0000 OR-ed with 7 bit value;
- * lowdigit ::= # 7 bit value;
- */
-
-#define INSN_MASK	0xc0
-#define INSN_COPYFROM_SOURCE	0x00
-#define INSN_COPYFROM_TARGET	0x40
-#define INSN_COPYFROM_DATA	0x80
-#define OPERAND_MASK	0x3f
-
-#define VLI_CONTINUE	0x80
-#define VLI_DIGIT_MASK	0x7f
-#define VLI_BITS_PER_DIGIT 7
-
-struct window {
-	struct sliding_view *in;
-	struct strbuf out;
-	struct strbuf instructions;
-	struct strbuf data;
-};
-
-#define WINDOW_INIT(w)	{ (w), STRBUF_INIT, STRBUF_INIT, STRBUF_INIT }
-
-static void window_release(struct window *ctx)
-{
-	strbuf_release(&ctx->out);
-	strbuf_release(&ctx->instructions);
-	strbuf_release(&ctx->data);
-}
-
-static int write_strbuf(struct strbuf *sb, FILE *out)
-{
-	if (fwrite(sb->buf, 1, sb->len, out) == sb->len)	/* Success. */
-		return 0;
-	return error_errno("cannot write delta postimage");
-}
-
-static int error_short_read(struct line_buffer *input)
-{
-	if (buffer_ferror(input))
-		return error_errno("error reading delta");
-	return error("invalid delta: unexpected end of file");
-}
-
-static int read_chunk(struct line_buffer *delta, off_t *delta_len,
-		      struct strbuf *buf, size_t len)
-{
-	assert(*delta_len >= 0);
-	strbuf_reset(buf);
-	if (len > (uintmax_t) *delta_len ||
-	    buffer_read_binary(delta, buf, len) != len)
-		return error_short_read(delta);
-	*delta_len -= buf->len;
-	return 0;
-}
-
-static int read_magic(struct line_buffer *in, off_t *len)
-{
-	static const char magic[] = {'S', 'V', 'N', '\0'};
-	struct strbuf sb = STRBUF_INIT;
-
-	if (read_chunk(in, len, &sb, sizeof(magic))) {
-		strbuf_release(&sb);
-		return -1;
-	}
-	if (memcmp(sb.buf, magic, sizeof(magic))) {
-		strbuf_release(&sb);
-		return error("invalid delta: unrecognized file type");
-	}
-	strbuf_release(&sb);
-	return 0;
-}
-
-static int read_int(struct line_buffer *in, uintmax_t *result, off_t *len)
-{
-	uintmax_t rv = 0;
-	off_t sz;
-	for (sz = *len; sz; sz--) {
-		const int ch = buffer_read_char(in);
-		if (ch == EOF)
-			break;
-
-		rv <<= VLI_BITS_PER_DIGIT;
-		rv += (ch & VLI_DIGIT_MASK);
-		if (ch & VLI_CONTINUE)
-			continue;
-
-		*result = rv;
-		*len = sz - 1;
-		return 0;
-	}
-	return error_short_read(in);
-}
-
-static int parse_int(const char **buf, size_t *result, const char *end)
-{
-	size_t rv = 0;
-	const char *pos;
-	for (pos = *buf; pos != end; pos++) {
-		unsigned char ch = *pos;
-
-		rv <<= VLI_BITS_PER_DIGIT;
-		rv += (ch & VLI_DIGIT_MASK);
-		if (ch & VLI_CONTINUE)
-			continue;
-
-		*result = rv;
-		*buf = pos + 1;
-		return 0;
-	}
-	return error("invalid delta: unexpected end of instructions section");
-}
-
-static int read_offset(struct line_buffer *in, off_t *result, off_t *len)
-{
-	uintmax_t val;
-	if (read_int(in, &val, len))
-		return -1;
-	if (val > maximum_signed_value_of_type(off_t))
-		return error("unrepresentable offset in delta: %"PRIuMAX"", val);
-	*result = val;
-	return 0;
-}
-
-static int read_length(struct line_buffer *in, size_t *result, off_t *len)
-{
-	uintmax_t val;
-	if (read_int(in, &val, len))
-		return -1;
-	if (val > SIZE_MAX)
-		return error("unrepresentable length in delta: %"PRIuMAX"", val);
-	*result = val;
-	return 0;
-}
-
-static int copyfrom_source(struct window *ctx, const char **instructions,
-			   size_t nbytes, const char *insns_end)
-{
-	size_t offset;
-	if (parse_int(instructions, &offset, insns_end))
-		return -1;
-	if (unsigned_add_overflows(offset, nbytes) ||
-	    offset + nbytes > ctx->in->width)
-		return error("invalid delta: copies source data outside view");
-	strbuf_add(&ctx->out, ctx->in->buf.buf + offset, nbytes);
-	return 0;
-}
-
-static int copyfrom_target(struct window *ctx, const char **instructions,
-			   size_t nbytes, const char *instructions_end)
-{
-	size_t offset;
-	if (parse_int(instructions, &offset, instructions_end))
-		return -1;
-	if (offset >= ctx->out.len)
-		return error("invalid delta: copies from the future");
-	for (; nbytes > 0; nbytes--)
-		strbuf_addch(&ctx->out, ctx->out.buf[offset++]);
-	return 0;
-}
-
-static int copyfrom_data(struct window *ctx, size_t *data_pos, size_t nbytes)
-{
-	const size_t pos = *data_pos;
-	if (unsigned_add_overflows(pos, nbytes) ||
-	    pos + nbytes > ctx->data.len)
-		return error("invalid delta: copies unavailable inline data");
-	strbuf_add(&ctx->out, ctx->data.buf + pos, nbytes);
-	*data_pos += nbytes;
-	return 0;
-}
-
-static int parse_first_operand(const char **buf, size_t *out, const char *end)
-{
-	size_t result = (unsigned char) *(*buf)++ & OPERAND_MASK;
-	if (result) {	/* immediate operand */
-		*out = result;
-		return 0;
-	}
-	return parse_int(buf, out, end);
-}
-
-static int execute_one_instruction(struct window *ctx,
-				const char **instructions, size_t *data_pos)
-{
-	unsigned int instruction;
-	const char *insns_end = ctx->instructions.buf + ctx->instructions.len;
-	size_t nbytes;
-	assert(ctx);
-	assert(instructions && *instructions);
-	assert(data_pos);
-
-	instruction = (unsigned char) **instructions;
-	if (parse_first_operand(instructions, &nbytes, insns_end))
-		return -1;
-	switch (instruction & INSN_MASK) {
-	case INSN_COPYFROM_SOURCE:
-		return copyfrom_source(ctx, instructions, nbytes, insns_end);
-	case INSN_COPYFROM_TARGET:
-		return copyfrom_target(ctx, instructions, nbytes, insns_end);
-	case INSN_COPYFROM_DATA:
-		return copyfrom_data(ctx, data_pos, nbytes);
-	default:
-		return error("invalid delta: unrecognized instruction");
-	}
-}
-
-static int apply_window_in_core(struct window *ctx)
-{
-	const char *instructions;
-	size_t data_pos = 0;
-
-	/*
-	 * Fill ctx->out.buf using data from the source, target,
-	 * and inline data views.
-	 */
-	for (instructions = ctx->instructions.buf;
-	     instructions != ctx->instructions.buf + ctx->instructions.len;
-	     )
-		if (execute_one_instruction(ctx, &instructions, &data_pos))
-			return -1;
-	if (data_pos != ctx->data.len)
-		return error("invalid delta: does not copy all inline data");
-	return 0;
-}
-
-static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
-			    struct sliding_view *preimage, FILE *out)
-{
-	int rv = -1;
-	struct window ctx = WINDOW_INIT(preimage);
-	size_t out_len;
-	size_t instructions_len;
-	size_t data_len;
-	assert(delta_len);
-
-	/* "source view" offset and length already handled; */
-	if (read_length(delta, &out_len, delta_len) ||
-	    read_length(delta, &instructions_len, delta_len) ||
-	    read_length(delta, &data_len, delta_len) ||
-	    read_chunk(delta, delta_len, &ctx.instructions, instructions_len) ||
-	    read_chunk(delta, delta_len, &ctx.data, data_len))
-		goto error_out;
-	strbuf_grow(&ctx.out, out_len);
-	if (apply_window_in_core(&ctx))
-		goto error_out;
-	if (ctx.out.len != out_len) {
-		rv = error("invalid delta: incorrect postimage length");
-		goto error_out;
-	}
-	if (write_strbuf(&ctx.out, out))
-		goto error_out;
-	rv = 0;
-error_out:
-	window_release(&ctx);
-	return rv;
-}
-
-int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
-			struct sliding_view *preimage, FILE *postimage)
-{
-	assert(delta && preimage && postimage && delta_len >= 0);
-
-	if (read_magic(delta, &delta_len))
-		return -1;
-	while (delta_len) {	/* For each window: */
-		off_t pre_off = -1;
-		size_t pre_len;
-
-		if (read_offset(delta, &pre_off, &delta_len) ||
-		    read_length(delta, &pre_len, &delta_len) ||
-		    move_window(preimage, pre_off, pre_len) ||
-		    apply_one_window(delta, &delta_len, preimage, postimage))
-			return -1;
-	}
-	return 0;
-}
diff --git a/vcs-svn/svndiff.h b/vcs-svn/svndiff.h
deleted file mode 100644
index 74eb464bab..0000000000
--- a/vcs-svn/svndiff.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef SVNDIFF_H_
-#define SVNDIFF_H_
-
-struct line_buffer;
-struct sliding_view;
-
-extern int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
-		struct sliding_view *preimage, FILE *postimage);
-
-#endif
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
deleted file mode 100644
index 08d136b8cc..0000000000
--- a/vcs-svn/svndump.c
+++ /dev/null
@@ -1,540 +0,0 @@
-/*
- * Parse and rearrange a svnadmin dump.
- * Create the dump with:
- * svnadmin dump --incremental -r<startrev>:<endrev> <repository> >outfile
- *
- * Licensed under a two-clause BSD-style license.
- * See LICENSE for details.
- */
-
-#include "cache.h"
-#include "fast_export.h"
-#include "line_buffer.h"
-#include "strbuf.h"
-#include "svndump.h"
-
-/*
- * Compare start of string to literal of equal length;
- * must be guarded by length test.
- */
-#define constcmp(s, ref) memcmp(s, ref, sizeof(ref) - 1)
-
-#define REPORT_FILENO 3
-
-#define NODEACT_REPLACE 4
-#define NODEACT_DELETE 3
-#define NODEACT_ADD 2
-#define NODEACT_CHANGE 1
-#define NODEACT_UNKNOWN 0
-
-/* States: */
-#define DUMP_CTX 0	/* dump metadata */
-#define REV_CTX  1	/* revision metadata */
-#define NODE_CTX 2	/* node metadata */
-#define INTERNODE_CTX 3	/* between nodes */
-
-#define DATE_RFC2822_LEN 31
-
-static struct line_buffer input = LINE_BUFFER_INIT;
-
-static struct {
-	uint32_t action, srcRev, type;
-	off_t prop_length, text_length;
-	struct strbuf src, dst;
-	uint32_t text_delta, prop_delta;
-} node_ctx;
-
-static struct {
-	uint32_t revision;
-	timestamp_t timestamp;
-	struct strbuf log, author, note;
-} rev_ctx;
-
-static struct {
-	uint32_t version;
-	struct strbuf uuid, url;
-} dump_ctx;
-
-static void reset_node_ctx(char *fname)
-{
-	node_ctx.type = 0;
-	node_ctx.action = NODEACT_UNKNOWN;
-	node_ctx.prop_length = -1;
-	node_ctx.text_length = -1;
-	strbuf_reset(&node_ctx.src);
-	node_ctx.srcRev = 0;
-	strbuf_reset(&node_ctx.dst);
-	if (fname)
-		strbuf_addstr(&node_ctx.dst, fname);
-	node_ctx.text_delta = 0;
-	node_ctx.prop_delta = 0;
-}
-
-static void reset_rev_ctx(uint32_t revision)
-{
-	rev_ctx.revision = revision;
-	rev_ctx.timestamp = 0;
-	strbuf_reset(&rev_ctx.log);
-	strbuf_reset(&rev_ctx.author);
-	strbuf_reset(&rev_ctx.note);
-}
-
-static void reset_dump_ctx(const char *url)
-{
-	strbuf_reset(&dump_ctx.url);
-	if (url)
-		strbuf_addstr(&dump_ctx.url, url);
-	dump_ctx.version = 1;
-	strbuf_reset(&dump_ctx.uuid);
-}
-
-static void handle_property(const struct strbuf *key_buf,
-				struct strbuf *val,
-				uint32_t *type_set)
-{
-	const char *key = key_buf->buf;
-	size_t keylen = key_buf->len;
-
-	switch (keylen + 1) {
-	case sizeof("svn:log"):
-		if (constcmp(key, "svn:log"))
-			break;
-		if (!val)
-			die("invalid dump: unsets svn:log");
-		strbuf_swap(&rev_ctx.log, val);
-		break;
-	case sizeof("svn:author"):
-		if (constcmp(key, "svn:author"))
-			break;
-		if (!val)
-			strbuf_reset(&rev_ctx.author);
-		else
-			strbuf_swap(&rev_ctx.author, val);
-		break;
-	case sizeof("svn:date"):
-		if (constcmp(key, "svn:date"))
-			break;
-		if (!val)
-			die("invalid dump: unsets svn:date");
-		if (parse_date_basic(val->buf, &rev_ctx.timestamp, NULL))
-			warning("invalid timestamp: %s", val->buf);
-		break;
-	case sizeof("svn:executable"):
-	case sizeof("svn:special"):
-		if (keylen == strlen("svn:executable") &&
-		    constcmp(key, "svn:executable"))
-			break;
-		if (keylen == strlen("svn:special") &&
-		    constcmp(key, "svn:special"))
-			break;
-		if (*type_set) {
-			if (!val)
-				return;
-			die("invalid dump: sets type twice");
-		}
-		if (!val) {
-			node_ctx.type = S_IFREG | 0644;
-			return;
-		}
-		*type_set = 1;
-		node_ctx.type = keylen == strlen("svn:executable") ?
-				(S_IFREG | 0755) :
-				S_IFLNK;
-	}
-}
-
-static void die_short_read(void)
-{
-	if (buffer_ferror(&input))
-		die_errno("error reading dump file");
-	die("invalid dump: unexpected end of file");
-}
-
-static void read_props(void)
-{
-	static struct strbuf key = STRBUF_INIT;
-	static struct strbuf val = STRBUF_INIT;
-	const char *t;
-	/*
-	 * NEEDSWORK: to support simple mode changes like
-	 *	K 11
-	 *	svn:special
-	 *	V 1
-	 *	*
-	 *	D 14
-	 *	svn:executable
-	 * we keep track of whether a mode has been set and reset to
-	 * plain file only if not.  We should be keeping track of the
-	 * symlink and executable bits separately instead.
-	 */
-	uint32_t type_set = 0;
-	while ((t = buffer_read_line(&input)) && strcmp(t, "PROPS-END")) {
-		uint32_t len;
-		const char type = t[0];
-		int ch;
-
-		if (!type || t[1] != ' ')
-			die("invalid property line: %s", t);
-		len = atoi(&t[2]);
-		strbuf_reset(&val);
-		buffer_read_binary(&input, &val, len);
-		if (val.len < len)
-			die_short_read();
-
-		/* Discard trailing newline. */
-		ch = buffer_read_char(&input);
-		if (ch == EOF)
-			die_short_read();
-		if (ch != '\n')
-			die("invalid dump: expected newline after %s", val.buf);
-
-		switch (type) {
-		case 'K':
-			strbuf_swap(&key, &val);
-			continue;
-		case 'D':
-			handle_property(&val, NULL, &type_set);
-			continue;
-		case 'V':
-			handle_property(&key, &val, &type_set);
-			strbuf_reset(&key);
-			continue;
-		default:
-			die("invalid property line: %s", t);
-		}
-	}
-}
-
-static void handle_node(void)
-{
-	const uint32_t type = node_ctx.type;
-	const int have_props = node_ctx.prop_length != -1;
-	const int have_text = node_ctx.text_length != -1;
-	/*
-	 * Old text for this node:
-	 *  NULL	- directory or bug
-	 *  empty_blob	- empty
-	 *  "<dataref>"	- data retrievable from fast-import
-	 */
-	static const char *const empty_blob = "::empty::";
-	const char *old_data = NULL;
-	uint32_t old_mode = S_IFREG | 0644;
-
-	if (node_ctx.action == NODEACT_DELETE) {
-		if (have_text || have_props || node_ctx.srcRev)
-			die("invalid dump: deletion node has "
-				"copyfrom info, text, or properties");
-		fast_export_delete(node_ctx.dst.buf);
-		return;
-	}
-	if (node_ctx.action == NODEACT_REPLACE) {
-		fast_export_delete(node_ctx.dst.buf);
-		node_ctx.action = NODEACT_ADD;
-	}
-	if (node_ctx.srcRev) {
-		fast_export_copy(node_ctx.srcRev, node_ctx.src.buf, node_ctx.dst.buf);
-		if (node_ctx.action == NODEACT_ADD)
-			node_ctx.action = NODEACT_CHANGE;
-	}
-	if (have_text && type == S_IFDIR)
-		die("invalid dump: directories cannot have text attached");
-
-	/*
-	 * Find old content (old_data) and decide on the new mode.
-	 */
-	if (node_ctx.action == NODEACT_CHANGE && !*node_ctx.dst.buf) {
-		if (type != S_IFDIR)
-			die("invalid dump: root of tree is not a regular file");
-		old_data = NULL;
-	} else if (node_ctx.action == NODEACT_CHANGE) {
-		uint32_t mode;
-		old_data = fast_export_read_path(node_ctx.dst.buf, &mode);
-		if (mode == S_IFDIR && type != S_IFDIR)
-			die("invalid dump: cannot modify a directory into a file");
-		if (mode != S_IFDIR && type == S_IFDIR)
-			die("invalid dump: cannot modify a file into a directory");
-		node_ctx.type = mode;
-		old_mode = mode;
-	} else if (node_ctx.action == NODEACT_ADD) {
-		if (type == S_IFDIR)
-			old_data = NULL;
-		else if (have_text)
-			old_data = empty_blob;
-		else
-			die("invalid dump: adds node without text");
-	} else {
-		die("invalid dump: Node-path block lacks Node-action");
-	}
-
-	/*
-	 * Adjust mode to reflect properties.
-	 */
-	if (have_props) {
-		if (!node_ctx.prop_delta)
-			node_ctx.type = type;
-		if (node_ctx.prop_length)
-			read_props();
-	}
-
-	/*
-	 * Save the result.
-	 */
-	if (type == S_IFDIR)	/* directories are not tracked. */
-		return;
-	assert(old_data);
-	if (old_data == empty_blob)
-		/* For the fast_export_* functions, NULL means empty. */
-		old_data = NULL;
-	if (!have_text) {
-		fast_export_modify(node_ctx.dst.buf, node_ctx.type, old_data);
-		return;
-	}
-	if (!node_ctx.text_delta) {
-		fast_export_modify(node_ctx.dst.buf, node_ctx.type, "inline");
-		fast_export_data(node_ctx.type, node_ctx.text_length, &input);
-		return;
-	}
-	fast_export_modify(node_ctx.dst.buf, node_ctx.type, "inline");
-	fast_export_blob_delta(node_ctx.type, old_mode, old_data,
-				node_ctx.text_length, &input);
-}
-
-static void begin_revision(const char *remote_ref)
-{
-	if (!rev_ctx.revision)	/* revision 0 gets no git commit. */
-		return;
-	fast_export_begin_commit(rev_ctx.revision, rev_ctx.author.buf,
-		&rev_ctx.log, dump_ctx.uuid.buf, dump_ctx.url.buf,
-		rev_ctx.timestamp, remote_ref);
-}
-
-static void end_revision(const char *note_ref)
-{
-	struct strbuf mark = STRBUF_INIT;
-	if (rev_ctx.revision) {
-		fast_export_end_commit(rev_ctx.revision);
-		fast_export_begin_note(rev_ctx.revision, "remote-svn",
-				"Note created by remote-svn.", rev_ctx.timestamp, note_ref);
-		strbuf_addf(&mark, ":%"PRIu32, rev_ctx.revision);
-		fast_export_note(mark.buf, "inline");
-		fast_export_buf_to_data(&rev_ctx.note);
-		strbuf_release(&mark);
-	}
-}
-
-void svndump_read(const char *url, const char *local_ref, const char *notes_ref)
-{
-	char *val;
-	char *t;
-	uint32_t active_ctx = DUMP_CTX;
-	uint32_t len;
-
-	reset_dump_ctx(url);
-	while ((t = buffer_read_line(&input))) {
-		val = strchr(t, ':');
-		if (!val)
-			continue;
-		val++;
-		if (*val != ' ')
-			continue;
-		val++;
-
-		/* strlen(key) + 1 */
-		switch (val - t - 1) {
-		case sizeof("SVN-fs-dump-format-version"):
-			if (constcmp(t, "SVN-fs-dump-format-version"))
-				continue;
-			dump_ctx.version = atoi(val);
-			if (dump_ctx.version > 3)
-				die("expected svn dump format version <= 3, found %"PRIu32,
-				    dump_ctx.version);
-			break;
-		case sizeof("UUID"):
-			if (constcmp(t, "UUID"))
-				continue;
-			strbuf_reset(&dump_ctx.uuid);
-			strbuf_addstr(&dump_ctx.uuid, val);
-			break;
-		case sizeof("Revision-number"):
-			if (constcmp(t, "Revision-number"))
-				continue;
-			if (active_ctx == NODE_CTX)
-				handle_node();
-			if (active_ctx == REV_CTX)
-				begin_revision(local_ref);
-			if (active_ctx != DUMP_CTX)
-				end_revision(notes_ref);
-			active_ctx = REV_CTX;
-			reset_rev_ctx(atoi(val));
-			strbuf_addf(&rev_ctx.note, "%s\n", t);
-			break;
-		case sizeof("Node-path"):
-			if (constcmp(t, "Node-"))
-				continue;
-			if (!constcmp(t + strlen("Node-"), "path")) {
-				if (active_ctx == NODE_CTX)
-					handle_node();
-				if (active_ctx == REV_CTX)
-					begin_revision(local_ref);
-				active_ctx = NODE_CTX;
-				reset_node_ctx(val);
-				strbuf_addf(&rev_ctx.note, "%s\n", t);
-				break;
-			}
-			if (constcmp(t + strlen("Node-"), "kind"))
-				continue;
-			strbuf_addf(&rev_ctx.note, "%s\n", t);
-			if (!strcmp(val, "dir"))
-				node_ctx.type = S_IFDIR;
-			else if (!strcmp(val, "file"))
-				node_ctx.type = S_IFREG | 0644;
-			else
-				fprintf(stderr, "Unknown node-kind: %s\n", val);
-			break;
-		case sizeof("Node-action"):
-			if (constcmp(t, "Node-action"))
-				continue;
-			strbuf_addf(&rev_ctx.note, "%s\n", t);
-			if (!strcmp(val, "delete")) {
-				node_ctx.action = NODEACT_DELETE;
-			} else if (!strcmp(val, "add")) {
-				node_ctx.action = NODEACT_ADD;
-			} else if (!strcmp(val, "change")) {
-				node_ctx.action = NODEACT_CHANGE;
-			} else if (!strcmp(val, "replace")) {
-				node_ctx.action = NODEACT_REPLACE;
-			} else {
-				fprintf(stderr, "Unknown node-action: %s\n", val);
-				node_ctx.action = NODEACT_UNKNOWN;
-			}
-			break;
-		case sizeof("Node-copyfrom-path"):
-			if (constcmp(t, "Node-copyfrom-path"))
-				continue;
-			strbuf_reset(&node_ctx.src);
-			strbuf_addstr(&node_ctx.src, val);
-			strbuf_addf(&rev_ctx.note, "%s\n", t);
-			break;
-		case sizeof("Node-copyfrom-rev"):
-			if (constcmp(t, "Node-copyfrom-rev"))
-				continue;
-			node_ctx.srcRev = atoi(val);
-			strbuf_addf(&rev_ctx.note, "%s\n", t);
-			break;
-		case sizeof("Text-content-length"):
-			if (constcmp(t, "Text") && constcmp(t, "Prop"))
-				continue;
-			if (constcmp(t + 4, "-content-length"))
-				continue;
-			{
-				char *end;
-				uintmax_t len;
-
-				len = strtoumax(val, &end, 10);
-				if (!isdigit(*val) || *end)
-					die("invalid dump: non-numeric length %s", val);
-				if (len > maximum_signed_value_of_type(off_t))
-					die("unrepresentable length in dump: %s", val);
-
-				if (*t == 'T')
-					node_ctx.text_length = (off_t) len;
-				else
-					node_ctx.prop_length = (off_t) len;
-				break;
-			}
-		case sizeof("Text-delta"):
-			if (!constcmp(t, "Text-delta")) {
-				node_ctx.text_delta = !strcmp(val, "true");
-				break;
-			}
-			if (constcmp(t, "Prop-delta"))
-				continue;
-			node_ctx.prop_delta = !strcmp(val, "true");
-			break;
-		case sizeof("Content-length"):
-			if (constcmp(t, "Content-length"))
-				continue;
-			len = atoi(val);
-			t = buffer_read_line(&input);
-			if (!t)
-				die_short_read();
-			if (*t)
-				die("invalid dump: expected blank line after content length header");
-			if (active_ctx == REV_CTX) {
-				read_props();
-			} else if (active_ctx == NODE_CTX) {
-				handle_node();
-				active_ctx = INTERNODE_CTX;
-			} else {
-				fprintf(stderr, "Unexpected content length header: %"PRIu32"\n", len);
-				if (buffer_skip_bytes(&input, len) != len)
-					die_short_read();
-			}
-		}
-	}
-	if (buffer_ferror(&input))
-		die_short_read();
-	if (active_ctx == NODE_CTX)
-		handle_node();
-	if (active_ctx == REV_CTX)
-		begin_revision(local_ref);
-	if (active_ctx != DUMP_CTX)
-		end_revision(notes_ref);
-}
-
-static void init(int report_fd)
-{
-	fast_export_init(report_fd);
-	strbuf_init(&dump_ctx.uuid, 4096);
-	strbuf_init(&dump_ctx.url, 4096);
-	strbuf_init(&rev_ctx.log, 4096);
-	strbuf_init(&rev_ctx.author, 4096);
-	strbuf_init(&rev_ctx.note, 4096);
-	strbuf_init(&node_ctx.src, 4096);
-	strbuf_init(&node_ctx.dst, 4096);
-	reset_dump_ctx(NULL);
-	reset_rev_ctx(0);
-	reset_node_ctx(NULL);
-	return;
-}
-
-int svndump_init(const char *filename)
-{
-	if (buffer_init(&input, filename))
-		return error_errno("cannot open %s", filename ? filename : "NULL");
-	init(REPORT_FILENO);
-	return 0;
-}
-
-int svndump_init_fd(int in_fd, int back_fd)
-{
-	if(buffer_fdinit(&input, xdup(in_fd)))
-		return error_errno("cannot open fd %d", in_fd);
-	init(xdup(back_fd));
-	return 0;
-}
-
-void svndump_deinit(void)
-{
-	fast_export_deinit();
-	reset_dump_ctx(NULL);
-	reset_rev_ctx(0);
-	reset_node_ctx(NULL);
-	strbuf_release(&rev_ctx.log);
-	strbuf_release(&rev_ctx.author);
-	strbuf_release(&rev_ctx.note);
-	strbuf_release(&node_ctx.src);
-	strbuf_release(&node_ctx.dst);
-	if (buffer_deinit(&input))
-		fprintf(stderr, "Input error\n");
-	if (ferror(stdout))
-		fprintf(stderr, "Output error\n");
-}
-
-void svndump_reset(void)
-{
-	strbuf_release(&dump_ctx.uuid);
-	strbuf_release(&dump_ctx.url);
-	strbuf_release(&rev_ctx.log);
-	strbuf_release(&rev_ctx.author);
-}
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
deleted file mode 100644
index b8eb12954e..0000000000
--- a/vcs-svn/svndump.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef SVNDUMP_H_
-#define SVNDUMP_H_
-
-int svndump_init(const char *filename);
-int svndump_init_fd(int in_fd, int back_fd);
-void svndump_read(const char *url, const char *local_ref, const char *notes_ref);
-void svndump_deinit(void);
-void svndump_reset(void);
-
-#endif
-- 
2.18.0.1205.g3878b1e64a
