Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF31BC46467
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 22:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiK0Wn3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 17:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiK0Wn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 17:43:27 -0500
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A546642D
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 14:43:25 -0800 (PST)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
        by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <psmith@gnu.org>)
        id 1ozQMq-0004h3-Sf; Sun, 27 Nov 2022 17:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
        s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
        From; bh=EsI6UM+HpB4dkUVyTOOFUJw7nv7S8lGOvQ9XQKVVK90=; b=rQUzo70smXRJ1q40gbu1
        UHtBSjPItdIOw8QOEzGuXJ6Hny55olgve6qrw7QKUMKmD69e0NDGAoqMFC5y2dT4lvxOKagEYtV1b
        ke7Dqt8sbR5GqZsehvjXvPmk2nclUQSCGaVLsnPXZ0apiYLvXHfnNvSsImi9QurYX1bLAuaqDx+hO
        X0TjTkg1SjsnBiFfkGLyfbVb8k+/LArJT5iqgIkKNHJqEsvAy4Yl5I+DC0ZfeCZnzwM9XyGu5y54k
        abTGoUY9VTSQsjIjlHCwLNL1K0St5U3wEIHNZhJl/KSn6LBfVuFZYxaVHglglECWsspKWGjcQ7dto
        INSrKQfdCR+vRw==;
Received: from pool-71-245-225-93.bstnma.fios.verizon.net ([71.245.225.93] helo=llin-psh13-dsa.internal.nuodb.com)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <psmith@gnu.org>)
        id 1ozQMq-0004HF-Kl; Sun, 27 Nov 2022 17:43:20 -0500
From:   Paul Smith <psmith@gnu.org>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Alexander Kanavin <alex.kanavin@gmail.com>
Subject: [PATCH 1/1] Avoid multiple patterns when recipes generate one file
Date:   Sun, 27 Nov 2022 17:42:51 -0500
Message-Id: <20221127224251.2508200-2-psmith@gnu.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221127224251.2508200-1-psmith@gnu.org>
References: <20221127224251.2508200-1-psmith@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A GNU make pattern rule with multiple targets has always meant that
a single invocation of the recipe will build all the targets.
However in older versions of GNU make a recipe that did not really
build all the targets would be tolerated.

Starting with GNU make 4.4 this behavior is deprecated and pattern
rules are expected to generate files to match all the patterns.
If not all targets are created then GNU make will not consider any
target up to date and will re-run the recipe when it is run again.

Modify Documentation/Makefile to split the man page-creating pattern
rule into a separate pattern rule for each pattern.

Reported-by: Alexander Kanavin <alex.kanavin@gmail.com>
Signed-off-by: Paul Smith <psmith@gnu.org>
---
 Documentation/Makefile | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d47acb2e25..21375cd3f2 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -351,8 +351,16 @@ $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
-%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
-	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+
+manpage-prereqs := manpage-base-url.xsl $(wildcard manpage*.xsl)
+manpage-cmd = $(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+
+%.1 : %.xml $(manpage-prereqs)
+	$(manpage-cmd)
+%.5 : %.xml $(manpage-prereqs)
+	$(manpage-cmd)
+%.7 : %.xml $(manpage-prereqs)
+	$(manpage-cmd)
 
 %.xml : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
-- 
2.35.3

