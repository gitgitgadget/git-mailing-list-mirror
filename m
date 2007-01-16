From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Tue, 16 Jan 2007 11:53:03 -0800
Message-ID: <20070116195303.GB1444@localdomain>
References: <200701150144.56793.jnareb@gmail.com> <200701151003.44498.jnareb@gmail.com> <20070115095613.GA4037@localdomain> <200701151132.00971.jnareb@gmail.com> <20070115112635.GA5134@localdomain> <Pine.LNX.4.63.0701151313050.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070116095150.GA31467@localdomain> <Pine.LNX.4.63.0701161129310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 20:54:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6uNm-0007ry-1X
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 20:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbXAPTxK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 14:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbXAPTxK
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 14:53:10 -0500
Received: from hand.yhbt.net ([66.150.188.102]:39644 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422AbXAPTxI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 14:53:08 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id B4C817DC094;
	Tue, 16 Jan 2007 11:53:03 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 16 Jan 2007 11:53:03 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701161129310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36957>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> I'd like that code to be simpler, though. Way simpler.

I've tried, but I'm not sure how much farther I can go.

> > +	{ "perl",
> > +		"\%git_config = (\n", ");\n",
> 0> +		"\t",
> > +		" => [\n", "\t],\n",
> > +		"\t\t", ",\n",
> > +		"'true'",
> > +		perl_quote_print, perl_quote_print },
> 
> The two quote members seem to be the same for _all_ three languages.

Yes, I was trying to imagine a corner case where quoting
for keys could be different than values.

I know Ruby can use :symbols but those don't support '.' and '-' as
far as I know, Perl doesn't require quoting for keys if they match
^-?\w+.  I guess just using quoted strings as keys is fine enough.
The patch below uses the same quote operator for both keys and values.

> > +	{ "python",
> > +		"git_config = {\n", "}\n",
> > +		"    ",
> 
> I don't understand why you do not consolidate that into using tabs for 
> _all_ backends?

I wanted to make things look familiar to people using those languages.

Most Ruby programmers I've seen use 2-space indents.  I myself have given
into using them when I write Ruby.

Python doesn't seem to care about indentation for data structures, but I
think Python programmers prefer spaces for indentation.  I'm not very
experienced with Python, however.

Tabs are my own personal preference for Perl; but indentation is very
inconsistent in Perl code I've looked at :/.  perlstyle(1) actually
recommends 4 space indents...

On the other hand, we are writing for interpreters and not humans.  So
maybe just using tabs is good enough (some formatting makes debugging
easier, so I'm not putting everything on one line :).

> > +static int show_lang_config(const char *key_, const char *value_)
> > +{
> > +	if (last_key) {
> > +		if (strcmp(last_key, key_)) {
> > +			free(last_key);
> > +			fputs(lang->array_end, stdout);
> > +			goto new_key;
> > +		}
> > +	} else {
> > +new_key:
> > +		last_key = xstrdup(key_);
> > +		fputs(lang->key_prefix, stdout);
> > +		lang->quote_key_fn(stdout, key_);
> > +		fputs(lang->array_start, stdout);
> > +	}
> 
> So this makes _all_ config vars arrays? It is consistent, yes... but it is 
> also ugly, no?

Somewhat ugly, yes, but I think returning everything as an array would
make things easier for code using the data structures.  They could
always just reference the first element if they didn't want the array
instead of having to find the type with ref() or .kind_of?

> > +static int show_lang_config_all(const char *lang_name)
> > +{
> > +	int i, rv;
> > +	for (i = ARRAY_SIZE(lang_dump_defs); --i >= 0; ) {
> > +		if (strcmp(lang_name, lang_dump_defs[i].name))
> > +			continue;
> > +		lang = lang_dump_defs + i;
> 
> IMHO this would be much easier to read using a path_list:
> 
> 	struct path_list_item *item = path_list_lookup(lang_name, &langs);
> 
> 	if (item == NULL)
> 		return -1;
> 
> 	lang = item->util;

Ah, I didn't know about path_list_lookup().  Now that I know about it, I
don't think it's worth it to create the extra data structures around
it.  We can just as easily switch to bsearch(3) when we add more
languages.

> > +		fputs(lang->decl_start, stdout);
> > +		rv = git_config(show_lang_config);
> > +		if (last_key) {
> > +			free(last_key);
> > +			last_key = NULL;
> > +			fputs(lang->array_end, stdout);
> > +			fputs(lang->decl_end, stdout);
> 
> If the config is empty, no decl_end is printed, right?

Good catch.  Thanks.

> > +		}
> > +		return rv;
> > +	}
> > +	fputs("Dumping config to '%s' is not yet supported", stderr);
> > +	return -1;
> > +}

--- a/builtin-repo-config.c
+++ b/builtin-repo-config.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "quote.h"
 
 static const char git_config_set_usage[] =
 "git-repo-config [ --global ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --list";
@@ -14,6 +15,89 @@ static int do_not_match;
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
+	void (*quote_fn)(FILE *, const char*);
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
+		perl_quote_print },
+	{ "python",
+		"git_config = {\n", "}\n",
+		"    ",
+		" : [\n", "    ],\n",
+		"        ", ",\n",
+		"True",
+		python_quote_print },
+	{ "ruby", /* Ruby is very Perl-like */
+		"git_config = {\n", "}\n",
+		"  ",
+		" => [\n", "  ],\n",
+		"    ", ",\n",
+		"true",
+		perl_quote_print },
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
+		lang->quote_fn(stdout, key_);
+		fputs(lang->array_start, stdout);
+	}
+	fputs(lang->val_prefix, stdout);
+	if (value_)
+		lang->quote_fn(stdout, value_);
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
+		}
+		fputs(lang->decl_end, stdout);
+		return rv;
+	}
+	fputs("Dumping config to '%s' is not yet supported", stderr);
+	return -1;
+}
+
 static int show_all_config(const char *key_, const char *value_)
 {
 	if (value_)
@@ -138,6 +222,8 @@ int cmd_repo_config(int argc, const char **argv, const char *prefix)
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
