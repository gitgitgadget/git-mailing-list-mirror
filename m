From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Mon, 15 Jan 2007 03:26:35 -0800
Message-ID: <20070115112635.GA5134@localdomain>
References: <200701150144.56793.jnareb@gmail.com> <200701151003.44498.jnareb@gmail.com> <20070115095613.GA4037@localdomain> <200701151132.00971.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:33:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VVp-0000R2-C3
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:20:49 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9n-0003eK-LI
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbXAOL0i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 06:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbXAOL0h
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 06:26:37 -0500
Received: from hand.yhbt.net ([66.150.188.102]:38877 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932231AbXAOL0h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 06:26:37 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 64D3D7DC094;
	Mon, 15 Jan 2007 03:26:35 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 15 Jan 2007 03:26:35 -0800
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200701151132.00971.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36841>

Jakub Narebski <jnareb@gmail.com> wrote:
> Eric Wong wrote:
> > Jakub Narebski <jnareb@gmail.com> wrote:
> >> Eric Wong wrote:
> >>> Jakub Narebski <jnareb@gmail.com> wrote:
> >>>> To make gitweb faster I thought about adding to it, or to Git.pm,
> >>>> simple nonvalidation config file reader. Nonvalidating means that
> >>>> it would accept some input which git-repo-config considers invalid.
> >>> 
> >>> How about something like git-for-each-ref that dumps the entire output
> >>> of a config file into an eval()-able string?  That way we don't have to
> >>> deal with corner-cases and subtle differences between C and Perl
> >>> implementations.
> >> 
> >> The idea is (at least for gitweb) to avoid cost of fork. And I think
> >> if the format gets documented properly, there should be no differences
> >> in config file parsing.
> > 
> > If the Perl output is redirected to a file (say .git/config.perl) and
> > only regenerated when .git/config changes, `do(".git/config.perl")' will
> > likely be faster since all the parsing will be done by Perl itself.
> 
> Would you write "git repo-config --perl", then? ;-)

The below patch should be a start (only tested on my fairly standard
.git/config).  A --python option should be easy, too :)

> Besides, I'd rather avoid the need for /tmp/gitweb, and I think usually
> gitweb do not have (and should not have) write access to repository.

Good point.  Having to maintain a .git/config.perl in the repository
would be a pain from an administrative standpoint; but on the other hand
.git/config is not often regenerated.

I don't think giving gitweb write access to a repo is a good idea;
either.  Perhaps it would be updated via hook like the HTTP stuff.
IMHO, there is nothing wrong with gitweb writing to /tmp; however.

diff --git a/builtin-repo-config.c b/builtin-repo-config.c
index 9063311..a9ef358 100644
--- a/builtin-repo-config.c
+++ b/builtin-repo-config.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "quote.h"
 
 static const char git_config_set_usage[] =
 "git-repo-config [ --global ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --list";
@@ -13,6 +14,7 @@ static int do_all;
 static int do_not_match;
 static int seen;
 static enum { T_RAW, T_INT, T_BOOL } type = T_RAW;
+static char *last_key;
 
 static int show_all_config(const char *key_, const char *value_)
 {
@@ -23,6 +25,30 @@ static int show_all_config(const char *key_, const char *value_)
 	return 0;
 }
 
+static int show_perl_config(const char *key_, const char *value_)
+{
+	if (last_key) {
+		if (strcmp(last_key, key_)) {
+			free(last_key);
+			last_key = xstrdup(key_);
+			fputs("\t],\n\t", stdout);
+			perl_quote_print(stdout, key_);
+			fputs(" => [\n", stdout);
+		}
+	} else {
+		last_key = xstrdup(key_);
+		fputc('\t', stdout);
+		perl_quote_print(stdout, key_);
+		fputs(" => [\n", stdout);
+	}
+	if (value_) {
+		fputs("\t\t", stdout);
+		perl_quote_print(stdout, value_);
+		fputs(",\n", stdout);
+	}
+	return 0;
+}
+
 static int show_config(const char* key_, const char* value_)
 {
 	char value[256];
@@ -138,6 +164,17 @@ int cmd_repo_config(int argc, const char **argv, const char *prefix)
 			type = T_BOOL;
 		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l"))
 			return git_config(show_all_config);
+		else if (!strcmp(argv[1], "--perl")) {
+			int rv;
+			puts("\%git_config = (");
+			rv = git_config(show_perl_config);
+			if (last_key) {
+				puts("\t]\n);\n");
+				free(last_key);
+				last_key = NULL;
+			}
+			return rv;
+		}
 		else if (!strcmp(argv[1], "--global")) {
 			char *home = getenv("HOME");
 			if (home) {

-- 
Eric Wong
