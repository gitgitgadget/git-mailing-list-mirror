From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v3 1/6] alias.c: replace `git_config()` with `git_config_get_string()`
Date: Mon, 21 Jul 2014 14:43:28 +0100
Message-ID: <53CD1900.6040909@ramsay1.demon.co.uk>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com> <1405941145-12120-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 15:43:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9DsN-0002gf-M1
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 15:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbaGUNnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 09:43:32 -0400
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:39357 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932205AbaGUNnb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 09:43:31 -0400
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 6DA4EAC40C3;
	Mon, 21 Jul 2014 14:43:44 +0100 (BST)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 38528AC40B2;
	Mon, 21 Jul 2014 14:43:44 +0100 (BST)
Received: from [192.168.254.7] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Mon, 21 Jul 2014 14:43:43 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1405941145-12120-2-git-send-email-tanayabh@gmail.com>
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253962>

On 21/07/14 12:12, Tanay Abhra wrote:
> Use `git_config_get_string()` instead of `git_config()` to take advantage of
> the config-set API which provides a cleaner control flow.
> The function now raises an error instead of dying when a NULL value is found.
> 
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  alias.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/alias.c b/alias.c
> index 758c867..a453bd8 100644
> --- a/alias.c
> +++ b/alias.c
> @@ -1,26 +1,13 @@
>  #include "cache.h"
>  
> -static const char *alias_key;
> -static char *alias_val;
> -
> -static int alias_lookup_cb(const char *k, const char *v, void *cb)
> -{
> -	const char *name;
> -	if (skip_prefix(k, "alias.", &name) && !strcmp(name, alias_key)) {
> -		if (!v)
> -			return config_error_nonbool(k);
> -		alias_val = xstrdup(v);
> -		return 0;
> -	}
> -	return 0;
> -}
> -
> -char *alias_lookup(const char *alias)
> +char *alias_lookup(const char* alias)

No, this is not C++. :-D

>  {
> -	alias_key = alias;
> -	alias_val = NULL;
> -	git_config(alias_lookup_cb, NULL);
> -	return alias_val;
> +	const char *v = NULL;
> +	struct strbuf key = STRBUF_INIT;
> +	strbuf_addf(&key, "alias.%s", alias);
> +	git_config_get_string(key.buf, &v);
> +	strbuf_release(&key);
> +	return (char*)v;
>  }
>  
>  #define SPLIT_CMDLINE_BAD_ENDING 1
> 
