From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] Submodules: Add 'on-demand' value for the
 'fetchRecurseSubmodule' option
Date: Wed, 23 Feb 2011 15:16:21 -0800
Message-ID: <7vei6y5ol6.fsf@alter.siamese.dyndns.org>
References: <4D656F25.5090007@web.de> <4D656FB0.7040904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 24 00:16:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsNwo-0008C3-Su
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 00:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494Ab1BWXQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 18:16:38 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab1BWXQi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 18:16:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 971CF4363;
	Wed, 23 Feb 2011 18:17:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=unsn0UMUylV4lcO9tI3Laywr13Y=; b=VHNU1B
	spGHX2jlFzDWH2NcrFmMTXNAnPr10TPygmkczGcBwqWjcuj/BuHJAH9xd87saPoL
	fv2RRyAsw8hptYCu8icxTAyPuDfxdthZEnHRRsrDYMWwThJYekGWzumy76DKVYlq
	4G6s/zAYyY6wRzOqLs+gGVZfVT8Us/lZBbJC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m78j++kv81lIe4Cn5fblerlWTIzY70t3
	A5BQpPr8IBweHO+s3bSubGclb2UD4qQP2Ooho2HnVpXfgNpTIFD30qk+kBxvV3Jv
	UQtyKIybb3er3k1RGsvGZYJxs+pnEwop4g+v50ZYs157D82ZnJz+s/mCDZEFY+xo
	CUVa2565jrU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B4CB435B;
	Wed, 23 Feb 2011 18:17:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 405EE4355; Wed, 23 Feb 2011
 18:17:35 -0500 (EST)
In-Reply-To: <4D656FB0.7040904@web.de> (Jens Lehmann's message of "Wed\, 23
 Feb 2011 21\:36\:00 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1DAE0718-3FA3-11E0-A957-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167737>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> diff --git a/submodule.c b/submodule.c
> index cccd728..b477c3c 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -113,7 +113,7 @@ int parse_submodule_config_option(const char *var, const char *value)
>  		if (!config)
>  			config = string_list_append(&config_fetch_recurse_submodules_for_name,
>  						    strbuf_detach(&submodname, NULL));
> -		config->util = git_config_bool(var, value) ? (void *)1 : NULL;
> +		config->util = (void *)(size_t)parse_fetch_recurse_submodules_arg(value);

What is this double-cast about?

> @@ -376,8 +376,13 @@ int fetch_populated_submodules(int num_options, const char **options,
> ...
> +				if ((size_t)fetch_recurse_submodules_option->util == RECURSE_SUBMODULES_OFF)
>  					continue;
> +				if ((size_t)fetch_recurse_submodules_option->util == RECURSE_SUBMODULES_ON_DEMAND) {

Likewise here; size_t feels a strange type to cast to in this comparison
between (void *) and an enum, no?
