From: Jeff King <peff@peff.net>
Subject: [PATCHv3 04/11] Makefile: apply dependencies consistently to
 sparse/asm targets
Date: Wed, 20 Jun 2012 14:31:33 -0400
Message-ID: <20120620183133.GD30995@sigill.intra.peff.net>
References: <20120620182855.GA26948@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 20:31:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShPgz-0006sa-8x
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 20:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432Ab2FTSbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 14:31:38 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39004
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932309Ab2FTSbh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 14:31:37 -0400
Received: (qmail 26840 invoked by uid 107); 20 Jun 2012 18:31:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 14:31:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 14:31:33 -0400
Content-Disposition: inline
In-Reply-To: <20120620182855.GA26948@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200320>

When a C file "foo.c" depends on a generated header file, we
note the dependency for the "foo.o" target. However, we
should also note it for other targets that are built from
foo.c, like "foo.sp" and "foo.s". These tend to be missed
because the latter two are not part of the default build,
and are typically built after a regular build which will
generate the header.  Let's be consistent about including
them in dependencies.

This also makes us more consistent with nearby lines which
tack on EXTRA_CPPFLAGS when building certain files.  These
flags may sometimes require extra dependencies to be added
(e.g., like GIT-VERSION-FILE; this is not the case for any
of the updated lines in this patch, but it is establishing a
style that will be used in later patches). Technically the
".sp" and ".s" targets do not care about these dependencies,
because they are force-built (".sp" because it is a phony
target, and ".s" because we explicitly force a rebuild).

Since the blocks in question are about communicating "things
built from foo.c depend on these flags", it frees the reader
from having to know or care more about how those targets are
implemented, and why it is OK for only "foo.o" to depend on
GIT-VERSION-FILE while "foo.sp" and "foo.s" both are
impacted by $(GIT_VERSION). And it helps future-proof us if
those force-build details should ever change.

This patch explicitly does not update the static header
dependencies used when COMPUTED_HEADER_DEPENDENCIES is off.
They are similar to the GIT-VERSION-FILE case above, in that
technically "foo.s" would depend on its included headers,
but it is irrelevant because we force-build it anyway. So it
would be tempting to update them in the same way (for
readability and future-proofing). However, those rules are
meant as a fallback to the computed header dependencies,
which do not handle ".s" and ".sp" at all (and are a much
harder problem to solve, as gcc is the one generating those
dependency lists).

So let's leave that harder problem until (and if) somebody
wants to change the ".sp" and ".s" rules, and keep the
static header dependencies consistent with the computed
ones.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 58e2099..d2112f8 100644
--- a/Makefile
+++ b/Makefile
@@ -1982,9 +1982,9 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
-help.sp help.o: common-cmds.h
+help.sp help.s help.o: common-cmds.h
 
-builtin/help.sp builtin/help.o: common-cmds.h
+builtin/help.sp builtin/help.s builtin/help.o: common-cmds.h
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
-- 
1.7.11.5.gc0eeaa8
