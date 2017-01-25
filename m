Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 403001F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 21:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbdAYVnm (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 16:43:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54595 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751803AbdAYVnl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 16:43:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A93664644;
        Wed, 25 Jan 2017 16:43:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eeXk1b5qzIAdg4RpcRYeOcs00Go=; b=CAhXXJ
        C/F6ywP5xDotC1NW3tOkwQOZXoiUAbJOZCrhgsPkf3V8+CKbys1yAF0P6i5GMZET
        OIYWDet6dhjtpCNtnVA39MlWw0tIt76yyzxLzvy+pEawu4zTUD5X+taDJaUXKLDx
        c0YKUHfLgsWvoP9WFevNc6E53wT2pypUYYOz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AIRNcuXxOyYCXAdSVBtfm4PFmhrKPGzN
        4UHvlXoWyqPs47z3U4V+EcQYxqRY5Kdcgi4S32V/5HaigIfKd72fj7JNoNL2oUgj
        a96m8d//1xPsUYgYeCuExkNROIVR5sGID9oIU7bmRzFTct6wwlp13BfyFbVWOYLT
        BoJ38OIOqxk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31E3864643;
        Wed, 25 Jan 2017 16:43:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E2CB64642;
        Wed, 25 Jan 2017 16:43:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Cornelius Weig <cornelius.weig@tngtech.com>, git@vger.kernel.org,
        novalis@novalis.org, pclouds@gmail.com
Subject: Re: [PATCH] tag: add tag.createReflog option
References: <20170125001906.13916-1-cornelius.weig@tngtech.com>
        <20170125180054.7mioop2o6uvqloyt@sigill.intra.peff.net>
        <00712f81-e0ba-52e6-77bc-095a2ed706c4@tngtech.com>
        <20170125213328.meehgxvzuajjgvag@sigill.intra.peff.net>
Date:   Wed, 25 Jan 2017 13:43:38 -0800
In-Reply-To: <20170125213328.meehgxvzuajjgvag@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 25 Jan 2017 16:33:29 -0500")
Message-ID: <xmqqpoja95o5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5560F62C-E347-11E6-B9D3-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +enum log_refs_config {
> +	LOG_REFS_UNSET = -1,
> +	LOG_REFS_NONE = 0,
> +	LOG_REFS_NORMAL, /* see should_create_reflog for rules */
> +	LOG_REFS_ALWAYS
> +};
> +extern enum log_refs_config log_all_ref_updates;
> +...
> +int should_create_reflog(const char *refname)
> +{
> +	switch (log_all_ref_updates) {
> +	case LOG_REFS_ALWAYS:
> +		return 1;
> +	case LOG_REFS_NORMAL:
> +		return !prefixcmp(refname, "refs/heads/") ||
> +		       !prefixcmp(refname, "refs/remotes/") ||
> +		       !prefixcmp(refname, "refs/notes/") ||
> +		       !strcmp(refname, "HEAD");
> +	default:
> +		return 0;
> +	}
> +}

Yup, this is how I expected for the feature to be done.

Just a hint for Cornelius; prefixcmp() is an old name for what is
called starts_with() these days.
