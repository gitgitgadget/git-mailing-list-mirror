From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Teach Git how to parse standard power of 2 suffixes.
Date: Sat, 30 Dec 2006 21:56:05 -0800
Message-ID: <7vy7ooip6y.fsf@assigned-by-dhcp.cox.net>
References: <20061231031305.GA5620@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 06:56:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0tg5-0001rY-9C
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 06:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933017AbWLaF4K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 00:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933026AbWLaF4K
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 00:56:10 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:48395 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933017AbWLaF4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 00:56:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231055606.QPNJ20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 Dec 2006 00:56:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5HvK1W00e1kojtg0000000; Sun, 31 Dec 2006 00:55:20 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20061231031305.GA5620@spearce.org> (Shawn O. Pearce's message of
	"Sat, 30 Dec 2006 22:13:05 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35676>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
> index b379ec5..c55a8ba 100644
> --- a/Documentation/git-repo-config.txt
> +++ b/Documentation/git-repo-config.txt
> @@ -87,7 +87,10 @@ OPTIONS
>  	git-repo-config will ensure that the output is "true" or "false"
>  
>  --int::
> -	git-repo-config will ensure that the output is a simple decimal number
> +	git-repo-config will ensure that the output is a simple
> +	decimal number.  An optional value suffix of 'k', 'm', or 'g'
> +	in the config file will cause the value to be multiplied
> +	by 1024, 1048576, or 1073741824 prior to output.

Thanks.  I think this is applicable on top of 'master'.

>  ENVIRONMENT
> diff --git a/config.c b/config.c
> index 2e0d5a8..83ce9e1 100644
> --- a/config.c
> +++ b/config.c
> @@ -236,8 +236,16 @@ int git_config_int(const char *name, const char *value)
>  	if (value && *value) {
>  		char *end;
>  		int val = strtol(value, &end, 0);
> +		while (isspace(*end))
> +			end++;

Why?  Are you allowing "1024 k"?  Do we want to?

>  		if (!*end)
>  			return val;
> +		if (!strcasecmp(end, "k"))
> +			return val * 1024;
> +		if (!strcasecmp(end, "m"))
> +			return val * 1024 * 1024;
> +		if (!strcasecmp(end, "g"))
> +			return val * 1024 * 1024 * 1024;
>  	}
>  	die("bad config value for '%s' in %s", name, config_file_name);
>  }
> -- 
> 1.5.0.rc0.g6bb1
