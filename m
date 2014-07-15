From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 1/2] add `config_set` API for caching config-like files
Date: Tue, 15 Jul 2014 08:46:24 -0700
Message-ID: <xmqqoawqwrov.fsf@gitster.dls.corp.google.com>
References: <1405434571-25459-1-git-send-email-tanayabh@gmail.com>
	<1405434571-25459-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 17:46:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X74wC-0007GK-No
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 17:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbaGOPqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 11:46:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58353 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbaGOPqg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 11:46:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F0E6B2893B;
	Tue, 15 Jul 2014 11:46:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wnEm17GY3/eT244KBK4xBhKBEM8=; b=ffEd/I
	++GQRVdWAMy9jc6tngp245RBbEJzrnjiprJcf2A9p058vQDgi+fdBT2wxjZ6BKUi
	B0Tu6mnXSyoMWeVvsn4vpedtdrNcQuVb7FoSL6lRotzl7KSxDLwULfXG673kdzkX
	fDT0xY2PkdzSn3wKqzfmjqdN2u1ST0CQRlEFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vDMIREQplWW4FjFU6V8Zc8uUq4XXXny1
	FehmSe1jo4x1RD+fsqNLVezK90Y7UNMDkUJSvWbHKkogtAb4xlztS96sB5wXcXMa
	XS5V/kRYHmA5x4+IJbtwbaWx2yJZApIHjLa+ZcDanwEFYBf1Pb7yulNDGCnRXlNt
	Vb2X6iHi2+w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E79A92893A;
	Tue, 15 Jul 2014 11:46:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C052728931;
	Tue, 15 Jul 2014 11:46:08 -0400 (EDT)
In-Reply-To: <1405434571-25459-2-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Tue, 15 Jul 2014 07:29:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 23A45DF2-0C37-11E4-BDC3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253566>

Tanay Abhra <tanayabh@gmail.com> writes:

> diff --git a/config.c b/config.c
> index ba882a1..89e2d67 100644
> --- a/config.c
> +++ b/config.c
> ...
> +const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
> +{
> +	struct config_set_element *e = configset_find_element(cs, key);
> +	return e ? &e->value_list : NULL;
> +}

Somehow I find the placement of this function out of place.  Didn't
you get the same impression while proofreading the entire file after
you are done writing this patch?

The right place for it would probably be immediately before
git_configset_get_value(), I would think.

> +int git_configset_add_file(struct config_set *cs, const char *filename)
> +{
> +	int ret = 0;
> +	ret = git_config_from_file(config_hash_callback, filename, cs);
> +	if (!ret)
> +		return 0;
> +	else {
> +		git_configset_clear(cs);
> +		return -1;
> +	}
> +}

If I add contents from file "A" successfully and then attempt to
further add contents from file "B" which fails, I would lose
contents I read from "A"?

It would not be worth trying to make it transactional (i.e. making
sure cs contains what was there before the config-from-file was
called if it failed), so in such a case we may end up seeing a
mixture of full contents from A and partial contents from B, which
is just as useless as a cleared configset, so it is not wrong to
clear it per-se.  An alternative might be to return without
clearing, as we are leaving the configset in a useless state either
way and give the caller a choice between clearing it and continue,
and dying without even spending unnecessary cycles to clear.  That
might be more consistent with what git_config_check_init() does,
where you die without bothering to clear what was half-read into the
configset.

Whatever behaviour is chosen in the error codepath, it needs to be
documented.

Thanks.
