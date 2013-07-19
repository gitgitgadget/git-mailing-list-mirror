From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 1/4] config: add support for http.<url>.* settings
Date: Fri, 19 Jul 2013 13:08:36 -0700
Message-ID: <7va9liuxbv.fsf@alter.siamese.dyndns.org>
References: <9a5e7ef2eb19b10b28f154b3d5e03cd@f74d39fa044aa309eaea14b9f57fe79>
	<296e6ff588bb131a7e8274738d4378c@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 22:08:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Gyq-0006K4-IV
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 22:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596Ab3GSUIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 16:08:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37990 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148Ab3GSUIj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 16:08:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2845932AFD;
	Fri, 19 Jul 2013 20:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lGCl5nN21rK2xtrlzJ5sEiNHCMg=; b=XyXn1c
	8NoFlOXU5qMkOtmT8tmoR3qizI7c2RVwGi0KNQ0Wg1Ufn/deXgJLSbe5dx2G8Wrp
	reJfgdVCbtQyau/GIDgt+ru45xPRnnm9ktKz7beuFsdnvVOc6jDuJKt9Dz/Ua6yO
	SM0LJxuuUoDHlhwFGYtFcS/+3D4H2W1sIeGMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AmlpSsE3pHleqDPkDevH58CqUM2v8erz
	odDj8LV6lc/Xd4JsXQ626YQMCQfzbtGOY5Ywbpp5kuVJ2io4LT3NojsgjckGP95A
	13GvBmrlVFNYf842IaBztt1a7eWRLXvKLQnBbbt8EMcB3Hx2JrOhR9FrYmZTthRM
	dpd4zPmAv6w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 190F632AFC;
	Fri, 19 Jul 2013 20:08:39 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 311A332AFB;
	Fri, 19 Jul 2013 20:08:38 +0000 (UTC)
In-Reply-To: <296e6ff588bb131a7e8274738d4378c@f74d39fa044aa309eaea14b9f57fe79>
	(Kyle J. McKay's message of "Fri, 19 Jul 2013 05:48:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFEA01E0-F0AE-11E2-B0A0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230845>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> +static size_t http_option_max_matched_len[OPT_MAX];
>  ...
> +static int new_match_is_shorter(size_t matchlen, enum http_option_type opt)
> +{
> +	/*
> +	 * Compare matchlen to the last matched length of option opt and
> +	 * return true if matchlen is shorter than the last matched length
> +	 * (meaning the config setting should be ignored).  Upon seeing the
> +	 * _same_ key (i.e. new key has the same match length which is therefore
> +	 * not shorter) the new setting will override the previous setting.
> +	 * Otherwise return false and record matchlen as the current last
> +	 * matched length of option opt.
> +	 */
> +	if (matchlen < http_option_max_matched_len[opt])
> +		return 1;
> +	http_option_max_matched_len[opt] = matchlen;
> +	return 0;
> +}
> + ...
> @@ -337,7 +472,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  
>  	http_is_verbose = 0;
>  
> -	git_config(http_options, NULL);
> +	git_config(http_options, (void *)url);

Can http_init() be called more than once?  max-matched-len (and
leter user-matched as well) is initialized to zero at the link time,
and never reset after it is used for matching the configuration file
entries with a single URL.

If this function is called more than once, the code needs to
memset(0) the array(s), don't it?

Another possibility, which might be better, is to package that array
and the url into a structure, have it on the stackframe of this
function, i.e.

	struct match_url_state {
        	const char *url;

		size_t http_option_max_matched_len[OPT_MAX];
		int http_option_user_matched[OPT_MAX];
	} match_url_state = {NULL};

	git_config(http_options, &match_url_state);

or something.  In any case, you no longer have to cast the second
parameter of git_config to (void *) only to defeat constness ;-)

>  	curl_global_init(CURL_GLOBAL_ALL);
