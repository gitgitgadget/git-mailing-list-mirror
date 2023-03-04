Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82A6C61DA4
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 01:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCDB2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 20:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCDB2l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 20:28:41 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9373E30194
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 17:28:39 -0800 (PST)
Received: (qmail 8617 invoked by uid 109); 4 Mar 2023 01:28:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Mar 2023 01:28:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 490 invoked by uid 111); 4 Mar 2023 01:28:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Mar 2023 20:28:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Mar 2023 20:28:36 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Henry <git@drmikehenry.com>, git@vger.kernel.org
Subject: Re: `git bundle create -` may not write to `stdout`
Message-ID: <ZAKexHiit5vOmv7M@coredump.intra.peff.net>
References: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
 <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net>
 <xmqqv8jhcvrq.fsf@gitster.g>
 <ZAJ6oI3clNH2O3R7@coredump.intra.peff.net>
 <xmqqpm9pcu6t.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpm9pcu6t.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2023 at 03:05:14PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This test looks good to me. Let's also not forget about the doc fixes. I
> > don't think there's much urgency to get this into v2.40,
> 
> Doc?  Meaning 
> 
> 	<file> can be "-" to mean the standard output (for writing)
> 	or the standard input (for reading)
> 
> or something?

Yeah, I was referring to my earlier mail in the thread, which said:

>> So it seems like we'd want a three-patch series:
>> 
>>   1. The first hunk I showed above, along with a test to demonstrate the
>>      fix.
>> 
>>   2. Remove bogus references to --stdout in the docs.
>> 
>>   3. Document "-".

Your patch is (1), but we'd want (2) and (3) still.

> Given that the other three subcommands also take <file>
> 
>     'git bundle' create [-q | --quiet | --progress | --all-progress] ...
>                         [--version=<version>] <file> <git-rev-list-args>
>     'git bundle' verify [-q | --quiet] <file>
>     'git bundle' list-heads <file> [<refname>...]
>     'git bundle' unbundle [--progress] <file> [<refname>...]
> 
> but read_bundle_header() function all three calls begins like so:
> 
>     int read_bundle_header(const char *path, struct bundle_header *header)
>     {
>             int fd = open(path, O_RDONLY);
> 
>             if (fd < 0)
>                     return error(_("could not open '%s'"), path);
>             return read_bundle_header_fd(fd, header, path);
>     }
> 
> this function needs to be fixed first ;-)

I wasn't thinking of changing the behavior for input, but just focusing
the docs in the right spot (the "create" option), like:

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 18a022b4b4..ea6b5c24d1 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -65,9 +65,9 @@ OPTIONS
 create [options] <file> <git-rev-list-args>::
 	Used to create a bundle named 'file'.  This requires the
 	'<git-rev-list-args>' arguments to define the bundle contents.
 	'options' contains the options specific to the 'git bundle create'
-	subcommand.
+	subcommand. If 'file' is `-`, the bundle is written to stdout.
 
 verify <file>::
 	Used to check that a bundle file is valid and will apply
 	cleanly to the current repository.  This includes checks on the

> > but I can put
> > it together in the next day or three.
> 
> Thanks.  Just for reference, here is what I have (just a log
> message, the patch is the same and does not support input yet).

I don't mind supporting "-" for input, but I don't think it's strictly
necessary and nobody is really asking for it. I'm also not sure it won't
run afoul of problems in the lower-level code. I seem to recall that the
bundle code may want to seek() on read, but a quick grep doesn't seem to
turn anything up (so I'm not sure if I'm mis-remembering or just didn't
look hard enough).

> ----- >8 -----
> Subject: [PATCH] bundle: don't blindly apply prefix_filename() to "-"

Thanks.

-Peff
