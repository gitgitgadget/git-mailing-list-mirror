Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833D4C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420B623AC8
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbgLHWgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:36:55 -0500
Received: from avasout02.plus.net ([212.159.14.17]:60896 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgLHWgz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:36:55 -0500
Received: from [10.0.2.15] ([147.147.167.100])
        by smtp with ESMTPA
        id mlazkHI7Y0K1Omlb0kvnBp; Tue, 08 Dec 2020 22:36:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1607466994; bh=YXTxsP4wW85bpUfWsIFOiKObY5kbloIglwJEgk0hVtg=;
        h=To:Cc:From:Subject:Date;
        b=ekkZtzUPQ5l6ej65ok9YqviPmt+Q54eK3j1UaTW6Lz7lgGdDsDmMStEfhl0I+hLmM
         7MK4JDtWsp005r82zn6Gt/7lU+seYlL1gW8DGR3qjR33pKVGi/+j966HjOKiKUIoxk
         W2OOdjFIWhl2Le2pGbOZkBu9WCfHt7y+vni9iFLBvP/nzwFU31iuRnP/JTLLTsO+Hl
         kJp3EtlDVF3Y4P2xN4DlUz/x6mMkTLxZ9xUqraB/UCUNTXFCROWFBKndRqHlbAMZ69
         fAt1GsxZQLt+UD1o1SbmyF8wfKV+9CBqySb0Bs9pzkAL8zZQaoqYkhoMesVy2cheA0
         NLL2Awj8uqViw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QaP9QvTv c=1 sm=1 tr=0
 a=qL5TBQHgqnWGdG4DsQFN/Q==:117 a=qL5TBQHgqnWGdG4DsQFN/Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=12cImHxmkD7F_EgP1BAA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 5/5] Makefile: don't use a versioned temp distribution
 directory
Message-ID: <89173add-2919-8a28-9e06-ca4a0c2a5ffb@ramsayjones.plus.com>
Date:   Tue, 8 Dec 2020 22:36:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFcSshLEAn6vfvCwzgZ4p6CJ1cOZ3ehNvuQ/daU8U3OldTrAvVHjbQkeVU1fH9qRevwDR3sJmqPS6JX3LoRVh3pni7N3l/E7WjW25LmpR8MkKGG+sWXl
 AsS+1Wu3KgM6ldav3/hgVGymxp9Ws5pY69q/f0FHDXO7sf5MZgggEzykzl2/8SsH4KDhgvaDpg6/8g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The 'dist' target uses a versioned temp directory, $(GIT_TARNAME), into
which it copies various files added to the distribution tarball. Should
it be necessary to remove this directory in the 'clean' target, since
the name depends on $(GIT_VERSION), the current HEAD must be positioned
on the same commit as when 'make dist' was issued. Otherwise, the target
will fail to remove that directory.

Create an '.dist-tmp-dir' directory and copy the various files into this
now un-versioned directory while creating the distribution tarball. Change
the 'clean' target to remove the '.dist-tmp-dir' directory, instead of the
version dependent $(GIT_TARNAME) directory.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Makefile | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 09d6f23b88..90e91a2185 100644
--- a/Makefile
+++ b/Makefile
@@ -3060,9 +3060,9 @@ GIT_TARNAME = git-$(GIT_VERSION)
 GIT_ARCHIVE_EXTRA_FILES = \
 	--prefix=$(GIT_TARNAME)/ \
 	--add-file=configure \
-	--add-file=$(GIT_TARNAME)/version \
+	--add-file=.dist-tmp-dir/version \
 	--prefix=$(GIT_TARNAME)/git-gui/ \
-	--add-file=$(GIT_TARNAME)/git-gui/version
+	--add-file=.dist-tmp-dir/git-gui/version
 ifdef DC_SHA1_SUBMODULE
 GIT_ARCHIVE_EXTRA_FILES += \
 	--prefix=$(GIT_TARNAME)/sha1collisiondetection/ \
@@ -3074,13 +3074,14 @@ GIT_ARCHIVE_EXTRA_FILES += \
 	--add-file=sha1collisiondetection/lib/ubc_check.h
 endif
 dist: git-archive$(X) configure
-	@mkdir -p $(GIT_TARNAME)
-	@echo $(GIT_VERSION) > $(GIT_TARNAME)/version
-	@$(MAKE) -C git-gui TARDIR=../$(GIT_TARNAME)/git-gui dist-version
+	@$(RM) -r .dist-tmp-dir
+	@mkdir .dist-tmp-dir
+	@echo $(GIT_VERSION) > .dist-tmp-dir/version
+	@$(MAKE) -C git-gui TARDIR=../.dist-tmp-dir/git-gui dist-version
 	./git-archive --format=tar \
 		$(GIT_ARCHIVE_EXTRA_FILES) \
 		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
-	@$(RM) -r $(GIT_TARNAME)
+	@$(RM) -r .dist-tmp-dir
 	gzip -f -9 $(GIT_TARNAME).tar
 
 rpm::
@@ -3149,7 +3150,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) -r po/build/
 	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
-	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
+	$(RM) -r .dist-tmp-dir .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
-- 
2.29.0
