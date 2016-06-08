From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH 1/2] bisect--helper: `is_expected_rev` shell function in C
Date: Wed,  8 Jun 2016 20:54:14 +0530
Message-ID: <20160608152415.7770-1-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 17:30:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAfMZ-0008TZ-PJ
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 17:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757473AbcFHPZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 11:25:43 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33296 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757469AbcFHPZn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 11:25:43 -0400
Received: by mail-pa0-f66.google.com with SMTP id di3so790133pab.0
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 08:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0yLi5nz02O1bbfozkEflCA+hrzGNTxTSf6c/IksKjpM=;
        b=ogv6aezb81HA47pnZM4iTCnvdmbp7gPo9CWQyWwZOYbcbEGEU3Bf/sEHt8oKvWK5aU
         flah69TH6AdVCfmd0uiPs/Bt1fOntYfutV2TFTAbajNf4qNgo1gzXGMpEa/zQpVv8Xv5
         PGYbcmmUlBj1TtBNJzuDmlkc8TsZFxe3+Bd92vBMHFsr3bA5zTZ80ywseA1izcRzF5UI
         rZUzETM5szKMiXScthh8+SrR8X5nHfyfNjimf5ehhv5zesEZiVZEyUDO9JU+X4nkAG0h
         9YfyiqeyNCGfxlEj+FoEIspSClVyYLVYvGfr9XuXR2VPSJDXR21gKQ7VtG9C3V0OZDiS
         HGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0yLi5nz02O1bbfozkEflCA+hrzGNTxTSf6c/IksKjpM=;
        b=F5KFgeptmHWUWTlzN7b9G/pHbsKWz9vsEw4UiPmayTM93WoXo3k2lK+IsrglD95PPE
         WSrC32HMNH+ie5PpaNiLdKuGg+lDxJuquGakRH1mGuAE3vbRLRLitNkdfBfPCR2mUmd6
         JcwG7H+Km9VgfOQblu6HxyyvqftVXMXImu88ksngC59J/Gv+zRQo4IPLRjnfBck/DdxK
         ykE+grngjwzX3hum7F6lbv5zpBVJzeWvlANYuaJIxTlqD0WGNy4elgGsDK6cuiC0UTDH
         T+OpNMfOPHp7LPZA/thxxGJLcfPZ5KX3XbxoCF9toaJiMVbUXrNxuZb2eim6146t4vuW
         L8iQ==
X-Gm-Message-State: ALyK8tJtzhyI7UsbIwY//s1H25Dp/wBjsSRks73ydoTq/t7kue2jei8zmAO2gPXE9Tt8/g==
X-Received: by 10.66.1.134 with SMTP id 6mr6373592pam.15.1465399542154;
        Wed, 08 Jun 2016 08:25:42 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id ce8sm3190089pad.44.2016.06.08.08.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Jun 2016 08:25:41 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296805>

Reimplement `is_expected_rev` shell function in C. This will further be
called from `check_expected_revs` function. This is a quite small
function thus subcommand facility is redundant.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
This applies on the previous patches.

 builtin/bisect--helper.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4153e8a..06bc9b8 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -160,6 +160,20 @@ int bisect_reset(const char *commit)
 	return bisect_clean_state();
 }
 
+static int is_expected_rev(const char *expected_hex)
+{
+	struct strbuf actual_hex = STRBUF_INIT;
+
+	if (!file_exists(git_path_bisect_expected_rev()))
+		return 0;
+
+	if (!strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0))
+		return 0;
+
+	strbuf_trim(&actual_hex);
+	return !strcmp(actual_hex.buf, expected_hex);
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-- 
2.8.3
