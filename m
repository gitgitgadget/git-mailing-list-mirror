Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDADC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587CA6103D
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245751AbhIITqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:46:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60665 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245263AbhIITqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 15:46:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D488EFA74;
        Thu,  9 Sep 2021 15:45:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yQ7AxWUWzNMZWNnjRX1alfgPMMPK8C7rL08Svc
        H3Tfg=; b=VXTWyT0ACVyOuOOMPWf1J9yGJk8YaWW77wLlfVq/5/Sa2lSzsdg3jv
        04//IqC+RpvPuf0MAG+HlASANkpnmxCs9BcorGQa4kYXhggltpEbNYLUYktgcCDs
        a40SD5tXMMJLiuVY7OA2gghR+RJkrL+94YjnTlYzBrQZBG05avmL4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E84FFEFA72;
        Thu,  9 Sep 2021 15:45:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10886EFA71;
        Thu,  9 Sep 2021 15:45:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH 6/9] index-pack: refactor renaming in final()
References: <cover.1630461918.git.me@ttaylorr.com>
        <cover.1631157880.git.me@ttaylorr.com>
        <3c9b515907ecb632faf73ce8db83efed1493d1f1.1631157880.git.me@ttaylorr.com>
Date:   Thu, 09 Sep 2021 12:45:04 -0700
In-Reply-To: <3c9b515907ecb632faf73ce8db83efed1493d1f1.1631157880.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 8 Sep 2021 23:25:09 -0400")
Message-ID: <xmqq35qdzg73.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E1ACC78-11A6-11EC-B142-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> But since we've got "rev" as well now, let's do the renaming via a
> helper, this is both a net decrease in lines, and improves the
> readability,...

xyz_ may be cute, but is distracting.  I do not think it loses any
information if we used final_name, current_name, etc.; it may make
the result even easier to read.

> +static void rename_tmp_packfile(const char **final_xyz_name,
> +				const char *curr_xyz_name,
> +				struct strbuf *xyz_name, unsigned char *hash,
> +				const char *ext, int else_chmod_if)
> +{
> +	if (*final_xyz_name != curr_xyz_name) {
> +		if (!*final_xyz_name)
> +			*final_xyz_name = odb_pack_name(xyz_name, hash, ext);
> +		if (finalize_object_file(curr_xyz_name, *final_xyz_name))
> +			die(_("unable to rename temporary '*.%s' file to '%s"),
> +			    ext, *final_xyz_name);
> +	} else if (else_chmod_if) {
> +		chmod(*final_xyz_name, 0444);
> +	}
> +}

"else_chmod_if" is unclear.  The caller must be aware of what 'else'
refers to and anybody adding a new caller is forced to go look at
the body of this helper.  I think chmod (or "make_read_only")
happens only when the current one already has the final name, so
perhaps that is what the name should highlight?  

make-read-only-if-same or somesuch?

Thanks.
