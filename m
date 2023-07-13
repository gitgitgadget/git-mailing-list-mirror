Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA11C001B0
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 17:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjGMRC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 13:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGMRC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 13:02:27 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43962683
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 10:02:26 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B99E1A9D43;
        Thu, 13 Jul 2023 13:02:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ekjf7FdL7TCl1LW/6CjMqTT6tWHsnHNlojjWKQ
        McO7Q=; b=Cb4WCMKPOgJVjKyDBmccGpcdwFUb8QL1UFdF5rrbmuVDu9YYbIjC6C
        JlayUiJbrjkafjEzhEsTqovmV5FL5YmLuk5YyBisQJiXR8VsCsBxN6UZhd1KJsHG
        lRUOx7Nu6K5psMOVH7RI8UxhwKeDHqE9tdJWSPco88DOsnZjVEz+s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50C501A9D40;
        Thu, 13 Jul 2023 13:02:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC1051A9D3F;
        Thu, 13 Jul 2023 13:02:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Herrmann <aherrmann@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] configure.ac: Don't overwrite NO_EXPAT option
References: <20230713074654.23957-1-aherrmann@suse.de>
Date:   Thu, 13 Jul 2023 10:02:17 -0700
In-Reply-To: <20230713074654.23957-1-aherrmann@suse.de> (Andreas Herrmann's
        message of "Thu, 13 Jul 2023 09:45:41 +0200")
Message-ID: <xmqqwmz3pwx2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 067958AE-219F-11EE-A94C-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Herrmann <aherrmann@suse.de> writes:

> Subject: Re: [PATCH] configure.ac: Don't overwrite NO_EXPAT option

Downcase "D" in "Don't" (cf. "git log --oneline --no-merges
--since=2.months"), please.

> Even if 'configure --with-expat=no' was run, expat support is used,
> because library detection overwrites it. Avoid this overwrite.

As I suspect that "configure" is not used a part of any experienced
Git developers' daily development cycle, it is unfortunately very
understandable how this left unnoticed for so long, ever since
424adc50 (autoconf: Move variables which we always set to
config.mak.in, 2006-08-08), if I am reading the patch correctly, as
a part of the very beginning of autoconf support.

Thanks for spotting it, and the fix look straight-forward.

> (I think, configure should obey what the user has specified.)

Sure, but please rephrase this parenthesized sentence.

 * if you are unsure, and leaning to negative, say that below the
   three-dash line.  No need for (parentheses).

 * otherwise, lose the (parentheses), "I think", and in general be
   more assertive.

The latter is more preferrable.  The sentence with "I think" is your
proposal to make it the project policy to make sure that ./configure
script honors what the user gave it.  If other developers disagree
with the policy you propose there, they will object and give their
reason during their reviews.  If we adopt it as the project policy,
which I personally think is very sensible, it is good to have it
stated not as a mere personal opinion of the author of a commit, but
more as a general rule.

Having said all that, I have some further observation.

The NO_EXPAT support does not look *so* special.  It is split into
two parts:

 * Use AC_ARG_WITH(expat) to handle "--with-expat"

 * AC_CHECK_LIB([expat]) to auto-detect NO_EXPAT

Aren't there other symbols that share the same pattern?  For
example, how well do NO_CURL or NO_ICONV (which I picked because
AC_ARG_WITH(curl) comes before and AC_ARG_WITH(iconv) comes after
AC_ARG_WITH(expat)) work?  Do they share the same issue?

A quick "git grep AC_ARG_WITH" finds openssl, libpcre*, and tcltk
also share the same pattern, in addition to curl and iconv.  I may
be misreading the script but USE_LIBPCRE2 support looks OK.
NO_OPENSSL looks iffy, though not wrong per-se.  SHA1_Init is probed
in libcrypto and in libssl regardless of the value of NO_OPENSSL.

I do not think it is a good idea to address the same issue for some
of these other symbols, in addition to expat, in a single patch.
Let's have people review the current patch for NO_EXPAT first, and
leave the other symbols for possible follow-up patches.

Thanks.
