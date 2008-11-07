From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] checkout: Don't crash when switching away from an invalid
 branch.
Date: Fri, 7 Nov 2008 19:05:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811071903300.30769@pacific.mpi-cbg.de>
References: <871vxnbhbh.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Fri Nov 07 18:59:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyVc2-0001gO-Cv
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 18:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbYKGR56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 12:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbYKGR56
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 12:57:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:45943 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750911AbYKGR56 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 12:57:58 -0500
Received: (qmail invoked by alias); 07 Nov 2008 17:57:55 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 07 Nov 2008 18:57:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19OntlEHoROLr/pJzt9+GgEnH1mH57MYFhUnVkRsf
	P6e+LEqrP+Dagj
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <871vxnbhbh.fsf@wine.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100319>

Hi,

On Fri, 7 Nov 2008, Alexandre Julliard wrote:

> I have a tree where for some reason HEAD was pointing to an invalid 
> commit. I'm not sure how this happened, but git checkout should be able 
> to recover from that situation without crashing.

Agree.

> diff --git a/builtin-checkout.c b/builtin-checkout.c
> index 57b94d2..7c1b8cd 100644
> --- a/builtin-checkout.c
> +++ b/builtin-checkout.c
> @@ -47,7 +47,8 @@ static int post_checkout_hook(struct commit *old, struct commit *new,
>  
>  	memset(&proc, 0, sizeof(proc));
>  	argv[0] = name;
> -	argv[1] = xstrdup(sha1_to_hex(old->object.sha1));
> +	argv[1] = old ? xstrdup(sha1_to_hex(old->object.sha1))
> +		      : "0000000000000000000000000000000000000000";

I guess you want to use the variable null_sha1 here.

> @@ -492,10 +493,13 @@ static void update_refs_for_switch(struct checkout_opts *opts,
>  	}
>  
>  	old_desc = old->name;
> -	if (!old_desc)
> +	if (!old_desc && old->commit)
>  		old_desc = sha1_to_hex(old->commit->object.sha1);
> -	strbuf_addf(&msg, "checkout: moving from %s to %s",
> -		    old_desc, new->name);
> +	if (old_desc)
> +		strbuf_addf(&msg, "checkout: moving from %s to %s",
> +			    old_desc, new->name);
> +	else
> +		strbuf_addf(&msg, "checkout: moving to %s", new->name);

Why not
		old_desc ? old_desc : "(invalid)"
?

> diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-head.sh
> new file mode 100755

Nice!

Thank you,
Dscho
