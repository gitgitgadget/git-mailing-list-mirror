Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7EDC433EA
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 02:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7BA720792
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 02:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WA5x5RGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387724AbgGWCE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 22:04:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58515 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731394AbgGWCE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 22:04:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1017478ABE;
        Wed, 22 Jul 2020 22:04:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Cdn5GnSzJ9rtV81eSdQag5WDHH4=; b=WA5x5R
        GrOwQFZnBeN7/QGQ6qGNi/UC1imb0jTpRoeWgOSa8Z/erheAWKLHnQUSboX1mlMV
        HBR/wkhXT8wXEzFQIq9EFEh/Hp95x9lZfuK05PB7aJHwiB+M7y23uztd0EVhOKRz
        COgaAfPAzt51kRsDWdcZP16kTBX2SaSUgt62E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QAhSZrcDZm6ZW4qFsEVBtwzekevGBmp2
        B1NmR0xGOvrngEgKCIfm6ws/gpgHQdp2D6YorAofLG5kyxoquEYXwlgYO6IHfzBp
        CTjaJcU1H2Vc6dDJ7i/ztCvUDSIGy5xSYHzBn9jVsOAptitwQWlHUYcZU2KiP0w+
        zIWSdptGigk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05ADE78ABD;
        Wed, 22 Jul 2020 22:04:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8561478ABC;
        Wed, 22 Jul 2020 22:04:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v3 32/39] setup: add support for reading extensions.objectformat
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
        <20200723010943.2329634-33-sandals@crustytoothpaste.net>
Date:   Wed, 22 Jul 2020 19:04:52 -0700
In-Reply-To: <20200723010943.2329634-33-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 23 Jul 2020 01:09:36 +0000")
Message-ID: <xmqqblk73s1n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6102624-CC88-11EA-BC2A-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> @@ -613,6 +622,11 @@ int verify_repository_format(const struct repository_format *format,
>  		return -1;
>  	}
>  
> +	if (format->version <= 0 && format->hash_algo != GIT_HASH_SHA1) {
> +		strbuf_addstr(err, _("extensions.objectFormat is not valid in repo v0"));
> +		return -1;
> +	}
> +
>  	return 0;
>  }
>  

By declaring that the repository is invalid if its version is less
than 1 and objectFormat extension defined, we prevent unwanted
upgrading from happening by mistake.

OK.

