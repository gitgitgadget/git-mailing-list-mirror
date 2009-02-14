From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] parse-opt: migrate builtin-ls-files.
Date: Sat, 14 Feb 2009 21:56:04 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902142127040.10279@pacific.mpi-cbg.de>
References: <1231376145-32331-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Feb 14 21:56:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYRZ4-0006FD-4f
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 21:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbZBNUzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 15:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbZBNUzN
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 15:55:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:52619 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751357AbZBNUzM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 15:55:12 -0500
Received: (qmail invoked by alias); 14 Feb 2009 20:55:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 14 Feb 2009 21:55:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ipaZH5aXi/VYkx2YCTqHMKlryfQN436xwtJ8NTf
	x8ARLMJneqGa+t
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1231376145-32331-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109924>

Hi,

On Thu, 8 Jan 2009, Miklos Vajna wrote:

> +static int option_parse_z(const struct option *opt,
> +			  const char *arg, int unset)
> +{
> +	if (unset)
> +		line_terminator = '\n';
> +	else
> +		line_terminator = 0;
> +	return 0;
> +}

	line_terminator = unset ? '\0' : '\n';

Hmm?

> +static int option_parse_exclude(const struct option *opt,
> +				const char *arg, int unset)
> +{
> +	struct dir_struct *dir = opt->value;
> +
> +	exc_given = 1;
> +	add_exclude(arg, "", 0, &dir->exclude_list[EXC_CMDL]);

Why is &dir->exclude_list[EXC_CMDL] not stored in opt->value directly?

> +static int option_parse_ignored(const struct option *opt,
> +				const char *arg, int unset)
> +{
> +	struct dir_struct *dir = opt->value;
> +
> +	dir->show_ignored = !unset;
> +
> +	return 0;
> +}

Maybe this wants to be converted into an OPTION_BIT compatible data type?

> +static int option_parse_directory(const struct option *opt,
> +				  const char *arg, int unset)
> +{
> +	struct dir_struct *dir = opt->value;
> +
> +	dir->show_other_directories = !unset;
> +
> +	return 0;
> +}

Likewise?

> +static int option_parse_empty(const struct option *opt,
> +				 const char *arg, int unset)
> +{
> +	struct dir_struct *dir = opt->value;
> +
> +	dir->hide_empty_directories = unset;
> +
> +	return 0;
> +}

Maybe we need an OPT_BIT_NEG?

> +static int option_parse_full_name(const struct option *opt,
> +				  const char *arg, int unset)
> +{
> +	prefix_offset = 0;
> +
> +	return 0;
> +}

Not that it matters much, but maybe you can guard this with an
"if (!unset)"?

> +		{ OPTION_CALLBACK, 0, "full-name", NULL, NULL,
> +			"make the output relative to the project top directory",
> +			PARSE_OPT_NOARG, option_parse_full_name },

Maybe OPT_NONEG, and maybe SET_INT?

> +	if (dir.exclude_per_dir)
> +		exc_given = 1;

You could use a boolean to handle --exclude-standard, too... But you did 
not do that so that there is no regression with specific ordering of the 
exclude options, right?

Ciao,
Dscho
