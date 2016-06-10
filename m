From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 19/44] builtin/apply: make remove_file() return -1 on error
Date: Fri, 10 Jun 2016 22:10:53 +0200
Message-ID: <20160610201118.13813-20-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSoB-0004N6-4y
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbcFJUMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33421 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932294AbcFJUMH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id r5so1068798wmr.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SAbYPuaCzeLSbKlsJ45aks1WGfJ19+fHPHRSHWYkR9w=;
        b=G4ep8neG2O2wPTDNYob8AkdW8QFvkGh1/QBH+Vvw4Lrl0Os4olcfgg6ZAVmNXXW+uq
         Nph17x5V2ywo7G24O5Fx0UIgZBia2a2JeEUV5w/2tbrnuD7RgiJKUod0FBGCdFfo9ExE
         lRCQMAbXY6C4Ohg5iK+V27BAdTH1MQFBuYVwQm8gbegKlR91IIDKd6rm2Ji8pnLJfvBI
         +bIk15KRkbrhhrbShCPs/B4aCKJPUSIzuzFpbyouMUoCVUd/Va1zlRhso1whPWxH5x3g
         iqm6mW7ISNk2gLN+qTyfqktlMsuSXrWRg9uBFthCmogUJVGqw89JyCKeB2J85jb01Q4z
         mjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SAbYPuaCzeLSbKlsJ45aks1WGfJ19+fHPHRSHWYkR9w=;
        b=WELajWTHNktf0NQa8ieo1wKntCF6yhC/QnDMYa4BAvqAetX0W4CnB8X85qPzVCu/wi
         EM3OTOu0OGejOm53vs7MUPlcfbsPPYMrMcFBT1cPQyC9v74/u2XYqye8bcXBn3faGb9Z
         vOGvP2Fb3okrG/tohxDZlX0hHRbsUJGWA2c0iZ+buTsnjymuzJOaBjpZ4iMH/eBLgW35
         ZYm1xdyo5yHop2UKFfac5CuPMvu4Wv2znHvwLpuD4tGUdiP4jade0jv0vTt/vU3JaVyV
         mzVwuctdakdyHOTRFbnvi33N6/1eDxfka3ZRKHEva8HdzyHSZm1wq1MTCfuHyxiHyMp0
         M4hg==
X-Gm-Message-State: ALyK8tL66/rljfV+ZQ4f08Rj9+YKSrvxQ4ODI3PKWR6E8/5gyGT9Pl3yBlWdO4DwtoKRtg==
X-Received: by 10.194.58.239 with SMTP id u15mr3705438wjq.73.1465589525901;
        Fri, 10 Jun 2016 13:12:05 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:05 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297056>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", remove_file() should return -1 instead of
calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e74b068..694c65b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4074,17 +4074,18 @@ static void patch_stats(struct apply_state *state, struct patch *patch)
 	}
 }
 
-static void remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
+static int remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
 {
 	if (state->update_index) {
 		if (remove_file_from_cache(patch->old_name) < 0)
-			die(_("unable to remove %s from index"), patch->old_name);
+			return error(_("unable to remove %s from index"), patch->old_name);
 	}
 	if (!state->cached) {
 		if (!remove_or_warn(patch->old_mode, patch->old_name) && rmdir_empty) {
 			remove_path(patch->old_name);
 		}
 	}
+	return 0;
 }
 
 static void add_index_file(struct apply_state *state,
@@ -4263,8 +4264,10 @@ static void write_out_one_result(struct apply_state *state,
 				 int phase)
 {
 	if (patch->is_delete > 0) {
-		if (phase == 0)
-			remove_file(state, patch, 1);
+		if (phase == 0) {
+			if (remove_file(state, patch, 1))
+				exit(1);
+		}
 		return;
 	}
 	if (patch->is_new > 0 || patch->is_copy) {
@@ -4276,8 +4279,10 @@ static void write_out_one_result(struct apply_state *state,
 	 * Rename or modification boils down to the same
 	 * thing: remove the old, write the new
 	 */
-	if (phase == 0)
-		remove_file(state, patch, patch->is_rename);
+	if (phase == 0) {
+		if (remove_file(state, patch, patch->is_rename))
+			exit(1);
+	}
 	if (phase == 1)
 		create_file(state, patch);
 }
-- 
2.9.0.rc2.362.g3cd93d0
