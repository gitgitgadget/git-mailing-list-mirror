From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 5/8] config: add `git_die_config()` to the config-set API
Date: Mon, 04 Aug 2014 11:07:12 -0700
Message-ID: <xmqqoaw0ruwf.fsf@gitster.dls.corp.google.com>
References: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
	<1406912756-15517-6-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 20:07:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEMfQ-0004Gz-SR
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbaHDSHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:07:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50723 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbaHDSHW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:07:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF9562EEDE;
	Mon,  4 Aug 2014 14:07:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nTsacVjK/lCObB4kd2RIUYAaT9A=; b=C3uNh3
	VQV6SiriMqJ5t7rzzfnt4ovt3hR+9XtYiy/wqL58Ic8y5vooIb0px9MC/aWtfUov
	A/Kws9p7AhWokiIRWMPOIoBHdo5dN1ty1S8UChNLEqI/daOog88YHxLQevCpm50/
	hWhLmyJyKL/I+8UTfq4OoBtvxJXGYTujXxFH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gmIvmYAEm4klvHeqUB/PJgeBPDccAEP6
	qTfkMinfDb3ukaMNKUvEqb9WxKhmdqSaoUHejfqWjVrSiBs4BiDfM9hzhktAV+qp
	fTu9CQO+H/DBBysVLTgQQI904aCQQWoOWWbG81d4tsEnpp5r1NHk8w1zLHrUx1nN
	NaHTiewuh5o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D3AA72EEDB;
	Mon,  4 Aug 2014 14:07:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 020BC2EEC3;
	Mon,  4 Aug 2014 14:07:14 -0400 (EDT)
In-Reply-To: <1406912756-15517-6-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Fri, 1 Aug 2014 10:05:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2A203996-1C02-11E4-868F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254748>

Tanay Abhra <tanayabh@gmail.com> writes:

> Add `git_die_config` that dies printing the line number and the file name
> of the highest priority value for the configuration variable `key`.
>
> It has usage in non-callback based config value retrieval where we can
> raise an error and die if there is a semantic error.
> For example,
>
> 	if (!git_config_get_value(key, &value)) {
> 		/* NULL values not allowed */
> 		if (!value)
> 			git_config_die(key);
> 		else
> 			/* do work */
> 	}

It feels a bit unnatural at the API level that this does not take
'value'; I do understand that it is not a big deal in the error code
path to locate again the value from the configuration using the key,
but still.

It feels even more unnatural that the caller cannot say _how_ it
finds the value offending by not taking any message.  For one
particular callchain, e.g. git_config_get_string() that eventually
calls git_config_string() which will show an error message via
config_error_nonbool(), you may not want any extra message, but for
new callers that wants to make sure value falls within a supported
range, this forces it to write

	if (!git_config_get_int(key, &num)) {
        	if (!(0 < num && num < 4)) {
			error("'%s' must be between 1 and 3");
                        git_config_die(key);
		}
		/* otherwise work */
	}

and then the error message would say something like:

	error: 'core.frotz' must be between 1 and 3
	fatal: bad config variable 'core.frotz' at file line 15 in .git/config

which sounds somewhat backwards, at least to me.

> +NORETURN
> +void git_die_config_linenr(const char *key, const char *filename, int linenr)
> +{
> +	if (!linenr)
> +		die(_("unable to parse '%s' from command-line config"), key);

Do we have existing code that says "we signal that it is from the
command line by setting linenr to zero" already?  Otherwise I would
have thought filename == NULL would be a more sensible convention.

Otherwise OK.

> +	else
> +		die(_("bad config variable '%s' at file line %d in %s"),

At least, quote the last '%s'.

> +			key,
> +			linenr,
> +			filename);

Don't waste vertical real-estate line this.

Perhaps

        die(_("bad config variable '%s' in file '%s' at line %d"),
            key, linenr, filename);
