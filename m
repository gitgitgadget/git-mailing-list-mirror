Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F965C388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025DC20724
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="n6nIYwq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbgKEVJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:09:53 -0500
Received: from avasout03.plus.net ([84.93.230.244]:34282 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVJw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 16:09:52 -0500
Received: from [10.0.2.15] ([195.213.6.50])
        by smtp with ESMTPA
        id amVykLtRD99nqamVzkhVl1; Thu, 05 Nov 2020 21:09:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604610591; bh=VTztjWAe6lDGJM/w9zS9NmRTSoDROmuOcK2soBHh+Og=;
        h=To:Cc:From:Subject:Date;
        b=n6nIYwq8lVq788fUhBzBUjRJdFeL7rXnBjR1HHt9pdNMjRg3+KMBAa0jDjkzQQMb8
         D68Cyhtg0o+tTOX9hrTXYdFBd1mMclAByORvfdnXs+TVVzmJSErYNeMeWUhP9ebbjj
         RPiHi4MHtGUE23O5EA7RkdUc5H0BQiUjPLKulHdGb90m4haXrMfHfHff4mOLXQX87Q
         m+SaGr5uCuzXpsC64wfkJFkz0rt3rFHk54CgTL/lXj9rEefF9kk7qG76gidGltmj7t
         cz2+fnT5aFSGZGdp/0bnfcGqQVWwbWsVg/xWknLEqIEtCsXO/og5PAEKNLwzYoaC17
         kCf5PwyLVc4pg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Uoz4y94B c=1 sm=1 tr=0
 a=n8v6pzUV7wpcOOJT0hzGjw==:117 a=n8v6pzUV7wpcOOJT0hzGjw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=S6w345GtZ0HUjcSwCL0A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     GIT Mailing-list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 7/8] Makefile: don't delete dist tarballs directly by name
Message-ID: <48fdd198-93ad-7282-27e6-9a0c6de93067@ramsayjones.plus.com>
Date:   Thu, 5 Nov 2020 21:09:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAPZoYqboI/gE1ccq5i1lcN9WVgNygxAslHpr1sZVq9y1QrB6Yp+7vFCeFPdh+4K6wsfzxJlvQiX0IKqDznMf2kUFM165UXAIL4jZfaQV7MfQE7hSJ9q
 /MPvrIYN22Cu5pGJyHAE/KeuTE1PKW6D6ideMRuJ3sdM8/nkIn+MGm+lVo6wPRxM2nzJKU/BIUkV9w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


A future patch requires the 'clean' target not to depend, either
directly or indirectly, on the $(GIT_VERSION) variable. However, the
distribution tarballs, $(GIT_TARNAME).tar.gz, $(htmldocs).tar.gz and
$(manpages).tar.gz, all depend on $(GIT_VERSION). The 'clean' target
attempts to remove these tarballs by name and so has the unwanted
dependency.

The first attempt to remove this dependency involved creating the
distribution tarballs in a new top-level directory (e.g. 'dist-tars/'),
that didn't reference the version number, and could be simply removed
in the 'clean' target. Unfortunately, this could lead to breaking an
unknown number of scripts for an unknown number of developers. (This
actually breaks one of my own scripts!). Despite this being my
preferred solution, I had to abandon this approach, since I don't know
what problems it may cause.

The second attempt involved using a wildcard pattern, in place of the
$(GIT_VERSION) variable, in the distribution tarball filenames. This
also proved to be an inadequate solution, no matter how elaborate the
pattern became, because it was always possible that it could lead to
the removal of some '*.tar.gz' file that would, otherwise, not have
been removed (eg. git-2.29.0-saved-build.tar.gz).

Also, note that the current 'clean' target requires that you do not move
the current branch away from the commit you were on, when creating the
distribution tarballs, before issuing the 'make clean'. If you do so,
then you will find that the tarballs are not removed:

  $ git checkout nclean
  ...
  $ make dist
  ...
  $ ls *.tar.gz
  git-2.29.0.6.g8255a76caf.tar.gz
  $

  $ git checkout master
  Switched to branch 'master'
  Your branch is up to date with 'origin/master'.
  $ make clean
  ...
  rm -f git-2.29.2.154.g8a58376a31.tar.gz
  rm -f git-htmldocs-2.29.2.154.g8a58376a31.tar.gz git-manpages-2.29.2.154.g8a58376a31.tar.gz
  ...
  $

  $ ls *.tar.gz
  git-2.29.0.6.g8255a76caf.tar.gz
  $

[I always find the documentation tarballs of the last release intact
when I am just about to create the new tarballs for this release. This
means that I invariably remove them by hand.]

In order to remove the version dependency, append the name of each
distribution tarball created, in the 'dist' and 'doc-dist' targets, to
a file ('dist-tars'). Then in the 'clean' target, simply iterate through
the names in this file, if any, removing them as we go. (Not forgetting
to clean up the 'dist-tars' file as well).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 .gitignore |  1 +
 Makefile   | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index 6232d33924..425b8cc2a4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -191,6 +191,7 @@
 /gitweb/static/gitweb.min.*
 /config-list.h
 /command-list.h
+/dist-tars
 *.tar.gz
 *.dsc
 *.deb
diff --git a/Makefile b/Makefile
index 90e91a2185..bc9ce28bc3 100644
--- a/Makefile
+++ b/Makefile
@@ -3083,6 +3083,7 @@ dist: git-archive$(X) configure
 		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
 	@$(RM) -r .dist-tmp-dir
 	gzip -f -9 $(GIT_TARNAME).tar
+	@echo $(GIT_TARNAME).tar.gz >>dist-tars
 
 rpm::
 	@echo >&2 "Use distro packaged sources to run rpmbuild"
@@ -3112,6 +3113,7 @@ dist-doc:
 	$(MAKE) -C Documentation WEBDOC_DEST=../.doc-tmp-dir install-webdoc
 	cd .doc-tmp-dir && $(TAR) cf ../$(htmldocs).tar $(TAR_DIST_EXTRA_OPTS) .
 	gzip -n -9 -f $(htmldocs).tar
+	@echo $(htmldocs).tar.gz >>dist-tars
 	:
 	$(RM) -r .doc-tmp-dir
 	mkdir -p .doc-tmp-dir/man1 .doc-tmp-dir/man5 .doc-tmp-dir/man7
@@ -3122,6 +3124,7 @@ dist-doc:
 		install
 	cd .doc-tmp-dir && $(TAR) cf ../$(manpages).tar $(TAR_DIST_EXTRA_OPTS) .
 	gzip -n -9 -f $(manpages).tar
+	@echo $(manpages).tar.gz >>dist-tars
 	$(RM) -r .doc-tmp-dir
 
 ### Cleaning rules
@@ -3151,8 +3154,12 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) -r po/build/
 	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
 	$(RM) -r .dist-tmp-dir .doc-tmp-dir
-	$(RM) $(GIT_TARNAME).tar.gz
-	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
+	@if test -s dist-tars; then \
+		for i in $$(cat dist-tars); do \
+			$(RM) $$i; \
+		done \
+	fi
+	$(RM) dist-tars
 	$(MAKE) -C Documentation/ clean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
 ifndef NO_PERL
-- 
2.29.0
