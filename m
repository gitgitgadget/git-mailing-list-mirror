Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BEEC433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 23:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA9CD20776
	for <git@archiver.kernel.org>; Fri, 29 May 2020 23:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="koAhgyil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgE2XAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 19:00:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59123 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE2XAq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 19:00:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BAFC55265E;
        Fri, 29 May 2020 19:00:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ntavNvttp84dczu4QJ72sv5ZVJY=; b=koAhgy
        ilA4TVQYLLR1mqcUN/YIh2RxcNDVhY6szNwMZ2GiS/MX/7xtXldki03xBgIwXHoF
        FmQXtX18RXkEbbg1lZ8+czRBZR2i1GXDKP6PDS4h/LiAjq0KKbKY5RLwc6K0o+4S
        /W4ex6L2rrgi2bL5ikbWwHVk2c3jWwFQNiKto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VpIOJpqRvihnrgdozdThrSX7HFPU0o5m
        2w2o367Ku4GQIu9uBVD3P1Q+A6YvZKhb/DGFj175Y1DmIW4M7+eV1M6PcE099btj
        LIQaib6WcFekHfKiKt9oBOU27WAYQ1oCQNKX8wdjvI5Ozy+xODRBDoXHTvJk7GQ5
        9QBIbu3rnzs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B35925265D;
        Fri, 29 May 2020 19:00:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 408B15265A;
        Fri, 29 May 2020 19:00:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/8] http: use --stdin when getting dumb HTTP pack
References: <cover.1590789428.git.jonathantanmy@google.com>
        <4d17d560b87746acfd62ff785cc22c09600d4e65.1590789428.git.jonathantanmy@google.com>
Date:   Fri, 29 May 2020 16:00:41 -0700
In-Reply-To: <4d17d560b87746acfd62ff785cc22c09600d4e65.1590789428.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 29 May 2020 15:30:13 -0700")
Message-ID: <xmqqmu5qxs6e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38AD9654-A200-11EA-B493-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When Git fetches a pack using dumb HTTP, it reuses the server's name for
> the packfile (which incorporates a hash), which is different from the
> behavior of fetch-pack and receive-pack.

My first two reads of the above mistakenly thought that for some
reason the packfile has the URL to the server encoded in its name,
but that is not what you meant by "the server's name".  You rather
meant "the name the server stores the packfile under", "the name the
server gave the packfile", "it reuses the name the server uses for
the packfile".  The last rephrase may be the easiest to understand.

> A subsequent patch will allow downloading packs over HTTP(S) as part of
> a fetch. These downloads will not necessarily be from a Git repository,
> and thus may not have a hash as part of its name.

A location that is not necessarily a Git repository can still honor
the naming convention, so I find this a bit weak argument.  After
all, the procedure to prepare such a CDN backed file would be using
Git and the (git) "natural" name for the resulting packfile is
easily available to it, isn't it?

I am not necessarily against loosening the limitation of the shape
of the filename, but we may want to say the reason why we want to
name the packfile on the CDN side differently from how Git would
naturally name them.  What benefit would we get out from geing able
to do so?  Perhaps it makes arrangements such as "you can fetch
'pack-v1.0.pack' to become reasonably up-to-date if you at least
have the version v1.0 software", "if the last time you fetched from
us was 2020-05-20 or after, you can fetch 'pack-2020-05-20.pack' and
be assured that you aren't missing anything", etc.?  Such a "why
would somebody want to name the packfile differently" would make a
more convincing justification.

> Thus, teach http to pass --stdin to index-pack, so that we have no
> reliance on the server's name for the packfile.

OK.  By definition, if we feed the packdata via --stdin, the
index-pack command would not even _know_ what the filename we use,
or the name the other side had.  Makes sense.

