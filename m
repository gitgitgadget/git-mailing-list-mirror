From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] @{-<n>}: avoid crash with corrupt reflog
Date: Mon, 19 Jan 2009 15:57:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901191547220.3586@pacific.mpi-cbg.de>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <1232163011-20088-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de> <200901171438.22504.trast@student.ethz.ch> <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <7vljt97nld.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de> <7vmydp5tqj.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901180201070.3586@pacific.mpi-cbg.de> <7vprilyt1w.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901182152010.3586@pacific.mpi-cbg.de> <7vprijra52.fsf@gitster.siamese.dyndns.org> <7vljt7r9mq.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191338470.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 15:59:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOvac-0007KW-9P
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 15:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757730AbZASO5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 09:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754913AbZASO5h
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 09:57:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:35928 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758274AbZASO5g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 09:57:36 -0500
Received: (qmail invoked by alias); 19 Jan 2009 14:57:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 19 Jan 2009 15:57:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+sU8A+ILSsY5xOUqNmMe99v6mWHMj85e2VSCRYxX
	vE4WMACdZcLEIz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901191338470.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106363>

Hi,

On Mon, 19 Jan 2009, Johannes Schindelin wrote:

> diff --git a/sha1_name.c b/sha1_name.c
> index 9e5f444..853bac6 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -705,18 +705,18 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
>  	size_t len;
>  	int nth;
>  
> -	if (!prefixcmp(message, "checkout: moving from ")) {
> -		match = message + strlen("checkout: moving from ");
> -		if ((target = strstr(match, " to ")) != NULL)
> -			target += 4;
> -	}
> -
> -	if (!match)
> +	if (prefixcmp(message, "checkout: moving from "))
>  		return 0;
>  
> -	len = target - match - 4;
> -	if (target[len] == '\n' && !strncmp(match, target, len))
> -		return 0;
> +	match = message + strlen("checkout: moving from ");
> +	if ((target = strstr(match, " to ")) != NULL) {
> +		len = target - match - 4;

Aargh, the "- 4" is wrong, of course.

> +		target += 4;
> +		if (target[len] == '\n' && !strncmp(match, target, len))
> +			return 0;
> +	}
> +	else
> +		len = strchrnul(match, ' ') - match;
>  
>  	nth = cb->cnt++ % cb->alloc;
>  	strbuf_reset(&cb->buf[nth]);

Sorry for the noise,
Dscho
