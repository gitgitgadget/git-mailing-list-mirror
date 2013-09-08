From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 13/14] index-pack: skip looking for ofs-deltas in v4 as they are not allowed
Date: Sun,  8 Sep 2013 14:22:39 +0700
Message-ID: <1378624960-8919-14-git-send-email-pclouds@gmail.com>
References: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
 <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 09:20:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZIm-0004L1-5U
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929Ab3IHHUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:20:51 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:34318 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab3IHHUv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:20:51 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so4865399pbc.21
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 00:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=06DmD9oE2iPMLELBXoej/OODzTOL/59SPENVW0OSFUQ=;
        b=cpTw0M5zwUt/RUVdVl9vyFv4+zkpP8ReAGuebCGy7ARSx25MlhdXn6r6cbE+hewxcH
         N43gFOxomDQB45/3vhqL591fmeBLMJ73NtO8Jdxg0wg5Z1hG2HdiRRjxpDfC4wbjy1WG
         PI4yfYDVD0EWjvbNqsQeoc1EvKUg/DQy4ty8JchlUf7A7C34SLeOHJKPKw0gtBKz5xAn
         xS08jRzonEDH3fXUWOK2JiHBtkh2Qdz6loMEpAWNbrBWdJ09Oo7V1+wklS6MMmlAxxFW
         TGLQckrFAEkhvy+JGPn2Ul38wBrzXkczJAZE3UqGFjDcx7NRgP5qoumalKEPO4Ife9fj
         KiIA==
X-Received: by 10.68.218.163 with SMTP id ph3mr12310964pbc.19.1378624850648;
        Sun, 08 Sep 2013 00:20:50 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id qp10sm9310599pab.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 00:20:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 14:23:59 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234210>

---
 builtin/index-pack.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index e903a49..ce06473 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1173,10 +1173,13 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 		find_delta_children(&base_spec,
 				    &base->ref_first, &base->ref_last, OBJ_REF_DELTA);
 
-		memset(&base_spec, 0, sizeof(base_spec));
-		base_spec.offset = base->obj->idx.offset;
-		find_delta_children(&base_spec,
-				    &base->ofs_first, &base->ofs_last, OBJ_OFS_DELTA);
+		if (!packv4) {
+			memset(&base_spec, 0, sizeof(base_spec));
+			base_spec.offset = base->obj->idx.offset;
+			find_delta_children(&base_spec,
+					    &base->ofs_first, &base->ofs_last,
+					    OBJ_OFS_DELTA);
+		}
 
 		if (base->ref_last == -1 && base->ofs_last == -1) {
 			free(base->data);
-- 
1.8.2.83.gc99314b
