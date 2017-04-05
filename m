Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BC8720966
	for <e@80x24.org>; Wed,  5 Apr 2017 13:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933273AbdDENFl (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 09:05:41 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:41176 "EHLO
        homiemail-a95.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932901AbdDENE2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2017 09:04:28 -0400
X-Greylist: delayed 12647 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Apr 2017 09:04:28 EDT
Received: from homiemail-a95.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTP id A8D8F600051B
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 06:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=
        jupiterrise.com; bh=Le8f6Ssj9tgacT8vSRMg1hgjfio=; b=adOXvmXR2QCL
        BGJlMHn5S3Srnn5IiJwXl9BL6WfoYEuY7H+FzWPEDDxuYpY4kFX7LgyDw/PJC3Po
        zdmv/SuOyWiT+5z225hK8+0s4uEPCnmv5sL06+9QBST7jeSE7JdDzJopa1hmOI+j
        gYAGGtA1UnIeOtaOzPJxGGRtDbQ9zgc=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTPSA id 718E26000504
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 06:04:27 -0700 (PDT)
Received: from athena.tgcnet.jupiterrise.com (athena.tgcnet [192.168.20.1])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTP id 180A6612DA
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 15:04:25 +0200 (CEST)
Received: by athena.tgcnet.jupiterrise.com (Postfix, from userid 500)
        id 08A0D76C7A; Wed,  5 Apr 2017 15:04:25 +0200 (CEST)
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/7] Make NO_PERL_MAKEMAKER behave more like ExtUtils::MakeMaker
Date:   Wed,  5 Apr 2017 15:04:18 +0200
Message-Id: <20170405130424.13803-2-tgc@jupiterrise.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170405130424.13803-1-tgc@jupiterrise.com>
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170405130424.13803-1-tgc@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change makes NO_PERL_MAKEMAKER behave more as ExtUtils::MakeMaker
by installing the modules into the perl libdir and not $(prefix)/lib.
It will default to sitelib but will allow the user to choose by setting
the INSTALLDIRS variable which is also honored by ExtUtils::MakeMaker.

Signed-off-by: Tom G. Christensen <tgc@jupiterrise.com>
---
 perl/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/perl/Makefile b/perl/Makefile
index 15d96fcc7..ce53a240c 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -25,7 +25,12 @@ clean:
 $(makfile): PM.stamp
 
 ifdef NO_PERL_MAKEMAKER
-instdir_SQ = $(subst ','\'',$(prefix)/lib)
+perllib = site
+ifdef INSTALLDIRS
+perllib = $(INSTALLDIRS)
+endif
+perlinstdir := $(shell sh -c "$(PERL_PATH_SQ) -V:install$(perllib)lib | cut -d\' -f2")
+instdir_SQ = $(subst ','\'',$(perlinstdir))
 
 modules += Git
 modules += Git/I18N
-- 
2.12.2

