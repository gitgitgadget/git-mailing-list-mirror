Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 599D81F424
	for <e@80x24.org>; Wed, 11 Apr 2018 06:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbeDKGv3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 02:51:29 -0400
Received: from mx.mylinuxtime.de ([148.251.109.235]:47074 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbeDKGv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 02:51:28 -0400
Received: from leda.eworm.de (unknown [10.10.4.2])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 3D9C8265EB;
        Wed, 11 Apr 2018 08:51:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de 3D9C8265EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
        t=1523429487; bh=nTIMJ8BYUAvVDniXw083YqoQ+K2VOhiFgrry1FTPGoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kjUEpYUFuMXEgOsC9oWIo7A7Pqq7CAP2If1yVjQoVU3Cm+B4aMX1hUHyCu+Hi66X2
         vLE/Fiwnk6Ie3aVzxi6mxUxNsa6iGpq4EVmjintv26XHrpVZPQIbnJZiUv9BYAIPOc
         ypoe9OuXSnI8mW+ScLCCA5xwcWCdD7OpIxSkCuXM=
Received: by leda.eworm.de (Postfix, from userid 1000)
        id D83E9102940; Wed, 11 Apr 2018 08:51:21 +0200 (CEST)
From:   Christian Hesse <mail@eworm.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Dan Jacques <dnj@chromium.org>,
        Christian Hesse <mail@eworm.de>
Subject: [PATCH v3 1/1] perl: fix installing modules from contrib
Date:   Wed, 11 Apr 2018 08:51:20 +0200
Message-Id: <20180411065120.9432-1-mail@eworm.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <xmqqpo3620tz.fsf@gitster-ct.c.googlers.com>
References: <xmqqpo3620tz.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 20d2a30f (Makefile: replace perl/Makefile.PL with simple make rules)
removed a target that allowed Makefiles from contrib/ to get the correct
install path. This introduces a new target for main Makefile and fixes
installation for Mediawiki module.

v2: Pass prefix as that can have influence as well, add single quotes
    for _SQ variant.
v3: Rename target, add to .PHONY.

Signed-off-by: Christian Hesse <mail@eworm.de>
---
 Makefile                   | 3 +++
 contrib/mw-to-git/Makefile | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index f18168725..5a06eddf2 100644
--- a/Makefile
+++ b/Makefile
@@ -2014,6 +2014,9 @@ GIT-PERL-DEFINES: FORCE
 		echo "$$FLAGS" >$@; \
 	    fi
 
+.PHONY: say-perllibdir
+say-perllibdir:
+	@echo '$(perllibdir_SQ)'
 
 .PHONY: gitweb
 gitweb:
diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index a4b6f7a2c..e301a5b4e 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -21,8 +21,9 @@ HERE=contrib/mw-to-git/
 INSTALL = install
 
 SCRIPT_PERL_FULL=$(patsubst %,$(HERE)/%,$(SCRIPT_PERL))
-INSTLIBDIR=$(shell $(MAKE) -C $(GIT_ROOT_DIR)/perl \
-                -s --no-print-directory instlibdir)
+INSTLIBDIR=$(shell $(MAKE) -C $(GIT_ROOT_DIR)/ \
+                -s --no-print-directory prefix=$(prefix) \
+                perllibdir=$(perllibdir) say-perllibdir)
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 INSTLIBDIR_SQ = $(subst ','\'',$(INSTLIBDIR))
 
