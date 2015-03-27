From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/6] shallow: fix a memleak
Date: Fri, 27 Mar 2015 15:09:02 -0700
Message-ID: <1427494150-8085-3-git-send-email-sbeller@google.com>
References: <1427494150-8085-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 27 23:10:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbcSL-00057y-UB
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbbC0WKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:10:13 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33434 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbbC0WKK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:10:10 -0400
Received: by iecvj10 with SMTP id vj10so81259437iec.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lx+l/8EX5/B6t7GqicAJdN2LFsQiGYmKQ2HlmguR5LI=;
        b=GTZxCeiMfL/svjY/OvERiZeGM1FYITPYb9AQwUIjDcKYw6+oY+CDvwM+Qyqj0qWNZn
         rrkcasvflwQePwvaTjimoFvjGio05elA3udIw526Bap41Vz3w33XNa64bYPkhPMa0Nvd
         nH/dKp4phD3fS9cR6UCfD6bcIiT2iGmFZApNMnUPdjut32lsEoYi+2UoL3ZP39TDrA0h
         AcEm+IhDTlt8A8o2vfPoCwLDsY7vpj8IX8aq1zEIidIMMA1XM8BhRmHX+oezeZB1iOeO
         JAqaKUMNoZPbKdBNEmoS4c7L76D9DtEzV794/0PWKPFmi2cx4j72eggJpUV785O4xjvz
         Qhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lx+l/8EX5/B6t7GqicAJdN2LFsQiGYmKQ2HlmguR5LI=;
        b=V8i9BFsb9uNJkJlU8jRfdu4r0awibNvIUVkWjsRlw6PLh240+k3ytDOm/gF79UrpGq
         vBg1kENiiZS+wZzlHDYI0r+DO/HUAXMDvfK5i1VupfmjeofmQENwIQvf4l065B9wd3CX
         AnJkS6F8sjgD0WNg6+ne9b0S2T4DSD1QrBq5lmMefRK8Yh9w/5bZHTCK5rrt8ByimFXV
         2M4JmbkYc7sEUSRxrad9o8VotBZv4npN10Cq0hpaZAumyx0eUnZwcuWMNdntAc5lGnH6
         Vh5UD5DPKW+x2Z5xpzKadRAA4pPuMo+G3jXAotNYR5e6Kth0hZ15Ji3qSLRck+E/QEBY
         DSRQ==
X-Gm-Message-State: ALoCoQn4Mar8rjZZ7j15Y+xpIjG4xIZT4+75HwgPd+m1VVKY7S26Hg7jkLRKz2FjJMvThmHLIvqv
X-Received: by 10.50.30.138 with SMTP id s10mr1497377igh.3.1427494209442;
        Fri, 27 Mar 2015 15:10:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7174:4672:de72:7789])
        by mx.google.com with ESMTPSA id f1sm2209626igt.14.2015.03.27.15.10.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 15:10:09 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427494150-8085-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266383>

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
