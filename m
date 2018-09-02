Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA36C1F404
	for <e@80x24.org>; Sun,  2 Sep 2018 07:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeIBMBt (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 08:01:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:36576 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726006AbeIBMBt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 08:01:49 -0400
Received: (qmail 12838 invoked by uid 109); 2 Sep 2018 07:46:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 02 Sep 2018 07:46:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16768 invoked by uid 111); 2 Sep 2018 07:47:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 02 Sep 2018 03:47:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Sep 2018 03:46:57 -0400
Date:   Sun, 2 Sep 2018 03:46:57 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
Subject: Re: non-smooth progress  indication for git fsck and git gc
Message-ID: <20180902074656.GB18787@sigill.intra.peff.net>
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
 <20180816155714.GA22739@sigill.intra.peff.net>
 <87bma2qcba.fsf@evledraar.gmail.com>
 <87y3clbcqf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y3clbcqf.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 01, 2018 at 02:53:28PM +0200, Ævar Arnfjörð Bjarmason wrote:

> With this we'll get output like:
> 
>     $ ~/g/git/git  -C ~/g/2015-04-03-1M-git/  --exec-path=$PWD fsck
>     Checking object directories: 100% (256/256), done.
>     Hashing: 100% (452634108/452634108), done.
>     Hashing: 100% (1073741824/1073741824), done.
>     Hashing: 100% (1073741824/1073741824), done.
>     Hashing: 100% (1008001572/1008001572), done.
>     Checking objects:   2% (262144/13064614)
>     ^C
> 
> All tests pass with this. Isn't it awesome? Except it's of course a
> massive hack, we wouldn't want to just hook into SHA1DC like this.

I still consider that output so-so; the byte counts are big and there's
no indication how many "hashing" lines we're going to see. It's also
broken up in a weird way (it's not one per file; it's one per giant
chunk we fed to sha1).

> The problem comes down to us needing to call git_hash_sha1_update() with
> some really huge input, that function is going to take a *long* time,
> and the only way we're getting incremental progress is:
> 
>  1) If we ourselves split the input into N chunks
>  2) If we hack into the SHA1 library itself
> 
> This patch does #2, but for this to be acceptable we'd need to do
> something like #1.

I think we could just do the chunking in verify_packfile(), couldn't we?
(And the .idx hash, if we really want to cover that case, but IMHO
that's way less interesting).

Something like this, which chunks it there, uses a per-packfile meter
(though still does not give any clue how many packfiles there are), and
shows a throughput meter.

diff --git a/pack-check.c b/pack-check.c
index d3a57df34f..c94223664f 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -62,10 +62,25 @@ static int verify_packfile(struct packed_git *p,
 	uint32_t nr_objects, i;
 	int err = 0;
 	struct idx_entry *entries;
+	struct progress *hashing_progress;
+	char *title;
+	off_t total_hashed = 0;
 
 	if (!is_pack_valid(p))
 		return error("packfile %s cannot be accessed", p->pack_name);
 
+	if (progress) {
+		/* Probably too long... */
+		title = xstrfmt("Hashing %s", p->pack_name);
+
+		/*
+		 * I don't think it actually works to have two progresses going
+		 * at the same time, because when the first one ends, we'll
+		 * cancel the alarm. But hey, this is a hacky proof of concept.
+		 */
+		hashing_progress = start_progress(title, 0);
+	}
+
 	the_hash_algo->init_fn(&ctx);
 	do {
 		unsigned long remaining;
@@ -75,9 +90,25 @@ static int verify_packfile(struct packed_git *p,
 			pack_sig_ofs = p->pack_size - the_hash_algo->rawsz;
 		if (offset > pack_sig_ofs)
 			remaining -= (unsigned int)(offset - pack_sig_ofs);
-		the_hash_algo->update_fn(&ctx, in, remaining);
+		while (remaining) {
+			int chunk = remaining < 4096 ? remaining : 4096;
+			the_hash_algo->update_fn(&ctx, in, chunk);
+			in += chunk;
+			remaining -= chunk;
+			total_hashed += chunk;
+			/*
+			 * The progress code needs tweaking to show throughputs
+			 * better for open-ended meters.
+			 */
+			display_throughput(hashing_progress, total_hashed);
+			display_progress(hashing_progress, 0);
+		}
 	} while (offset < pack_sig_ofs);
+
 	the_hash_algo->final_fn(hash, &ctx);
+	stop_progress(&hashing_progress);
+	free(title);
+
 	pack_sig = use_pack(p, w_curs, pack_sig_ofs, NULL);
 	if (hashcmp(hash, pack_sig))
 		err = error("%s pack checksum mismatch",
