From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Mon, 15 Jan 2007 13:15:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701151313050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701150144.56793.jnareb@gmail.com> <200701151003.44498.jnareb@gmail.com>
 <20070115095613.GA4037@localdomain> <200701151132.00971.jnareb@gmail.com>
 <20070115112635.GA5134@localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:33:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VVo-0000QU-Fn
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:20:48 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9x-0003eK-5M
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbXAOMPh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 07:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbXAOMPh
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 07:15:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:51021 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932273AbXAOMPg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 07:15:36 -0500
Received: (qmail invoked by alias); 15 Jan 2007 12:15:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 15 Jan 2007 13:15:34 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20070115112635.GA5134@localdomain>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36840>

Hi,

On Mon, 15 Jan 2007, Eric Wong wrote:

> > Would you write "git repo-config --perl", then? ;-)
> 
> The below patch should be a start (only tested on my fairly standard 
> .git/config).  A --python option should be easy, too :)

A bit shorter (and gets the booleans right, plus being even easier 
towards --python extension):

---

 builtin-repo-config.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin-repo-config.c b/builtin-repo-config.c
index 9063311..8ebf436 100644
--- a/builtin-repo-config.c
+++ b/builtin-repo-config.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "quote.h"
 
 static const char git_config_set_usage[] =
 "git-repo-config [ --global ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --list";
@@ -12,11 +13,18 @@ static int use_key_regexp;
 static int do_all;
 static int do_not_match;
 static int seen;
+static const char *perl_prefix = NULL;
 static enum { T_RAW, T_INT, T_BOOL } type = T_RAW;
 
 static int show_all_config(const char *key_, const char *value_)
 {
-	if (value_)
+	if (perl_prefix) {
+		printf("%s", perl_prefix);
+		perl_quote_print(stdout, key_);
+		printf(" => ");
+		perl_quote_print(stdout, value_ ? value_ : "true");
+		perl_prefix = ",\n\t";
+	} else if (value_)
 		printf("%s=%s\n", key_, value_);
 	else
 		printf("%s\n", key_);
@@ -138,7 +146,14 @@ int cmd_repo_config(int argc, const char **argv, const char *prefix)
 			type = T_BOOL;
 		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l"))
 			return git_config(show_all_config);
-		else if (!strcmp(argv[1], "--global")) {
+		else if (!strcmp(argv[1], "--perl")) {
+			int ret;
+			perl_prefix = "\n\t";
+			printf("%%git_config = (");
+			ret = git_config(show_all_config);
+			printf("\n);\n");
+			return ret;
+		} else if (!strcmp(argv[1], "--global")) {
 			char *home = getenv("HOME");
 			if (home) {
 				char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
