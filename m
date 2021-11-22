Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FFFC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 21:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbhKVVNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 16:13:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:36700 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhKVVNW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 16:13:22 -0500
Received: (qmail 22310 invoked by uid 109); 22 Nov 2021 21:10:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Nov 2021 21:10:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25558 invoked by uid 111); 22 Nov 2021 21:10:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Nov 2021 16:10:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Nov 2021 16:10:14 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 2/5] upload-archive: use regular "struct child_process"
 pattern
Message-ID: <YZwHNkf2l9uPrIJv@coredump.intra.peff.net>
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
 <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
 <patch-2.5-a411098699d-20211122T153605Z-avarab@gmail.com>
 <211122.86fsrnyko4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211122.86fsrnyko4.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 09:53:34PM +0100, Ævar Arnfjörð Bjarmason wrote:

> But as to skipping the "argc > 1" test I've got this still:
>     
>     @@ -89,9 +89,11 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
>              * multiplexed out to our fd#1.  If the child dies, we tell the other
>              * end over channel #3.
>              */
>     -       argv[0] = "upload-archive--writer";
>             writer.out = writer.err = -1;
>             writer.git_cmd = 1;
>     +       strvec_push(&writer.args, "upload-archive--writer");
>     +       if (argc > 1)
>     +               strvec_pushv(&writer.args, argv + 1);
>             if (start_command(&writer)) {
>                     int err = errno;
>                     packet_write_fmt(1, "NACK unable to spawn subprocess\n");
> 
> We'll segfault if we give NULL to strvec_pushv() so we still need that
> check. Were you thinking of strvec_pushl(), or am I missing something?

We wouldn't be giving NULL to strvec_pushv(). We'd be giving argv+1,
which is guaranteed non-NULL, but may point to NULL. In that case the
loop condition in strvec_pushv() would turn it into a noop.

-Peff
