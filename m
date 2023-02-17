Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37577C61DA4
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 00:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjBQAvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 19:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjBQAvR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 19:51:17 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C2255E7D
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 16:50:59 -0800 (PST)
Received: (qmail 1006 invoked by uid 109); 17 Feb 2023 00:50:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Feb 2023 00:50:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14587 invoked by uid 111); 17 Feb 2023 00:50:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Feb 2023 19:50:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Feb 2023 19:50:58 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Raul E Rangel <rrangel@chromium.org>, git@vger.kernel.org
Subject: Re: Feature request: Add --mtime option to git archive
Message-ID: <Y+7PcqpYhF5ZuApG@coredump.intra.peff.net>
References: <Y+6G9n6cWRT9EKyl@google.com>
 <Y+6akicTFG9n0eZy@coredump.intra.peff.net>
 <xmqq5yc1p7yn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yc1p7yn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 02:21:36PM -0800, Junio C Hamano wrote:

> >> When generating a tarball with `git archive <tree>`, `git archive` will
> >> use the current time as the mtime. This results in a non-hermetic
> >> tarball. Could we should add a --mtime option that allows passing in
> >> the time? 
> >
> > That seems like a very reasonable feature to have. Just to sketch out
> > the implementation, in case anybody wants to work on it: ...
> 
> There has been a discussion on not just "fix mtime" but coming up
> with a lot more stable tar archive format specification.

Yes, I think in brian's proposal the mtime would always be 0. I don't
mind that either (and really, I doubt anybody would really want to set
--mtime to anything but a fixed, known value anyway). This is a much
smaller change that could be done in the meantime with less effort, but
I guess we'd be stuck with --mtime forever, then.

A similar option in is to simply start using "0" in the meantime, like:

diff --git a/archive.c b/archive.c
index 81ff76fce9..48d89785c3 100644
--- a/archive.c
+++ b/archive.c
@@ -470,7 +470,7 @@ static void parse_treeish_arg(const char **argv,
 		archive_time = commit->date;
 	} else {
 		commit_oid = NULL;
-		archive_time = time(NULL);
+		archive_time = 0;
 	}
 
 	tree = parse_tree_indirect(&oid);

Nobody will complain about changing the byte-for-byte format, since by definition it
was already changing once per second (cue somebody complaining that they
have been using LD_PRELOAD tricks to simulate --mtime).

I do wonder if people would complain (both with the patch above and with
brian's proposal) that the resulting tarballs extract everything with a
date in 1970. That's not functionally a problem, but it looks kind of
weird in "ls -l".

-Peff
