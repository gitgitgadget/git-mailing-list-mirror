From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 66/83] builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
Date: Sun, 24 Apr 2016 15:34:06 +0200
Message-ID: <1461504863-15946-67-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:37:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKDn-0000Q2-D3
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbcDXNhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:37:05 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36933 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbcDXNgT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:19 -0400
Received: by mail-wm0-f42.google.com with SMTP id n3so90226595wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=83OwG7ggmc3V3DjYIewCpMIRWMwoUX6/vvXj+W5MAXg=;
        b=Cbl3Xu9pTzi/n30u4u0GAV+ToSoALm/8Zj3ZH1YgmGO3PaIUH10hkqga6HWvsDss0G
         ZEU6FAVAj9u9fYg40Dibw8ZQZfkNloDIcUkTO4bJppA+3+4POmhudpTloHtkHnZ73VLJ
         j5J6HI0c54LqUTmDdKoIzmhbCy5DOBkMXB89kumZRFs9d43ti4WNPEx2Eqi8xsTTIHPU
         o8pXL6OPoCQn20DrjcRsS6gi4/acD2pUU9/YB2eh0q0iLO7CSMZE6gGCRbvF5NVuakVQ
         gum/vsOVKZcO8hGyeilGjpzAvIQYqkwJAtdp+hTd6dp0qIwsQ3rDgFy8HAOqlmzz+EPw
         3ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=83OwG7ggmc3V3DjYIewCpMIRWMwoUX6/vvXj+W5MAXg=;
        b=VJu4S58kzcr96aKt9mq3bJVZM8F7hz202TsuqD7GcztAuOsMok4A0e00Q4l71auCsp
         QrQvoGb2iQGMNK9/c5Ct+pBpJOxC4pOZ0HzJ1zbZ3DyjrPJxeHxEG/KevfG7c95s9wH9
         kZAKaivAumswcNU7rA6CqfHWFmiA1ikok4vpSSEQlnKHHqb0oDKQf2Aymv4VEopp4nug
         qLiF55g31JQdcT/7d8LjzQc0ThjsUa3mI/4rPffgFTpecpPPwPVaNfgiCmKPYIT/sOVf
         T9HqbEXsgjAK+bre4/gV9cIFnJIV3RzJt28rlh9VMDWckRSSLA2H2BNi1xBu+YjIWaKV
         InOQ==
X-Gm-Message-State: AOPr4FX3JAQyxTunnjgmFsZNiOzUmqHXdk57oxgiQEvZ/x1pnsomOOQcW4SZkUU98Xa6pw==
X-Received: by 10.28.93.85 with SMTP id r82mr7473790wmb.77.1461504978514;
        Sun, 24 Apr 2016 06:36:18 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:17 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292369>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 268356b..8b7a8e0 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3699,7 +3699,7 @@ static int path_is_beyond_symlink(struct apply_state *state, const char *name_)
 	return ret;
 }
 
-static void die_on_unsafe_path(struct patch *patch)
+static int check_unsafe_path(struct patch *patch)
 {
 	const char *old_name = NULL;
 	const char *new_name = NULL;
@@ -3711,9 +3711,10 @@ static void die_on_unsafe_path(struct patch *patch)
 		new_name = patch->new_name;
 
 	if (old_name && !verify_path(old_name))
-		die(_("invalid path '%s'"), old_name);
+		return error(_("invalid path '%s'"), old_name);
 	if (new_name && !verify_path(new_name))
-		die(_("invalid path '%s'"), new_name);
+		return error(_("invalid path '%s'"), new_name);
+	return 0;
 }
 
 /*
@@ -3803,8 +3804,8 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 		}
 	}
 
-	if (!state->unsafe_paths)
-		die_on_unsafe_path(patch);
+	if (!state->unsafe_paths && check_unsafe_path(patch))
+		return -1;
 
 	/*
 	 * An attempt to read from or delete a path that is beyond a
-- 
2.8.1.300.g5fed0c0
