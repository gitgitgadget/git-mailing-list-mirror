Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 307EA1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 19:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbdHCTef (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 15:34:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50498 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751251AbdHCTef (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 15:34:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95AF7A69B6;
        Thu,  3 Aug 2017 15:34:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d76d0ngPC5eQTvsXLwgih1kbGNY=; b=vkewk3
        KNyGmW3LVLqVAon+CmrjsVCL4V/bi2It/m+QKWIpp06bDsGDuso7rx96px1NQQQa
        m85OI5v3Xi4oDqURIIZgUwv2i6t8XHet7f5Kb+ed+/52P/UcY+T9o8IkZrJrFEVn
        ZfSWMbqwspSjeJ0F3+hguGtjHtNkWE/WTmPPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O+H90VPFVhnrqqx8fvJGC/CZik2sLuxJ
        DNuXAX1yYXszxgAJHmTc4lvOSlb7MU4V/uCMbp9rGzqdG5W56cgp4GpntaNfNLsF
        rA+YZF+LRZrNYKSJH+O6zCD/Pos8pQ11P7VcBVTRU8yXlJRQ9A12O5BC6Fm7hf96
        PWwR6xyHYLQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D2BFA69B5;
        Thu,  3 Aug 2017 15:34:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DBEDFA69B4;
        Thu,  3 Aug 2017 15:34:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 10/40] Add initial external odb support
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
        <20170803091926.1755-11-chriscool@tuxfamily.org>
Date:   Thu, 03 Aug 2017 12:34:25 -0700
In-Reply-To: <20170803091926.1755-11-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 3 Aug 2017 11:18:56 +0200")
Message-ID: <xmqqfud8xx6m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2F1C114-7882-11E7-9A13-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +int external_odb_has_object(const unsigned char *sha1)
> +{
> +	struct odb_helper *o;
> +
> +	external_odb_init();
> +
> +	for (o = helpers; o; o = o->next)
> +		if (odb_helper_has_object(o, sha1))
> +			return 1;
> +	return 0;
> +}
> +
> +int external_odb_get_object(const unsigned char *sha1)
> +{
> +	struct odb_helper *o;
> +	const char *path;
> +
> +	if (!external_odb_has_object(sha1))
> +		return -1;

This probably would not matter, as I do not expect one repository to
connect to and backed by very many external odb instances, but I
would have expected that the interaction would go more like "ah, we
need this object that is lacking locally. let's see if there is
anybody with the object. now we found who claims to have the object,
let's ask that guy (and nobody else) to give the object to us".

IOW, I would have expected two functions:

 - struct odb_helper *external_odb_with(struct object_id *oid);
 - int external_odb_get(struct object_id *oid, struct odb_helper *odb);

where the latter may start like

    if (!odb) {
	odb = external_odb_with(oid);
	if (!odb)
	    return -1;
    }
    ... go ask that odb for the object ...

> diff --git a/external-odb.h b/external-odb.h
> new file mode 100644
> index 0000000000..9989490c9e
> --- /dev/null
> +++ b/external-odb.h
> @@ -0,0 +1,8 @@
> +#ifndef EXTERNAL_ODB_H
> +#define EXTERNAL_ODB_H
> +
> +const char *external_odb_root(void);
> +int external_odb_has_object(const unsigned char *sha1);
> +int external_odb_get_object(const unsigned char *sha1);

Even though ancient codebase of ours deliberately omitted them, I
think our recent trend is to explicitly spell "extern " in headers.

> diff --git a/odb-helper.h b/odb-helper.h
> new file mode 100644
> index 0000000000..5800661704
> --- /dev/null
> +++ b/odb-helper.h

Likewise.
