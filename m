Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5185AC433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 22:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2305F206A5
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 22:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rN8expl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgGJWCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:02:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55423 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgGJWCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 18:02:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 609E2D2B3E;
        Fri, 10 Jul 2020 18:02:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tEinbBYhmVA5ZAI4JUgQ2KUQA1Q=; b=rN8exp
        l3Gu+KVB7C4Zjmjy0XbwA+Pk5BDJwihROFCICxQZI2LZxqjPBlzu9NBScELfz5jk
        s8CERe4VugezxWiCaeTh3MawjOHtZshXb70wqGQ8klT7I4XdzJ4BWFbAzNs1M4Qr
        PvDcQZOBgN7ut/ssdiZ3RFyF6KLITFE8xr9DU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m0b+rTK2UwbY9dv9/gG5xbLMsuIFQnl/
        q6IbH3qZPwl8aQRl58j/i/mi1V7rzZ/I5dgBkCrQV+Z50Rs3SC6fevI3DbVKQBF5
        hjksRkfkwgtpiJtkjJI8TJQI8AtO6st54wufjLPLmz3TJBJnDHT6JEvJlcxB2R3m
        siKI7/BfEXE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58F8FD2B3C;
        Fri, 10 Jul 2020 18:02:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9B86CD2B38;
        Fri, 10 Jul 2020 18:02:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 0/4] deterministic commit timestamps in tests
References: <20200709203336.GA2748777@coredump.intra.peff.net>
Date:   Fri, 10 Jul 2020 15:02:01 -0700
In-Reply-To: <20200709203336.GA2748777@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 9 Jul 2020 16:33:36 -0400")
Message-ID: <xmqqa707rpuu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCC2AD4A-C2F8-11EA-B568-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Most tests use test_tick or test_commit to get deterministic timestamps
> in commits. Some don't because they don't care about the timestamps. But
> they can still be annoying to debug, since the output changes from run
> to run.
>
> This series sets a default timestamp for those scripts, in a way that
> doesn't interfere with anybody using test_tick. The change is in the
> final commit. The others are preparatory to deal with fallout in the
> test suite. Normally fallout would give me pause about whether this is a
> good idea, but a) there's not much of it and b) I think it helped shake
> out questionable assumptions in those tests.
>
> This a replacement for the patches being discussed in:
>
>   https://lore.kernel.org/git/pull.816.git.git.1594149804313.gitgitgadget@gmail.com/
>
> It looks like Junio already picked up one of the fixes as
> jk/t6000-timestamp-fix. The first patch here is identical (so we can
> either drop that branch, or drop the first patch from this series and
> apply on top).
>
>   [1/4]: t6000: use test_tick consistently
>   [2/4]: t9700: loosen ident timezone regex
>   [3/4]: t5539: make timestamp requirements more explicit
>   [4/4]: test-lib: set deterministic default author/committer date
>
>  t/t5539-fetch-http-shallow.sh | 4 +++-
>  t/t6000-rev-list-misc.sh      | 7 +++++--
>  t/t9700/test.pl               | 6 +++---
>  t/test-lib.sh                 | 3 +++
>  4 files changed, 14 insertions(+), 6 deletions(-)
>
> -Peff

I have this queued on top for today's integration run.  The last
step is something worth doing in the longer term, but certainly not
for the upcoming release ;-).

-- >8 --
Subject: [PATCH] BANDAID: t9100.17 & t9100.18

---
 t/t9100-git-svn-basic.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 2c309a57d9..33ea813585 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -8,6 +8,8 @@ GIT_SVN_LC_ALL=${LC_ALL:-$LANG}
 
 . ./lib-git-svn.sh
 
+unset GIT_AUTHOR_DATE GIT_COMMITTER_DATE
+
 case "$GIT_SVN_LC_ALL" in
 *.UTF-8)
 	test_set_prereq UTF8
-- 
2.28.0-rc0

