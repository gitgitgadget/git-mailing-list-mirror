From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH/RFC] config: Add --null/-z option for null-delimted output
Date: Mon, 18 Jun 2007 01:25:32 +0200
Message-ID: <11821227322913-git-send-email-frank@lichtenheld.de>
References: <f2t6na$5bi$1@sea.gmane.org>
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 18 01:25:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I047u-0004ne-JU
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 01:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759714AbXFQXZk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 19:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759535AbXFQXZk
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 19:25:40 -0400
Received: from v32413.1blu.de ([88.84.155.73]:53627 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756550AbXFQXZj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 19:25:39 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1I047m-0007wr-2s; Mon, 18 Jun 2007 01:25:38 +0200
Received: from host86-147-63-233.range86-147.btcentralplus.com ([86.147.63.233] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1I047h-0000PG-Qj; Mon, 18 Jun 2007 01:25:34 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1I047g-0002eB-4T; Mon, 18 Jun 2007 01:25:32 +0200
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <f2t6na$5bi$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50377>

Use \n as delimiter between key and value and \0 as
delimiter after each key/value pair. This should be
easily parsable output.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 builtin-config.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

 Note the FIXME. Does anyone remember the reason why --get-regexp
 and --list use different output format?

 On Tue, May 22, 2007 at 12:37:57AM +0200, Jakub Narebski wrote:
 > Frank Lichtenheld wrote:
 > > On Mon, May 21, 2007 at 09:54:23PM +0200, Jan Hudec wrote:
 > >>     KEY <TAB> VALUE <NUL>
 > > Both subsection names and values can contain <TAB> characters, so the
 > > latter isn't possible.
 > But neither subsection names (even [section "subsection"] style) not key
 > names cannot contain newline <LF>. I.e.
 >         KEY <LF> VALUE <NUL>

diff --git a/builtin-config.c b/builtin-config.c
index b2515f7..bed2722 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -2,7 +2,7 @@
 #include "cache.h"
 
 static const char git_config_set_usage[] =
-"git-config [ --global | --system ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list";
+"git-config [ --global | --system ] [ --bool | --int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list";
 
 static char *key;
 static regex_t *key_regexp;
@@ -12,14 +12,16 @@ static int use_key_regexp;
 static int do_all;
 static int do_not_match;
 static int seen;
+static char delim = '=';
+static char term = '\n';
 static enum { T_RAW, T_INT, T_BOOL } type = T_RAW;
 
 static int show_all_config(const char *key_, const char *value_)
 {
 	if (value_)
-		printf("%s=%s\n", key_, value_);
+		printf("%s%c%s%c", key_, delim, value_, term);
 	else
-		printf("%s\n", key_);
+		printf("%s%c", key_, term);
 	return 0;
 }
 
@@ -39,6 +41,7 @@ static int show_config(const char* key_, const char* value_)
 		return 0;
 
 	if (show_keys)
+		/* FIXME: not useful with --null */
 		printf("%s ", key_);
 	if (seen && !do_all)
 		dup_error = 1;
@@ -54,7 +57,7 @@ static int show_config(const char* key_, const char* value_)
 				key_, vptr);
 	}
 	else
-		printf("%s\n", vptr);
+		printf("%s%c", vptr, term);
 
 	return 0;
 }
@@ -155,6 +158,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		}
 		else if (!strcmp(argv[1], "--system"))
 			setenv("GIT_CONFIG", ETC_GITCONFIG, 1);
+		else if (!strcmp(argv[1], "--null") || !strcmp(argv[1], "-z")) {
+			term = '\0';
+			delim = '\n';
+		}
 		else if (!strcmp(argv[1], "--rename-section")) {
 			int ret;
 			if (argc != 4)
-- 
1.5.2.1
