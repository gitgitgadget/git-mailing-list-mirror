Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF185C61DA3
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 01:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjCDBq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 20:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDBq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 20:46:26 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AB3BB9F
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 17:46:25 -0800 (PST)
Received: (qmail 8862 invoked by uid 109); 4 Mar 2023 01:46:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Mar 2023 01:46:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 611 invoked by uid 111); 4 Mar 2023 01:46:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Mar 2023 20:46:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Mar 2023 20:46:24 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Henry <git@drmikehenry.com>, git@vger.kernel.org
Subject: Re: `git bundle create -` may not write to `stdout`
Message-ID: <ZAKi8MzGWk5PZUJk@coredump.intra.peff.net>
References: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
 <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net>
 <xmqqv8jhcvrq.fsf@gitster.g>
 <ZAJ6oI3clNH2O3R7@coredump.intra.peff.net>
 <xmqqpm9pcu6t.fsf@gitster.g>
 <ZAKexHiit5vOmv7M@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAKexHiit5vOmv7M@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2023 at 08:28:36PM -0500, Jeff King wrote:

> > Given that the other three subcommands also take <file>
> > 
> >     'git bundle' create [-q | --quiet | --progress | --all-progress] ...
> >                         [--version=<version>] <file> <git-rev-list-args>
> >     'git bundle' verify [-q | --quiet] <file>
> >     'git bundle' list-heads <file> [<refname>...]
> >     'git bundle' unbundle [--progress] <file> [<refname>...]
> > 
> > but read_bundle_header() function all three calls begins like so:
> > 
> >     int read_bundle_header(const char *path, struct bundle_header *header)
> >     {
> >             int fd = open(path, O_RDONLY);
> > 
> >             if (fd < 0)
> >                     return error(_("could not open '%s'"), path);
> >             return read_bundle_header_fd(fd, header, path);
> >     }
> > 
> > this function needs to be fixed first ;-)
> 
> I wasn't thinking of changing the behavior for input, but just focusing
> the docs in the right spot (the "create" option), like:

Oh, hmph. I didn't realize that both my patch and yours are touching a
shared options-parser that affects both reading and writing. So the
patch by itself is fixing "git bundle create -" but breaking "git bundle
verify -". We either need to teach the reading side to handle "-", or we
have to teach parse_options_cmd_bundle() to handle the two cases
differently.

-Peff
