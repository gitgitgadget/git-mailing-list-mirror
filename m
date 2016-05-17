From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] mv: free memory at the end if desired
Date: Mon, 16 May 2016 20:22:45 -0700
Message-ID: <20160517032247.25092-2-sbeller@google.com>
References: <20160517032247.25092-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue May 17 05:23:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Vb6-0002G1-QI
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 05:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbcEQDWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 23:22:55 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35828 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbcEQDWy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 23:22:54 -0400
Received: by mail-pa0-f49.google.com with SMTP id gj5so1667789pac.2
        for <git@vger.kernel.org>; Mon, 16 May 2016 20:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gxgryspcdv0voKl91X9/W9c29o0p6kaxKJNkxDd5nvI=;
        b=S0ngdW4rqAyran3dGVGZdrnnmHVd1LUqLUQBwZVq58QmV9sl7s/po1GVUqeIx5X+Ek
         pWMKjooy62ORvPbfWoN6vv3f5DL9X7L32IYlC+RJuQJ/4I5VKn2YVG+FFVJZRx9bbNJ7
         4yZZJLboPOKk+Y7TBmykoCwaXf+S0mrCkEqcOKvc0IboKJRubRYHnEdZiCAceUnn8cPG
         uiPIzsaNHrzfxgRFt+LMGeWFcitLGkwOf0mKROtQNCq7OBcCcuDtCdPzJZFFAoQqlCGV
         Qvd5DsUJCuksxQ8v7aGoOnd9X4cRtS4slitwCBj0NxeK+V0FKFnZadgV5wZePNo19GQw
         UsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gxgryspcdv0voKl91X9/W9c29o0p6kaxKJNkxDd5nvI=;
        b=LP3rGf3KMcV06MEPiVHINE4guvAOVm9/0ODJEpzc1x/KKG94MKCj6rAu1QXC9lEwki
         c9LV1dcpuqPG7a7zCTyhA3NMO8bsUDtPFNkPk2IXTVc8VHJYW7MybC2Pw7KP+5x0A2up
         TpZQu0iNFayhrTiLdhliaYqFhdUBE7xlRnfddFY143/bi7CMTyr/gXOl+iOzgP8fJvKv
         w6vsnGxrw3SQCGwab85sBYv/58hyJHVj70JzJyzyZ0aUbg4vSfjvKq7xOvwT+guCCSNj
         BEtOvXYOXkUyZRg7jEG50pqsaNRTxZn+IZ83Hk42+PSVbeX7X3VBboPLW42HD1sEiQI0
         HDIg==
X-Gm-Message-State: AOPr4FUKII+DctGhK3QQdOlo/jsPvR5LFsCEjxZOI7tApUJR9Dj3q199pY/QMgGmsl4Cp6Ll
X-Received: by 10.66.134.15 with SMTP id pg15mr49878346pab.98.1463455373361;
        Mon, 16 May 2016 20:22:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d9b2:8bac:9e16:6023])
        by smtp.gmail.com with ESMTPSA id to9sm525039pab.27.2016.05.16.20.22.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 May 2016 20:22:52 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.g9c0faef
In-Reply-To: <20160517032247.25092-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294843>

From: Stefan Beller <stefanbeller@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Makefile     | 7 ++++++-
 builtin/mv.c | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 3f03366..e533257 100644
--- a/Makefile
+++ b/Makefile
@@ -389,7 +389,8 @@ CFLAGS += -Werror \
 	-Wpointer-arith \
 	-Wstrict-prototypes \
 	-Wunused \
-	-Wvla
+	-Wvla \
+	-DFREE_ALL_MEMORY
 endif
 
 # Create as necessary, replace existing, make ranlib unneeded.
@@ -1479,6 +1480,10 @@ ifdef HAVE_GETDELIM
 	BASIC_CFLAGS += -DHAVE_GETDELIM
 endif
 
+ifdef FREE_ALL_MEMORY
+	BASIC_CFLAGS += -DFREE_ALL_MEMORY
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
diff --git a/builtin/mv.c b/builtin/mv.c
index a201426..c48dbb9 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -282,5 +282,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("Unable to write new index file"));
 
+#ifdef FREE_ALL_MEMORY
+	free(destination);
+	free(source);
+	free(submodule_gitfile);
+	free(modes);
+#endif
+
 	return 0;
 }
-- 
2.8.2.401.g9c0faef
