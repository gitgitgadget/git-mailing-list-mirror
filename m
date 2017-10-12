Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46C220372
	for <e@80x24.org>; Thu, 12 Oct 2017 12:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757058AbdJLMb5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 08:31:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:50840 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1757588AbdJLMbz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 08:31:55 -0400
Received: (qmail 12769 invoked by uid 109); 12 Oct 2017 12:31:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 12:31:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15105 invoked by uid 111); 12 Oct 2017 12:31:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 08:31:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Oct 2017 08:31:53 -0400
Date:   Thu, 12 Oct 2017 08:31:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk
 configuration
Message-ID: <20171012123153.i265nun6pklw7kjg@sigill.intra.peff.net>
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
 <20171012021007.7441-1-gitster@pobox.com>
 <20171012021007.7441-2-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171012021007.7441-2-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 11:10:06AM +0900, Junio C Hamano wrote:

> From: Jeff King <peff@peff.net>
> 
> An earlier patch downgraded "always" that comes via the ui.color
> configuration variable to "auto", in order to work around an
> unfortunate regression to "git add -i".
> 
> That "fix" however regressed other third-party tools that depend on
> "git -c color.ui=always cmd" as the way to defeat any end-user
> configuration and force coloured output from git subcommand, even
> when the output does not go to a terminal.
> 
> It is a bit ugly to treat "-c color.ui=always" from the command line
> differently from a definition that comes from on-disk configuration
> files, but it is a moral equivalent of "--color=always" option given
> to the subcommand from the command line, i.e. a signal that tells us
> that the script writer knows what s/he is doing.  So let's take that
> route to unbreak this case while defeating a (now declared to be)
> misguided color.ui that is set to always in the configuration file.
> 
> NEEDS-SIGN-OFF-BY: Jeff King <peff@peff.net>

Signed-off-by: Jeff King <peff@peff.net>

Thanks for picking this up. I meant to get to it yesterday but ran out
of time. Your description looks good to me.

>  color.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

We should probably protect the command-line behavior with a test. Can
you squash this in?

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 25a9c65dc5..582cab5c8a 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -261,6 +261,17 @@ test_expect_success 'rev-list %C(auto,...) respects --color' '
 	test_cmp expect actual
 '
 
+test_expect_success "color.ui=always in config file same as auto" '
+	test_config color.ui always &&
+	git log --format=$COLOR -1 >actual &&
+	has_no_color actual
+'
+
+test_expect_success "color.ui=always on command-line is always" '
+	git -c color.ui=always log --format=$COLOR -1 >actual &&
+	has_color actual
+'
+
 iconv -f utf-8 -t $test_encoding > commit-msg <<EOF
 Test printing of complex bodies
 

Technically the first test is already covered by the "add -p" we added
elsewhere, but I think the sequence make sit easier to understand. Also
as an aside, I think this patch means that:

  git -c color.ui=always add -p

is broken (as would a hypothetical "git --default-color=always add -p").
That's sufficiently insane that I'm not sure we should care about it.

-Peff
