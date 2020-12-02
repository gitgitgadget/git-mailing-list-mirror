Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D760C64E8A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 02:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088DA206A5
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 02:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgLBC1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 21:27:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:48248 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgLBC1G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 21:27:06 -0500
Received: (qmail 29902 invoked by uid 109); 2 Dec 2020 02:26:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Dec 2020 02:26:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3050 invoked by uid 111); 2 Dec 2020 02:26:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 21:26:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 21:26:24 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] .gitignore: remove dangling file
Message-ID: <X8b7UMcsfaD0OFv4@coredump.intra.peff.net>
References: <20201201004649.57548-1-felipe.contreras@gmail.com>
 <20201201004649.57548-3-felipe.contreras@gmail.com>
 <xmqqczztqszv.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqczztqszv.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 10:30:12AM -0800, Junio C Hamano wrote:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > The library was removed 7 years ago on commit ae34ac126f. But not from
> > the .gitignore file.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> 
> Good eyes.  Any automation used here, or just mark I eyeballs?

I was curious how hard it would be to find unused ones, and it is not
too bad:

  find * -type f |
  git check-ignore --stdin -v |
  perl -e '
    my $ignore_file = shift;
    while (<>) {
      /^\Q$ignore_file\E:(\d+)/ and $seen{$1} = 1;
    }
    open(my $fh, "<", $ignore_file);
    while (<$fh>) {
      print "$. $_" unless $seen{$.};
    }
  ' .gitignore

It turns up many hits, depending on what built cruft you have in your
directory (having a crufty state is nice because it shows which patterns
are used, but it also may mean you have leftover trash from old versions
that doesn't get built anymore, and which we wouldn't notice). So I
think a human has to apply some brain-power to the result to see which
ones are plausibly created by other people's environments.

You might want to revisit some of the old dist rules (do we still ever
build git-core-*? "make dist" doesn't seem to. Likewise, "make rpm" and
"make deb" are no more, so perhaps it's time to drop those ignores.

The one below didn't take much brain-power, though.

-- >8 --
Subject: [PATCH] gitignore: drop duplicate entry for git-sh-i18n

This was accidentally added by e00cf070a4 (git-sh-i18n.sh: add no-op
gettext() and eval_gettext() wrappers, 2011-05-14), even though an
earlier commit in the same series had already done so.

Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index f85d02c854..d20d4afc1d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -152,7 +152,6 @@
 /git-sh-i18n
 /git-sh-i18n--envsubst
 /git-sh-setup
-/git-sh-i18n
 /git-shell
 /git-shortlog
 /git-show
-- 
2.29.2.894.g2dadb8c6b8

