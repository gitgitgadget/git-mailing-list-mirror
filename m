Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314D0C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 21:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0333B21744
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 21:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kPz17GJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgAFVBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:01:10 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52118 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgAFVBK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 16:01:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 60C97A71C3;
        Mon,  6 Jan 2020 16:01:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qrUrYTkbqZLm2HWlECyATkkhEpI=; b=kPz17G
        JH9VKwbfH711z0Ek8IZEFTMI8bnKElfGjqtw24nYE+GQDUjqe+Jv/EWGjAuXIxHK
        QWt0JqemmDWPfe2s1S0OIIHWIg3PimQJS9QypRFYEvmr+J9AbHpZsQveWxPHtpCD
        F6rIx1IT61oLM95OmVDd+/SKyDlmq70Evi37s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dKwKd+liuBZMk5XuB25GlQtWMCqZfK88
        lf+lA3Elp6altiTzw8JRKRLeYbtXwYtgye/64L/4rzj3GCrQbC6mSyYGnlzZiRCI
        uHSV+t8QvNfMgqOGgAEiOAwyBDoHz0bI90hzba3UDBZLT/k8zFUEwDwIRJHt9Gw4
        WS9BQ8PG0c0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58D26A71C2;
        Mon,  6 Jan 2020 16:01:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8C503A71BD;
        Mon,  6 Jan 2020 16:01:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/5] merge: verify signatures if gpg.verifySignatures is true
References: <20200105135616.19102-1-hji@dyntopia.com>
        <20200105135616.19102-5-hji@dyntopia.com>
Date:   Mon, 06 Jan 2020 13:01:03 -0800
In-Reply-To: <20200105135616.19102-5-hji@dyntopia.com> (Hans Jerry
        Illikainen's message of "Sun, 5 Jan 2020 13:56:15 +0000")
Message-ID: <xmqqa7708flc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A78CC040-30C7-11EA-90B5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

> @@ -610,6 +610,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
>  		show_diffstat = git_config_bool(k, v);
>  	else if (!strcmp(k, "merge.verifysignatures"))
>  		verify_signatures = git_config_bool(k, v);
> +	else if (!strcmp(k, "gpg.verifysignatures") && verify_signatures < 0)
> +		verify_signatures = git_config_bool(k, v);

Hmm, the next person who attempts to generalize the mechanism
further would have a hard time introducing a fallback configuration
that is even common than "gpg" when s/he has to start with this
code, no?  That is, this patch introduced "gpg.verifysignatures is
used when merge.verifysignatures is not defined" and with the two
level override the code works OK, but to implement "if neither gpg.*
or merge.* is defined, common.verifysignatures is used instead", the
above part needs to be dismantled and redone.

Keeping the "initialize verify_signatures to -1 (unspecified)" from
this patch, setting a separate gpg_verify_signatures variable upon
seeing gpg.verifysignatures, and consolidating the final finding
after git_config(git_merge_config, NULL) returns into verify_signatures
like so:

	init_diff_ui_defaults();
	git_config(git_merge_config, NULL);

+	if (verify_signatures < 0)
+		verify_signatures = (0 <= gpg_verify_signatures) 
+				  ? gpg_verify_signatures 
+				  : 0;

would be more in line with the way we arrange multiple configuration
variables to serve as fallback defaults.  And that is more easily
extensible.

Also with such an arrangement, "if (verify_signatures == 1)" we see
below will become unnecessary, which is another plus.

Thanks.

>  	else if (!strcmp(k, "pull.twohead"))
>  		return git_config_string(&pull_twohead, k, v);
>  	else if (!strcmp(k, "pull.octopus"))
> @@ -1399,7 +1401,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		if (remoteheads->next)
>  			die(_("Can merge only exactly one commit into empty head"));
>  
> -		if (verify_signatures &&
> +		if (verify_signatures == 1 &&
>  		    gpg_verify_commit(&remoteheads->item->object.oid, NULL,
>  				      NULL, gpg_flags))
>  			die(_("Signature verification failed"));
> @@ -1423,7 +1425,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		usage_with_options(builtin_merge_usage,
>  			builtin_merge_options);
>  
> -	if (verify_signatures) {
> +	if (verify_signatures == 1) {
>  		for (p = remoteheads; p; p = p->next) {
>  			if (gpg_verify_commit(&p->item->object.oid, NULL, NULL,
>  					      gpg_flags))

