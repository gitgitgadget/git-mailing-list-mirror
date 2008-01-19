From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Tiny bug report, interaction between alias and help
Date: Sat, 19 Jan 2008 22:55:24 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801192252060.5731@racer.site>
References: <20080119142750.GA9182@phenix.progiciels-bpi.ca> <20080119174146.GA3913@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Fran=E7ois_Pinard?= <pinard@iro.umontreal.ca>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 19 23:56:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGMbf-0000zU-C6
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 23:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbYASWzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 17:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbYASWzi
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 17:55:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:52000 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752114AbYASWzh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 17:55:37 -0500
Received: (qmail invoked by alias); 19 Jan 2008 22:55:35 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp042) with SMTP; 19 Jan 2008 23:55:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19RRzgAMjpRy+DDqlvxHM3lApZe6Fzmy98CV9nyj0
	9S92Y13bP8K1P1
X-X-Sender: gene099@racer.site
In-Reply-To: <20080119174146.GA3913@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71136>

Hi,

On Sat, 19 Jan 2008, Jeff King wrote:

> @@ -362,21 +386,30 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	else if (!strcmp(help_cmd, "--web") || !strcmp(help_cmd, "-w")) {
> -		show_html_page(argc > 2 ? argv[2] : NULL);
> +		const char *cmd = argc > 2 ? argv[2] : NULL;
> +		if (cmd && show_alias_help(cmd))
> +			return 0;
> +		show_html_page(cmd);
>  	}
>  
>  	else if (!strcmp(help_cmd, "--info") || !strcmp(help_cmd, "-i")) {
> -		show_info_page(argc > 2 ? argv[2] : NULL);
> +		const char *cmd = argc > 2 ? argv[2] : NULL;
> +		if (cmd && show_alias_help(cmd))
> +			return 0;
> +		show_info_page(cmd);
>  	}
>  
>  	else if (!strcmp(help_cmd, "--man") || !strcmp(help_cmd, "-m")) {
> -		show_man_page(argc > 2 ? argv[2] : NULL);
> +		const char *cmd = argc > 2 ? argv[2] : NULL;
> +		if (cmd && show_alias_help(cmd))
> +			return 0;
> +		show_man_page(cmd);
>  	}
>  
>  	else {
> -		int nongit;
> +		if (show_alias_help(help_cmd))
> +			return 0;
>  
> -		setup_git_directory_gently(&nongit);
>  		git_config(git_help_config);
>  		if (help_default_format)
>  			parse_help_format(help_default_format);
> -- 
> 1.5.4.rc3.1129.g3e1ca-dirty

Urgh... We really have something like that in git?  Looks like a prime 
candidate for refactoring a la

	void (*show_cmd)(const char *git_cmd) = show_man_page;
	const char *cmd = argc > 2 ? argv[2] : NULL;

	if (cmd && show_alias_help(cmd))
		return 0;

	if (!strcmp(help_cmd, "--web") || !strcmp(help_cmd, "-w"))
		show_cmd = show_html_page;
	else ...
		...

	show_cmd(cmd);

Ciao,
Dscho
