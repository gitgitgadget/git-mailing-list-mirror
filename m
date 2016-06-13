From: kmcguigan@twopensource.com
Subject: [PATCH 1/1] Don't free remote->name after fetch
Date: Mon, 13 Jun 2016 14:17:17 -0400
Message-ID: <1465841837-31604-1-git-send-email-kmcguigan@twopensource.com>
Cc: Keith McGuigan <kmcguigan@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 20:17:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCWQR-0002X7-HU
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 20:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161084AbcFMSRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 14:17:23 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33231 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111AbcFMSRW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 14:17:22 -0400
Received: by mail-qg0-f49.google.com with SMTP id l44so71578596qgd.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=kihLJXxIeioVSxUg6BpX/dauaJxhr5b/BfGD0GCxGvo=;
        b=DW4DKZZ/WmKftUOyjutEsbGt7TDtkoEJaI1D0BNcQYyZ8EnmljnP0lb86CLKs13cvM
         vAXvp3karqKPWomF3hX0k1InBazZf9PrW37x38S0uNwCoEwwuDO7+1RQPGXcofwgIvGd
         SFWkQfK+Atrqm/0TNp7E/moiQcfUOQRRQPVN1vV86E0WOtKoEKjgHaXyBK/j0stuNev7
         RuArh0l3iFvAxzt+R5I0QpU0EodGWdeixfB9maAPzfbt1u6g5MiMxKxCHV4C3h+yheJj
         GJrrm5rFSsTgXvaI7gnc/u398uXKjoIyy1JVcdKdSUGQmvaO38ioDQuU19KDTFmmexX9
         e5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kihLJXxIeioVSxUg6BpX/dauaJxhr5b/BfGD0GCxGvo=;
        b=leMxJj5+rR1Qz66qB05eezRVMJDYY0zirJ+FME+C0LWX3FdfnZ/i9MtRtpmWslYbsd
         k87Vr4Ba/E1lUtUhHOYeTSEmtzn04MfzEsyKeGtQN/LHsJiJue4bB2J9ZV4PFneNS3T4
         r1pCN4ui6hr1+8zkbjqQ+mE8sMaJAz+e7M6RYXpB3xVp0I4zUf8oAyKcdYSRHlto37Xp
         tyexkXyefoq5C/MuN46GEcewZN++eJvbTjEfhZ3cI+C3ocGbxh6HK9XwxUXYcctgtsqY
         d1RvTm+3NeTVdtzzHpy0NIG7KF1gfTHuprRtTGm/K1ZwWhF0zHzQfBwWXVXCKTlIiP1A
         /CSw==
X-Gm-Message-State: ALyK8tJ7dx/4dAyHSJYMgogDYa73xSNDDuQXWCH5fvUa8nIgmk+djj86iKRzikz3YQMaNg==
X-Received: by 10.140.84.197 with SMTP id l63mr15127540qgd.12.1465841840708;
        Mon, 13 Jun 2016 11:17:20 -0700 (PDT)
Received: from tw-mbp-kmcguigan.twitter.corp (d-216-246-147-91.cpe.metrocast.net. [216.246.147.91])
        by smtp.gmail.com with ESMTPSA id n129sm7150338qhc.15.2016.06.13.11.17.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Jun 2016 11:17:20 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.95.gc8e4e3a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297238>

From: Keith McGuigan <kmcguigan@twopensource.com>

The string_list gets populated with the names from the remotes[] array,
which are not dup'd and the list does not own.

Signed-of-by: Keith McGuigan <kmcguigan@twopensource.com>
---
 builtin/fetch.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 630ae6a1bb78..181da5a2e7a3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1347,8 +1347,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		argv_array_clear(&options);
 	}
 
-	/* All names were strdup()ed or strndup()ed */
-	list.strdup_strings = 1;
 	string_list_clear(&list, 0);
 
 	close_all_packs();
-- 
2.8.0.rc3.95.gc8e4e3a
