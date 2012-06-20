From: Jeff King <peff@peff.net>
Subject: [PATCHv3 02/11] Makefile: fold MISC_H into LIB_H
Date: Wed, 20 Jun 2012 14:30:56 -0400
Message-ID: <20120620183055.GB30995@sigill.intra.peff.net>
References: <20120620182855.GA26948@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 20:31:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShPgL-0005tL-IN
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 20:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451Ab2FTSbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 14:31:01 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:38993
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932434Ab2FTSa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 14:30:59 -0400
Received: (qmail 26778 invoked by uid 107); 20 Jun 2012 18:30:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 14:30:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 14:30:56 -0400
Content-Disposition: inline
In-Reply-To: <20120620182855.GA26948@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200318>

We keep a list of most of the header files in LIB_H, but
some are split out into MISC_H. The original point
of LIB_H was that it would force recompilation of C files
when any of the library headers changed. It was
over-encompassing, since not all C files included all of the
library headers; this made it simple to maintain, but meant
that we sometimes recompiled when it was not necessary.

Over time, some new headers were omitted from LIB_H, and
rules were added to the Makefile for a few specific targets
to explicitly depend on them. This avoided some unnecessary
recompilation at the cost of having to maintain the
dependency list of those targets manually (e.g., d349a03).

Later, we needed a complete list of headers from which we
should extract strings to localized. Thus 1b8b2e4 introduced
MISC_H to mention all header files not included in LIB_H,
and the concatenation of the two lists is fed to xgettext.
Headers mentioned as dependencies must also be manually
added to MISC_H to receive the benefits of localization.

Having to update multiple locations manually is a pain and
has led to errors. For example, see "git log -Swt-status.h
Makefile" for some back-and-forth between the two locations.
Or the fact that column.h was never added to MISC_H, and
therefore was not localized (which is fixed by this patch).
Moreover, the benefits of keeping these few headers out of
LIB_H is not that great, for two reasons:

  1. The better way to do this is by auto-computing the
     dependencies, which is more accurate and less work to
     maintain. If your compiler supports it, we turn on
     computed header dependencies by default these days. So
     these manual dependencies are used only for people who
     do not have gcc at all (which increases the chance of
     them becoming stale, as many developers will never even
     use them).

  2. Even if you do not have gcc, the manual header
     dependencies do not help all that much.  They obviously
     cannot help with an initial compilation (since their
     purpose is to avoid unnecessary recompilation when a
     header changes), which means they are only useful when
     building a new version of git in the working tree that
     held an existing build (e.g., after checkout or during a
     bisection). But since a change of a header in LIB_H
     will force recompilation, and given that the vast
     majority of headers are in LIB_H, most version changes
     will result in a full rebuild anyway.

Let's just fold MISC_H into LIB_H and get rid of these
manual rules. The worst case is some extra compilation, but
even that is unlikely to matter due to the reasons above.

The one exception is that we should keep common-cmds.h
separate. Because it is generated, the computed dependencies
do not handle it properly, and we must keep separate
individual dependencies on it. Let's therefore rename MISC_H
to GENERATED_H to make it more clear what should go in it.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 45 ++++++++++++++++-----------------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/Makefile b/Makefile
index 72cdb56..500966b 100644
--- a/Makefile
+++ b/Makefile
@@ -397,7 +397,7 @@ XDIFF_OBJS =
 VCSSVN_H =
 VCSSVN_OBJS =
 VCSSVN_TEST_OBJS =
-MISC_H =
+GENERATED_H =
 EXTRA_CPPFLAGS =
 LIB_H =
 LIB_OBJS =
@@ -574,30 +574,22 @@ VCSSVN_H += vcs-svn/fast_export.h
 VCSSVN_H += vcs-svn/svndiff.h
 VCSSVN_H += vcs-svn/svndump.h
 
-MISC_H += bisect.h
-MISC_H += branch.h
-MISC_H += bundle.h
-MISC_H += common-cmds.h
-MISC_H += fetch-pack.h
-MISC_H += reachable.h
-MISC_H += send-pack.h
-MISC_H += shortlog.h
-MISC_H += tar.h
-MISC_H += thread-utils.h
-MISC_H += url.h
-MISC_H += walker.h
-MISC_H += wt-status.h
+GENERATED_H += common-cmds.h
 
 LIB_H += advice.h
 LIB_H += archive.h
 LIB_H += argv-array.h
 LIB_H += attr.h
