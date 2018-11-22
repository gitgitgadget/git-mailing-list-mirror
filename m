Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0428F1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 17:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404554AbeKWEd1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 23:33:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:48794 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388954AbeKWEd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 23:33:26 -0500
Received: (qmail 27368 invoked by uid 109); 22 Nov 2018 17:53:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Nov 2018 17:53:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23820 invoked by uid 111); 22 Nov 2018 17:52:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Nov 2018 12:52:25 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2018 12:53:00 -0500
Date:   Thu, 22 Nov 2018 12:53:00 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: What's cooking in git.git (Nov 2018, #06; Wed, 21)
Message-ID: <20181122175259.GC22123@sigill.intra.peff.net>
References: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com>
 <87muq2zoy9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87muq2zoy9.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 21, 2018 at 11:48:14AM +0100, Ævar Arnfjörð Bjarmason wrote:

> 
> On Wed, Nov 21 2018, Junio C Hamano wrote:
> 
> > * jk/loose-object-cache (2018-11-13) 9 commits
> >   (merged to 'next' on 2018-11-18 at 276691a21b)
> >  + fetch-pack: drop custom loose object cache
> >  + sha1-file: use loose object cache for quick existence check
> >  + object-store: provide helpers for loose_objects_cache
> >  + sha1-file: use an object_directory for the main object dir
> >  + handle alternates paths the same as the main object dir
> >  + sha1_file_name(): overwrite buffer instead of appending
> >  + rename "alternate_object_database" to "object_directory"
> >  + submodule--helper: prefer strip_suffix() to ends_with()
> >  + fsck: do not reuse child_process structs
> >
> >  Code clean-up with optimization for the codepath that checks
> >  (non-)existence of loose objects.
> >
> >  Will cook in 'next'.
> 
> I think as noted in
> https://public-inbox.org/git/e5148b8c-9a3a-5d2e-ac8c-3e536c0f2358@web.de/
> that we should hold off the [89]/9 of this series due to the performance
> regressions this introduces in some cases (while fixing other cases).
> 
> I hadn't had time to follow up on that, and figured it could wait until
> post-2.20 for a re-roll.

Yeah, my intent had been to circle back around to this, but I just
hadn't gotten to it. I'm still pondering a config option or similar,
though I remain unconvinced that the cases in which you've showed it
being slow are actually realistic or worth worrying about (and certainly
having an obscure config option is not enough to help most people). If
we could have it kick in heuristically, that would be better.

However, note that the cache-load for finding abbreviations _must_ have
the complete list. And has been loading it for some time. So if you run
"git-fetch", for example, you've already been running this code for
months (and using the cache in more places is now a free speedup).

At the very least, we'd want this patch on top, too. I also think René's
suggestion use access() is worth pursuing (though to some degree is
orthogonal to the cache).

-- >8 --
Subject: [PATCH] odb_load_loose_cache: fix strbuf leak

Commit 66f04152be (object-store: provide helpers for
loose_objects_cache, 2018-11-12) moved the cache-loading code from
find_short_object_filename(), but forgot the line that releases the path
strbuf.

Reported-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 sha1-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sha1-file.c b/sha1-file.c
index 5894e48ea4..5a272f70de 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -2169,6 +2169,7 @@ void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
 				    NULL, NULL,
 				    &odb->loose_objects_cache);
 	odb->loose_objects_subdir_seen[subdir_nr] = 1;
+	strbuf_release(&buf);
 }
 
 static int check_stream_sha1(git_zstream *stream,
-- 
2.20.0.rc1.703.g93fba25b62

