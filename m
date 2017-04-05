Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35B6120966
	for <e@80x24.org>; Wed,  5 Apr 2017 13:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933265AbdDENFk (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 09:05:40 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:41184 "EHLO
        homiemail-a95.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932922AbdDENE2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2017 09:04:28 -0400
Received: from homiemail-a95.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTP id E948D6000504
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 06:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=
        jupiterrise.com; bh=rYdrkKk8w79KKPcMH8U62rmdgZw=; b=Fi0gE3tvzmIN
        dPAhQ9CtZ8amDNU5KCyQcPKUx8JEfAhIZb4giDhOVg/yXh40JaAEdvyX5gkH8SMC
        t13B9wbd9ccb/68DOxDBmCVW1ginLbBk8ExhxrStAZDnY1c+T6BLesoKXiWXSns1
        0aFR9BoayJ136Fy4bV97gKDkmtecogg=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTPSA id A1DEB6000519
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 06:04:27 -0700 (PDT)
Received: from athena.tgcnet.jupiterrise.com (athena.tgcnet [192.168.20.1])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTP id 196DA612DE
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 15:04:25 +0200 (CEST)
Received: by athena.tgcnet.jupiterrise.com (Postfix, from userid 500)
        id 0BDAC76C83; Wed,  5 Apr 2017 15:04:25 +0200 (CEST)
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/7] Install man pages when NO_PERL_MAKEMAKER is used
Date:   Wed,  5 Apr 2017 15:04:19 +0200
Message-Id: <20170405130424.13803-3-tgc@jupiterrise.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170405130424.13803-1-tgc@jupiterrise.com>
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170405130424.13803-1-tgc@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds man page installation when using NO_PERL_MAKEMAKER to ensure
parity with the normal case where ExtUtils::MakeMaker is used.

Signed-off-by: Tom G. Christensen <tgc@jupiterrise.com>
---
 perl/Makefile | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/perl/Makefile b/perl/Makefile
index ce53a240c..c4b96b058 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -31,6 +31,11 @@ perllib = $(INSTALLDIRS)
 endif
 perlinstdir := $(shell sh -c "$(PERL_PATH_SQ) -V:install$(perllib)lib | cut -d\' -f2")
 instdir_SQ = $(subst ','\'',$(perlinstdir))
+ifdef mandir
+mandir_SQ = $(subst ',''\'',$(mandir))
+else
+mandir_SQ = /usr/share/man
+endif
 
 modules += Git
 modules += Git/I18N
@@ -74,9 +79,17 @@ $(makfile): ../GIT-CFLAGS Makefile
 		else \
 			subdir=/$${i%/*}; \
 		fi; \
+		if test -z $$subdir; \
+		then \
+			manpage=$$i; \
+		else \
+			manpage=$$(echo $$i|sed 's#/#::#g'); \
+		fi; \
 		echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/'$$i'.pm"' >> $@; \
 		echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)'$$subdir'"' >> $@; \
 		echo '	cp '$$i'.pm "$$(DESTDIR)$(instdir_SQ)/'$$i'.pm"' >> $@; \
+		echo '	mkdir -p "$$(DESTDIR)$(mandir_SQ)/man3"' >> $@; \
+		echo '	pod2man '$$i'.pm "$$(DESTDIR)$(mandir_SQ)/man3/'$$manpage'.3pm"' >> $@; \
 	done
 	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
 	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
-- 
2.12.2

