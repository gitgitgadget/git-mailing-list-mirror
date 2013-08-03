From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCHv3 7/9] config parsing options: allow one flag multiple times
Date: Sat,  3 Aug 2013 13:51:24 +0200
Message-ID: <1375530686-2309-8-git-send-email-stefanbeller@googlemail.com>
References: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sat Aug 03 13:51:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5aN5-0005cc-Oa
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 13:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab3HCLv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 07:51:26 -0400
Received: from mail-ea0-f181.google.com ([209.85.215.181]:46955 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551Ab3HCLvU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 07:51:20 -0400
Received: by mail-ea0-f181.google.com with SMTP id d10so771473eaj.12
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 04:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VXZQf/aTVwKF29A1ulETCGiNOWuZk3cieO3327jJ17s=;
        b=tlKmdnPat1Fd0dAcmZCVnhaHpWcm9FRzhfHioxvSZzyETO55ML3lFfY3X03VdKenk+
         WCJsJ/dydorCEJV4Zi2Ly27DaONbFbWWC02S7euh2fTqB7+dg/HJilrwWtI8QSJcXNAZ
         WLmAFfruozOi2ggtGMq4+C/EWZssuHJl9frqzBu2JkLgUJXTK3DwQInfscmIMoHrNqCb
         +ayVh4M4usEgCFPINM8zHRE/BX4AXr2wej8AG4tpvnd9ItpJTMO3yCXsi5RF2w9aZCnH
         dsGpPF6feICmlROThS4J5Luc5cPDVS7tOb0DWZb3btMMtMm6MAjIv7YSUIAiGONGQ9m5
         sZSQ==
X-Received: by 10.14.1.70 with SMTP id 46mr9305108eec.82.1375530678491;
        Sat, 03 Aug 2013 04:51:18 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id k3sm18869455een.16.2013.08.03.04.51.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 04:51:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.16.g7fca822.dirty
In-Reply-To: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231588>

This task emerged from b04ba2bb (parse-options: deprecate OPT_BOOLEAN,
2011-09-27).

This commit introduces a change for the users, after this patch
you can pass one of the config level flags multiple times:
Before:
	$ git config --global --global --list
	error: only one config file at a time.
	usage: ...

Afterwards this will work. This is due to the following check in the code:
	if (use_global_config + use_system_config + use_local_config +
	    !!given_config_file + !!given_config_blob > 1) {
		error("only one config file at a time.");
		usage_with_options(builtin_config_usage, builtin_config_options);
	}

With OPT_BOOL instead of OPT_BOOLEAN the variables use_global_config,
use_system_config, use_local_config will only have the value 0 if the
command line option was not passed or 1 no matter how often the
respective command line option was passed.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index da12fdb..4ab9e9a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -50,9 +50,9 @@ static int respect_includes = -1;
 
 static struct option builtin_config_options[] = {
 	OPT_GROUP(N_("Config file location")),
-	OPT_BOOLEAN(0, "global", &use_global_config, N_("use global config file")),
-	OPT_BOOLEAN(0, "system", &use_system_config, N_("use system config file")),
-	OPT_BOOLEAN(0, "local", &use_local_config, N_("use repository config file")),
+	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
+	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
+	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
 	OPT_STRING('f', "file", &given_config_file, N_("file"), N_("use given config file")),
 	OPT_STRING(0, "blob", &given_config_blob, N_("blob-id"), N_("read config from given blob object")),
 	OPT_GROUP(N_("Action")),
-- 
1.8.4.rc0.16.g7fca822.dirty
