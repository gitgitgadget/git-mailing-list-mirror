From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH] daemon.c: avoid accessing ss_family member of struct
 sockaddr_storage
Date: Mon, 15 Mar 2010 23:37:53 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1003152336520.29993@cone.home.martin.st>
References: <alpine.DEB.2.00.1003120922040.29993@cone.home.martin.st> <XI3O9HirgFwPkEqC3RdYR4j56mg_uuJQZk1YFST6ukqbKXjgxaqJdNDHwlLXg5R_FVXWmWQSGmg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, git@mlists.thewrittenword.com, peff@peff.net,
	kusmabite@gmail.com, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Mar 15 22:38:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrHzQ-0006KF-08
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 22:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936852Ab0COViO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 17:38:14 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:42749 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932222Ab0COViN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 17:38:13 -0400
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by jenni1.inet.fi (8.5.014)
        id 4B17DDDA04157039; Mon, 15 Mar 2010 23:38:09 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <XI3O9HirgFwPkEqC3RdYR4j56mg_uuJQZk1YFST6ukqbKXjgxaqJdNDHwlLXg5R_FVXWmWQSGmg@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142258>

On Mon, 15 Mar 2010, Brandon Casey wrote:

> diff --git a/daemon.c b/daemon.c
> index 3769b6f..8a52fdc 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -590,9 +590,11 @@ static int execute(struct sockaddr *addr)
>  static int addrcmp(const struct sockaddr_storage *s1,
>      const struct sockaddr_storage *s2)
>  {
> -	if (s1->ss_family != s2->ss_family)
> -		return s1->ss_family - s2->ss_family;
> -	if (s1->ss_family == AF_INET)
> +	if (((const struct sockaddr*) s1)->sa_family !=
> +	    ((const struct sockaddr*) s2)->sa_family)
> +		return ((const struct sockaddr*) s1)->sa_family -
> +		       ((const struct sockaddr*) s2)->sa_family;
> +	if (((const struct sockaddr*) s1)->sa_family == AF_INET)
>  		return memcmp(&((struct sockaddr_in *)s1)->sin_addr,
>  		    &((struct sockaddr_in *)s2)->sin_addr,
>  		    sizeof(struct in_addr));

Coming to think about it, would it simplify the code even more if the 
function were to take a const struct sockaddr* as a parameter instead? 
That would, on the other hand, require more casts where it's called, 
though...

// Martin
