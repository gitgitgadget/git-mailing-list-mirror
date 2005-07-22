From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/2] GIT: Try all addresses for given remote name
Date: Fri, 22 Jul 2005 23:09:13 +0200
Message-ID: <20050722210913.GH11916@pasky.ji.cz>
References: <20050721.091036.01119516.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 23:11:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw4mq-00084F-OG
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 23:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVGVVJr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 17:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVGVVJr
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 17:09:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18183 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262184AbVGVVJP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 17:09:15 -0400
Received: (qmail 25404 invoked by uid 2001); 22 Jul 2005 21:09:14 -0000
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Content-Disposition: inline
In-Reply-To: <20050721.091036.01119516.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jul 21, 2005 at 03:10:36PM CEST, I got a letter
where "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org> told me that...
> Hello.

Hello,

> Try all addresses for given remote name until it succeeds.
> Also supports IPv6.
> 
> Signed-of-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> 
> diff --git a/connect.c b/connect.c
> --- a/connect.c
> +++ b/connect.c
> @@ -96,42 +96,57 @@ static enum protocol get_protocol(const 
>  	die("I don't handle protocol '%s'", name);
>  }
>  
> -static void lookup_host(const char *host, struct sockaddr *in)
> -{
> -	struct addrinfo *res;
> -	int ret;
> -
> -	ret = getaddrinfo(host, NULL, NULL, &res);
> -	if (ret)
> -		die("Unable to look up %s (%s)", host, gai_strerror(ret));
> -	*in = *res->ai_addr;
> -	freeaddrinfo(res);
> -}
> +#define STR_(s)	# s
> +#define STR(s)	STR_(s)

Uh-huh? Why two macros? Well, why any macros at all?

>  static int git_tcp_connect(int fd[2], const char *prog, char *host, char *path)
>  {
> -	struct sockaddr addr;
> -	int port = DEFAULT_GIT_PORT, sockfd;
> -	char *colon;
> -
> -	colon = strchr(host, ':');
> -	if (colon) {
> -		char *end;
> -		unsigned long n = strtoul(colon+1, &end, 0);
> -		if (colon[1] && !*end) {
> -			*colon = 0;
> -			port = n;
> +	int sockfd = -1;
> +	char *colon, *end;
> +	char *port = STR(DEFAULT_GIT_PORT);
> +	struct addrinfo hints, *ai0, *ai;
> +	int gai;
> +
> +	if (host[0] == '[') {
> +		end = strchr(host + 1, ']');
> +		if (end) {
> +			*end = 0;
> +			end++;
> +			host++;
> +		} else
> +			end = host;
> +	} else
> +		end = host;
> +	colon = strchr(end, ':');
> +
> +	if (colon)
> +		port = colon + 1;
> +
> +	memset(&hints, 0, sizeof(hints));
> +	hints.ai_socktype = SOCK_STREAM;
> +	hints.ai_protocol = IPPROTO_TCP;
> +
> +	gai = getaddrinfo(host, port, &hints, &ai);
> +	if (gai)
> +		die("Unable to look up %s (%s)", host, gai_strerror(gai));
> +
> +	for (ai0 = ai; ai; ai = ai->ai_next) {
> +		sockfd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> +		if (sockfd < 0)
> +			continue;
> +		if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
> +			close(sockfd);
> +			sockfd = -1;
> +			continue;
>  		}
> +		break;
>  	}
>  
> -	lookup_host(host, &addr);
> -	((struct sockaddr_in *)&addr)->sin_port = htons(port);
> +	freeaddrinfo(ai0);
>  
> -	sockfd = socket(PF_INET, SOCK_STREAM, IPPROTO_IP);
>  	if (sockfd < 0)
>  		die("unable to create socket (%s)", strerror(errno));
> -	if (connect(sockfd, (void *)&addr, sizeof(addr)) < 0)
> -		die("unable to connect (%s)", strerror(errno));
> +
>  	fd[0] = sockfd;
>  	fd[1] = sockfd;
>  	packet_write(sockfd, "%s %s\n", prog, path);

You are saying that you were unable to create socket while you just were
unable to connect.  Not any biggie, but it saves the user the trouble of
one strace after being confused by an error message. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
