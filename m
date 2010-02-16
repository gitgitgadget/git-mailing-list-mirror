From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v2 2/4] Refactoring: connect.c: move duplicated code to
 get_host_and_port
Date: Mon, 15 Feb 2010 23:10:04 -0500
Message-ID: <20100216041004.GA7529@cthulhu>
References: <1266276411-5796-1-git-send-email-michael.lukashov@gmail.com>
 <1266276411-5796-3-git-send-email-michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 05:10:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhElM-0003uF-Kz
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 05:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574Ab0BPEKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 23:10:07 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:58095 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932547Ab0BPEKG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 23:10:06 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 7095C822010; Mon, 15 Feb 2010 23:10:04 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1266276411-5796-3-git-send-email-michael.lukashov@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140063>

* Michael Lukashov (michael.lukashov@gmail.com) [100215 18:33]:
> The following functions:
> 
>   git_tcp_connect_sock (IPV6 version)
>   git_tcp_connect_sock (no IPV6 version),
>   git_proxy_connect
> 
> have common block of code. Move it to a new function 'get_host_and_port'
> 
> Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
> ---
>  connect.c |   83 +++++++++++++++++++++---------------------------------------
>  1 files changed, 29 insertions(+), 54 deletions(-)
> 
> diff --git a/connect.c b/connect.c
> index 20054e4..cd399f4 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -152,6 +152,28 @@ static enum protocol get_protocol(const char *name)
>  #define STR_(s)	# s
>  #define STR(s)	STR_(s)
>  
> +static void get_host_and_port(char **host, const char **port)
> +{
> +	char *colon, *end;
> +
> +	if (*host[0] == '[') {
> +		end = strchr(*host + 1, ']');
> +		if (end) {
> +			*end = 0;
> +			end++;
> +			(*host)++;
> +		} else
> +			end = *host;
> +	} else
> +		end = *host;
> +	colon = strchr(end, ':');
> +
> +	if (colon) {
> +		*colon = 0;
> +		*port = colon + 1;
> +	}
> +}
> +
>  #ifndef NO_IPV6
>  
>  static const char *ai_name(const struct addrinfo *ai)
> @@ -170,30 +192,14 @@ static const char *ai_name(const struct addrinfo *ai)
>  static int git_tcp_connect_sock(char *host, int flags)
>  {
>  	int sockfd = -1, saved_errno = 0;
> -	char *colon, *end;
>  	const char *port = STR(DEFAULT_GIT_PORT);
>  	struct addrinfo hints, *ai0, *ai;
>  	int gai;
>  	int cnt = 0;
>  
> -	if (host[0] == '[') {
> -		end = strchr(host + 1, ']');
> -		if (end) {
> -			*end = 0;
> -			end++;
> -			host++;
> -		} else
> -			end = host;
> -	} else
> -		end = host;
> -	colon = strchr(end, ':');
> -
> -	if (colon) {
> -		*colon = 0;
> -		port = colon + 1;
> -		if (!*port)
> -			port = "<none>";
> -	}
> +	get_host_and_port(&host, &port);
> +	if (!*port)
> +		*port = "<none>";

shouldn't that be 'port = "none";'?

          --larry
