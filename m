From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] config: Add new option to open an editor.
Date: Sat,  7 Feb 2009 23:53:00 +0200
Message-ID: <1234043580-7241-1-git-send-email-felipe.contreras@gmail.com>
References: <94a0d4530902071350h4caab5a8s597ed099d232dde9@mail.gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 22:54:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVv8F-0001NE-62
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 22:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbZBGVxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 16:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbZBGVxH
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 16:53:07 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:54011 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbZBGVxG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 16:53:06 -0500
Received: by fxm13 with SMTP id 13so1930153fxm.13
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 13:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cMZ28vmmuzHGAXjhyqs5WBgEDCqbx8YhqZDg4LDyeEU=;
        b=t8mCvbPVPivr4bBZZmb/ERDy3wBh4GzKZE7eL/ml5ZusrBl9/CeNKwN2as74kvvl3/
         VMA2MEBzL5uJt7E9tlx7j5LqGTIWmV/oygW/HyhIUY7WBpaIq4PCIB3d26/H5R4Dpw7k
         haLEzo7ApgfFEh0UGRzOXWv7xTeAQ3enyld3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fb7mMFJTgJEAJ/eHx1H4bMOdalyodCj+RL/O/EKIwE2wD6dyDnIe63K4GTD048oxZT
         bGxLZYTniAIsUPW4VUK6XdMDZ5FayuDWAFpZ2mNQD+o29aEuu69R8b1XtIiatb7pnQo2
         H3urUzHLUClULssRP9oI7iMlKX4Tjv62oeczw=
Received: by 10.223.115.12 with SMTP id g12mr298297faq.92.1234043582858;
        Sat, 07 Feb 2009 13:53:02 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 12sm1738648fks.5.2009.02.07.13.53.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Feb 2009 13:53:02 -0800 (PST)
X-Mailer: git-send-email 1.6.1.2
In-Reply-To: <94a0d4530902071350h4caab5a8s597ed099d232dde9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108891>

The idea was originated by discussion about usability of manually
editing the config file in 'special needs' systems such as Windows. Now
the user can forget a bit about where the config files actually are.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-config.txt |    6 ++++++
 builtin-config.c             |   13 ++++++++++++-
 2 files changed, 18 insertions(+), 1 deletions(-)

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
index f710162..6937eaf 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -3,7 +3,7 @@
 #include "color.h"
 
 static const char git_config_set_usage[] =
-"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty]";
+"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty] | --edit | -e ]";
 
 static char *key;
 static regex_t *key_regexp;
@@ -362,6 +362,17 @@ int cmd_config(int argc, const char **argv, const char *prefix)
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
+			git_config(git_default_config, NULL);
+			launch_editor(config_filename, NULL, NULL);
+			return 0;
 		} else
 			break;
 		argc--;
-- 
1.6.1.2
