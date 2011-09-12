From: Pang Yan Han <pangyanhan@gmail.com>
Subject: [PATCH/RFCv2 2/2] format-patch: produce non colorized patches when ui.color=always
Date: Tue, 13 Sep 2011 01:46:41 +0800
Message-ID: <1315849601-26497-3-git-send-email-pangyanhan@gmail.com>
References: <1315849601-26497-1-git-send-email-pangyanhan@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, martin.von.zweigbergk@gmail.com,
	sdaoden@googlemail.com, ib@wupperonline.de,
	Pang Yan Han <pangyanhan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 19:49:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Adc-00088J-Uj
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 19:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835Ab1ILRtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 13:49:40 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38982 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab1ILRtk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 13:49:40 -0400
Received: by mail-qy0-f181.google.com with SMTP id 7so348573qyk.19
        for <git@vger.kernel.org>; Mon, 12 Sep 2011 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=He26UOZmV8qQ8C4Ik8gIxPhAQvSE/JN/6O1u8jPeRyg=;
        b=LE0h6iaHdZ6UBEBUhEQLTx4Nd5DZpyf7s3+jRxBAJ87Pg4Bn9ZrsO9202hEvOnnzIy
         Ey9j4LQpXYeFerNew6rSJjfDuD6zOq41bLFPVXB/7BTesZTueC3tF8PMKKbPRShSUMiI
         TuAS9vQBwlY5hNNNgdWYeJHr0Ry0oh58n0PjU=
Received: by 10.224.204.136 with SMTP id fm8mr837493qab.364.1315849779530;
        Mon, 12 Sep 2011 10:49:39 -0700 (PDT)
Received: from localhost (bb219-74-111-93.singnet.com.sg. [219.74.111.93])
        by mx.google.com with ESMTPS id gx6sm5338034qab.20.2011.09.12.10.49.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Sep 2011 10:49:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.190.g713ddd
In-Reply-To: <1315849601-26497-1-git-send-email-pangyanhan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181228>

commit c9bfb953 (want_color: automatically fallback to color.ui,
2011-08-17) introduced a regression where format-patch produces colorized
patches when color.ui is set to "always".

In f3aafa4 (Disable color detection during format-patch, 2006-07-09),
git_format_config was taught to intercept diff.color to avoid passing it
down to git_log_config and later, git_diff_ui_config.

Teach git_format_config to intercept color.ui in the same way.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Pang Yan Han <pangyanhan@gmail.com>
---
 builtin/log.c                  |    3 ++-
 t/t4051-format-patch-config.sh |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index d760ee0..99f8c4c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -608,7 +608,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		string_list_append(&extra_cc, value);
 		return 0;
 	}
-	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
+	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff") ||
+		!strcmp(var, "color.ui")) {
 		return 0;
 	}
 	if (!strcmp(var, "format.numbered")) {
diff --git a/t/t4051-format-patch-config.sh b/t/t4051-format-patch-config.sh
index cea9c7d..35b349e 100755
--- a/t/t4051-format-patch-config.sh
+++ b/t/t4051-format-patch-config.sh
@@ -13,7 +13,7 @@ test_expect_success setup '
 	git commit -m "commit2"
 '
 
-test_expect_failure 'format patch with ui.color=always generates non colorized patch' '
+test_expect_success 'format patch with ui.color=always generates non colorized patch' '
 	git config color.ui always &&
 	git format-patch -1 &&
 	mv 0001-commit2.patch actual &&
-- 
1.7.7.rc0.190.gb47b6
