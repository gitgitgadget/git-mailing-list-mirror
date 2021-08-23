Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EE4C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 18:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5798613A5
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 18:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhHWS2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 14:28:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:56926 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231788AbhHWS2U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 14:28:20 -0400
Received: (qmail 12893 invoked by uid 109); 23 Aug 2021 18:27:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Aug 2021 18:27:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31293 invoked by uid 111); 23 Aug 2021 18:27:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Aug 2021 14:27:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Aug 2021 14:27:36 -0400
From:   Jeff King <peff@peff.net>
To:     Marvin =?utf-8?Q?H=C3=A4user?= <mhaeuser@posteo.de>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] send-email propagates "In-Reply-To"
Message-ID: <YSPomC95hxZZTHRe@coredump.intra.peff.net>
References: <4db7759c-2123-533b-9f89-954c07f5832a@posteo.de>
 <YSPOOGxTMEgStdjJ@coredump.intra.peff.net>
 <5cd5a58b-ac9e-4628-a8d3-836b1f795732@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cd5a58b-ac9e-4628-a8d3-836b1f795732@posteo.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 05:44:32PM +0000, Marvin Häuser wrote:

> > Your patch looks like the right direction. Handling $references at the
> > same time is the right thing to do. The extra setting of $subject seems
> > weird, though.
> 
> Basically the idea is to either 1) advance the values (for threading)
> or 2) reset them to their defaults, i.e. never just preserve them. I
> neither know Perl nor the git design well, so I just applied the
> pattern to the subject as well. Should I just drop it? What would be
> the potential issues with enforcing the pattern?

I'm not all that familiar with the innards of git-send-email.perl
either. Looking closer, I see $subject is indeed declared outside of the
regular loop, so it would need to be reset (just like $message_id is). I
guess nobody noticed because patches almost always have their own
"Subject:" header, which would override it.

But either that should go into its own patch, or the commit message
should be modified to explain that it is covering not just
in-reply-to/references, but we think this fixes all similar variables.

> > We'd want to add a test to t/t9001-send-email.sh, too, I'd think.
> 
> I'm not home and I might need a few days to look into this. Any
> helping hand is greatly appreciated. :)

You'd want something like the patch below (and possibly something
similar for the $subject handling).

Both of the new tests fail without your patch and pass with it, but:

  - note the weird behavior I found with --in-reply-to; this is
    something we might want to address at the same time

  - applying your patch fails the earlier t9001.52 ("In-Reply-To without
    --chain-reply-to"). I didn't dig into what's going on there.

---
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 57fc10e7f8..747872d5be 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2227,6 +2227,56 @@ test_expect_success $PREREQ 'test shell expression with --sendmail-cmd' '
 	test_path_is_file commandline1
 '
 
+test_expect_success $PREREQ 'set up in-reply-to/references patches' '
+	cat >has-reply.patch <<-\EOF &&
+	From: A U Thor <author@example.com>
+	Subject: patch with in-reply-to
+	Message-ID: <patch.with.in.reply.to@example.com>
+	In-Reply-To: <replied.to@example.com>
+	References: <replied.to@example.com>
+
+	This is the body.
+	EOF
+	cat >no-reply.patch <<-\EOF
+	From: A U Thor <author@example.com>
+	Subject: patch without in-reply-to
+	Message-ID: <patch.without.in.reply.to@example.com>
+
+	This is the body.
+	EOF
+'
+
+test_expect_success $PREREQ 'patch reply headers not carried over with --no-thread' '
+	clean_fake_sendmail &&
+	git send-email \
+		--no-thread \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		has-reply.patch no-reply.patch &&
+	grep "In-Reply-To: <replied.to@example.com>" msgtxt1 &&
+	grep "References: <replied.to@example.com>" msgtxt1 &&
+	! grep replied.to@example.com msgtxt2
+'
+
+test_expect_success $PREREQ 'cmdline in-reply-to used with --no-thread' '
+	clean_fake_sendmail &&
+	git send-email \
+		--no-thread \
+		--in-reply-to="<cmdline.reply@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		has-reply.patch no-reply.patch &&
+	# what should happen with has-reply.patch here? The
+	# current behavior seems to throw away its in-file
+	# in-reply-to entirely in favor of the command line
+	# one. That seems like a bug?
+	#
+	# But definitely the second message should get the cmdline
+	# value, and not be empty.
+	grep "In-Reply-To: <cmdline.reply@example.com>" msgtxt2 &&
+	grep "References: <cmdline.reply@example.com>" msgtxt2
+'
+
 test_expect_success $PREREQ 'invoke hook' '
 	mkdir -p .git/hooks &&
 
