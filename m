From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Tue, 16 Jan 2007 11:47:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701161129310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701150144.56793.jnareb@gmail.com> <200701151003.44498.jnareb@gmail.com>
 <20070115095613.GA4037@localdomain> <200701151132.00971.jnareb@gmail.com>
 <20070115112635.GA5134@localdomain> <Pine.LNX.4.63.0701151313050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070116095150.GA31467@localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 11:48:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6lrG-0006ZP-D2
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 11:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbXAPKr7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 05:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbXAPKr7
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 05:47:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:49416 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751093AbXAPKr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 05:47:58 -0500
Received: (qmail invoked by alias); 16 Jan 2007 10:47:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 16 Jan 2007 11:47:56 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20070116095150.GA31467@localdomain>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36925>

Hi,

On Tue, 16 Jan 2007, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > On Mon, 15 Jan 2007, Eric Wong wrote:
> > 
> > > > Would you write "git repo-config --perl", then? ;-)
> > > 
> > > The below patch should be a start (only tested on my fairly standard 
> > > .git/config).  A --python option should be easy, too :)
> > 
> > A bit shorter (and gets the booleans right, plus being even easier 
> > towards --python extension):
> 
> Your version doesn't get arrays right, however.

That's right.

I'd like that code to be simpler, though. Way simpler.

> --- a/builtin-repo-config.c
> +++ b/builtin-repo-config.c
> @@ -1,5 +1,6 @@
>  #include "builtin.h"
>  #include "cache.h"
> +#include "quote.h"
>  
>  static const char git_config_set_usage[] =
>  "git-repo-config [ --global ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --list";
> @@ -14,6 +15,90 @@ static int do_not_match;
>  static int seen;
>  static enum { T_RAW, T_INT, T_BOOL } type = T_RAW;
>  
> +struct lang_dump {
> +	const char *name;
> +	const char *decl_start;
> +	const char *decl_end;
> +	const char *key_prefix;
> +	const char *array_start;
> +	const char *array_end;
> +	const char *val_prefix;
> +	const char *val_suffix;
> +	const char *true_val; /* should already be quoted, if needed */
> +	void (*quote_key_fn)(FILE *, const char*);
> +	void (*quote_val_fn)(FILE *, const char*);
> +};
> +static char *last_key;
> +static struct lang_dump *lang;
> +static struct lang_dump lang_dump_defs[] = {
> +	{ "perl",
> +		"\%git_config = (\n", ");\n",
0> +		"\t",
> +		" => [\n", "\t],\n",
> +		"\t\t", ",\n",
> +		"'true'",
> +		perl_quote_print, perl_quote_print },

The two quote members seem to be the same for _all_ three languages.

> +	{ "python",
> +		"git_config = {\n", "}\n",
> +		"    ",

I don't understand why you do not consolidate that into using tabs for 
_all_ backends?


> +static int show_lang_config(const char *key_, const char *value_)
> +{
> +	if (last_key) {
> +		if (strcmp(last_key, key_)) {
> +			free(last_key);
> +			fputs(lang->array_end, stdout);
> +			goto new_key;
> +		}
> +	} else {
> +new_key:
> +		last_key = xstrdup(key_);
> +		fputs(lang->key_prefix, stdout);
> +		lang->quote_key_fn(stdout, key_);
> +		fputs(lang->array_start, stdout);
> +	}

So this makes _all_ config vars arrays? It is consistent, yes... but it is 
also ugly, no?

> +static int show_lang_config_all(const char *lang_name)
> +{
> +	int i, rv;
> +	for (i = ARRAY_SIZE(lang_dump_defs); --i >= 0; ) {
> +		if (strcmp(lang_name, lang_dump_defs[i].name))
> +			continue;
> +		lang = lang_dump_defs + i;

IMHO this would be much easier to read using a path_list:

	struct path_list_item *item = path_list_lookup(lang_name, &langs);

	if (item == NULL)
		return -1;

	lang = item->util;

> +		fputs(lang->decl_start, stdout);
> +		rv = git_config(show_lang_config);
> +		if (last_key) {
> +			free(last_key);
> +			last_key = NULL;
> +			fputs(lang->array_end, stdout);
> +			fputs(lang->decl_end, stdout);

If the config is empty, no decl_end is printed, right?

> +		}
> +		return rv;
> +	}
> +	fputs("Dumping config to '%s' is not yet supported", stderr);
> +	return -1;
> +}

Ciao,
Dscho
