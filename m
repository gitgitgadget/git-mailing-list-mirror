From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/2] GIT: Listen on IPv6 as well, if available.
Date: Fri, 22 Jul 2005 23:21:51 +0200
Message-ID: <20050722212151.GI11916@pasky.ji.cz>
References: <20050721.091049.46807257.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, yoshfuji@wide.ad.jp
X-From: git-owner@vger.kernel.org Fri Jul 22 23:33:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw528-000588-3M
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 23:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVGVVZf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 17:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVGVVXF
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 17:23:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41991 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262185AbVGVVVy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 17:21:54 -0400
Received: (qmail 26562 invoked by uid 2001); 22 Jul 2005 21:21:52 -0000
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Content-Disposition: inline
In-Reply-To: <20050721.091049.46807257.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jul 21, 2005 at 03:10:49PM CEST, I got a letter
where "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org> told me that...
> Hello.

Hello from an IPv6 fan,

> Listen on IPv6 as well, if available.
> 
> Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> 
> diff --git a/daemon.c b/daemon.c
> --- a/daemon.c
> +++ b/daemon.c
> @@ -219,37 +219,102 @@ static void child_handler(int signo)
>  
>  static int serve(int port)
>  {
..snip..

this whole getaddrinfo() magic looks horribly complicated. What's wrong
on just adding a similar code (or factoring it out to a function) for
IPv6 as there is for IPv4, just s/INET/INET6/?

>  	for (;;) {
> -		struct sockaddr_in in;
> -		socklen_t addrlen = sizeof(in);
> -		int incoming = accept(sockfd, (void *)&in, &addrlen);
> -
> -		if (incoming < 0) {
> -			switch (errno) {
> -			case EAGAIN:
> -			case EINTR:
> -			case ECONNABORTED:
> -				continue;
> -			default:
> -				die("accept returned %s", strerror(errno));
> +		struct sockaddr_storage ss;
> +		socklen_t sslen = sizeof(ss);

Perhaps move those to the most inner block. (All right, I'm nitpicking
too much again, sorry.)

> +
> +		int i;
> +		fds = fds_init;
> +		
> +		if (select(maxfd + 1, &fds, NULL, NULL, NULL) == -1) {
> +			/* warning? */

Certainly a warning and at least sleep(1) to avoid cpuburn-like
behaviour in case of anything going wrong.

> +			continue;
> +		}
> +
> +		for (i = 0; i < socknum; i++) {
> +			int sockfd = socklist[i];
> +
> +			if (FD_ISSET(sockfd, &fds)) {
> +				int incoming = accept(sockfd, (struct sockaddr *)&ss, &sslen);
> +				if (incoming < 0) {
> +					switch (errno) {
> +					case EAGAIN:
> +					case EINTR:
> +					case ECONNABORTED:
> +						continue;
> +					default:
> +						die("accept returned %s", strerror(errno));
> +					}
> +				}
> +				handle(incoming, (struct sockaddr *)&ss, sslen);
>  			}
>  		}
> -		handle(incoming, &in, addrlen);
>  	}
>  }

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
