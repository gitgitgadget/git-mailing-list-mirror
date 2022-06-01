Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECBACCA468
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 13:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353379AbiFANvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 09:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353365AbiFANvu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 09:51:50 -0400
X-Greylist: delayed 422 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Jun 2022 06:51:45 PDT
Received: from nmsh7.e.nsc.no (nmsh7.e.nsc.no [148.123.160.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E8D63C9
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 06:51:45 -0700 (PDT)
Received: from Lorule.wifi.realnett.no (unknown [194.19.73.58])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: joak-pet@online.no)
        by nmsh7.e.nsc.no (smtp.online.no) with ESMTPSA id 9224BE6095;
        Wed,  1 Jun 2022 15:44:40 +0200 (CEST)
From:   Joakim Petersen <joak-pet@online.no>
To:     git@vger.kernel.org
Cc:     Joakim Petersen <joak-pet@online.no>
Subject: [RFC PATCH] git-prompt: make colourization consistent
Date:   Wed,  1 Jun 2022 15:44:14 +0200
Message-Id: <20220601134414.66825-1-joak-pet@online.no>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Source-IP: 194.19.73.58
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.201
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The short upstream state indicator inherits the colour of the last short
state indicator before it (if there is one), and the sparsity state
indicator inherits this colour as well. Make the colourization of these
state indicators consistent by clearing any colour before printing the
short upstream state indicator, as this immediately follows the last
coloured indicator.

Signed-off-by: Joakim Petersen <joak-pet@online.no>
---
As of 0ec7c23cdc6bde5af3039c59e21507adf7579a99, colourization of the
output of __git_ps1 has changed such that the short upstream state
indicator inherits the colour of the last short state indicator before
it (if there is one), while before this change it was white/the default
text colour. Some examples of what I mean are (assuming all indicators
are enabled):
 * If the local tree is clean and there is something in the stash, both
   the '$' and the short upstream state indicator following it will be
   blue.
 * If the local tree has new, untracked files, both the '%' and the
   short upstream state indicator will be red.
 * If all local changes are added to the index and the stash is empty,
   both the '+' and the short upstream state indicator following it will
   be green.
 * If the local tree is clean and there is nothing in the stash, the
   short upstream state indicator will be white/${default text colour}.

This appears to be an unintended side-effect of the change, and makes
little sense semantically (e.g. why is it bad to be in sync with
upstream when you have uncommitted local changes?). The cause of the
change is that previously, the short upstream state indicator appeared
immediately after the rebase/revert/bisect/merge state indicator, which
is prepended with the clear colour code, while it now follows the
sequence of colourized indicators, without any clearing of colour.
However, adding a clearing of colour before the short upstream state
indicator will change how the sparsity state indicator is colourized,
as it currently inherits (and before the change referenced also
inherited) the colour of the last short state indicator before it.
Reading the commit message of the change that introduced the sparsity
state indicator, it appears this colourization also was unintended.

 contrib/completion/git-prompt.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 87b2b916c0..dfd6cef35f 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -286,6 +286,7 @@ __git_ps1_colorize_gitstring ()
 	if [ -n "$u" ]; then
 		u="$bad_color$u"
 	fi
+	p="$c_clear$p"
 	r="$c_clear$r"
 }
 

base-commit: e54793a95afeea1e10de1e5ad7eab914e7416250
-- 
2.36.1

