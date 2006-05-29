From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Read configuration also from ~/.gitrc
Date: Mon, 29 May 2006 09:20:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605290913330.8863@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060526152837.GQ23852@progsoc.uts.edu.au> <20060528222641.GF10488@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anand Kumria <wildfire@progsoc.uts.edu.au>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 09:20:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkc32-0003e2-OX
	for gcvg-git@gmane.org; Mon, 29 May 2006 09:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWE2HUK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 03:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWE2HUK
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 03:20:10 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:43496 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750729AbWE2HUI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 03:20:08 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id A73A813FA;
	Mon, 29 May 2006 09:20:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 9B16113E5;
	Mon, 29 May 2006 09:20:07 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 57329B79;
	Mon, 29 May 2006 09:20:07 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060528222641.GF10488@pasky.or.cz>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20930>

Hi,

On Mon, 29 May 2006, Petr Baudis wrote:

> diff --git a/config.c b/config.c
> index 0248c6d..8a98865 100644
> --- a/config.c
> +++ b/config.c
> @@ -312,7 +312,11 @@ int git_config_from_file(config_fn_t fn,
>  
>  int git_config(config_fn_t fn)
>  {
> -	return git_config_from_file(fn, git_path("config"));
> +	int ret = 0;
> +	if (getenv("HOME"))
> +		ret += git_config_from_file(fn, mkpath("%s/.gitrc", getenv("HOME")));
> +	ret += git_config_from_file(fn, git_path("config"));
> +	return ret;
>  }
>  
>  /*


But would this not break for the normal case? If you override one key in 
the repository's config, with this patch, repo-config will barf. The 
normal case is that you do not expect multiple values for the same key. 
Your patch reads both ~/.gitrc and $GIT_DIR/config, and if a key has a 
value in both (even if they are identical), repo-config will error out.

Further, storing a key will no longer work. This is an obscure side 
effect of this patch not caring about storing anything in ~/.gitrc: If you 
find the key section (or the key) in ~/.gitrc, the offset will be stored, 
_and used on $GIT_DIR/config_!

I agree it is nice to have a global git configuration, but I have it: I 
use templates.

Ciao,
Dscho
