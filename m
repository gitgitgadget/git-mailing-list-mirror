Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6158C4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 07:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLHHdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 02:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiLHHc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 02:32:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30FECD0
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 23:32:55 -0800 (PST)
Received: (qmail 23720 invoked by uid 109); 8 Dec 2022 07:32:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Dec 2022 07:32:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10049 invoked by uid 111); 8 Dec 2022 07:32:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Dec 2022 02:32:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Dec 2022 02:32:54 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/4] hashfile: allow skipping the hash function
Message-ID: <Y5GTJuM3jNnStvsQ@coredump.intra.peff.net>
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
 <40ee8dbaef06f8f4265d12436455279499d7ac01.1670433958.git.gitgitgadget@gmail.com>
 <221207.868rjiam86.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221207.868rjiam86.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 07, 2022 at 11:13:15PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > +	if (f->skip_hash)
> > +		memset(f->buffer, 0, the_hash_algo->rawsz);
> 
> Here you're hardcoding a new version of null_oid(), but we can use it
> instead. Perhaps:
> 	
> 	diff --git a/csum-file.c b/csum-file.c
> 	index 3243473c3d7..b54c4f66cbb 100644
> 	--- a/csum-file.c
> 	+++ b/csum-file.c
> 	@@ -63,11 +63,12 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
> 	 		      enum fsync_component component, unsigned int flags)
> 	 {
> 	 	int fd;
> 	+	const struct object_id *const noid = null_oid();
> 	 
> 	 	hashflush(f);
> 	 
> 	 	if (f->skip_hash)
> 	-		memset(f->buffer, 0, the_hash_algo->rawsz);
> 	+		memcpy(f->buffer, noid, sizeof(*noid));
> 	 	else
> 	 		the_hash_algo->final_fn(f->buffer, &f->ctx);

I don't think that's quite right; the object_id struct has other stuff
in it.  You'd probably want:

  hashcpy(f->buffer, null_oid());

But I think we already have a helper to just do it directly:

  hashclr(f->buffer);

-Peff
