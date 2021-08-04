Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558B8C432BE
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 17:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E4061008
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 17:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbhHDRpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 13:45:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58085 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237890AbhHDRpU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 13:45:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B666E14EABA;
        Wed,  4 Aug 2021 13:45:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=naqkSSu8kWCQXByLZkVQFr3mpSNm0k8Uf6M80V
        RJ+nw=; b=fpS8qGA66LqWgvmQ61deU0fuJAh+PJQoyxcxIcg6Ysbg+b1lWntrOJ
        42VdNMOwLkn2pQso+jCQLX28PALJqoXWYEzGM2TPQGv9O0dwAEAkjW+jIRhidn8Q
        wqROSlqYlIXXWXGoSIOGeq1zSeYW9atgJt85Modu5CjLOtYy7lB2k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ADF0D14EAB9;
        Wed,  4 Aug 2021 13:45:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E668D14EAB7;
        Wed,  4 Aug 2021 13:45:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: speed up loading of refs via commit graph
References: <08519b8ab6f395cffbcd5e530bfba6aaf64241a2.1628085347.git.ps@pks.im>
Date:   Wed, 04 Aug 2021 10:45:02 -0700
In-Reply-To: <08519b8ab6f395cffbcd5e530bfba6aaf64241a2.1628085347.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 4 Aug 2021 15:56:11 +0200")
Message-ID: <xmqqczqtp0ip.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B39B9FC4-F54B-11EB-B38B-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> -	if (type == OBJ_COMMIT)
> -		return (struct commit *) parse_object(the_repository, oid);
> +
> +	if (type == OBJ_COMMIT) {
> +		struct commit *commit = lookup_commit(the_repository, oid);
> +		if (!commit || repo_parse_commit(the_repository, commit))
> +			return NULL;
> +		return commit;
> +	}

OK.

Asking parse_object() to turn an object name to an in-core instance
of the object is a pretty much standard and generic idiom, but in
this codepath, we have already asked for the type and know it must
be a commit, so asking parse_commit() that is more specialized makes
quite a lot of sense.

Thanks.
