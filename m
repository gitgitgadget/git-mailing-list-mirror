Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3761F461
	for <e@80x24.org>; Mon, 24 Jun 2019 02:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfFXCkC (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 22:40:02 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:57162 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfFXCkC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 22:40:02 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 060CC34689C
        for <git@vger.kernel.org>; Sun, 23 Jun 2019 21:50:55 +0000 (UTC)
Received: (qmail 24426 invoked by uid 129); 23 Jun 2019 21:50:50 -0000
X-HELO: bohr-int.orbis-terrarum.net
Authentication-Results: orbis-terrarum.net; auth=pass (plain) smtp.auth=robbat2-bohr@orbis-terrarum.net; iprev=fail; iprev=fail
Received: from node-1w7jr9qtv0a5amn9pw5p8gn5k.ipv6.telus.net (HELO bohr-int.orbis-terrarum.net) (2001:569:7caf:ee00:4988:d144:fb03:3538)
 by orbis-terrarum.net (qpsmtpd/0.95) with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted); Sun, 23 Jun 2019 21:50:50 +0000
Received: (nullmailer pid 24440 invoked by uid 10000);
        Sun, 23 Jun 2019 21:50:52 -0000
From:   robbat2@gentoo.org
To:     git@vger.kernel.org
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH] Makefile: include contrib docs in dist-doc tarballs
Date:   Sun, 23 Jun 2019 14:50:46 -0700
Message-Id: <20190623215046.24030-1-robbat2@gentoo.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Checked: Checked by ClamAV on orbis-terrarum.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Robin H. Johnson" <robbat2@gentoo.org>

The pre-built htmldoc/manpage tarballs do not include any documentation
from the contrib code. As a result, if you want that documentation, you
need the full documentation stack to build them.

By including the contrib docs in the tarballs, this is prevented.

The documentation process in the contrib directories could use some
general cleanups, but this gets it going for now.
- Add doc install target that includes the .txt files
- svn-fe has no doc install targets at all.

See-Also: https://bugs.gentoo.org/687886
See-Also: https://bugs.gentoo.org/687848
See-Also: https://bugs.gentoo.org/517794
Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 Makefile | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index f58bf14c7b..fc36a9211e 100644
--- a/Makefile
+++ b/Makefile
@@ -3008,21 +3008,48 @@ artifacts-tar:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) \
 
 htmldocs = git-htmldocs-$(GIT_VERSION)
 manpages = git-manpages-$(GIT_VERSION)
-.PHONY: dist-doc distclean
-dist-doc:
+.PHONY: dist-doc distclean contrib-doc
+
+# subdirs with install-html & install-man targets
+contrib_doc_dirs := contrib/contacts contrib/subtree
+doc_dirs := Documentation $(contrib_doc_dirs)
+
+contrib-doc:
+	$(MAKE) -C contrib/svn-fe svn-fe.html svn-fe.1 # no doc target
+	for d in $(contrib_doc_dirs) ; do \
+		$(MAKE) -C $$d doc ; \
+	done
+
+dist-doc: doc contrib-doc
 	$(RM) -r .doc-tmp-dir
 	mkdir .doc-tmp-dir
-	$(MAKE) -C Documentation WEBDOC_DEST=../.doc-tmp-dir install-webdoc
+	for d in $(doc_dirs) ; do \
+		$(MAKE) -C $$d \
+			DESTDIR=$(PWD)/ \
+			htmldir=/.doc-tmp-dir/ \
+			install-html ; \
+	done
+	: # These files have no install targets
+	cp --target .doc-tmp-dir \
+		contrib/subtree/git-subtree.txt \
+		contrib/contacts/git-contacts.txt \
+		contrib/svn-fe/svn-fe.html \
+		contrib/svn-fe/svn-fe.txt
 	cd .doc-tmp-dir && $(TAR) cf ../$(htmldocs).tar .
 	gzip -n -9 -f $(htmldocs).tar
 	:
 	$(RM) -r .doc-tmp-dir
 	mkdir -p .doc-tmp-dir/man1 .doc-tmp-dir/man5 .doc-tmp-dir/man7
-	$(MAKE) -C Documentation DESTDIR=./ \
-		man1dir=../.doc-tmp-dir/man1 \
-		man5dir=../.doc-tmp-dir/man5 \
-		man7dir=../.doc-tmp-dir/man7 \
-		install
+	for d in $(doc_dirs) ; do \
+		$(MAKE) -C $$d DESTDIR=$(PWD)/ \
+		man1dir=/.doc-tmp-dir/man1 \
+		man5dir=/.doc-tmp-dir/man5 \
+		man7dir=/.doc-tmp-dir/man7 \
+		install-man ; \
+	done
+	: # These files have no install targets
+	cp --target .doc-tmp-dir/man1/ \
+		contrib/svn-fe/svn-fe.1
 	cd .doc-tmp-dir && $(TAR) cf ../$(manpages).tar .
 	gzip -n -9 -f $(manpages).tar
 	$(RM) -r .doc-tmp-dir
-- 
2.22.0

