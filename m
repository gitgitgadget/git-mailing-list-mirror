Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55734C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343E861059
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245383AbhIBJkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:40:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:37286 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245688AbhIBJj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 05:39:27 -0400
Received: (qmail 21875 invoked by uid 109); 2 Sep 2021 09:38:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Sep 2021 09:38:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23192 invoked by uid 111); 2 Sep 2021 09:38:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Sep 2021 05:38:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 2 Sep 2021 05:38:28 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v5 00/27] multi-pack reachability bitmaps
Message-ID: <YTCblArLMMupKDkU@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
 <xmqq5yvkqidc.fsf@gitster.g>
 <YS/Pqc7lkMlnlBYR@nand.local>
 <xmqq1r68qevl.fsf@gitster.g>
 <YS/juRg9N/cCoR0d@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YS/juRg9N/cCoR0d@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 01, 2021 at 04:34:01PM -0400, Taylor Blau wrote:

> > Oh, no, don't get me wrong.  I am comfortable with the documented
> > limitation, as that is what the area experts have agreed that is
> > reasonable given the expected use case.
> >
> > I however am much less comfortable with a documented limitation that
> > we make no attempt to enforce, and that is why the first thing I
> > looked for after seeing the documentation update was new code to
> > make sure we reject a random directory that is not our alternate
> > object store.
> 
> Sure, I don't mind getting more strict here in this series. If you want,
> the below could be queued instead of the original 11/27:
> 
> --- 8< ---
> 
> Subject: [PATCH] midx: avoid opening multiple MIDXs when writing

I think this is worth doing here, as part of this series.

Two observations (neither of which would lead to changing the patch):

> diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
> index c9b063d31e..0af6beb2dd 100644
> --- a/Documentation/git-multi-pack-index.txt
> +++ b/Documentation/git-multi-pack-index.txt
> @@ -23,6 +23,8 @@ OPTIONS
>  	Use given directory for the location of Git objects. We check
>  	`<dir>/packs/multi-pack-index` for the current MIDX file, and
>  	`<dir>/packs` for the pack-files to index.
> ++
> +`<dir>` must be an alternate of the current repository.

I wondered if this needed to say "must be the main object directory of
or an alternate of the current repository". But if you are intending to
operate in the main object directory, you would simply omit --object-dir
entirely. It is good that it will still work if you specified it
explicitly, but I don't think we need to clutter the documentation with
it.

> index cd86315221..003eaaac5c 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -43,28 +43,6 @@ static struct opts_commit_graph {
>  	int enable_changed_paths;
>  } opts;
> 
> -static struct object_directory *find_odb(struct repository *r,
> -					 const char *obj_dir)
> -{
> -	struct object_directory *odb;
> -	char *obj_dir_real = real_pathdup(obj_dir, 1);
> -	struct strbuf odb_path_real = STRBUF_INIT;
> -
> -	prepare_alt_odb(r);
> -	for (odb = r->objects->odb; odb; odb = odb->next) {
> -		strbuf_realpath(&odb_path_real, odb->path, 1);
> -		if (!strcmp(obj_dir_real, odb_path_real.buf))
> -			break;
> -	}
> -
> -	free(obj_dir_real);
> -	strbuf_release(&odb_path_real);
> -
> -	if (!odb)
> -		die(_("could not find object directory matching %s"), obj_dir);
> -	return odb;
> -}

Ah, right, commit-graph faces this same conundrum we've been discussing.
And it behaves in the way that we concluded:

  $ git init one
  $ git commit-graph write --object-dir $PWD/one/.git/objects
  fatal: not a git repository (or any of the parent directories): .git

  $ git init two
  $ git -C two commit-graph write --object-dir $PWD/one/.git/objects
  fatal: could not find object directory matching /home/peff/tmp/one/.git/objects

That gives me more confidence in the direction we decided on.

(Apologies if this was obvious to others, but I didn't see any mention
of commit-graph's similar option in the recent discussion).

-Peff
