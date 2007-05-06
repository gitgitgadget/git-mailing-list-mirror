From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-config: read remote config files over HTTP
Date: Sat, 05 May 2007 23:55:28 -0700
Message-ID: <7virb6fnkv.fsf@assigned-by-dhcp.cox.net>
References: <11782757671754-git-send-email-skimo@liacs.nl>
	<11782757671933-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sven Verdoolaege <skimo@liacs.nl>
X-From: git-owner@vger.kernel.org Sun May 06 08:55:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkaeb-0005aI-Ii
	for gcvg-git@gmane.org; Sun, 06 May 2007 08:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237AbXEFGza (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 02:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755248AbXEFGza
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 02:55:30 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:59638 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755237AbXEFGz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 02:55:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506065529.YQTQ24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 6 May 2007 02:55:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vivU1W00f1kojtg0000000; Sun, 06 May 2007 02:55:29 -0400
In-Reply-To: <11782757671933-git-send-email-skimo@liacs.nl> (Sven
	Verdoolaege's message of "Fri, 4 May 2007 12:49:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46306>

Sven Verdoolaege <skimo@liacs.nl> writes:

> diff --git a/Makefile b/Makefile
> index 0185386..b782111 100644
> --- a/Makefile
> +++ b/Makefile

Very nicely done. 

> diff --git a/config.c b/config.c
> index 0da74e0..36e3b97 100644
> --- a/config.c
> +++ b/config.c
> @@ -7,6 +7,7 @@
>   */
>  #include "cache.h"
>  #include "pkt-line.h"
> +#include "http_config.h"
>  
>  #define MAXNAME (256)
>  
> @@ -395,6 +396,16 @@ int git_config_from_file(config_fn_t fn, const char *filename)
>  	return ret;
>  }
>  
> +static int config_from_http(config_fn_t fn, char *dest)
> +{
> +	static char *config_temp = "config.temp";
> +	if (git_http_fetch_config(dest, config_temp))
> +		return 1;
> +	git_config_from_file(fn, config_temp);
> +	unlink(config_temp);
> +	return 0;
> +}

Not mkstemp()?

> @@ -403,6 +414,9 @@ int git_config_from_remote(config_fn_t fn, char *dest)
>  	static char var[MAXNAME];
>  	static char value[1024];
>  
> +	if (!prefixcmp(dest, "http://"))
> +		return config_from_http(fn, dest);
> +

Shouldn't this also work for other protocols we handle via curl?

> diff --git a/http.c b/http.c
> index ae27e0c..3e1ccce 100644
> --- a/http.c
> +++ b/http.c
> @@ -25,6 +25,10 @@ long curl_low_speed_limit = -1;
>  long curl_low_speed_time = -1;
>  int curl_ftp_no_epsv = 0;
>  
> +#ifdef USE_CURL_MULTI
> +void (*fill_active_slots)(void) = NULL;
> +#endif
> +

I wonder if we could lose USE_CURL_MULTI around this one,...

>  struct curl_slist *pragma_header;
>  
>  struct active_request_slot *active_queue_head = NULL;
> @@ -394,7 +398,8 @@ void step_active_slots(void)
>  	} while (curlm_result == CURLM_CALL_MULTI_PERFORM);
>  	if (num_transfers < active_requests) {
>  		process_curl_messages();
> -		fill_active_slots();
> +		if (fill_active_slots)
> +			fill_active_slots();
>  	}
>  }
>  #endif
> @@ -459,7 +464,8 @@ void release_active_slot(struct active_request_slot *slot)
>  		slot->curl = NULL;
>  	}
>  #ifdef USE_CURL_MULTI
> -	fill_active_slots();
> +	if (fill_active_slots)
> +		fill_active_slots();
>  #endif
>  }

... and especially this one.

The fill_active_slots variable may happen to stay at NULL under
!USE_CURL_MULTI, because the only code that sets the variable
would be in #ifdef USE_CURL_MULTI.
