From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] builtin-config: add --exec-editor for use in scripts
Date: Sat, 31 Jan 2009 18:53:52 -0800
Message-ID: <20090201025349.GA22160@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 01 03:55:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTSUc-0000yL-ME
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 03:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbZBACxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 21:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbZBACxx
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 21:53:53 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:46939 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538AbZBACxw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 21:53:52 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 455681F799;
	Sun,  1 Feb 2009 02:53:52 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107973>

This exposes the launch_editor() library function for use by
various scripting languages.  This allows the ensure consistent
handling of GIT_EDITOR/VISUAL/EDITOR environment variables as
well as the handling of special characters such as spaces in the
various environment variables.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 I'm not sure if git-config is the best place to stick it.  I plan to
 start using this in git-svn but I don't want to implement Git::Editor
 in Perl and have to keep track of editor.c.  Of course this also makes
 the logic/rules used in libgit usable to any other scripting language
 capable of launching other programs.

 I'll probably also do something like this with setup_pager(), too...

 Documentation/git-config.txt |   10 ++++++++++
 builtin-config.c             |    6 +++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 19a8917..2dd9f1c 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -22,6 +22,7 @@ SYNOPSIS
 'git config' [<file-option>] [-z|--null] -l | --list
 'git config' [<file-option>] --get-color name [default]
 'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
+'git config' [<file-option>] --exec-editor filename
 
 DESCRIPTION
 -----------
@@ -157,6 +158,15 @@ See also <<FILES>>.
 	output.  The optional `default` parameter is used instead, if
 	there is no color configured for `name`.
 
+--exec-editor filename::
+
+	Executes the editor on filename as configured by the
+	GIT_EDITOR/VISUAL/EDITOR environment variables (in that order).
+	This exposes the launch_editor() library function for use with
+	scripting languages that may not have C bindings.  The
+	launch_editor() function takes into account special characters
+	such as spaces in the editor argument.
+
 [[FILES]]
 FILES
 -----
diff --git a/builtin-config.c b/builtin-config.c
index f710162..1c805da 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -3,7 +3,7 @@
 #include "color.h"
 
 static const char git_config_set_usage[] =
-"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty]";
+"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty] | --exec-editor filename";
 
 static char *key;
 static regex_t *key_regexp;
@@ -362,6 +362,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			return get_color(argc-2, argv+2);
 		} else if (!strcmp(argv[1], "--get-colorbool")) {
 			return get_colorbool(argc-2, argv+2);
+		} else if (!strcmp(argv[1], "--exec-editor")) {
+			if (argc != 3)
+				usage(git_config_set_usage);
+			return launch_editor(argv[2], NULL, NULL);
 		} else
 			break;
 		argc--;
-- 
Eric Wong
