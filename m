From: Stefan Beller <sbeller@google.com>
Subject: [PATCH V2 1/6] shallow: fix a memleak
Date: Fri, 27 Mar 2015 15:32:44 -0700
Message-ID: <1427495569-10863-2-git-send-email-sbeller@google.com>
References: <1427495569-10863-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, pclouds@gmail.com
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 23:33:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbcoS-0005WD-Vh
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbbC0WdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:33:08 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36039 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbbC0WdG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:33:06 -0400
Received: by iedm5 with SMTP id m5so81529967ied.3
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lx+l/8EX5/B6t7GqicAJdN2LFsQiGYmKQ2HlmguR5LI=;
        b=R3H4RJMFBTI6vlHMAnE1rAm7jW+nw+4CYgnkuyqBZrLmUnBT4dq8FK/j4V8fo/P6YB
         NfJBngyJ+g71xIysl/ZffkOafxnfc/ju2G+tSx7wAdfGvUFZ5fmFQbKHe47AjjF5cTuu
         b0S3npi+lHZSa/i9Ow9sLz0CE/l1Uk+KedZZFGWklDloKk3ysVpXCG4Cd8zGqGnlMPCY
         Vk6IDRK9NTIeD14wXvmo3zuPyJNwkqLUtlwH9PBWwsbiY6oIQxmiV+QrMXJLdf8k21Ke
         Flcvbnsdb0GB1bx/ZjZuP61nhJfHsArmWAJdu8KRsSp5pifJIb09wGhpZUw31zKvuB4f
         RDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lx+l/8EX5/B6t7GqicAJdN2LFsQiGYmKQ2HlmguR5LI=;
        b=R6F461QI0qyf6c+p+9QGMeLBKwaJRAEMXj5dvKF+XfVbKG1TW+xP6fz0k2wW7O50MT
         3ThFy9Jg08vP1Dyno9fQqD6REfZotw6d9lM4V1JvbyHV+WxZQy8heVxS/29rMNOzKZXy
         3qAnt+qYIyxcqrhZsYXr4VGHm+ZbiyhjhBNcWOxrMZESR+wFStXYAlO33+TYO7olU0Di
         7fyz+pjr5kjyL/plcXRPni0o4vnNvQvTSxq90sIihM9pqF03d7FipHRMvWAkzR2/WpWU
         xO+rTg2euuUoQVWVBBOSkaS6OBrn7WJC7cYZmfrFbY9OO7g56htayHjHKlBMtExDUzOk
         pzpw==
X-Gm-Message-State: ALoCoQlZNzTpvExS+bMEowtJSurhjVuIzifVC3qn0uPwtvxIP+J6pU/KrNy9k91KDOrhHDEWkiw9
X-Received: by 10.42.89.72 with SMTP id f8mr47815018icm.24.1427495585298;
        Fri, 27 Mar 2015 15:33:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7174:4672:de72:7789])
        by mx.google.com with ESMTPSA id b6sm2247697igb.15.2015.03.27.15.33.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 15:33:04 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427495569-10863-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266396>

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
