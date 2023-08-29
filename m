Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3CBC83F17
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 00:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbjH2Asx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 20:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbjH2AsY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 20:48:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182DCCCE
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 17:48:02 -0700 (PDT)
Received: (qmail 3233 invoked by uid 109); 29 Aug 2023 00:48:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Aug 2023 00:48:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6569 invoked by uid 111); 29 Aug 2023 00:48:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 20:48:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 20:48:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/22] sequencer: use repository parameter in
 short_commit_name()
Message-ID: <20230829004801.GA3876652@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
 <20230828214629.GA3831137@coredump.intra.peff.net>
 <xmqqsf82g65k.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsf82g65k.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 28, 2023 at 03:21:11PM -0700, Junio C Hamano wrote:

> > @@ -3172,7 +3171,8 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
> >  		item->offset_in_buf = todo_list->buf.len;
> >  		subject_len = find_commit_subject(commit_buffer, &subject);
> >  		strbuf_addf(&todo_list->buf, "%s %s %.*s\n", command_string,
> > -			short_commit_name(commit), subject_len, subject);
> > +			short_commit_name(opts->revs->repo, commit),
> > +			subject_len, subject);
> >  		repo_unuse_commit_buffer(the_repository, commit,
> >  					 commit_buffer);
> 
> But how do we ascertain that opts->revs->repo is always safe to use
> (iow initialized to a sensible value)?  repo_init_revisions() takes
> a repository as its parameter and the first thing it does is to set
> it to the revs->repo, so it is safe for any "struct rev_info" that
> came from there, but REV_INFO_INIT omits initializer for the .repo
> member.

I mostly just assumed it would have been initialized, because passing in
anything else and expecting it to work is a bit crazy. REV_INFO_INIT
specifically says:

   * This will not fully initialize a "struct rev_info", the
   * repo_init_revisions() function needs to be called before
   * setup_revisions() and any revision walking takes place.

and then goes on to explain that the point is just so you can "goto
cleanup" and free it if you never made it to the init_revisions() call.
So the code would already be pretty buggy in this case.

That said, all of the code paths here do call repo_init_revisions(), so
I think it is OK. But if we want to make the patch simple and more
obviously correct, I would prefer to just blindly use the_repository in
callers that don't have a "struct repository" themselves. Then we know
it's a strict step forward (if slightly smaller), and we can leave the
refactoring of the rest of the sequencer code for another day. I was
trying hard to draw a reasonable line and not get this already-large
series derailed by only semi-related refactoring.

> The other two calls in this loop refer to the_repository so the
> current code would be safe even if opts->revs->repo is set or NULL,
> but that will no longer be true with the updated code.  I'd feel
> safer if at the beginning of the function we create a local variable
> "struct rev_info *repo" that is initialized to opts->revs->repo and
> use it throughout the function instead of the_repository.

I'm not sure how that makes it any safer, as it would mean using the
suspect repo pointer in more places. Unless you are proposing to do:

  struct repository *r = opts->revs->repo;
  if (!r)
	r = the_repository; /* or BUG() ? */

-Peff
