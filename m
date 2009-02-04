From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3] config: Add new option to open an editor.
Date: Thu,  5 Feb 2009 00:34:16 +0200
Message-ID: <1233786856-6571-1-git-send-email-felipe.contreras@gmail.com>
References: <94a0d4530902040741t4333b132v886d7057353ed52a@mail.gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 23:35:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUqLV-0005RB-LU
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 23:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756688AbZBDWeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 17:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756142AbZBDWeW
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 17:34:22 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:34554 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755849AbZBDWeV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 17:34:21 -0500
Received: by fxm13 with SMTP id 13so3403589fxm.13
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 14:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Zye8faNM+LzUiM7uIejR/3b1JzKaIqY/4pgaFiNd37U=;
        b=rfs2g/6V3cS0X3XExKg1lA0ldTNznXmQOy2QhR99BkmWONhHK1cUByHx3CoGRP5w61
         GOjvYf5TDnjZgUUzekFSezqafkPkp15d7xIs68FherYeDN/JQI/IVzNn+CXhCYjKVx2E
         M4MGVTvJUwbj3mgXAcgL7HL/HldqJugBXmc7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=X2V8n6TuInl/q8AtCQsdvlxaAsMtQiimV5HgD77yQAa4/smtWgybw0irP+N09VUCyd
         OCRd/O9c6CQ4CSr/qKwW35kKnLG7mGN4JdP8gAZUgY4e/FyS30idxU0Nh977AVLLE/3q
         AcxIDPQLzWgK0RBPMIWwwOrRMxiq8nuj2RO2s=
Received: by 10.223.121.6 with SMTP id f6mr616301far.77.1233786858971;
        Wed, 04 Feb 2009 14:34:18 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id z15sm6889014fkz.31.2009.02.04.14.34.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 14:34:18 -0800 (PST)
X-Mailer: git-send-email 1.6.1.2
In-Reply-To: <94a0d4530902040741t4333b132v886d7057353ed52a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108446>

The idea was originated by discussion about usability of manually
editing the config file in 'special needs' systems such as Windows. Now
the user can forget a bit about where the config files actually are.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-config.txt |    6 ++++++
 builtin-config.c             |   12 +++++++++++-
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 19a8917..7d14007 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -22,6 +22,7 @@ SYNOPSIS
 'git config' [<file-option>] [-z|--null] -l | --list
 'git config' [<file-option>] --get-color name [default]
 'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
+'git config' [<file-option>] -e | --edit
 
 DESCRIPTION
 -----------
@@ -157,6 +158,11 @@ See also <<FILES>>.
 	output.  The optional `default` parameter is used instead, if
 	there is no color configured for `name`.
 
+-e::
+--edit::
+	Opens an editor to modify the specified config file; either
+	'--system', '--global', or repository (default).
+
 [[FILES]]
 FILES
 -----
diff --git a/builtin-config.c b/builtin-config.c
index 1582673..4457b34 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -3,7 +3,7 @@
 #include "color.h"
 
 static const char git_config_set_usage[] =
-"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty]";
+"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty] | --edit | -e ]";
 
 static char *key;
 static regex_t *key_regexp;
@@ -362,6 +362,16 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			return get_color(argc-2, argv+2);
 		} else if (!strcmp(argv[1], "--get-colorbool")) {
 			return get_colorbool(argc-2, argv+2);
+		} else if (!strcmp(argv[1], "--edit") || !strcmp(argv[1], "-e")) {
+			const char *config_filename;
+			if (argc != 2)
+				usage(git_config_set_usage);
+			if (config_exclusive_filename)
+				config_filename = config_exclusive_filename;
+			else
+				config_filename = git_path("config");
+			launch_editor(config_filename, NULL, NULL);
+			return 0;
 		} else
 			break;
 		argc--;
-- 
1.6.1.2
