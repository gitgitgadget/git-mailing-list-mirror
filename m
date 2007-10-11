From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gc: by default use safer "-A" option to repack when
 not --prune'ing
Date: Thu, 11 Oct 2007 01:12:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710110106160.4174@racer.site>
References: <470D6509.5020607@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Oct 11 02:13:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iflfu-0004Id-Cc
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 02:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbXJKANF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 20:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752577AbXJKANF
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 20:13:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:41884 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752647AbXJKANE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 20:13:04 -0400
Received: (qmail invoked by alias); 11 Oct 2007 00:13:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp025) with SMTP; 11 Oct 2007 02:13:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WSRFwRcYWxQ1i2Igp/8tidoKI2jqXL+byUVK7Pj
	jHtG9tc0bQHhHx
X-X-Sender: gene099@racer.site
In-Reply-To: <470D6509.5020607@nrlssc.navy.mil>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60572>

Hi,

On Wed, 10 Oct 2007, Brandon Casey wrote:

>  static int need_to_gc(void)
>  {
> -	int ac = 0;
> -
>  	/*
>  	 * Setting gc.auto and gc.autopacklimit to 0 or negative can
>  	 * disable the automatic gc.
> @@ -158,14 +156,10 @@ static int need_to_gc(void)
>  	 * we run "repack -A -d -l".  Otherwise we tell the caller
>  	 * there is no need.
>  	 */
> -	argv_repack[ac++] = "repack";
>  	if (too_many_packs())
> -		argv_repack[ac++] = "-A";
> +		append_option(argv_repack, "-A", MAX_ADD);
>  	else if (!too_many_loose_objects())
>  		return 0;
> -	argv_repack[ac++] = "-d";
> -	argv_repack[ac++] = "-l";
> -	argv_repack[ac++] = NULL;
>  	return 1;
>  }
>  

This is a nice cleanup, but it does not belong in this patch.

> @@ -211,6 +205,16 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  		prune = 0;
>  		if (!need_to_gc())
>  			return 0;
> +	} else {
> +		/*
> +		 * Use safer (for shared repos) "-A" option to
> +		 * repack when not pruning. Auto-gc makes its
> +                 * own decision.
> +		 */
> +		if (prune)
> +			append_option(argv_repack, "-a", MAX_ADD);
> +		else
> +			append_option(argv_repack, "-A", MAX_ADD);
>  	}
>  
>  	if (pack_refs && run_command_v_opt(argv_pack_refs, RUN_GIT_CMD))

To use the append_option() function, you need to make sure that the argv 
has enough space, so I suggest adding another NULL to argv_repack[].  This 
is enough, since you only ever add one option.  But you should mention it 
somewhere, probably above the definition of argv_repack[].

Other than that: I think your patch makes tons of sense; much better than 
what I tried to cobble together with the cyclic alternates detection.

Ciao,
Dscho
