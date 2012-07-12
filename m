From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: fix several access(NULL) calls
Date: Thu, 12 Jul 2012 13:12:37 -0700
Message-ID: <7vwr28agcq.fsf@alter.siamese.dyndns.org>
References: <877gu9wh05.fsf@thomas.inf.ethz.ch>
 <1342094660-3052-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vtxxcc36v.fsf@alter.siamese.dyndns.org> <vpq1ukgai4e.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 12 22:13:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpPlL-0007NF-FM
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 22:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758140Ab2GLUMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 16:12:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48327 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756026Ab2GLUMj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 16:12:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 582A88639;
	Thu, 12 Jul 2012 16:12:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/YlXVX2vKVBjeZI2nduJXZFDWYA=; b=uacuXt
	s8HS8zDZVhlzJwA0+jZjPGzUkNm7gDvzYmKpRdSCd994FTXMtD7d4fCSUrUkQpyi
	8JJRdsX+Xwtog7SfDSE7HTEU158oJc1OEYg2MJDZys8EQwhEy5t7ZgXej3dvjry8
	cmjvw+BcWUBGKwWHi75XV0DQmaQ78WHRgY6hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=daIL9VgI6Tq83CsF6Dqzd6S374H6tzyR
	64yLxLGJ9sK8CNvPM04hUI1C0ihcOQ3MqLOvo4dB41XtDAK+zVKF92p5m9hfeaqf
	7KQigXLEEdCE0cKlsFB//KMgxFxVKtIyYeyZLx7bK3WPs1y7NrBhKilt6ohYKBj1
	b+LJ8nL99wg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 468418638;
	Thu, 12 Jul 2012 16:12:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B41B68636; Thu, 12 Jul 2012
 16:12:38 -0400 (EDT)
In-Reply-To: <vpq1ukgai4e.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu, 12 Jul 2012 21:34:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED8F7924-CC5D-11E1-96A7-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201378>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>>> +		if (user_config && access(user_config, R_OK) &&
>>> +		    xdg_config && !access(xdg_config, R_OK))
>>>  			given_config_file = xdg_config;
>>
>> Shouldn't we be using xdg_config, if user_config is NULL and
>> xdg_config is defined and accessible?
>
> I don't think so. If user_config is NULL, it means something went wrong,
> because $HOME is unset. In this case, I'd rather die than using some
> other configuration file silently (which would be possible if
> $XDG_CONFIG_HOME is set), and this is what the code does:
>
> 		if (user_config && access(user_config, R_OK) &&
> 		    xdg_config && !access(xdg_config, R_OK))
> 			given_config_file = xdg_config;
> 		else if (user_config)
> 			given_config_file = user_config;
> 		else
> 			die("$HOME not set");
>
> Perhaps it could actually be made even clearer with
>
> 		if (!user_config)
> 			die("$HOME not set");
> 		else if (access(user_config, R_OK) &&
> 			 xdg_config && !access(xdg_config, R_OK))
> 			given_config_file = xdg_config;
> 		else
> 			given_config_file = user_config;

At least the code needs to break lines at different point and a comment.

	if (user_config &&
		access(user_config, R_OK) &&
                (xdg_config && !access(xdg_config, R_OK)))
                /*
                 * Even if we have usable XDG stuff, we want to
		 * error out on missing HOME!!!
                 */
		use xdg config;
	else if (user_config)
		use user config;
	else
		unusable situation;

But is it really true that we want to error out on missing HOME if
we have usable XDG stuff?
