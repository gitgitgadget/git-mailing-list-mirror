Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976B7C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 266F824181
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xcwY+gzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgKQVZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:25:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62262 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbgKQVZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:25:58 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A7F2A10036F;
        Tue, 17 Nov 2020 16:25:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z5OSVjTY3E8TLPNQvoXFPxQtvLc=; b=xcwY+g
        zrHmx706O9EPy0yY/0se3Jsyo9AQEhtUf09qhQFCiN4JNJZA+DOSGMT3M5PUy7mK
        dywvL9qmdwsqpuWjtLXuve4eiGg3ZV/CKu8/XUJdLuZ3IQzZa8Sh8rFRmUe9fK4t
        ZZVICvtivSTY9WdAgdsoo7+5Se3dDCP0eojY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JqxUd2TelpqFhwhyUjknnxVeJOx31igE
        m34PZZhtp3RoNik43tUacQ1txjp1FCRwwQTk7swtw0QDK14KXU4Ap3Nrg7ek+fwF
        xH3Y8odoxNumzn65YL/gdZcjEwuHbADsLPl2debwOayORhGT8ZgtDPyv9ciBiBov
        ljjuLbK1tCA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A1C4410036E;
        Tue, 17 Nov 2020 16:25:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E9F8410036D;
        Tue, 17 Nov 2020 16:25:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org, lanodan <contact+git@hacktivis.me>
Subject: Re: [PATCH v2] help.c: configurable suggestions
References: <20201117152535.9795-1-sir@cmpwn.com>
Date:   Tue, 17 Nov 2020 13:25:50 -0800
In-Reply-To: <20201117152535.9795-1-sir@cmpwn.com> (Drew DeVault's message of
        "Tue, 17 Nov 2020 10:25:35 -0500")
Message-ID: <xmqq4kln65gh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 780A5CCC-291B-11EB-AA53-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew DeVault <sir@cmpwn.com> writes:

> -	if (!strcmp(var, "help.autocorrect"))
> -		autocorrect = git_config_int(var,value);
> +	if (!strcasecmp(var, "help.autocorrect")) {

This is an unwarranted change.  The first part and the last part of
a configuration variable name are downcased before the config
callback functions are called, so strcmp() is sufficient.

> +		if (!value)
> +			return config_error_nonbool(var);

This is to protect us against

	[help]
		autocorrect

(i.e. "true" expressed without "= true"), which is not strictly
needed when the only thing we do with value is git_config_int()
because it knows how to handle value==NULL case.  But it starts
to matter when parsing variables with more elaborate shape, like
"int or some known token".

And because we want to keep the promise "if you write negative
value, it means immediate" we made to our users, we can instead make
this variable "number or 'never'".  To do so, keep that "barf if
NULL" check above, and then add something like:

		if (!strcmp(value, "never"))
			autocorrect = AUTOCORRECT_NEVER;
		else {
			int v = git_config_int(var, value);
                        autocorrect = (v < 0) 
				? AUTOCORRECT_IMMEDIATELY : v;
		}

The configuration the end user has may say '-2', but that is
different from 'never', so instead of leaving a negative value as
is, like this code below does ...

> +		autocorrect = git_config_int(var, value);

... we normalize any negative value the user gave us to
AUTOCORRECT_IMMEDIATELY.  That way, we can keep configuration the
user has working the same way as before, while allowing a new value
'never' to have a new meaning.

We might want to further make the variable "number, 'never' or
'immediate'" for consistency, with an eye on the possibility that we
might eventually want to deprecate the "negative means immediate".

To do so, we could do:

		if (!strcmp(value, "never")) {
			autocorrect = AUTOCORRECT_NEVER;
		} else if (!strcmp(value, "immediate")) {
			autocorrect = AUTOCORRECT_IMMEDIATELY;
		} else {
			int v = git_config_int(var, value);
                        autocorrect = (v < 0) 
				? AUTOCORRECT_IMMEDIATELY : v;
		}

instead.

