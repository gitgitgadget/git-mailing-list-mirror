Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270E5C33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 07:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F303020702
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 07:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgA3HRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 02:17:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:48144 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725798AbgA3HRB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 02:17:01 -0500
Received: (qmail 21650 invoked by uid 109); 30 Jan 2020 07:17:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Jan 2020 07:17:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21410 invoked by uid 111); 30 Jan 2020 07:24:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jan 2020 02:24:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jan 2020 02:17:00 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David =?utf-8?B?QnVyc3Ryw7Zt?= <davidburstrom@spotify.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] sha1-name: mark get_oid() error messages for
 translation
Message-ID: <20200130071700.GB2189233@coredump.intra.peff.net>
References: <20200125000542.GA566779@coredump.intra.peff.net>
 <20200125001301.GC567109@coredump.intra.peff.net>
 <xmqqpnf2dk6m.fsf@gitster-ct.c.googlers.com>
 <xmqqimkudjmt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqimkudjmt.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 01:42:50PM -0800, Junio C Hamano wrote:

> >> -	fatal: Path '$2$3' $4, but not ${5:-$SQ$3$SQ}.
> >> -	Did you mean '$1:$2$3'${2:+ aka $SQ$1:./$3$SQ}?
> >> +	fatal: path '$2$3' $4, but not ${5:-$SQ$3$SQ}
> >> +	hint: Did you mean '$1:$2$3'${2:+ aka $SQ$1:./$3$SQ}?
> >>  	EOF
> >>  	test_cmp expected error
> >
> > ...this obviously would not allow GIT_TEST_GETTEXT_POISON test to
> > pass.  And ...

Hrmph. I know I tested with GETTEXT_POISON, but you are obviously right
that this doesn't pass. I must have botched something in one of my
rebase passes at the end.

Thanks for catching it, but...

> I'll queue this band-aid on top before making my last pushout for
> the day.  Even with poisoned i18n/l10n, die(_(msg)) gives "fatal:"
> prefix at the beginning, so that is what test_did_you_mean would
> expect to see from a passing test under GIT_TEST_GETTEXT_POISON.
> 
> The other hunk is about a test that greps in "error".

I think we can do this much more simply, by just using i18ncmp:

diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index c2b5125c12..62085a89e3 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -12,7 +12,7 @@ test_did_you_mean ()
 	fatal: path '$2$3' $4, but not ${5:-$SQ$3$SQ}
 	hint: Did you mean '$1:$2$3'${2:+ aka $SQ$1:./$3$SQ}?
 	EOF
-	test_cmp expected error
+	test_i18ncmp expected error
 }
 
 HASH_file=

(we'd still need the s/grep/test_i18ngrep/ in your second hunk).

-Peff
