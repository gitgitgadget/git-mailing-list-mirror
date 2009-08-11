From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 4/6] Add is_git_command_or_alias() for checking
 availability of a given git command
Date: Tue, 11 Aug 2009 14:21:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908111358060.4638@intel-tinevez-2-302>
References: <alpine.LNX.2.00.0908101205120.27553@iabervon.org> <1249985426-13726-5-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, barkalow@iabervon.org, gitster@pobox.com,
	benji@silverinsanity.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:21:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqMN-0002qk-LR
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668AbZHKMVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 08:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbZHKMVN
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:21:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:45065 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751857AbZHKMVM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 08:21:12 -0400
Received: (qmail invoked by alias); 11 Aug 2009 12:21:12 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp019) with SMTP; 11 Aug 2009 14:21:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3zU1Fd7n3TXMdtgwOigt2RFdXjeSiomCliNKqiF
	6IclRF7zYrYwXT
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1249985426-13726-5-git-send-email-johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125531>

Hi,

On Tue, 11 Aug 2009, Johan Herland wrote:

> diff --git a/help.c b/help.c
> index 994561d..a616277 100644
> --- a/help.c
> +++ b/help.c
> @@ -296,6 +296,27 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
>  	old->names = NULL;
>  }
>  
> +int is_git_command_or_alias(const char *cmd)
> +{
> +	struct cmdnames main_cmds, other_cmds;
> +
> +	memset(&main_cmds, 0, sizeof(main_cmds));
> +	memset(&other_cmds, 0, sizeof(other_cmds));
> +	memset(&aliases, 0, sizeof(aliases));
> +
> +	git_config(git_unknown_cmd_config, NULL);
> +
> +	load_command_list("git-", &main_cmds, &other_cmds);
> +
> +	add_cmd_list(&main_cmds, &aliases);
> +	add_cmd_list(&main_cmds, &other_cmds);
> +	qsort(main_cmds.names, main_cmds.cnt,
> +	      sizeof(main_cmds.names), cmdname_compare);
> +	uniq(&main_cmds);
> +
> +	return is_in_cmdlist(&main_cmds, cmd);
> +}

Sorting a list is an O(n log n) operation, searching through a list 
linearly is O(n).  You throw away main_cmds (without freeing) after that, 
so I think it is not a good trade-off.

Ciao,
Dscho
