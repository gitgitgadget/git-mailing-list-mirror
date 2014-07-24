From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v12 1/2] add `config_set` API for caching config-like files
Date: Thu, 24 Jul 2014 11:41:43 -0700
Message-ID: <xmqqwqb28uqg.fsf@gitster.dls.corp.google.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<xmqqiomnda1y.fsf@gitster.dls.corp.google.com>
	<53D120FE.8000809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:42:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XANxk-0000vJ-8C
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 20:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933322AbaGXSlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 14:41:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61469 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757603AbaGXSlv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 14:41:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 408D62AD20;
	Thu, 24 Jul 2014 14:41:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FlbNjMP6Bc7KoTy3r+JT1V/+WSc=; b=H7bHqr
	haoaZhIdj4y7q3TGur7tgs/p9Scc5Ax9pjy7ka3B55ZjgzX1eYCvN7o++GyE43Hg
	c/K+PY4dq4cfcBYQ+2++du9gdD4g4st0upBsoGrHUUftnBV+wWku0TDS7QWnGucb
	RYx/RlPBKIdYgUGRXZYyKitZkuhPYKGda9z/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V6quqjK/kXOvXkvhYijtEW4d8OTaQ7ae
	5HrnKpB2tENG8p3d/Bwm+25e25AjDj72RJksKIQpPZHfXh+EA2VHh+ZfkyTgsG0l
	eakt1ZUo1Hz6m1UFvkoTaOr/99lkmJw4XdNwGNNphWOzeUqi/ZqzTCD0AwAcWsnE
	qgrJp/K5M6c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 358E92AD1F;
	Thu, 24 Jul 2014 14:41:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4A7C52AD14;
	Thu, 24 Jul 2014 14:41:45 -0400 (EDT)
In-Reply-To: <53D120FE.8000809@gmail.com> (Tanay Abhra's message of "Thu, 24
	Jul 2014 20:36:38 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 299266B4-1362-11E4-8C42-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254176>

Tanay Abhra <tanayabh@gmail.com> writes:

> +int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest)
> +{
> +	const char *value;
> +	if (!git_configset_get_value(cs, key, &value))
> +		return git_config_string(dest, key, value);
> +	else
> +		return 1;
> +}
> +
> +int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
> +{
> +	const char *value;
> +	if (!git_configset_get_value(cs, key, &value)) {
> +		if (!value)
> +			return config_error_nonbool(key);
> +		*dest = xstrdup(value);
> +		return 0;
> +	}
> +	else
> +		return 1;
> +}

Hmm, do we really need duplicate and an almost identical
implementations?

I would have expected either one of these two (expecting the latter
more than the former from the discussion):

 1. Because git_configset_get_string_const() returns a const string
    not to be touched by the caller, it does not even xstrdup(),
    while git_configset_get_string() does.

 2. These behave identically, and the only reason we have two is
    because some callers want to receive the string in "char *"
    while others want to use "const char *".

If you were going route #1, then you would need duplicate but subtly
different implementations; get_string_const() variant would not be
calling git_config_string() because it does xstrdup() the value and
give the caller a new string the caller has to free.

If you were going route #2, the I would have expected there is only
one implementation, _get_string(), and _get_string_const() would
call it while casting the dest parameter it receives.
