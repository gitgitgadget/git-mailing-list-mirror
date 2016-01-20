From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 01/11] dir: free untracked cache when removing it
Date: Wed, 20 Jan 2016 10:59:34 +0100
Message-ID: <1453283984-8979-2-git-send-email-chriscool@tuxfamily.org>
References: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 11:06:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLpeX-0007o9-4H
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 11:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758209AbcATKGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 05:06:10 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33877 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933213AbcATKGE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 05:06:04 -0500
Received: by mail-wm0-f41.google.com with SMTP id u188so177717773wmu.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 02:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7SNE06lj8b1/6Tg+7YqmNKcxf2WVYYodsgTkW5zpyzk=;
        b=hpjaFxFu7mK0Ltjc0ifAdEYninEStgeUa7Mw35nEP7cJKBQVBQTJc4d70oea6m46gG
         pWbrerC2D4ucBcY/KGvSPBmlboB0kpyvRqGse8Z+ECAf3BQxuiiKuABys7a784a3rY1M
         j2FdRBJ/xKDdY4JC6eAPt0HN60WJkn0F/6Wm/Axr+xtyBXlxpMefXSwm6ZP9a7VcbAGn
         ZdFmOLmBML3SYCG+FRectLUbFqu03n+5txUEmXZaboq9AA7gCuFxg50BkgUvLEoUcEyJ
         OVIv029IKXw4ECv6660BQ3MyBY5noI3yDj9g7WK6ZKTGh1JS92NBXuhG4d0Lopm6aRYk
         cihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7SNE06lj8b1/6Tg+7YqmNKcxf2WVYYodsgTkW5zpyzk=;
        b=OC699VF5SMnDqATkw75tiixWwXK6uxIskkJgqd8GJyelq/USUBevDdXzNdEDtEfvmb
         Ob9seQd2kc3KLnIImK9MqkEUgu+cJxsIahLQa2jmnWbZD7gnONFylHRnAhcE2jJl/fzz
         RLb8TSfBOrPQLN8Uux94FgxqOnVKiztlcnHlSrAdiMEjxlolXzvXbmfg5rUVrYbdjWdX
         dTnegd5K8X04iklrKn4RwvdUfmY48i9egFVdssNEW7006r4liETxVcZtYT+r9TJQOwh+
         lu3ZtMEXjbhPDpFcl3SpTGUC9bd++VyI7kiU5G9ofL3LFvbDLWwPSn4JOMvS4BFRj6Tw
         kzHw==
X-Gm-Message-State: ALoCoQl8eMEHvMEESGzU+Kl9+K6s2Tnt+j5XFffzJMaxy/mczVzzr6oGkJOR17U6LxeMu4MG9WFtW6BsxCBzolZlIxBDr+f6DA==
X-Received: by 10.194.80.200 with SMTP id t8mr34930271wjx.74.1453284362649;
        Wed, 20 Jan 2016 02:06:02 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id x6sm32305613wje.38.2016.01.20.02.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 02:06:01 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g6be5eef
In-Reply-To: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284434>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7431938..a6fff87 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1123,6 +1123,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		add_untracked_ident(the_index.untracked);
 		the_index.cache_changed |= UNTRACKED_CHANGED;
 	} else if (!untracked_cache && the_index.untracked) {
+		free_untracked_cache(the_index.untracked);
 		the_index.untracked = NULL;
 		the_index.cache_changed |= UNTRACKED_CHANGED;
 	}
-- 
2.7.0.36.g6be5eef
