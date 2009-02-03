From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] config: Add new option to open an editor.
Date: Wed,  4 Feb 2009 01:26:37 +0200
Message-ID: <1233703597-14532-1-git-send-email-felipe.contreras@gmail.com>
References: <94a0d4530902031525o11e512barfc2f50c33a520474@mail.gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 00:28:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUUgw-0007cY-7D
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 00:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbZBCX0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 18:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbZBCX0m
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 18:26:42 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:50570 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbZBCX0l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 18:26:41 -0500
Received: by fxm13 with SMTP id 13so2668974fxm.13
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 15:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zecV/HXpW8LNkSySvCstWq+AAUpKpt7E+DIFDax5Mh4=;
        b=p13aIroXjtvhI511WMmiMDkLkyUqQz8gvAJsR4niZDwKqrMorNm/3MAh96jLl39bbn
         ly8vrAh42415nH9AMz1hFG2iAcgtL9VALumGmmxYwDIYg5qVTmWX60T+WKQA4aIT9/ma
         4p8xH3vVXM9x2o52ue6KSdM09koSxMEY2cw2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XmD5Qdpf5ODCBc3EAs3OL6l1Pry2CgDYVyMwLc8+Lhv7Y2x886tWfZDs312f/imLY0
         xPSDXV/BXtBI3/03Yv+iYcChAjHqHHBjdpZI53ozIwV7nXFQeb3cJKCvlU9bRI4eP3cb
         4SWNSH/r/4NodmF2PXOEB3h4CpLw2HDVc/ShI=
Received: by 10.180.221.13 with SMTP id t13mr965334bkg.55.1233703599263;
        Tue, 03 Feb 2009 15:26:39 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 31sm6940127fkt.22.2009.02.03.15.26.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 15:26:38 -0800 (PST)
X-Mailer: git-send-email 1.6.1.2
In-Reply-To: <94a0d4530902031525o11e512barfc2f50c33a520474@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108276>

The idea was originated by discussion about usability of manually
editing the config file in 'special needs' systems such as Windows. Now
the user can forget a bit about where the config files actually are.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-config.txt |    6 ++++++
 builtin-config.c             |   10 +++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

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
index 1582673..0405242 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -3,7 +3,7 @@
 #include "color.h"
 
 static const char git_config_set_usage[] =
-"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty]";
+"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty] | --edit | -e ]";
 
 static char *key;
 static regex_t *key_regexp;
@@ -362,6 +362,14 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			return get_color(argc-2, argv+2);
 		} else if (!strcmp(argv[1], "--get-colorbool")) {
 			return get_colorbool(argc-2, argv+2);
+		} else if (!strcmp(argv[1], "--edit") || !strcmp(argv[1], "-e")) {
+			const char *config_filename;
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
