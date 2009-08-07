From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFC] Makefile: build/install git-remote-<scheme> as hardlinks
 when able
Date: Fri, 07 Aug 2009 12:19:07 -0700
Message-ID: <7v7hxfxwic.fsf_-_@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0908050053580.2147@iabervon.org>
 <alpine.DEB.1.00.0908051206460.8306@pacific.mpi-cbg.de>
 <alpine.LNX.2.00.0908051145250.2147@iabervon.org>
 <7v63d06wjq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 07 21:19:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZUyJ-00010D-5i
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 21:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933089AbZHGTTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 15:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933057AbZHGTTO
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 15:19:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933049AbZHGTTN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 15:19:13 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6EB122018E;
	Fri,  7 Aug 2009 15:19:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D00A12018C; Fri,  7 Aug 2009
 15:19:08 -0400 (EDT)
In-Reply-To: <7v63d06wjq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 06 Aug 2009 22\:08\:09 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3108859C-8387-11DE-885E-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125209>

Three git-remote-<scheme> helper programs are the same executable that
uses libcurl to implement the named protocol transfer.  Instead of
running the linker three times to build different programs, build one and
hardlink (or copy if the underlying filesystem does not support it) the
other two.

Install one to $(gitexecdir) and make the other two hardnlinks, in a way
similar to how we install programs that implement built-in commands.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

I do not particularly like this one.  ALL_PROGRAMS does not include any of
the built-in programs, but because CURL_SYNONYMS are part of PROGRAMS, the
install step needs to filter them out, so that we can arrange to make
hardlinks to the synonyms in a separate step.

Putting git-remote-http$X on OTHER_PROGRAMS like we do for git$X does not
work well either, as that won't install it in gitexecdir.

 Makefile |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index e29b15f..438cffb 100644
--- a/Makefile
+++ b/Makefile
@@ -383,7 +383,8 @@ BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
 BUILT_INS += git-whatchanged$X
 
-# what 'all' will build and 'install' will install, in gitexecdir
+# what 'all' will build and 'install' will install in gitexecdir,
+# excluding programs for built-in commands
 ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
 
 # what 'all' will build but not install in gitexecdir
@@ -980,7 +981,8 @@ else
 	else
 		CURL_LIBCURL = -lcurl
 	endif
-	PROGRAMS += git-remote-http$X git-remote-https$X git-remote-ftp$X git-http-fetch$X
+	CURL_SYNONYMS = git-remote-https$X git-remote-ftp$X
+	PROGRAMS += git-remote-http$X $(CURL_SYNONYMS) git-http-fetch$X
 	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
@@ -1256,6 +1258,7 @@ ifndef V
 	QUIET_LINK     = @echo '   ' LINK $@;
 	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
 	QUIET_GEN      = @echo '   ' GEN $@;
+	QUIET_LNCP     = @echo '   ' LN/CP $@;
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
@@ -1494,10 +1497,16 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-git-remote-http$X git-remote-https$X git-remote-ftp$X: remote-curl.o http.o http-walker.o $(GITLIBS)
+git-remote-http$X: remote-curl.o http.o http-walker.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
+$(CURL_SYNONYMS): git-remote-http$X
+	$(QUIET_LNCP)$(RM) $@ && \
+	ln $< $@ 2>/dev/null || \
+	ln -s $< $@ 2>/dev/null || \
+	cp $< $@
+
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H) $(wildcard */*.h)
 builtin-revert.o wt-status.o: wt-status.h
@@ -1653,7 +1662,7 @@ export gitexec_instdir
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(filter-out $(CURL_SYNONYMS), $(ALL_PROGRAMS)) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-archive$X git-shell$X git-cvsserver '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 ifndef NO_PERL
@@ -1679,6 +1688,12 @@ endif
 		ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$execdir/git$X" "$$execdir/$$p" || exit; \
 	  done; } && \
+	{ for p in $(CURL_SYNONYMS); do \
+		$(RM) "$$execdir/$$p" && \
+		ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
+		ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
+		cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; \
+	  done; } && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
 install-doc:
