From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] Makefile: use `find` to determine static header
 dependencies
Date: Mon, 25 Aug 2014 16:00:42 -0400
Message-ID: <20140825200042.GJ30953@peff.net>
References: <20140822042716.GE27992@peff.net>
 <20140822043303.GB18192@peff.net>
 <20140825194641.GS20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 22:00:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM0Rd-0004yi-CO
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 22:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933462AbaHYUAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 16:00:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:58672 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933052AbaHYUAo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 16:00:44 -0400
Received: (qmail 1047 invoked by uid 102); 25 Aug 2014 20:00:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Aug 2014 15:00:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2014 16:00:42 -0400
Content-Disposition: inline
In-Reply-To: <20140825194641.GS20185@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255860>

On Mon, Aug 25, 2014 at 12:46:41PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > -LOCALIZED_C := $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
> > +LOCALIZED_C = $(C_OBJ:o=c) $(GENERATED_H)
> 
> Why is LIB_H dropped here?  This would mean that po/git.pot stops
> including strings from macros and static inline functions in headers
> (e.g., in parse-options.h).

Ick, this is an accidental leftover from the earlier iteration of the
patch, which moved that part to a separate line (inside my gross
GIT_REAL_POT conditional). The extra line went away, but I forgot to add
$(LIB_H) back in here. Thanks for noticing.

Here's a revised version of the patch which fixes it (and I
double-checked to make sure it continues to not execute the find unless
you are doing a "make pot").

-- >8 --
Subject: Makefile: use `find` to determine static header dependencies

Most modern platforms will use automatically computed header
dependencies to figure out when a C file needs rebuilt due
to a header changing. With old compilers, however, we
fallback to a static list of header files. If any of them
changes, we recompile everything. This is overly
conservative, but the best we can do on older platforms.

It is unfortunately easy for our static header list to grow
stale, as none of the regular developers make use of it.
Instead of trying to keep it up to date, let's invoke "find"
to generate the list dynamically.

