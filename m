Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E64182023D
	for <e@80x24.org>; Wed, 17 May 2017 05:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbdEQFo3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 01:44:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:53329 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753243AbdEQFo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 01:44:28 -0400
Received: (qmail 7734 invoked by uid 109); 17 May 2017 05:44:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 05:44:27 +0000
Received: (qmail 5313 invoked by uid 111); 17 May 2017 05:45:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 01:45:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 May 2017 01:44:25 -0400
Date:   Wed, 17 May 2017 01:44:25 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: t5400 failure on Windows
Message-ID: <20170517054424.cq66cl5ukvhsz34y@sigill.intra.peff.net>
References: <50f6d8b7-383b-7673-22ad-9a9b80bec2d1@kdbg.org>
 <20170515222406.hxab2wrapv75ybmj@sigill.intra.peff.net>
 <afca6bf5-472e-dda4-2c16-a2256080ac51@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afca6bf5-472e-dda4-2c16-a2256080ac51@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 08:35:46PM +0200, Johannes Sixt wrote:

> Am 16.05.2017 um 00:24 schrieb Jeff King:
> >    4. There is something racy and unportable about both programs writing
> >       to the same trace file. It's opened with O_APPEND, which means that
> >       each write should atomically position the pointer at the end of the
> >       file. Is it possible there's a problem with that in the way
> >       O_APPEND works on Windows?
> > 
> >       If that was the case, though, I'd generally expect a sheared write
> >       or a partial overwrite. The two origin/HEAD lines from the two
> >       programs are the exact same length, but I'd find it more likely for
> >       the overwrite to happen with one of the follow-on lines.
> 
> Good guesswork! O_APPEND is not atomic on Windows, in particular, it is
> emulated as lseek(SEEK_END) followed by write().
> 
> I ran the test a few more times, and it fails in different ways (different
> missing lines) and also succeeds in a minority of the cases.

OK, that definitely explains it, then.

> Windows is capable of writing atomically in the way O_APPEND requires
> (keyword: FILE_APPEND_DATA), but I do not see a way to wedge this into the
> emulation layer. For the time being, I think I have to skip the test case.

I wonder if there's a way we could convince the trace for the two
programs to go to separate locations. We don't care about receive-pack's
trace at all. So maybe:

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 3331e0f53..d375d7110 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -288,7 +288,10 @@ test_expect_success 'receive-pack de-dupes .have lines' '
 	$shared .have
 	EOF
 
-	GIT_TRACE_PACKET=$(pwd)/trace git push fork HEAD:foo &&
+	GIT_TRACE_PACKET=$(pwd)/trace \
+	    git push \
+		--receive-pack="unset GIT_TRACE_PACKET; git-receive-pack" \
+		fork HEAD:foo &&
 	extract_ref_advertisement <trace >refs &&
 	test_cmp expect refs
 '

> The question remains how endangered our uses of O_APPEND are when the POSIX
> semantics are not obeyed precisely:
> 
> * trace.c: It is about debugging. Not critical.

Agreed.

> * sequencer.c: It writes the "done" file. No concurrent accesses are
> expected: Not critial.

Agreed.

> * refs/files-backend.c: There are uses in functions open_or_create_logfile()
> and log_ref_setup(). Sounds like it is in reflogs. Sounds like this is about
> reflogs. If there are concurrent accesses, there is a danger that a reflog
> is not recorded correctly. Then reflogs may be missing and objects may be
> pruned earlier than expected. That's something to worry about, but I would
> not count it as mission critical.

We should always hold the matching ref lock already when modifying a
reflog. I seem to recall there was a case that missed this (I think
maybe modifying the HEAD reflog without holding HEAD.lock), but it was
fixed in the last few versions.

So I think we're probably OK, but I agree it's an interesting gotcha
that may bite us in the future.

-Peff
