From: David Turner <dturner@twopensource.com>
Subject: [PATCH] builtin/clean.c: Handle disappearing files
Date: Thu, 14 May 2015 17:16:40 -0400
Message-ID: <1431638200-20449-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 23:16:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt0Uw-000082-Mt
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 23:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965352AbbENVQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 17:16:50 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36655 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964836AbbENVQt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 17:16:49 -0400
Received: by qkgw4 with SMTP id w4so18197424qkg.3
        for <git@vger.kernel.org>; Thu, 14 May 2015 14:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oO1BX9rP1YnNwUr0r3/0wlXXw1RnPvzb6lsRD1hYlH4=;
        b=RRerTTp/hidfFuU8tuD0tvw+e/uNniw/2CRtror0xc4mGBupkuJDOw4UHwYL29kuk0
         NspZhSCEGWFALosqNlTCAXjWTxG98e6EpvakPQKvgym1+pf3WhjOiESIQ3MsclUz7Qol
         xHlOrCikuHpsai287+0g2ZSyojGBOFtLL26kcgBeA5+B6o+Krc1mR1nEwC4MqA61O8eI
         v/7veh8V8QBs3vl5fjpcfKQnaQ7VF4Ct+jaHY0vYXGAjqKARSHbPEM+uYKUidjxaRZeB
         Pu6ostuXvHmMYQ0x0KMfQWtLgOUEVs6s1/qTJQL4Rz5aK/250THiYeEL+TpSc9J90UAi
         Vhzg==
X-Gm-Message-State: ALoCoQkTbdfy8pE4ON6r8gPTbxY9Q324BlWAejfVwHi04urPP5xQKQW+MQcmfQn4iIW/TAN5KEz/
X-Received: by 10.140.151.15 with SMTP id 15mr8314613qhx.104.1431638208571;
        Thu, 14 May 2015 14:16:48 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by mx.google.com with ESMTPSA id c2sm176981qkh.14.2015.05.14.14.16.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 May 2015 14:16:47 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269098>

During a git clean, some other process might be deleting files as
well.  If this happens, make git clean no longer die.

Signed-off-by: David Turner <dturner@twitter.com>
---
 builtin/clean.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 98c103f..3ae44c2 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -941,8 +941,16 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		if (!cache_name_is_other(ent->name, ent->len))
 			continue;
 
-		if (lstat(ent->name, &st))
-			die_errno("Cannot lstat '%s'", ent->name);
+		/*
+		 * Some concurrent process might have already removed
+		 * ent->name.
+		 */
+		if (lstat(ent->name, &st)) {
+			if (errno == ENOENT || errno == ENOTDIR)
+				continue;
+			else
+				die_errno("Cannot lstat '%s'", ent->name);
+		}
 
 		if (pathspec.nr)
 			matches = dir_path_match(ent, &pathspec, 0, NULL);
-- 
2.0.4.315.gad8727a-twtrsrc
