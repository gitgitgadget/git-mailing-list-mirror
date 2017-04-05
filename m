Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BCAF20966
	for <e@80x24.org>; Wed,  5 Apr 2017 13:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933257AbdDENFj (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 09:05:39 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:41192 "EHLO
        homiemail-a95.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933013AbdDENE3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2017 09:04:29 -0400
Received: from homiemail-a95.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTP id 69C0F6000509
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 06:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=
        jupiterrise.com; bh=lH3v5ktTV4RTMkvYLNUehFn7/ZU=; b=WiTalc9ox06S
        bif5KUXFb0natOSd3eyXtICT8WSC+w/A4k4x8RswF9AvTVS9+jSDwCZVsiuDfAkz
        Zy8sRahBpa0RXSlYyBjJqXwqKW4JvOKMqThm7/mi0T8j3PT/WAUS8k0kIUqN4InV
        yFU/oziQYycfyaQE6J/GHDO6qp9x3JM=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTPSA id 34A8B600050C
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 06:04:29 -0700 (PDT)
Received: from athena.tgcnet.jupiterrise.com (athena.tgcnet [192.168.20.1])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTP id 1C584612E0
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 15:04:25 +0200 (CEST)
Received: by athena.tgcnet.jupiterrise.com (Postfix, from userid 500)
        id 19E9976C82; Wed,  5 Apr 2017 15:04:25 +0200 (CEST)
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
To:     git@vger.kernel.org
Subject: [PATCH 5/7] Add support for gnupg < 1.4
Date:   Wed,  5 Apr 2017 15:04:22 +0200
Message-Id: <20170405130424.13803-6-tgc@jupiterrise.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170405130424.13803-1-tgc@jupiterrise.com>
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170405130424.13803-1-tgc@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds an OLD_GNUPG define to the Makefile which when activated will
ensure git does not use the --keyid-format argument when calling the
'gpg' program.
This is consistent with how 'gpg' was used in git < 2.10.0 and slightly
decreases security.

Signed-off-by: Tom G. Christensen <tgc@jupiterrise.com>
---
 Makefile        | 6 ++++++
 gpg-interface.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index ca9f16d19..f8f585d21 100644
--- a/Makefile
+++ b/Makefile
@@ -386,6 +386,8 @@ all::
 #
 # to say "export LESS=FRX (and LV=-c) if the environment variable
 # LESS (and LV) is not set, respectively".
+#
+# Define OLD_GNUPG if you need support for gnupg < 1.4.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1529,6 +1531,10 @@ ifndef PAGER_ENV
 PAGER_ENV = LESS=FRX LV=-c
 endif
 
+ifdef OLD_GNUPG
+	BASIC_CFLAGS += -DOLD_GNUPG
+endif
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
diff --git a/gpg-interface.c b/gpg-interface.c
index e44cc27da..57f1ea792 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -224,7 +224,9 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	argv_array_pushl(&gpg.args,
 			 gpg_program,
 			 "--status-fd=1",
+#ifndef OLD_GNUPG
 			 "--keyid-format=long",
+#endif
 			 "--verify", temp.filename.buf, "-",
 			 NULL);
 
-- 
2.12.2

