From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Tue, 16 Jan 2007 01:51:51 -0800
Message-ID: <20070116095150.GA31467@localdomain>
References: <200701150144.56793.jnareb@gmail.com> <200701151003.44498.jnareb@gmail.com> <20070115095613.GA4037@localdomain> <200701151132.00971.jnareb@gmail.com> <20070115112635.GA5134@localdomain> <Pine.LNX.4.63.0701151313050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 10:52:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6kyy-00086K-IC
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 10:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbXAPJvy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 04:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbXAPJvy
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 04:51:54 -0500
Received: from hand.yhbt.net ([66.150.188.102]:39421 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbXAPJvx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 04:51:53 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 7712D7DC094;
	Tue, 16 Jan 2007 01:51:51 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 16 Jan 2007 01:51:51 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701151313050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36922>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Mon, 15 Jan 2007, Eric Wong wrote:
> 
> > > Would you write "git repo-config --perl", then? ;-)
> > 
> > The below patch should be a start (only tested on my fairly standard 
> > .git/config).  A --python option should be easy, too :)
> 
> A bit shorter (and gets the booleans right, plus being even easier 
> towards --python extension):

Your version doesn't get arrays right, however.

Here's a Perl/Python/Ruby version below.  It should be extendable for
other languages; feedback and additions appreciated:

Note that usage has been changed to --dump=(perl|python|ruby)

I may add key_suffix to lang_dump just to be consistent with pairings,
but array_start seems to handle all cases of it and it would be
redundant...

--- a/builtin-repo-config.c
+++ b/builtin-repo-config.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "quote.h"
 
 static const char git_config_set_usage[] =
 "git-repo-config [ --global ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --list";
@@ -14,6 +15,90 @@ static int do_not_match;
 static int seen;
 static enum { T_RAW, T_INT, T_BOOL } type = T_RAW;
 
+struct lang_dump {
+	const char *name;
+	const char *decl_start;
+	const char *decl_end;
+	const char *key_prefix;
+	const char *array_start;
+	const char *array_end;
+	const char *val_prefix;
+	const char *val_suffix;
+	const char *true_val; /* should already be quoted, if needed */
+	void (*quote_key_fn)(FILE *, const char*);
+	void (*quote_val_fn)(FILE *, const char*);
+};
+static char *last_key;
+static struct lang_dump *lang;
+static struct lang_dump lang_dump_defs[] = {
+	{ "perl",
+		"\%git_config = (\n", ");\n",
+		"\t",
+		" => [\n", "\t],\n",
+		"\t\t", ",\n",
+		"'true'",
+		perl_quote_print, perl_quote_print },
+	{ "python",
+		"git_config = {\n", "}\n",
+		"    ",
+		" : [\n", "    ],\n",
+		"        ", ",\n",
+		"True",
+		python_quote_print, python_quote_print },
+	{ "ruby", /* Ruby is very Perl-like */
+		"git_config = {\n", "}\n",
+		"  ",
+		" => [\n", "  ],\n",
+		"    ", ",\n",
+		"true",
+		perl_quote_print, perl_quote_print },
+};
+
+static int show_lang_config(const char *key_, const char *value_)
+{
+	if (last_key) {
+		if (strcmp(last_key, key_)) {
+			free(last_key);
+			fputs(lang->array_end, stdout);
+			goto new_key;
+		}
+	} else {
+new_key:
+		last_key = xstrdup(key_);
+		fputs(lang->key_prefix, stdout);
+		lang->quote_key_fn(stdout, key_);
+		fputs(lang->array_start, stdout);
+	}
+	fputs(lang->val_prefix, stdout);
+	if (value_)
+		lang->quote_val_fn(stdout, value_);
+	else
+		fputs(lang->true_val, stdout);
+	fputs(lang->val_suffix, stdout);
+	return 0;
+}
+
+static int show_lang_config_all(const char *lang_name)
+{
+	int i, rv;
+	for (i = ARRAY_SIZE(lang_dump_defs); --i >= 0; ) {
+		if (strcmp(lang_name, lang_dump_defs[i].name))
+			continue;
+		lang = lang_dump_defs + i;
+		fputs(lang->decl_start, stdout);
+		rv = git_config(show_lang_config);
+		if (last_key) {
+			free(last_key);
+			last_key = NULL;
+			fputs(lang->array_end, stdout);
+			fputs(lang->decl_end, stdout);
+		}
+		return rv;
+	}
+	fputs("Dumping config to '%s' is not yet supported", stderr);
+	return -1;
+}
+
 static int show_all_config(const char *key_, const char *value_)
 {
 	if (value_)
@@ -138,6 +223,8 @@ int cmd_repo_config(int argc, const char **argv, const char *prefix)
 			type = T_BOOL;
 		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l"))
 			return git_config(show_all_config);
+		else if (!strncmp(argv[1], "--dump=", 7))
+			return show_lang_config_all(argv[1] + 7);
 		else if (!strcmp(argv[1], "--global")) {
 			char *home = getenv("HOME");
 			if (home) {
-- 
Eric Wong
