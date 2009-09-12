From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v7 5/6] fast-import: add option command
Date: Sat, 12 Sep 2009 12:04:16 -0700
Message-ID: <20090912190416.GS1033@spearce.org>
References: <1252247748-14507-1-git-send-email-srabbelier@gmail.com> <1252247748-14507-2-git-send-email-srabbelier@gmail.com> <1252247748-14507-3-git-send-email-srabbelier@gmail.com> <1252247748-14507-4-git-send-email-srabbelier@gmail.com> <1252247748-14507-5-git-send-email-srabbelier@gmail.com> <1252247748-14507-6-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.clatworthy@canonical.com>,
	Matt McClure <mlm@aya.yale.edu>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	vcs-fast-import-devs@lists.launchpad.net
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 21:04:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmXtX-0007zP-CV
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 21:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892AbZILTEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 15:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754879AbZILTEN
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 15:04:13 -0400
Received: from george.spearce.org ([209.20.77.23]:37142 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637AbZILTEN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 15:04:13 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 81A93381FD; Sat, 12 Sep 2009 19:04:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1252247748-14507-6-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128288>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> This allows the frontend to specify any of the supported options as
> long as no non-option command has been given. This way the
> user does not have to include any frontend-specific options, but
> instead she can rely on the frontend to tell fast-import what it
> needs.
...
> @@ -2456,11 +2468,32 @@ static void parse_feature(void)
>  
>  	if (!prefixcmp(feature, "date-format=")) {
>  		option_date_format(feature + 12);
> +	} else if (!strcmp("git-options", feature)) {
> +		options_enabled = 1;

No.  We do not want to require "feature git-options" in order to
use "option git foo", because "feature git-options" will cause an
Hg importer to abort on the same stream.

Options are meant to be optional.  If the importer recognizes the
line, it should use it.  But if it does not, it should continue
anyway.

The more I think about this, I may have to agree with Ian, I'm not
sure option makes much sense.

You started this series so you could embed Git specific command line
options in the stream, rather than on the command line for git-hg.

But what should happen if "option import-marks=bleh" isn't
understood by fast-import?  Wouldn't the stream be useless anyway,
because the marks it assumes aren't present?  Or worse, "option
export-marks=bleh" isn't recognized.  The stream imports, but any
marks it was supposed to store for the frontend to reuse later
are gone.

> +static void parse_nongit_option(void)
> +{
> +	/* do nothing */
> +}

Please don't do this.  What a waste of code.

> @@ -2485,6 +2518,27 @@ static int git_pack_config(const char *k, const char *v, void *cb)
>  static const char fast_import_usage[] =
>  "git fast-import [--date-format=f] [--max-pack-size=n] [--depth=n] [--active-branches=n] [--export-marks=marks.file]";
>  
> +static void parse_argv(void)
> +{
> +	unsigned int i;
> +
> +	for (i = 1; i < global_argc; i++) {
> +		const char *a = global_argv[i];
> +
> +		if (*a != '-' || !strcmp(a, "--"))
> +			break;
> +
> +		/* error on unknown options */
> +		parse_one_option(a + 2, 0);
> +	}
> +	if (i != global_argc)
> +		usage(fast_import_usage);
> +
> +	seen_non_option_command = 1;

So if I pass a single command line option, like --export-marks,
we die if we see an "option git " inside of the stream?  That's not
what we wanted to do.

> @@ -2539,9 +2583,18 @@ int main(int argc, const char **argv)
>  			parse_progress();
>  		else if (!prefixcmp(command_buf.buf, "feature "))
>  			parse_feature();
> +		else if (!prefixcmp(command_buf.buf, "option git "))
> +			parse_option();
> +		else if (!prefixcmp(command_buf.buf, "option "))
> +			parse_nongit_option();

I thought on fast-import list we agreed that the syntax of option was:

  'option' SP vcs SP option

  vcs ::= 'git' | 'hg' | 'bzr' | ...
  option ::= name ('=' value)?
  name = ^[a-zA-Z][a-zA-Z-]*$
  value = quoted_string

So what is this parse_nongit_option() for, other than to obfuscate
the code?  Can't we handle all of this in parse_option, have it
check the VCS tag, and return early there?

-- 
Shawn.
