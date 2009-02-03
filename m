From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] config: Add new option to open an editor.
Date: Wed,  4 Feb 2009 00:40:26 +0200
Message-ID: <1233700826-11763-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 23:42:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUTxu-0000wU-GA
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 23:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbZBCWkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 17:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbZBCWkb
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 17:40:31 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:59676 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbZBCWka (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 17:40:30 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1037830fgg.17
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 14:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=kvTZGFDYsm3mdtBn2Dt89OMee0mUQ6CBsljMklXbSRE=;
        b=FiR9K9UbZdeanhwTfWWrEVwinrWd1JCPGzz4QG8dVUy45XEG0g+SRAdvLUjovxAkoI
         rSn1mg1bzqfYKAjQjVu7XphGUVfmdxaajrZTytcRXkbidPNOmiXOjl3hX/8SdqDNIqFi
         WWxhHinLE3Zsh3fh/N6MfYGTvQN8SRq1H5lfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=d3LbJw2Z7Lhn6qb0G/BCcFYu+4NrDfhkzBeymDLeBhdaOhtZt9mFyAtapDEANWt2L8
         /m2QmBzfEEcbz2Mx3S28VKfOG3xlY3XRg8D2B8caklqqSuUHDlhe3tfwo5OTeFZJGJ7Q
         7pZmjUjWhIWdXtBQE/V//34gn8/NPH8huxCB0=
Received: by 10.180.252.8 with SMTP id z8mr231938bkh.158.1233700828493;
        Tue, 03 Feb 2009 14:40:28 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id e17sm6862727fke.28.2009.02.03.14.40.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 14:40:28 -0800 (PST)
X-Mailer: git-send-email 1.6.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108256>

The idea was originated by discussion about usability of manually
editing the config file in 'special needs' systems such as Windows. Now
the user can forget a bit about where the config files actually are.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-config.txt |    6 ++++++
 builtin-config.c             |   11 ++++++++++-
 2 files changed, 16 insertions(+), 1 deletions(-)

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
index f710162..b0a86b1 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -3,7 +3,7 @@
 #include "color.h"
 
 static const char git_config_set_usage[] =
-"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty]";
+"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty] | --edit | -e ]";
 
 static char *key;
 static regex_t *key_regexp;
@@ -362,6 +362,15 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			return get_color(argc-2, argv+2);
 		} else if (!strcmp(argv[1], "--get-colorbool")) {
 			return get_colorbool(argc-2, argv+2);
+		} else if (!strcmp(argv[1], "--edit") || !strcmp(argv[1], "-e")) {
+			char *config_filename;
+			if (config_exclusive_filename)
+				config_filename = xstrdup(config_exclusive_filename);
+			else
+				config_filename = git_pathdup("config");
+			launch_editor(config_filename, NULL, NULL);
+			free(config_filename);
+			return 0;
 		} else
 			break;
 		argc--;
-- 
1.6.1.2
