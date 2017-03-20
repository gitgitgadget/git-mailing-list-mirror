Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BDEF20958
	for <e@80x24.org>; Mon, 20 Mar 2017 17:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755636AbdCTRZn (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 13:25:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62870 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754166AbdCTRZm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 13:25:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92EA97A608;
        Mon, 20 Mar 2017 13:25:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FjJbEpiNur5+5BS4Q5tosggQb2s=; b=E/GxmJ
        o9Kmf5n+zWT6UT0kNFVqEDIpSfsJqI+jL7P0zD3dNPiiDV7/WWUfrsS5EyV89neu
        +Odo3XaMPZw+JdHOwVGdecg2m5oPA5qBQPkbI/Mk9eoHTZjZrzN/xDNQS2Pw+jMC
        B6xC9tKT0K8F2EBJX/wOhkrW5fBwAxGoLFxWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dn4a781TX23MBOsR9zFCjdEzA8Iucl5d
        6p0DGdg6lrvvT3Kkw/lkkJhoeIx3jEoykiLHh2Pl41BDyAcEsBNNO4jjbBSxH9rx
        gBHEpSY6VlQ7jkwBbUP5NUEz91XGCVr/idSdKARKDhFcT4ewHlSWdwrJBwbQkuyU
        oHS/4q/R45o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BFB47A607;
        Mon, 20 Mar 2017 13:25:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E4B907A606;
        Mon, 20 Mar 2017 13:25:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        David Turner <novalis@novalis.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/20] Separate `ref_cache` into a separate module
References: <cover.1490026594.git.mhagger@alum.mit.edu>
Date:   Mon, 20 Mar 2017 10:25:37 -0700
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu> (Michael Haggerty's
        message of "Mon, 20 Mar 2017 17:33:05 +0100")
Message-ID: <xmqqo9wvx3la.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C805646-0D92-11E7-8FEC-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> * (And the main goal): Avoid reading and parsing the *whole
>   `packed-refs` file* (as we do now) every time any part of it is
>   needed. Instead, use binary search to find the reference and/or
>   range of references that we want, and parse the info out of the
>   mmapped image on the fly.

Oooohh....  Juicy.

> This patch series extracts a `ref_cache` module out of
> `files_ref_cache`, and goes some way to disentangling those two
> modules, which until now were overly intimate with each other:
>
> * Remove `verify_refname_available()` from the refs VTABLE, instead
>   implementing it in a generic way that uses only the usual refs API
>   to talk to the `ref_store`.
>
> * Split `ref_cache`-related code into a new module,
>   `refs/ref-cache.{c,h}`. Encapsulate the data structure in a new
>   class, `struct ref_cache`.
>
> * Change the lazy-filling mechanism of `ref_cache` to call back to its
>   backing `ref_store` via a callback function rather than calling
>   `read_loose_refs()` directly.

Nice.

> * Move the special handling of `refs/bisect/` from `ref_cache` to
>   `files_ref_store`.
>
> * Make `cache_ref_iterator_begin()` smarter, and change external users
>   to iterate via this interface instead of using
>   `do_for_each_entry_in_dir()`.
>
> Even after this patch series, the modules are still too intimate for
> my taste, but I think this is a big step forward, and it is enough to
> allow the other changes that I've been working on.
>
> These patches depend on Duy's nd/files-backend-git-dir branch, v6 [2].
> They are also available from my GitHub fork [1] as branch
> `separate-ref-cache`.
>
> Happily, this patch series actually removes a few more lines than it
> adds, mostly thanks to the simpler `verify_refname_available()`
> implementation.

Thanks.