+LIB_H += bisect.h
 LIB_H += blob.h
+LIB_H += branch.h
 LIB_H += builtin.h
 LIB_H += bulk-checkin.h
+LIB_H += bundle.h
 LIB_H += cache-tree.h
 LIB_H += cache.h
 LIB_H += color.h
+LIB_H += column.h
 LIB_H += commit.h
 LIB_H += compat/bswap.h
 LIB_H += compat/cygwin.h
@@ -618,6 +610,7 @@ LIB_H += diff.h
 LIB_H += diffcore.h
 LIB_H += dir.h
 LIB_H += exec_cmd.h
+LIB_H += fetch-pack.h
 LIB_H += fmt-merge-msg.h
 LIB_H += fsck.h
 LIB_H += gettext.h
@@ -627,6 +620,7 @@ LIB_H += graph.h
 LIB_H += grep.h
 LIB_H += hash.h
 LIB_H += help.h
+LIB_H += http.h
 LIB_H += kwset.h
 LIB_H += levenshtein.h
 LIB_H += list-objects.h
@@ -649,6 +643,7 @@ LIB_H += pkt-line.h
 LIB_H += progress.h
 LIB_H += prompt.h
 LIB_H += quote.h
+LIB_H += reachable.h
 LIB_H += reflog-walk.h
 LIB_H += refs.h
 LIB_H += remote.h
@@ -656,9 +651,11 @@ LIB_H += rerere.h
 LIB_H += resolve-undo.h
 LIB_H += revision.h
 LIB_H += run-command.h
+LIB_H += send-pack.h
 LIB_H += sequencer.h
 LIB_H += sha1-array.h
 LIB_H += sha1-lookup.h
+LIB_H += shortlog.h
 LIB_H += sideband.h
 LIB_H += sigchain.h
 LIB_H += strbuf.h
@@ -666,14 +663,18 @@ LIB_H += streaming.h
 LIB_H += string-list.h
 LIB_H += submodule.h
 LIB_H += tag.h
+LIB_H += tar.h
 LIB_H += thread-utils.h
 LIB_H += transport.h
 LIB_H += tree-walk.h
 LIB_H += tree.h
 LIB_H += unpack-trees.h
+LIB_H += url.h
 LIB_H += userdiff.h
 LIB_H += utf8.h
 LIB_H += varint.h
+LIB_H += walker.h
+LIB_H += wt-status.h
 LIB_H += xdiff-interface.h
 LIB_H += xdiff/xdiff.h
 
@@ -2237,20 +2238,6 @@ else
 # gcc detects!
 
 $(GIT_OBJS): $(LIB_H)
-builtin/branch.o builtin/checkout.o builtin/clone.o builtin/reset.o branch.o transport.o: branch.h
-builtin/bundle.o bundle.o transport.o: bundle.h
-builtin/bisect--helper.o builtin/rev-list.o bisect.o: bisect.h
-builtin/clone.o builtin/fetch-pack.o transport.o: fetch-pack.h
-builtin/index-pack.o builtin/grep.o builtin/pack-objects.o transport-helper.o thread-utils.o: thread-utils.h
-builtin/send-pack.o transport.o: send-pack.h
-builtin/log.o builtin/shortlog.o: shortlog.h
-builtin/prune.o builtin/reflog.o reachable.o: reachable.h
-builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
-builtin/tar-tree.o archive-tar.o: tar.h
-connect.o transport.o url.o http-backend.o: url.h
-builtin/branch.o builtin/commit.o builtin/tag.o column.o help.o pager.o: column.h
-http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.h
-http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h url.h
 
 xdiff-interface.o $(XDIFF_OBJS): $(XDIFF_H)
 
@@ -2347,7 +2334,7 @@ XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
 	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
 XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --keyword=__ --language=Perl
-LOCALIZED_C := $(C_OBJ:o=c) $(LIB_H) $(XDIFF_H) $(VCSSVN_H) $(MISC_H)
+LOCALIZED_C := $(C_OBJ:o=c) $(LIB_H) $(XDIFF_H) $(VCSSVN_H) $(GENERATED_H)
 LOCALIZED_SH := $(SCRIPT_SH)
 LOCALIZED_PERL := $(SCRIPT_PERL)
 
-- 
1.7.11.5.gc0eeaa8
