Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0F461F859
	for <e@80x24.org>; Mon, 15 Aug 2016 08:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbcHOIBZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 04:01:25 -0400
Received: from mx.mylinuxtime.de ([148.251.109.235]:44170 "EHLO
	mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbcHOIBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 04:01:25 -0400
X-Greylist: delayed 524 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Aug 2016 04:01:24 EDT
Received: from leda.eworm.de (unknown [10.10.1.2])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id 3947D25B0E;
	Mon, 15 Aug 2016 09:52:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de 3947D25B0E
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
	t=1471247558; bh=Ip0YheHcRyBxQyJTJmtK1cBNStmCnNkyJlmTGCUH5pc=;
	h=From:To:Cc:Subject:Date;
	b=C7DQUCCvMl7WEE2WoosxM6a876hT+KOyzrR7HUXS+DY436Aze5QJgmuAnyXSOg/Dn
	 AJ2uzLFiaCpYtqHtNh6uaaJPU9Yemlf7YzCZoOFRrTk3fpFbpgvFk44vqap0BDFCSu
	 2IlSQux62Jtq/PfuwEn+zjLGKi9K5DqWwD4pZI8Y=
Received: by leda.eworm.de (Postfix, from userid 1000)
	id 0220A100DBB; Mon, 15 Aug 2016 09:52:32 +0200 (CEST)
From:	Christian Hesse <list@eworm.de>
To:	git@vger.kernel.org
Cc:	Christian Hesse <mail@eworm.de>
Subject: [PATCH 1/1] do not add common-main to lib
Date:	Mon, 15 Aug 2016 09:52:07 +0200
Message-Id: <20160815075207.31280-1-list@eworm.de>
X-Mailer: git-send-email 2.9.3
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Christian Hesse <mail@eworm.de>

Commit 08aade70 (mingw: declare main()'s argv as const) changed
declaration of main function. This breaks linking external projects
(e.g. cgit) to libgit.a with:

error: Multiple definition of `main'

So do not add common-main to lib and let projects have their own
main function.

Signed-off-by: Christian Hesse <mail@eworm.de>
---
 Makefile | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index d96ecb7..1aea768 100644
--- a/Makefile
+++ b/Makefile
@@ -953,7 +953,8 @@ BUILTIN_OBJS += builtin/verify-tag.o
 BUILTIN_OBJS += builtin/worktree.o
 BUILTIN_OBJS += builtin/write-tree.o
 
-GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB)
+GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
+GITCOMMON = common-main.o $(GITLIBS)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -1593,15 +1594,15 @@ TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 DIFF_SQ = $(subst ','\'',$(DIFF))
 PERLLIB_EXTRA_SQ = $(subst ','\'',$(PERLLIB_EXTRA))
 
-# We must filter out any object files from $(GITLIBS),
+# We must filter out any object files from $(GITCOMMON),
 # as it is typically used like:
 #
-#   foo: foo.o $(GITLIBS)
+#   foo: foo.o $(GITCOMMON)
 #	$(CC) $(filter %.o,$^) $(LIBS)
 #
 # where we use it as a dependency. Since we also pull object files
 # from the dependency list, that would make each entry appear twice.
-LIBS = $(filter-out %.o, $(GITLIBS)) $(EXTLIBS)
+LIBS = $(filter-out %.o, $(GITCOMMON)) $(EXTLIBS)
 
 BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' \
 	$(COMPAT_CFLAGS)
@@ -1741,7 +1742,7 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
-git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
+git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITCOMMON)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
@@ -2033,21 +2034,21 @@ compat/nedmalloc/nedmalloc.sp compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS = \
 compat/nedmalloc/nedmalloc.sp: SPARSE_FLAGS += -Wno-non-pointer-null
 endif
 
-git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
+git-%$X: %.o GIT-LDFLAGS $(GITCOMMON)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
+git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITCOMMON)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(IMAP_SEND_LDFLAGS)
 
-git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
+git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITCOMMON)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(LIBS)
-git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
+git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITCOMMON)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
-git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) $(VCSSVN_LIB)
+git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITCOMMON) $(VCSSVN_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
 	$(VCSSVN_LIB)
 
@@ -2057,7 +2058,7 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
-$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
+$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITCOMMON)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
@@ -2271,7 +2272,7 @@ t/helper/test-svn-fe$X: $(VCSSVN_LIB)
 
 .PRECIOUS: $(TEST_OBJS)
 
-t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
+t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITCOMMON)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: t/helper/test-sha1$X
-- 
2.9.3

