From: David Turner <dturner@twopensource.com>
Subject: [PATCH] clean: only lstat files in pathspec
Date: Mon, 18 May 2015 14:08:46 -0400
Message-ID: <1431972526-26382-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 20:10:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuPUM-0003rA-77
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 20:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbbERSJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 14:09:58 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34517 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459AbbERSJz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 14:09:55 -0400
Received: by qkgx75 with SMTP id x75so114799338qkg.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 11:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WgtImrnJLQ2rpGdYZegBA8exZdXM5e7j22qXzJ4z2TI=;
        b=IHP5mhZ/dHYFW4HWugISMtaePIBXdS9BXqlZQPB7WImiSYtRe6HIzxPD+Vd0puFYWq
         hI5ptONlmarHBlVfuyRyPNbm7/U66n8ojxln4AYh74NCGMn25mUVkER67/0wKSD1U8Y0
         N8AoRoI3D1dT78MpFZrBf2x7aw7VeR12UtRp7eIR0fZEPnFfixS6KXyyP02qJuvcuJpY
         TvZ5vtBLNm8sJiBPsDPP/fBo5Oft1jSGWg524oRfKxgfCB8kx7+YjqxvsWoGXvMtxZge
         DsBQ+pnRDKB68cBge63KvkVdcivllR+V8wHmMHZcFTz26RaB4tSCltP4BnC4cRTHWKGB
         gTkw==
X-Gm-Message-State: ALoCoQm7qpV9CYeZYt/+L34puVrw+TPK96oEM9NRgBeUt+yiHQ0g+4jS4W8TEubT5fKMK64/4L0+
X-Received: by 10.229.98.200 with SMTP id r8mr32110148qcn.15.1431972594404;
        Mon, 18 May 2015 11:09:54 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by mx.google.com with ESMTPSA id 8sm7420276qhs.5.2015.05.18.11.09.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 11:09:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269290>

Git clean takes a list of paths to clean.  Make sure that it only
lstats files which match that list of paths.  Previously, if another
process was deleting files outside of the specified paths, clean might
have failed when attempting to lstat those files.  Now, it will not
lstat them, and thus will not fail.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/clean.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 98c103f..ada0196 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -941,15 +941,15 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		if (!cache_name_is_other(ent->name, ent->len))
 			continue;
 
-		if (lstat(ent->name, &st))
-			die_errno("Cannot lstat '%s'", ent->name);
-
 		if (pathspec.nr)
 			matches = dir_path_match(ent, &pathspec, 0, NULL);
 
 		if (pathspec.nr && !matches)
 			continue;
 
+		if (lstat(ent->name, &st))
+			die_errno("Cannot lstat '%s'", ent->name);
+
 		if (S_ISDIR(st.st_mode) && !remove_directories &&
 		    matches != MATCHED_EXACTLY)
 			continue;
-- 
2.0.4.315.gad8727a-twtrsrc
