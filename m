From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH] config: add --local option
Date: Tue,  3 Aug 2010 20:59:23 -0500
Message-ID: <1280887163-22275-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Joshua Jensen <jjensen@workspacewhiz.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 03:59:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgTGh-0002nB-MA
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 03:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758071Ab0HDB7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 21:59:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59598 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758004Ab0HDB7h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 21:59:37 -0400
Received: by iwn7 with SMTP id 7so5662946iwn.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 18:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=TaJRJFVPKVZiJQb+MZih4Afl0uKpv158Fb+/DDJvOHs=;
        b=jVLBKMhHLCjJX0bMgS7uXJcS7GhBWPe5ImceHZMy2ZPOqvIOdsCKRbq145evdEHYjm
         wnBSMaHpA+3kcv5ODlerBudHinafHHY/SqCWYbxS4nkFnDq4rOiXWIFWIv8fbfBtKUWw
         CnmY1rjAGIuufkbAB3Vrdet03+wWcSq9T2qvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=s5N6oAgVoZmcO/2ZcBmsYdRRC3x2BKOMJEGmdG7I6c7kdVv/KcO+d1AJ+7TtkI/86W
         Smqc87VR+139Uvlakp5o3EuzItYbqf27NEVZFvVgKcX4YTspz/nA+cPqIepFbuKfEIbQ
         qfq41ay076uW+tiumplRIU9M5PkvWYmxrdHU0=
Received: by 10.231.15.68 with SMTP id j4mr9345006iba.184.1280887173682;
        Tue, 03 Aug 2010 18:59:33 -0700 (PDT)
Received: from localhost.localdomain (kaayla.chi.corp.google.com [172.31.47.48])
        by mx.google.com with ESMTPS id r3sm7248151ibk.19.2010.08.03.18.59.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 18:59:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152553>

This is a shorthand similar to --system but instead uses
the config file of the current repository.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	This is a resend of [0] since there is now obvious interest
	in the feature by someone else.

	I s/repository/local/ as requested, with the exception of
	the help string, since that seemed more obvious.

	[0] http://article.gmane.org/gmane.comp.version-control.git/118673

 builtin/config.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index f3d1660..3cf9ff0 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -20,7 +20,7 @@ static char delim = '=';
 static char key_delim = ' ';
 static char term = '\n';
 
-static int use_global_config, use_system_config;
+static int use_global_config, use_system_config, use_local_config;
 static const char *given_config_file;
 static int actions, types;
 static const char *get_color_slot, *get_colorbool_slot;
@@ -51,6 +51,7 @@ static struct option builtin_config_options[] = {
 	OPT_GROUP("Config file location"),
 	OPT_BOOLEAN(0, "global", &use_global_config, "use global config file"),
 	OPT_BOOLEAN(0, "system", &use_system_config, "use system config file"),
+	OPT_BOOLEAN(0, "local", &use_local_config, "use repository config file"),
 	OPT_STRING('f', "file", &given_config_file, "FILE", "use given config file"),
 	OPT_GROUP("Action"),
 	OPT_BIT(0, "get", &actions, "get value: name [value-regex]", ACTION_GET),
@@ -342,7 +343,7 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 			     builtin_config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (use_global_config + use_system_config + !!given_config_file > 1) {
+	if (use_global_config + use_system_config + use_local_config + !!given_config_file > 1) {
 		error("only one config file at a time.");
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
@@ -358,6 +359,8 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 	}
 	else if (use_system_config)
 		config_exclusive_filename = git_etc_gitconfig();
+	else if (use_local_config)
+		config_exclusive_filename = git_pathdup("config");
 	else if (given_config_file) {
 		if (!is_absolute_path(given_config_file) && prefix)
 			config_exclusive_filename = prefix_filename(prefix,
-- 
1.7.1
