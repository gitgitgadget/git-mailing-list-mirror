From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream
 local branches
Date: Mon, 18 Feb 2008 12:14:25 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181209210.30505@racer.site>
References: 1203133557-50013-1-git-send-email-jaysoffian@gmail.com <1203336248-9308-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 13:15:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR4tu-0006Si-VV
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 13:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758164AbYBRMOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 07:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758196AbYBRMOj
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 07:14:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:41040 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757665AbYBRMOi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 07:14:38 -0500
Received: (qmail invoked by alias); 18 Feb 2008 12:14:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 18 Feb 2008 13:14:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19HpoQSe19Hgr3AbDZByngwryq4VLT11dsvNs909J
	FHoGf9F+tBe9Pc
X-X-Sender: gene099@racer.site
In-Reply-To: <1203336248-9308-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74272>

Hi,

On Mon, 18 Feb 2008, Jay Soffian wrote:

> diff --git a/branch.h b/branch.h
> index d30abe0..771d6ce 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -1,6 +1,12 @@
>  #ifndef BRANCH_H
>  #define BRANCH_H
>  
> +enum branch_track {
> +	BRANCH_TRACK_FALSE = 0,
> +	BRANCH_TRACK_TRUE = 1,

BRANCH_TRACK_REMOTES would be a better name here.  And you do not need the 
"= 1" and "= 2".

> +	BRANCH_TRACK_ALWAYS = 2,
> +};
> +
>  /* Functions for acting on the information about branches. */
>  
>  /*
> diff --git a/builtin-branch.c b/builtin-branch.c
> index 5094e0d..231bff4 100644
> --- a/builtin-branch.c
> +++ b/builtin-branch.c
> @@ -30,7 +30,7 @@ static const char * const builtin_branch_usage[] = {
>  static const char *head;
>  static unsigned char head_sha1[20];
>  
> -static int branch_track = 1;
> +static enum branch_track branch_track = BRANCH_TRACK_FALSE;

That is a clear regression.

> @@ -77,6 +77,10 @@ static int git_branch_config(const char *var, const char *value)
>  		return 0;
>  	}
>  	if (!strcmp(var, "branch.autosetupmerge")) {
> +		if (value && !strcasecmp(value, "always")) {
> +			branch_track = BRANCH_TRACK_ALWAYS;
> +			return 0;
> +		}
>  		branch_track = git_config_bool(var, value);
>  		return 0;
>  	}

You have this in builtin-branch.c and builtin-checkout.c.  Duplicated 
code.  IMHO it is time to move this into the git_default_config() function 
(with "branch_track" being renamed to "git_branch_track", and moved to 
environment.c).

Personally, I have no problem with typing "git merge <branch>" in your 
workflow.  I would even avoid saying "git pull" for obviously-local 
branches, because I would have forgotten which branch it tracked 
originally.

But hey, if you really want to... ;-)

Ciao,
Dscho
