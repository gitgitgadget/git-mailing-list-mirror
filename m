From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH] config: add --repository option
Date: Sat,  9 May 2009 18:35:36 +0200
Message-ID: <1241886936-18941-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 09 18:35:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2pWm-00029g-V5
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 18:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275AbZEIQfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 12:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755142AbZEIQfw
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 12:35:52 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:40812 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845AbZEIQfv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 12:35:51 -0400
Received: by ewy24 with SMTP id 24so2491368ewy.37
        for <git@vger.kernel.org>; Sat, 09 May 2009 09:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=rtqQpXWgZN5xwEOf+95V877k9Ocjr/6QS/iRXUf7Vig=;
        b=aGVS6gcIdgoCCDlVx0EkDs8g7y3yF8dXwNMshkRIVa31jdIHkuPum43UEUuhEU/YXE
         QNmU2qDREYnBtLnWDJNlWwKU1UcOk4H7D5cRsWUydv2d5MAqM8CM3p7y5MdxZcXYKl8b
         yex10Eu8+4arQ0zxXmco3owbpxdWxAPayFow8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=pK3aVW0AluMq4nL3gZh4dMSn65Di2C3fP3aoLs1ZAy5o75JbzAYczeoDiR4+dJx9hZ
         7puAmVGyKVGDC08q2NB53rQzSWZssUBhJf1RnhNuTWeSimF0fyYCwnPiPp2gezYCGQ9o
         PGa3tTCjdDKHCoMHqKPLwFk8y4KgpNPuaWv/E=
Received: by 10.210.77.2 with SMTP id z2mr6267150eba.87.1241886948735;
        Sat, 09 May 2009 09:35:48 -0700 (PDT)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 5sm3725840eyh.20.2009.05.09.09.35.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 May 2009 09:35:48 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.ga0e91
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118673>

This is a shorthand similar to --system but instead uses
the config file of the current repository.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	I often want to check what the local value of a config
	entry is, hence this patch.

 builtin-config.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index a81bc8b..1ae4f82 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -20,7 +20,7 @@ static char delim = '=';
 static char key_delim = ' ';
 static char term = '\n';
 
-static int use_global_config, use_system_config;
+static int use_global_config, use_system_config, use_repository_config;
 static const char *given_config_file;
 static int actions, types;
 static const char *get_color_slot, *get_colorbool_slot;
@@ -50,6 +50,7 @@ static struct option builtin_config_options[] = {
 	OPT_GROUP("Config file location"),
 	OPT_BOOLEAN(0, "global", &use_global_config, "use global config file"),
 	OPT_BOOLEAN(0, "system", &use_system_config, "use system config file"),
+	OPT_BOOLEAN(0, "repository", &use_repository_config, "use repository config file"),
 	OPT_STRING('f', "file", &given_config_file, "FILE", "use given config file"),
 	OPT_GROUP("Action"),
 	OPT_BIT(0, "get", &actions, "get value: name [value-regex]", ACTION_GET),
@@ -319,7 +320,7 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 	argc = parse_options(argc, argv, builtin_config_options, builtin_config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (use_global_config + use_system_config + !!given_config_file > 1) {
+	if (use_global_config + use_system_config + use_repository_config + !!given_config_file > 1) {
 		error("only one config file at a time.");
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
@@ -335,6 +336,8 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 	}
 	else if (use_system_config)
 		config_exclusive_filename = git_etc_gitconfig();
+	else if (use_repository_config)
+		config_exclusive_filename = git_pathdup("config");
 	else if (given_config_file) {
 		if (!is_absolute_path(given_config_file) && prefix)
 			config_exclusive_filename = prefix_filename(prefix,
-- 
1.6.3.1.ga0e91
