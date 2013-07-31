From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCHv2 7/9] config: parsing options: config file flag multiple times
Date: Wed, 31 Jul 2013 18:28:35 +0200
Message-ID: <1375288117-1576-8-git-send-email-stefanbeller@googlemail.com>
References: <1375288117-1576-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 18:29:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4ZGp-00084w-Cx
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 18:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210Ab3GaQ2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 12:28:41 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:48406 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932187Ab3GaQ2i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 12:28:38 -0400
Received: by mail-ee0-f53.google.com with SMTP id b15so473512eek.12
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nF/NE1XlH3vrx5vbk5psejSq4o1yNj66z1Ku8KZjBps=;
        b=Eq9Ud3qKcGNeaul1iJS6YfWju6GUyDDB0bHiBVCCQ8RB16c6QECRsuFGPH6jpdipnv
         qyaznF3Mqqtqn8x3J380FQm/5BluXvmWT3PC+X8Jp/9+v63BvA6UFOsv2FIGiAUJ4GNM
         rRdCB27/7RyGtyZpCRDdqBzAWQEwWx7w1P8QcZp91hPnB6D89JUT4Hv2d2jylh9pmNxn
         shdQGu+G9R3pIUo0z59+pKQvt1qYb9QrkUuqsx6Sak/i7dH6A+VTSZDNF6+2Hx3rVaYS
         vsAl8n3TxBgwlt7yxJLt6p1Uss9ua6VzRBCAH91myDT+YT9XlVTKZWdpXVSe8tgJ3NyH
         v43A==
X-Received: by 10.14.218.136 with SMTP id k8mr70258480eep.111.1375288117459;
        Wed, 31 Jul 2013 09:28:37 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id i2sm3750019eeu.4.2013.07.31.09.28.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 09:28:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5
In-Reply-To: <1375288117-1576-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231423>

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
1.8.4.rc0.1.g8f6a3e5
