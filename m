From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] shell: do not play duplicated definition games to shrink
 the executable
Date: Tue, 19 Aug 2008 18:06:06 -0700
Message-ID: <7vd4k4v6kh.fsf@gitster.siamese.dyndns.org>
References: <20080818123727.GB11842@schiele.dyndns.org>
 <7vy72tkfu0.fsf@gitster.siamese.dyndns.org>
 <20080819072650.GE11842@schiele.dyndns.org>
 <7vpro5fnke.fsf@gitster.siamese.dyndns.org> <48AA8931.1030009@viscovery.net>
 <20080819091830.GG11842@schiele.dyndns.org>
 <7vbpzoy53d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 03:07:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVcAX-0003uf-Ms
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 03:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbYHTBGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 21:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbYHTBGO
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 21:06:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020AbYHTBGN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 21:06:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8F4CF53729;
	Tue, 19 Aug 2008 21:06:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9C30C53727; Tue, 19 Aug 2008 21:06:08 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2E661E74-6E54-11DD-BC2A-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92945>

Playing with linker games to shrink git-shell did not go well with various
other platforms and compilers.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |    9 +--------
 shell.c  |    8 --------
 2 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index 53ab4b5..71339e1 100644
--- a/Makefile
+++ b/Makefile
@@ -333,7 +333,6 @@ endif
 export PERL_PATH
 
 LIB_FILE=libgit.a
-COMPAT_LIB = compat/lib.a
 XDIFF_LIB=xdiff/lib.a
 
 LIB_H += archive.h
@@ -1223,12 +1222,6 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-$(COMPAT_LIB): $(COMPAT_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(COMPAT_OBJS)
-
-git-shell$X: abspath.o ctype.o exec_cmd.o quote.o strbuf.o usage.o wrapper.o shell.o $(COMPAT_LIB)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(COMPAT_LIB)
-
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
 builtin-revert.o wt-status.o: wt-status.h
@@ -1441,7 +1434,7 @@ distclean: clean
 
 clean:
 	$(RM) *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
-		$(LIB_FILE) $(XDIFF_LIB) $(COMPAT_LIB)
+		$(LIB_FILE) $(XDIFF_LIB)
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags cscope*
diff --git a/shell.c b/shell.c
index 6a48de0..0f6a727 100644
--- a/shell.c
+++ b/shell.c
@@ -3,14 +3,6 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 
-/* Stubs for functions that make no sense for git-shell. These stubs
- * are provided here to avoid linking in external redundant modules.
- */
-void release_pack_memory(size_t need, int fd){}
-void trace_argv_printf(const char **argv, const char *fmt, ...){}
-void trace_printf(const char *fmt, ...){}
-
-
 static int do_generic_cmd(const char *me, char *arg)
 {
 	const char *my_argv[4];
-- 
1.6.0.6.gc6670b
