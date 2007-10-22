From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] "git help" and "git help -a" shouldn't exit(1) unless they error
Date: Mon, 22 Oct 2007 01:47:41 -0400
Message-ID: <20071022054741.GP14735@spearce.org>
References: <20071021214744.GH16291@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Scott R Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 07:48:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijq8u-0000GI-6I
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 07:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbXJVFrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 01:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbXJVFrq
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 01:47:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46497 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbXJVFrp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 01:47:45 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ijq8d-0000kd-Qz; Mon, 22 Oct 2007 01:47:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1E90920FBAE; Mon, 22 Oct 2007 01:47:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071021214744.GH16291@srparish.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61949>

Scott R Parish <srp@srparish.net> wrote:
> diff --git a/help.c b/help.c
> index 1cd33ec..b0d2dd4 100644
> --- a/help.c
> +++ b/help.c
> @@ -204,14 +204,14 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>  	if (!help_cmd) {
>  		printf("usage: %s\n\n", git_usage_string);
>  		list_common_cmds_help();
> -		exit(1);
> +		exit(0);
>  	}

Although it seems simple on the surface this patch breaks the
test suite:

	$ make test
	make -C t/ all
	make[1]: Entering directory `/home/spearce/mygit/t'
	*** t0000-basic.sh ***
	You do not seem to have built git yet.

The issue here is t0000-basic.sh runs "../git" and tests that the
exit status is 1.  If it isn't (the patch above makes it 0) we just
abort the test suite entirely.

I think its correct for "git help" to exit 0, and also for "git
help checkout" or "git checkout --help" to exit 0, but "git" by
itself with no subcommand should exit with an error, it requires a
subcommand to continue.  So some sort of change is needed in git.c
to handle this special no subcommand condition.
  
-- 
Shawn.
