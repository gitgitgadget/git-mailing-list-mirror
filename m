From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [RFC/PATCH v2 1/2] config: Add hashtable for config parsing &
 retrieval
Date: Mon, 02 Jun 2014 21:33:54 +0200
Message-ID: <538CD1A2.4020400@web.de>
References: <1401720460-6525-1-git-send-email-tanayabh@gmail.com> <1401720460-6525-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 21:34:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrXzo-0008M7-GD
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 21:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbaFBTeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 15:34:08 -0400
Received: from mout.web.de ([212.227.15.14]:60459 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbaFBTeH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 15:34:07 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0Lfmd0-1WTmxH20Jm-00pPi7; Mon, 02 Jun 2014 21:34:01
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1401720460-6525-2-git-send-email-tanayabh@gmail.com>
X-Provags-ID: V03:K0:hYtNKRvcQNbSzXsAbQFAGnU+MPBbELCHiUnLkx4UKneQqDE+C7H
 yXexF+iOcnVPQIXwSLQcD4kYdfYd0nkKU01/baA1sIQq9orbfbkOWudd3ILpQ0U51ZZFh1d
 ojXHO1xFbh2ZGiuLb1EGaaggDAuhFRtdzGjv7nPE7yg+nYilw5b55XrYqT9M7JToodqFhA5
 S8CE43allvTHbcTPKB6Eg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250584>

On 2014-06-02 16.47, Tanay Abhra wrote:

[]
Please see 3 minor remarks inline.
> --- a/config.c
> +++ b/config.c
> @@ -9,6 +9,8 @@
>  #include "exec_cmd.h"
>  #include "strbuf.h"
>  #include "quote.h"
> +#include "hashmap.h"
> +#include "string-list.h"
>  
>  struct config_source {
>  	struct config_source *prev;
> @@ -37,6 +39,112 @@ static struct config_source *cf;
>  
>  static int zlib_compression_seen;
>  
> +static struct hashmap config_cache;
> +
> +struct config_cache_entry {
> +	struct hashmap_entry ent;
> +	char *key;
> +	struct string_list *value_list;
> +};
> +
> +static int hashmap_is_init = 0;
we don't need the " = 0", as all static data is initialized to 0 (or NULL) 
> +
> +static int config_cache_entry_cmp_icase(const struct config_cache_entry *e1,
> +				 const struct config_cache_entry *e2, const char* key)
the * should be aligned to the variable "key":
const char *key

[]

> +static void config_cache_set_value(const char *key, const char *value)
> +{
> +	struct config_cache_entry *e;
> +
> +	e = config_cache_find_entry(key);
> +	if (!e) {
> +		e = malloc(sizeof(*e));
I think we need xmalloc() here (from wrapper.c)
