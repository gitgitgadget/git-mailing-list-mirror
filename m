Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE262023D
	for <e@80x24.org>; Wed,  1 Mar 2017 21:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753077AbdCAVoZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 16:44:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55841 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751157AbdCAVoX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 16:44:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CBE0C7812C;
        Wed,  1 Mar 2017 16:39:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZQUa/4A8H2RqrwNxTcMDj+iIlaA=; b=nEHJHo
        Vuv1LOgifHnJsK4vHlrDpfo/bSoIQrvtpvJgCjsEjk6nI/WZHNFZxJrIYtW4oh8x
        oFGc+q5aMFDq3wZC0+YJB4KZnnYVQceck7w+r2a+1Dwz6XP4CRBM6eRtVgPFDx+p
        TY0axc3DVAYBmOhJtHPx5nZx1vW/xayFJYYJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZoZBWV9i+06F+bUJ3VxqttujI9HezoVp
        Fpk43kPrKYCce7VAtqVxxM8yv0qBZ/1ssboWtYXG25cDW8HNVB+Fp9LwrnpgsIXh
        KVU1VKI0+R/tC5dhfR4pRQ3dtK7W63N2AMF0J9jdVhk/ar7PPyJzGjhBuIY+uvuV
        k96jq6sl2QY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C268D7812B;
        Wed,  1 Mar 2017 16:39:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 247E67812A;
        Wed,  1 Mar 2017 16:39:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 17/22] read-cache: unlink old sharedindex files
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
        <20170227180019.18666-18-chriscool@tuxfamily.org>
Date:   Wed, 01 Mar 2017 13:39:32 -0800
In-Reply-To: <20170227180019.18666-18-chriscool@tuxfamily.org> (Christian
        Couder's message of "Mon, 27 Feb 2017 19:00:14 +0100")
Message-ID: <xmqqefygfzhn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8EFD2108-FEC7-11E6-BEA5-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +static int can_delete_shared_index(const char *shared_index_path)
> +{
> +	struct stat st;
> +	unsigned long expiration;
> +
> +	/* Check timestamp */
> +	expiration = get_shared_index_expire_date();
> +	if (!expiration)
> +		return 0;
> +	if (stat(shared_index_path, &st))
> +		return error_errno(_("could not stat '%s"), shared_index_path);
> +	if (st.st_mtime > expiration)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static int clean_shared_index_files(const char *current_hex)
> +{
> +	struct dirent *de;
> +	DIR *dir = opendir(get_git_dir());
> +
> +	if (!dir)
> +		return error_errno(_("unable to open git dir: %s"), get_git_dir());
> +
> +	while ((de = readdir(dir)) != NULL) {
> +		const char *sha1_hex;
> +		const char *shared_index_path;
> +		if (!skip_prefix(de->d_name, "sharedindex.", &sha1_hex))
> +			continue;
> +		if (!strcmp(sha1_hex, current_hex))
> +			continue;
> +		shared_index_path = git_path("%s", de->d_name);
> +		if (can_delete_shared_index(shared_index_path) > 0 &&

Is this "can" or "should"?  This sounds like the latter.

> +		    unlink(shared_index_path))
> +			error_errno(_("unable to unlink: %s"), shared_index_path);

This does not make the entire operation to fail (and I think the
behaviour you have here is preferrable--we just want to report
without failing the main operation).

But should it be reported as "error: unable to unlink"?  It may be
better to give this message as a warning.
