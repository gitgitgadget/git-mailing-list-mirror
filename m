From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-daemon: Simplify child management and associated
	logging by
Date: Wed, 13 Aug 2008 00:32:24 +0200
Message-ID: <20080812223224.GA4134@steel.home>
References: <20080812193613.32388.92145.stgit@aristoteles.cuci.nl> <20080812212534.6871.19377.stgit@aristoteles.cuci.nl>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Aug 13 00:33:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT2Qk-0006Vt-2e
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 00:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbYHLWc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 18:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbYHLWc1
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 18:32:27 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:64790 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbYHLWc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 18:32:27 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20lf5y8=
Received: from tigra.home (Fab06.f.strato-dslnet.de [195.4.171.6])
	by post.webmailer.de (mrclete mo44) (RZmta 16.47)
	with ESMTP id j02f52k7CIVIAN ; Wed, 13 Aug 2008 00:32:25 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 1B01A277AE;
	Wed, 13 Aug 2008 00:32:25 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id D30AA56D2A; Wed, 13 Aug 2008 00:32:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080812212534.6871.19377.stgit@aristoteles.cuci.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92148>

Stephen R. van den Berg, Tue, Aug 12, 2008 23:25:35 +0200:
> +        struct child*newborn;

You may want to reformat the patch using tabs instead of spaces.

> +        newborn = xmalloc(sizeof *newborn);

The custom here is to use "sizeof(type)". Brackets and typename.

> +        if (newborn) {
> +	        struct child**cradle,*blanket;

"struct child **cradle, *blanket;" (the spaces before asterisks)

> +		memcpy(memset(&newborn->address, 0, sizeof newborn->address),
> +		 addr, addrlen);

Aren't separate calls easier to read (and type)?

	memset(&newborn->address, 0, sizeof(newborn->address));
	memcpy(&newborn->address, addr, addrlen);

> -static void kill_some_children(int signo, unsigned start, unsigned stop)
> +static void kill_some_child(int signo)
>  {
> -	start %= MAX_CHILDREN;
> -	stop %= MAX_CHILDREN;
> -	while (start != stop) {
> -		if (!(start & 3))
> -			kill(live_child[start].pid, signo);
> -		start = (start + 1) % MAX_CHILDREN;
> +	const struct child *blanket;
> +
> +	if ((blanket = firstborn)) {

	if (firstborn) {
	    const struct child *blanket = firstborn;

You don't even use blanket outside of the "if".

>  static void check_dead_children(void)
>  {
> +		loginfo("[%d] Disconnected%s", (int)pid, dead);

BTW, why do you need that pid_t->int cast?

> @@ -1105,6 +1026,10 @@ int main(int argc, char **argv)
>  			init_timeout = atoi(arg+15);
>  			continue;
>  		}
> +		if (!prefixcmp(arg, "--max-connections=")) {
> +			max_connections = atoi(arg+18);

An error checking wouldn't go amiss. And it can't be done with atoi
(consider strtol).
