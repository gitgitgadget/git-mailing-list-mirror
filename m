From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Make gc a builtin.
Date: Mon, 12 Mar 2007 10:43:12 -0400
Message-ID: <20070312144312.GE15150@spearce.org>
References: <11736508181273-git-send-email-jbowes@dangerouslyinc.com> <1173650820969-git-send-email-jbowes@dangerouslyinc.com> <Pine.LNX.4.63.0703112332550.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vtzwrtdmx.fsf@assigned-by-dhcp.cox.net> <3f80363f0703111951x9d88e74x8d7723af97c18c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: James Bowes <jbowes@dangerouslyinc.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 15:43:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQlk9-0005Ly-W9
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 15:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbXCLOnT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 10:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbXCLOnS
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 10:43:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43852 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030221AbXCLOnR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 10:43:17 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQljw-0007Sh-K8; Mon, 12 Mar 2007 10:43:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E5A9420FBAE; Mon, 12 Mar 2007 10:43:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <3f80363f0703111951x9d88e74x8d7723af97c18c7@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42033>

A good (second) try.

James Bowes <jbowes@dangerouslyinc.com> wrote:
> diff --git a/builtin-gc.c b/builtin-gc.c
> +
> +static int pack_refs;

Actually I think you want to use:

static int pack_refs = -1;

See below for why...

> +static int gc_config(const char *var, const char *value)
> +{
> +	if (!strcmp(var, "gc.packrefs"))
> +		if (strlen(value) == 0 || !strcmp(value, "notbare"))
> +			pack_refs = !is_bare_repository();
> +		else
> +			pack_refs = git_config_bool(var, value);
> +	else
> +		return git_default_config(var, value);
> +	return 0;
> +}

Gaaah.  How about some curly braces around the then part of that
first if?

Actually, we typically just write this more like:

static int gc_config(const char *var, const char *value)
{
	if (!strcmp(var, "gc.packrefs")) {
		if (!strcmp(value, "notbare"))
			pack_refs = -1;
		else
			pack_refs = git_config_bool(var, value);
	}
	return git_default_config(var, value);
}

> +int cmd_gc(int argc, const char **argv, const char *prefix)
> +{
> +	int i;
> +	int prune = 0;
> +
> +	git_config(gc_config);

if (pack_refs < 0)
	pack_refs = !is_bare_repository();

The is_bare_repository function guesses until the configuration
is done parsing; once the configuration has been parsed it has a
definate answer one way or the other.  So what I'm suggesting you
do here is set pack_refs = -1 to mean use the is_bare_repository
setting, otherwise it stays what it was set to.

> +    if (pack_refs)
> +	    if (run_command_v_opt(argv_pack_refs, RUN_GIT_CMD))
> +            goto failure;
....
> +    if (prune)
> +        if (run_command_v_opt(argv_prune, RUN_GIT_CMD))
> +            goto failure;

Gaah.  Tabs-vs-spaces, not to mention that these aren't even lining
up the same way.  I too prefer what Dsco suggested already:

	if (prune && run_command_v_opt(argv_prune, RUN_GIT_CMD))
		return error("failed to run %s", argv_prune[0]);

-- 
Shawn.