Since we do not use the value $(LIB_H) unless either
COMPUTE_HEADER_DEPENDENCIES is turned on or the user is
building "po/git.pot" (where it comes in via $(LOCALIZED_C),
make is smart enough to not even run this "find" in most
cases. However, we do need to stop using the "immediate"
variable assignment ":=" for $(LOCALIZED_C). That's OK,
because it was not otherwise useful here.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 140 ++++-----------------------------------------------------------
 1 file changed, 8 insertions(+), 132 deletions(-)

diff --git a/Makefile b/Makefile
index cf0ccdf..a4fc440 100644
--- a/Makefile
+++ b/Makefile
@@ -432,7 +432,6 @@ XDIFF_OBJS =
 VCSSVN_OBJS =
 GENERATED_H =
 EXTRA_CPPFLAGS =
-LIB_H =
 LIB_OBJS =
 PROGRAM_OBJS =
 PROGRAMS =
@@ -631,131 +630,11 @@ VCSSVN_LIB = vcs-svn/lib.a
 
 GENERATED_H += common-cmds.h
 
-LIB_H += advice.h
-LIB_H += archive.h
-LIB_H += argv-array.h
-LIB_H += attr.h
-LIB_H += bisect.h
-LIB_H += blob.h
-LIB_H += branch.h
-LIB_H += builtin.h
-LIB_H += bulk-checkin.h
-LIB_H += bundle.h
-LIB_H += cache-tree.h
-LIB_H += cache.h
-LIB_H += color.h
-LIB_H += column.h
-LIB_H += commit.h
-LIB_H += compat/bswap.h
-LIB_H += compat/mingw.h
-LIB_H += compat/obstack.h
-LIB_H += compat/poll/poll.h
-LIB_H += compat/precompose_utf8.h
-LIB_H += compat/terminal.h
-LIB_H += compat/win32/dirent.h
-LIB_H += compat/win32/pthread.h
-LIB_H += compat/win32/syslog.h
-LIB_H += connected.h
-LIB_H += convert.h
-LIB_H += credential.h
-LIB_H += csum-file.h
-LIB_H += decorate.h
-LIB_H += delta.h
-LIB_H += diff.h
-LIB_H += diffcore.h
-LIB_H += dir.h
-LIB_H += exec_cmd.h
-LIB_H += ewah/ewok.h
-LIB_H += ewah/ewok_rlw.h
-LIB_H += fetch-pack.h
-LIB_H += fmt-merge-msg.h
-LIB_H += fsck.h
-LIB_H += gettext.h
-LIB_H += git-compat-util.h
-LIB_H += gpg-interface.h
-LIB_H += graph.h
-LIB_H += grep.h
-LIB_H += hashmap.h
-LIB_H += help.h
-LIB_H += http.h
-LIB_H += kwset.h
-LIB_H += levenshtein.h
-LIB_H += line-log.h
-LIB_H += line-range.h
-LIB_H += list-objects.h
-LIB_H += ll-merge.h
-LIB_H += log-tree.h
-LIB_H += mailmap.h
-LIB_H += merge-blobs.h
-LIB_H += merge-recursive.h
-LIB_H += mergesort.h
-LIB_H += notes-cache.h
-LIB_H += notes-merge.h
-LIB_H += notes-utils.h
-LIB_H += notes.h
-LIB_H += object.h
-LIB_H += pack-objects.h
-LIB_H += pack-revindex.h
-LIB_H += pack.h
-LIB_H += pack-bitmap.h
-LIB_H += parse-options.h
-LIB_H += patch-ids.h
-LIB_H += pathspec.h
-LIB_H += pkt-line.h
-LIB_H += prio-queue.h
-LIB_H += progress.h
-LIB_H += prompt.h
-LIB_H += quote.h
-LIB_H += reachable.h
-LIB_H += reflog-walk.h
-LIB_H += refs.h
-LIB_H += remote.h
-LIB_H += rerere.h
-LIB_H += resolve-undo.h
-LIB_H += revision.h
-LIB_H += run-command.h
-LIB_H += send-pack.h
-LIB_H += sequencer.h
-LIB_H += sha1-array.h
-LIB_H += sha1-lookup.h
-LIB_H += shortlog.h
-LIB_H += sideband.h
-LIB_H += sigchain.h
-LIB_H += strbuf.h
-LIB_H += streaming.h
-LIB_H += string-list.h
-LIB_H += submodule.h
-LIB_H += tag.h
-LIB_H += tar.h
-LIB_H += thread-utils.h
-LIB_H += transport.h
-LIB_H += tree-walk.h
-LIB_H += tree.h
-LIB_H += unpack-trees.h
-LIB_H += unicode_width.h
-LIB_H += url.h
-LIB_H += urlmatch.h
-LIB_H += userdiff.h
-LIB_H += utf8.h
-LIB_H += varint.h
-LIB_H += vcs-svn/fast_export.h
-LIB_H += vcs-svn/line_buffer.h
-LIB_H += vcs-svn/repo_tree.h
-LIB_H += vcs-svn/sliding_window.h
-LIB_H += vcs-svn/svndiff.h
-LIB_H += vcs-svn/svndump.h
-LIB_H += walker.h
-LIB_H += wildmatch.h
-LIB_H += wt-status.h
-LIB_H += xdiff-interface.h
-LIB_H += xdiff/xdiff.h
-LIB_H += xdiff/xdiffi.h
-LIB_H += xdiff/xemit.h
-LIB_H += xdiff/xinclude.h
-LIB_H += xdiff/xmacros.h
-LIB_H += xdiff/xprepare.h
-LIB_H += xdiff/xtypes.h
-LIB_H += xdiff/xutils.h
+LIB_H = $(shell $(FIND) . \
+	-name .git -prune -o \
+	-name t -prune -o \
+	-name Documentation -prune -o \
+	-name '*.h' -print)
 
 LIB_OBJS += abspath.o
 LIB_OBJS += advice.o
@@ -1381,7 +1260,6 @@ ifdef NO_INET_PTON
 endif
 ifndef NO_UNIX_SOCKETS
 	LIB_OBJS += unix-socket.o
-	LIB_H += unix-socket.h
 	PROGRAM_OBJS += credential-cache.o
 	PROGRAM_OBJS += credential-cache--daemon.o
 endif
@@ -1405,12 +1283,10 @@ endif
 ifdef BLK_SHA1
 	SHA1_HEADER = "block-sha1/sha1.h"
 	LIB_OBJS += block-sha1/sha1.o
-	LIB_H += block-sha1/sha1.h
 else
 ifdef PPC_SHA1
 	SHA1_HEADER = "ppc/sha1.h"
 	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
-	LIB_H += ppc/sha1.h
 else
 ifdef APPLE_COMMON_CRYPTO
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
@@ -2128,9 +2004,9 @@ XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
 XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --keyword=__ --language=Perl
-LOCALIZED_C := $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
-LOCALIZED_SH := $(SCRIPT_SH)
-LOCALIZED_PERL := $(SCRIPT_PERL)
+LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
+LOCALIZED_SH = $(SCRIPT_SH)
+LOCALIZED_PERL = $(SCRIPT_PERL)
 
 ifdef XGETTEXT_INCLUDE_TESTS
 LOCALIZED_C += t/t0200/test.c
-- 
2.1.0.346.ga0367b9
