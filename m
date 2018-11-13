Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 024A61F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 04:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeKMN5q (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 08:57:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53862 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeKMN5q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 08:57:46 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D1C2380A7;
        Mon, 12 Nov 2018 23:01:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DgitKVB/KXvYv8X7oi0cUGiUVWM=; b=hbS8bx
        ksIcsU4+hOC3MfydOX8Y/YbVEzSy9hb1ARFAdhmbhkJCoPZC4rf8ZqtJ/U610ywg
        kiFOU4BvAadcIvBPDwJsT4t3iXPTaLbDlKMGx8dPljIw7c4FoGT2Rnlx0+JeWZuk
        HBh7aVVz4SFDN6TJkFimJAqKMIl1GfiXOEn/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P9zr5/dB4zUDmPeiCDUVQM1kdb95Ry1E
        j6erOYax3QNb7u2BVmpsR/Rmlrw6V7cuXRjPSjpmDXnHSy6F65maQmXapAmihDoi
        CfpdwLwzHpIjN1MpNN9WdmziB8Vs/UwbK8VC9U/S7HXbX2i5LkE3XfQNEJeemmoA
        mG0eatFQOp8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 659FE380A6;
        Mon, 12 Nov 2018 23:01:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 58003380A5;
        Mon, 12 Nov 2018 23:01:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     steadmon@google.com
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 1/1] protocol: advertise multiple supported versions
References: <cover.1539305180.git.steadmon@google.com>
        <cover.1542059029.git.steadmon@google.com>
        <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
Date:   Tue, 13 Nov 2018 13:01:27 +0900
In-Reply-To: <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
        (steadmon's message of "Mon, 12 Nov 2018 13:49:05 -0800")
Message-ID: <xmqqr2fpwrqg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC9A1D84-E6F8-11E8-9B14-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

steadmon@google.com writes:

> Currently the client advertises that it supports the wire protocol
> version set in the protocol.version config. However, not all services
> support the same set of protocol versions. When connecting to
> git-receive-pack, the client automatically downgrades to v0 if
> config.protocol is set to v2, but this check is not performed for other
> services.

"downgrades to v0 even if ... is set to v2" you mean?  Otherwise it
is unclear why asking for v2 leads to using v0.

> This patch creates a protocol version registry. Individual operations
> register all the protocol versions they support prior to communicating
> with a server. Versions should be listed in preference order; the
> version specified in protocol.version will automatically be moved to the
> front of the registry.
>
> The protocol version registry is passed to remote helpers via the
> GIT_PROTOCOL environment variable.
>
> Clients now advertise the full list of registered versions. Servers
> select the first recognized version from this advertisement.

Makes sense.

> +void get_client_protocol_version_advertisement(struct strbuf *advert)
> +{
> +	int tmp_nr = nr_allowed_versions;
> +	enum protocol_version *tmp_allowed_versions, config_version;
> +	strbuf_reset(advert);
> +
> +	have_advertised_versions_already = 1;
> +
> +	config_version = get_protocol_version_config();
> +	if (config_version == protocol_v0) {
> +		strbuf_addstr(advert, "version=0");
> +		return;
> +	}
> +
> +	if (tmp_nr > 0) {
> +		ALLOC_ARRAY(tmp_allowed_versions, tmp_nr);
> +		copy_array(tmp_allowed_versions, allowed_versions, tmp_nr,
> +			   sizeof(enum protocol_version));
> +	} else {
> +		ALLOC_ARRAY(tmp_allowed_versions, 1);
> +		tmp_nr = 1;
> +		tmp_allowed_versions[0] = config_version;
> +	}
> +
> +	if (tmp_allowed_versions[0] != config_version)
> +		for (int i = 1; i < nr_allowed_versions; i++)
> +			if (tmp_allowed_versions[i] == config_version) {
> +				enum protocol_version swap =
> +					tmp_allowed_versions[0];
> +				tmp_allowed_versions[0] =
> +					tmp_allowed_versions[i];
> +				tmp_allowed_versions[i] = swap;
> +			}
> +
> +	strbuf_addf(advert, "version=%s",
> +		    format_protocol_version(tmp_allowed_versions[0]));
> +	for (int i = 1; i < tmp_nr; i++)
> +		strbuf_addf(advert, ":version=%s",
> +			    format_protocol_version(tmp_allowed_versions[i]));
> +}
> +

So the idea is that the protocols the other end can talk come in
advert in their preferred order, and we take an intersection of them
and our "allowed-versions", but the preference is further skewed
with the "swap" thing if we have our own preference specified via
config?

I am wondering if the code added by this patch outside this
function, with if (strcmp(client_ad.buf, "version=0") sprinkled all
over the place, works sensibly when the other side says "I prefer
version=0 but I do not mind talking version=1".

Isn't tmp_allowed_versions[] leaking when we return from this
function?
