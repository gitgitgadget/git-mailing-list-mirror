X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Add --global option to git-repo-config.
Date: Thu, 2 Nov 2006 10:44:20 -0500
Message-ID: <BAYC1-PASMTP11D0E68D26DD5FF963405FAEFF0@CEZ.ICE>
References: <vpqmz7a1694.fsf@ecrins.imag.fr>
	<BAYC1-PASMTP018DA61B5F35F9603DF8A8AEFF0@CEZ.ICE>
	<Pine.LNX.4.63.0611021448100.1670@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP042F05A3C71EDC671552FFAEFF0@CEZ.ICE>
	<Pine.LNX.4.63.0611021550060.1670@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 15:45:14 +0000 (UTC)
Cc: git <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061102104420.5adaa45d.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0611021550060.1670@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 02 Nov 2006 15:53:32.0140 (UTC) FILETIME=[0BFEC2C0:01C6FE97]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfekJ-0004Ih-0S for gcvg-git@gmane.org; Thu, 02 Nov
 2006 16:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751151AbWKBPoY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 10:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWKBPoY
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 10:44:24 -0500
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:41625 "EHLO
 BAYC1-PASMTP11.CEZ.ICE") by vger.kernel.org with ESMTP id S1751151AbWKBPoX
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 10:44:23 -0500
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP11.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Thu, 2 Nov
 2006 07:53:31 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1Gfdno-0001ue-8h; Thu, 02 Nov 2006 09:44:20 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org


Allow user to set variables in global ~/.gitconfig file
using command line.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
---
 Documentation/git-repo-config.txt |   31 ++++++++++++++++++-------------
 builtin-repo-config.c             |   13 +++++++++++--
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
index 8a1ab61..8199615 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -3,19 +3,19 @@ git-repo-config(1)
 
 NAME
 ----
-git-repo-config - Get and set options in .git/config
+git-repo-config - Get and set repository or global options.
 
 
 SYNOPSIS
 --------
 [verse]
-'git-repo-config' [type] name [value [value_regex]]
-'git-repo-config' [type] --replace-all name [value [value_regex]]
-'git-repo-config' [type] --get name [value_regex]
-'git-repo-config' [type] --get-all name [value_regex]
-'git-repo-config' [type] --unset name [value_regex]
-'git-repo-config' [type] --unset-all name [value_regex]
-'git-repo-config' -l | --list
+'git-repo-config' [--global] [type] name [value [value_regex]]
+'git-repo-config' [--global] [type] --replace-all name [value [value_regex]]
+'git-repo-config' [--global] [type] --get name [value_regex]
+'git-repo-config' [--global] [type] --get-all name [value_regex]
+'git-repo-config' [--global] [type] --unset name [value_regex]
+'git-repo-config' [--global] [type] --unset-all name [value_regex]
+'git-repo-config' [--global] -l | --list
 
 DESCRIPTION
 -----------
@@ -41,8 +41,9 @@ This command will fail if:
 . Can not write to .git/config,
 . no section was provided,
 . the section or key is invalid,
-. you try to unset an option which does not exist, or
-. you try to unset/set an option for which multiple lines match.
+. you try to unset an option which does not exist,
+. you try to unset/set an option for which multiple lines match, or
+. you use --global option without $HOME being properly set.
 
 
 OPTIONS
@@ -64,14 +65,17 @@ OPTIONS
 --get-regexp::
 	Like --get-all, but interprets the name as a regular expression.
 
+--global::
+	Use global ~/.gitconfig file rather than the repository .git/config.
+
 --unset::
-	Remove the line matching the key from .git/config.
+	Remove the line matching the key from config file.
 
 --unset-all::
-	Remove all matching lines from .git/config.
+	Remove all matching lines from config file.
 
 -l, --list::
-	List all variables set in .git/config.
+	List all variables set in config file.
 
 
 ENVIRONMENT
@@ -79,6 +83,7 @@ ENVIRONMENT
 
 GIT_CONFIG::
 	Take the configuration from the given file instead of .git/config.
+	Using the "--global" option forces this to ~/.gitconfig.
 
 GIT_CONFIG_LOCAL::
 	Currently the same as $GIT_CONFIG; when Git will support global
diff --git a/builtin-repo-config.c b/builtin-repo-config.c
index f60cee1..7b6e572 100644
--- a/builtin-repo-config.c
+++ b/builtin-repo-config.c
@@ -3,7 +3,7 @@
 #include <regex.h>
 
 static const char git_config_set_usage[] =
-"git-repo-config [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --unset | --unset-all] name [value [value_regex]] | --list";
+"git-repo-config [ --global ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --unset | --unset-all] name [value [value_regex]] | --list";
 
 static char *key;
 static regex_t *key_regexp;
@@ -139,7 +139,16 @@ int cmd_repo_config(int argc, const char
 			type = T_BOOL;
 		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l"))
 			return git_config(show_all_config);
-		else
+		else if (!strcmp(argv[1], "--global")) {
+			char *home = getenv("HOME");
+			if (home) {
+				char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
+				setenv("GIT_CONFIG", user_config, 1);
+				free(user_config);
+			} else {
+				die("$HOME not set");
+			}
+		} else
 			break;
 		argc--;
 		argv++;
-- 
1.4.3.3.g869c
