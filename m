From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCHv2 6/8] submodule: simplify memory handling in config parsing
Date: Wed, 23 Jan 2013 21:51:23 +0100
Message-ID: <51004D4B.5090409@web.de>
References: <20130123062132.GA2038@sigill.intra.peff.net> <20130123062642.GF5036@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	=?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 23 21:51:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty7Ib-00068v-CV
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 21:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789Ab3AWUvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 15:51:37 -0500
Received: from mout.web.de ([212.227.15.3]:61590 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028Ab3AWUvg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 15:51:36 -0500
Received: from [192.168.178.41] ([91.3.166.4]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0LtnvF-1UzBZh3wCj-011AfD; Wed, 23 Jan 2013 21:51:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <20130123062642.GF5036@sigill.intra.peff.net>
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:XDlLB/zr9Y58GH0qQ3Nxs1lXHZzgi0bHQisRG9Yz+on
 pcLyAY5FC0e53/t2vvWCWnwLSNi3mTk4qWmroKVygNbSp0w7Wb
 eb0g5/z30eIneJsYwoMBC5d9S+Ke1akS470xlx4G0h5eM4Vefn
 28zUsaxTzDvh87uKnvyiN1Vr7K1AP7xEIksJdXQ65JFcOGlURM
 v37L3KTKarDXZ9iqJOU/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214362>

Am 23.01.2013 07:26, schrieb Jeff King:
> We keep a strbuf for the name of the submodule, even though
> we only ever add one string to it. Let's just use xmemdupz
> instead, which is slightly more efficient and makes it
> easier to follow what is going on.
> 
> Unfortunately, we still end up having to deal with some
> memory ownership issues in some code branches, as we have to
> allocate the string in order to do a string list lookup, and
> then only sometimes want to hand ownership of that string
> over to the string_list. Still, making that explicit in the
> code (as opposed to sometimes detaching the strbuf, and then
> always releasing it) makes it a little more obvious what is
> going on.

Thanks, this helps until I some day find the time to refactor
that code into a more digestible shape ;-)

Acked-by: Jens Lehmann <Jens.Lehmann@web.de>

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  submodule.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/submodule.c b/submodule.c
> index 25413de..9ba1496 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -127,7 +127,6 @@ int parse_submodule_config_option(const char *var, const char *value)
>  int parse_submodule_config_option(const char *var, const char *value)
>  {
>  	struct string_list_item *config;
> -	struct strbuf submodname = STRBUF_INIT;
>  	const char *name, *key;
>  	int namelen;
>  
> @@ -135,37 +134,36 @@ int parse_submodule_config_option(const char *var, const char *value)
>  		return 0;
>  
>  	if (!strcmp(key, "path")) {
> -		strbuf_add(&submodname, name, namelen);
>  		config = unsorted_string_list_lookup(&config_name_for_path, value);
>  		if (config)
>  			free(config->util);
>  		else
>  			config = string_list_append(&config_name_for_path, xstrdup(value));
> -		config->util = strbuf_detach(&submodname, NULL);
> -		strbuf_release(&submodname);
> +		config->util = xmemdupz(name, namelen);
>  	} else if (!strcmp(key, "fetchrecursesubmodules")) {
> -		strbuf_add(&submodname, name, namelen);
> -		config = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, submodname.buf);
> +		char *name_cstr = xmemdupz(name, namelen);
> +		config = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, name_cstr);
>  		if (!config)
> -			config = string_list_append(&config_fetch_recurse_submodules_for_name,
> -						    strbuf_detach(&submodname, NULL));
> +			config = string_list_append(&config_fetch_recurse_submodules_for_name, name_cstr);
> +		else
> +			free(name_cstr);
>  		config->util = (void *)(intptr_t)parse_fetch_recurse_submodules_arg(var, value);
> -		strbuf_release(&submodname);
>  	} else if (!strcmp(key, "ignore")) {
> +		char *name_cstr;
> +
>  		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
>  		    strcmp(value, "all") && strcmp(value, "none")) {
>  			warning("Invalid parameter \"%s\" for config option \"submodule.%s.ignore\"", value, var);
>  			return 0;
>  		}
>  
> -		strbuf_add(&submodname, name, namelen);
> -		config = unsorted_string_list_lookup(&config_ignore_for_name, submodname.buf);
> -		if (config)
> +		name_cstr = xmemdupz(name, namelen);
> +		config = unsorted_string_list_lookup(&config_ignore_for_name, name_cstr);
> +		if (config) {
>  			free(config->util);
> -		else
> -			config = string_list_append(&config_ignore_for_name,
> -						    strbuf_detach(&submodname, NULL));
> -		strbuf_release(&submodname);
> +			free(name_cstr);
> +		} else
> +			config = string_list_append(&config_ignore_for_name, name_cstr);
>  		config->util = xstrdup(value);
>  		return 0;
>  	}
> 
