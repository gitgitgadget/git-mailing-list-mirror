Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4142D1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 21:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeJaGaQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 02:30:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:33286 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725743AbeJaGaP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 02:30:15 -0400
Received: (qmail 25063 invoked by uid 109); 30 Oct 2018 21:35:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Oct 2018 21:35:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3682 invoked by uid 111); 30 Oct 2018 21:34:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 30 Oct 2018 17:34:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2018 17:35:05 -0400
Date:   Tue, 30 Oct 2018 17:35:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Infinite loop regression in git-fsck in v2.12.0
Message-ID: <20181030213505.GA11319@sigill.intra.peff.net>
References: <20170113175944.tdbfqx3e4xhris7m@sigill.intra.peff.net>
 <878t2fkxrn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878t2fkxrn.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2018 at 09:03:24PM +0100, Ævar Arnfjörð Bjarmason wrote:

> While playing around with having a GIT_TEST_FSCK=true as I suggested in
> https://public-inbox.org/git/20181030184331.27264-3-avarab@gmail.com/ I
> found that we've had an infinite loop in git-fsck since c68b489e56
> ("fsck: parse loose object paths directly", 2017-01-13)
> 
> In particular in the while() loop added by f6371f9210 ("sha1_file: add
> read_loose_object() function", 2017-01-13) in the check_stream_sha1()
> function.
> 
> To reproduce just:
> 
>     (
>         cd t &&
>         ./t5000-tar-tree.sh -d &&
>         git -C trash\ directory.t5000-tar-tree/ fsck
>     )

Thanks, I was easily able to reproduce.

> Before we'd print:
> 
>     error: sha1 mismatch 19f9c8273ec45a8938e6999cb59b3ff66739902a
>     error: 19f9c8273ec45a8938e6999cb59b3ff66739902a: object corrupt or missing
>     Checking object directories: 100% (256/256), done.
>     missing blob 19f9c8273ec45a8938e6999cb59b3ff66739902a

The problem isn't actually a sha1 mismatch, though that's what
parse_object() will report. The issue is actually that the file is
truncated. So zlib does not say "this is corrupt", but rather "I need
more bytes to keep going". And unfortunately it returns Z_BUF_ERROR both
for "I need more bytes" (in which we know we are truncated, because we
fed the whole mmap'd file in the first place) as well as "I need more
output buffer space" (which just means we should keep looping!).

So we need to distinguish those cases. I think this is the simplest fix:

diff --git a/sha1-file.c b/sha1-file.c
index dd0b6aa873..a7ff5fe25d 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -2199,6 +2199,7 @@ static int check_stream_sha1(git_zstream *stream,
 	 * see the comment in unpack_sha1_rest for details.
 	 */
 	while (total_read <= size &&
+	       stream->avail_in > 0 &&
 	       (status == Z_OK || status == Z_BUF_ERROR)) {
 		stream->next_out = buf;
 		stream->avail_out = sizeof(buf);

> I have no idea if this makes sense, but this fixes it and we pass all
> the fsck tests with it:
> 
>     diff --git a/sha1-file.c b/sha1-file.c
>     index dd0b6aa873..fffc31458e 100644
>     --- a/sha1-file.c
>     +++ b/sha1-file.c
>     @@ -2182,7 +2182,7 @@ static int check_stream_sha1(git_zstream *stream,
>      	git_hash_ctx c;
>      	unsigned char real_sha1[GIT_MAX_RAWSZ];
>      	unsigned char buf[4096];
>     -	unsigned long total_read;
>     +	unsigned long total_read, last_total_read;
>      	int status = Z_OK;
> 
>      	the_hash_algo->init_fn(&c);
>     @@ -2193,6 +2193,7 @@ static int check_stream_sha1(git_zstream *stream,
>      	 * do not count against the object's content size.
>      	 */
>      	total_read = stream->total_out - strlen(hdr) - 1;
>     +	last_total_read = total_read;

This works just by checking that we are making forward progress in the
output buffer. I think that would _probably_ be OK for this case, since
we know we have all of the input available. But in a case where we're
feeding the input in a stream, it would not be. It's possible there that
we would not create any output in one round, but would do so after
feeding more input bytes.

I think the patch I showed above addresses the root cause more directly.
I'll wrap that up in a real commit, but I think there may be some
related work:

  - "git show 19f9c827" does complain with "sha1 mismatch" (which isn't
    strictly correct, but is probably good enough). However, "git
    cat-file blob 19f9c827" exits non-zero without printing anything. It
    probably should complain more loudly.

  - the offending loop comes from f6371f9210. But that commit was mostly
    cargo-culting other parts of sha1-file.c. I'm worried that this bug
    exists elsewhere, too. I'll dig around to see if I can find other
    instances.

-Peff
