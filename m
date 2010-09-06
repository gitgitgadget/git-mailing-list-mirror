From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] RFC: help.autocorrect prompt
Date: Sun, 5 Sep 2010 21:59:49 -0500
Message-ID: <20100906025949.GA23594@burratino>
References: <1283740106-11411-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 05:02:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsRyB-0003dR-EW
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 05:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115Ab0IFDBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 23:01:49 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54258 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790Ab0IFDBs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 23:01:48 -0400
Received: by gxk23 with SMTP id 23so1467905gxk.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 20:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=G8ibZuk1i62NSnzktUMMvtTV0QHcKXY7lenKULZ3KgE=;
        b=aY0yDWbl4004isGf/is6RaCKfivr8qcmdZatggbYbKdBsu++PUHkzbjRROucbMD/HR
         H+SRcB3IJ37JrVJTSkPjFi1qXjN3kA4ytsWY6vBfWCmDfvu6kt77OVrR1aAfn/50JtQd
         Y/bdQoKsefJ+P6cv5JP46n4fcKYDFhv/VtEE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FVbE+JiVtr+rZHFAbnHmZVD9q7StcMlJ2W8YX3lUp8X8b29rwShAT8wMCqgJY8zeBO
         1cbkRaeWAYUrG8tfVGfiRlc9e1tnp4F0dN+7oLJyviQeLvq9XIUHmMyjqwdBC9EpV15W
         K99o5j+A6wjiIrP20UzzrDN8RE6mUN6RQoSS4=
Received: by 10.151.132.9 with SMTP id j9mr41569ybn.403.1283742106941;
        Sun, 05 Sep 2010 20:01:46 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id w24sm3026638ybk.1.2010.09.05.20.01.45
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 20:01:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283740106-11411-1-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155516>

(+cc: Dscho and Heiko)

David Barr wrote:

> A value of 'prompt' causes git to wait for confirmation
> before executing the assumed command.

Nice idea.

> ---

Sign-off?

> --- a/help.c
> +++ b/help.c
> @@ -267,8 +267,12 @@ static struct cmdnames aliases;
>  
>  static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
>  {
> -	if (!strcmp(var, "help.autocorrect"))
> -		autocorrect = git_config_int(var,value);
> +	if (!strcmp(var, "help.autocorrect")) {
> +		if (!strcmp(value, "prompt"))
> +			autocorrect = INT_MAX;
> +		else
> +			autocorrect = git_config_int(var,value);

Any particular significance to INT_MAX rather than, e.g., -1 here?
(Just curious; it seems unlikely someone would use INT_MAX and
accidentally trip on this.)

Not a problem introduced by your patch: should we be checking for
out-of-range (e.g., negative) values?

> @@ -342,7 +346,10 @@ const char *help_unknown_cmd(const char *cmd)
>  			"which does not exist.\n"
>  			"Continuing under the assumption that you meant '%s'\n",
>  			cmd, assumed);
> -		if (autocorrect > 0) {
> +		if (autocorrect == INT_MAX) {
> +			if (strcmp("y", git_getpass("Continue? (y/n) ")))
> +				exit(1);

Funny. :)

It might be better to actually always write this prompt to the
terminal, rather than popping up a gui $GIT_ASKPASS if the user has
set that up.  Maybe something like Heiko Voigt's "mingw: make failures
to unlike or move raise a question" (9229029, 2010-02-21 from
4msysgit.git):

	if (!isatty(STDIN_FILENO) || !isatty(STDERR_FILENO))
		exit(1);
	fprintf(stderr, "Continue? (y/n) ");
	if (!fgets(answer, sizeof(answer), stdin))
		exit(1)
	if (*answer != 'y' && *answer != 'Y')
		exit(1);

> +		} else if (autocorrect > 0) {
>  			fprintf(stderr, "in %0.1f seconds automatically...\n",
>  				(float)autocorrect/10.0);
>  			poll(NULL, 0, autocorrect * 100);

Thanks for a pleasant read.
Jonathan
