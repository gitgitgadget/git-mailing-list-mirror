From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/6] shallow: fix a memleak
Date: Fri, 27 Mar 2015 15:09:04 -0700
Message-ID: <1427494150-8085-5-git-send-email-sbeller@google.com>
References: <1427494150-8085-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 27 23:10:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbcSl-0005Ur-KJ
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbbC0WKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:10:44 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33456 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbbC0WKM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:10:12 -0400
Received: by iecvj10 with SMTP id vj10so81260024iec.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lx+l/8EX5/B6t7GqicAJdN2LFsQiGYmKQ2HlmguR5LI=;
        b=iWL0GYh8TDjhGiizGE7GsMAn9ssRbLitEPKzXCmaoZFBcO+hmf1HP+Jz20az7eX5nT
         cGNPmdaoFcrzCQori9PEG1oWlvbIL6c4kJIqScTQ5YP4knhZ13WCJAylWdm2Oxf27H6j
         XLVIgAkKKo6zml01SVTSvMnzfy9J2JqfRbGFNJWpfPAEu4K9AsNsjKSP2JkxHdXTz4rq
         Me8jO7Ny6UcREHUdCvSrAzDuaVRW9ZQfgQq3u6N4noiHxmhoVVtqYcUpcrSYapP55Mbs
         S0/JIPa2XI3wJTuDQchC8hCOurrLz52fA+hB07hwpwDsoI07L0QIdF32uhNzpbBjfx2m
         fsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lx+l/8EX5/B6t7GqicAJdN2LFsQiGYmKQ2HlmguR5LI=;
        b=C9Er1xix+UjPOhLWDYQxUeF6D3ncmUQ9LpGh/52tLV2zZK2eKj3SX+zciLri7DOIn0
         5RxzbJSSYGDpna27CFVODr2O5bYtzZiMtJFyjwPW5OaE+cp4Vml8q9HPHEQ09x32ikBW
         XoV7TzO/p4eZNnJ6Ff7T7Jmi6P7mFdbbauaOCzRUSaB///SVIZRpU6XbCurPviu70JpQ
         BOl84ufwdHCToEECrXhEpdnKcQDTA7u74LiRDeB4fNRI3ZW9Ir0n/pBbe/Egtz4SEhzm
         rhfoUOGGo3Wb42TySDkvRzt4cE0662hAlCZT3s2HbgFoFt2eFZs/1EkICk72AnLZMfi1
         zTZg==
X-Gm-Message-State: ALoCoQnsbZ8b134lc0+EIpcatWGBHx5crCZACcM+Z9AwXYaW8zIHSH+Danerr9qnS6Z0OpXJveQL
X-Received: by 10.42.66.11 with SMTP id n11mr27349433ici.83.1427494211723;
        Fri, 27 Mar 2015 15:10:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7174:4672:de72:7789])
        by mx.google.com with ESMTPSA id d19sm2132806ioj.37.2015.03.27.15.10.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 15:10:11 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427494150-8085-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266391>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 shallow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/shallow.c b/shallow.c
index d8bf40a..f8b0458 100644
--- a/shallow.c
+++ b/shallow.c
@@ -416,7 +416,7 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
 	uint32_t *bitmap = paint_alloc(info);
 	struct commit *c = lookup_commit_reference_gently(sha1, 1);
 	if (!c)
-		return;
+		goto out;
 	memset(bitmap, 0, bitmap_size);
 	bitmap[id / 32] |= (1 << (id % 32));
 	commit_list_insert(c, &head);
@@ -471,7 +471,7 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
 		if (o && o->type == OBJ_COMMIT)
 			o->flags &= ~SEEN;
 	}
-
+out:
 	free(tmp);
 }
 
-- 
2.3.0.81.gc37f363
