Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B960C433DF
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 16:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C470620738
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 16:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P0et444q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgFBQts (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:49:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56975 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBQts (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 12:49:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92FCC6AF26;
        Tue,  2 Jun 2020 12:49:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fD+fWvENcmV2oth93VBWF/Kx/3o=; b=P0et44
        4qM/5TlwCePl3rkHM6ebYXdZbVY0BSBfnPnKm2uNLqC7siDgvVEISrl1cbV28zzi
        LdHUL/c+B7oqHV/uoCLg6SQ8hSohoJfkKBVNBYt/tMuzugjMXLk6aLPsITSGqcHa
        OeUrEEqBEuCRM3iTmZGyfqixHVOwrwWm1L1h8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bLkvpiWgYTGig4ALdmr4A407vtUHj+Dm
        /5j44f/LUR3K/Za/VyZ3w2jDYdxoR8dzjaHBDY4zP5PxTLejbGq1skD6idJCSkTR
        Rt1gR2c9Iw+T8nQLdTtJh7N/M+CYDS59uAUUrZ9hxeEJQcosNvo3xC+VZLbxhE0Y
        7IhaLq8dT0Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B12C6AF25;
        Tue,  2 Jun 2020 12:49:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 163E36AF24;
        Tue,  2 Jun 2020 12:49:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jan Christoph Uhde <Jan@UhdeJc.com>, git@vger.kernel.org
Subject: Re: [PATCH] diff: discard blob data from stat-unmatched pairs
References: <54a3a798-0387-64df-be20-af69db124042@UhdeJc.com>
        <20200601044511.GA2529317@coredump.intra.peff.net>
        <cfc79aec-ec85-dbec-e37b-6b7035b4c5a4@UhdeJc.com>
        <20200601165408.GA2536619@coredump.intra.peff.net>
        <20200601202218.GA2763518@coredump.intra.peff.net>
Date:   Tue, 02 Jun 2020 09:49:43 -0700
In-Reply-To: <20200601202218.GA2763518@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 1 Jun 2020 16:22:18 -0400")
Message-ID: <xmqqmu5ltntk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F6C61AA-A4F1-11EA-83F5-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] diff: discard blob data from stat-unmatched pairs
>
> When performing a tree-level diff against the working tree, we may find
> that our index stat information is dirty, so we queue a filepair to be
> examined later. If the actual content hasn't changed, we call this a
> stat-unmatch; the stat information was out of date, but there's no
> actual diff.  Normally diffcore_std() would detect and remove these
> identical filepairs via diffcore_skip_stat_unmatch().  However, when
> "--quiet" is used, we want to stop the diff as soon as we see any
> changes, so we check for stat-unmatches immediately in diff_change().
>
> That check may require us to actually load the file contents into the
> pair of diff_filespecs. If we find that the pair isn't a stat-unmatch,
> then no big deal; we'd likely load the contents later anyway to generate
> a patch, do rename detection, etc, so we want to hold on to it. But if
> it a stat-unmatch, then we have no more use for that data; the whole
> point is that we're going discard the pair. However, we never free the
> allocated diff_filespec data.

Nicely spotted.  So we can discard when quiet is in effect after
this check, which makes sense.

After reading the initial analysis, I wondered if the fix we did in
f34b205f (diff: do not quit early on stat-dirty files, 2014-01-25)
was suboptimal and we should have instead done the "if QUICK, check
if the pair is merely stat-unmatch" in the loop(s) that call
diff_change(), hoping that it may have given us a better control
over the lifetime of the filespecs in each diff_filepair, but I do
not think it would made much difference.

>  	if (options->flags.quick && options->skip_stat_unmatch &&
> -	    !diff_filespec_check_stat_unmatch(options->repo, p))
> +	    !diff_filespec_check_stat_unmatch(options->repo, p)) {
> +		diff_free_filespec_data(p->one);
> +		diff_free_filespec_data(p->two);
>  		return;
> +	}

Thanks.  Will queue (with that s/it/& is/ typofix mentioned
elsewhere).

