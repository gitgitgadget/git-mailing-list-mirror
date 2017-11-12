Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 236311F42B
	for <e@80x24.org>; Sun, 12 Nov 2017 09:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750820AbdKLJyl (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 04:54:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:53744 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750723AbdKLJyj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 04:54:39 -0500
Received: (qmail 17862 invoked by uid 109); 12 Nov 2017 09:54:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 12 Nov 2017 09:54:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13491 invoked by uid 111); 12 Nov 2017 09:54:51 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (62.189.9.201)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 12 Nov 2017 04:54:51 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Nov 2017 09:54:36 +0000
Date:   Sun, 12 Nov 2017 09:54:36 +0000
From:   Jeff King <peff@peff.net>
To:     Gargi Sharma <gs051095@gmail.com>
Cc:     git@vger.kernel.org, olyatelezhnaya@gmail.com
Subject: Re: [PATCH] mru: Replace mru.[ch] with list.h implementation
Message-ID: <20171112095435.f4o662ygtt2taf5y@sigill.intra.peff.net>
References: <1510423606-9616-1-git-send-email-gs051095@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1510423606-9616-1-git-send-email-gs051095@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 11, 2017 at 01:06:46PM -0500, Gargi Sharma wrote:

> Replace custom allocation in mru.[ch] with generic calls
> to list.h API.
> 
> Signed-off-by: Gargi Sharma <gs051095@gmail.com>

Thanks, and welcome to the git list. :)

This looks like a good start on the topic, but I have a few comments.

It's a good idea to explain in the commit message not just what we're
doing, but why we want to do it, to help later readers of "git log". I
know that you picked this up from the discussion in the thread at:

  https://public-inbox.org/git/xmqq8tgz13x7.fsf@gitster.mtv.corp.google.com/

so it might be a good idea to summarize the ideas there (and add your
own thoughts, of course).

> ---
>  builtin/pack-objects.c | 14 ++++++++------
>  cache.h                |  9 +++++----
>  mru.c                  | 27 ---------------------------
>  mru.h                  | 40 ----------------------------------------
>  packfile.c             | 28 +++++++++++++++++++---------
>  5 files changed, 32 insertions(+), 86 deletions(-)
>  delete mode 100644 mru.c
>  delete mode 100644 mru.h

After the "---" line, you can put any information that people on the
list might want to know but that doesn't need to go into the commit
message. The big thing the maintainer would want to know here is that
your patch is prepared on top of the ot/mru-on-list topic, so he knows
where to apply it.

The diffstat is certainly encouraging so far. :)

> @@ -1012,9 +1012,9 @@ static int want_object_in_pack(const unsigned char *sha1,
>  			return want;
>  	}
>  
> -	list_for_each(pos, &packed_git_mru.list) {
> -		struct mru *entry = list_entry(pos, struct mru, list);
> -		struct packed_git *p = entry->item;
> +	list_for_each(pos, &packed_git_mru) {
> +		struct packed_git *p = list_entry(pos, struct packed_git, mru);
> +		struct list_head *entry = &(p->mru);
>  		off_t offset;
>  
>  		if (p == *found_pack)

I think "entry" here is going to be the same as "pos". That said, I
think it's only use is in bumping us to the front of the mru list later:

> @@ -1030,8 +1030,10 @@ static int want_object_in_pack(const unsigned char *sha1,
>  				*found_pack = p;
>  			}
>  			want = want_found_object(exclude, p);
> -			if (!exclude && want > 0)
> -				mru_mark(&packed_git_mru, entry);
> +			if (!exclude && want > 0) {
> +				list_del(entry);
> +				list_add(entry, &packed_git_mru);
> +			}

And I think this might be more obvious if we drop "entry" entirely and
just do:

  list_del(&p->mru);
  list_add(&p->mru, &packed_git_mru);

It might merit a comment like "/* bump to the front of the mru list */"
or similar to make it clear what's going on (or even adding a
list_move_to_front() helper).

> @@ -1566,6 +1566,7 @@ struct pack_window {
>  
>  extern struct packed_git {
>  	struct packed_git *next;
> +	struct list_head mru;
>  	struct pack_window *windows;
>  	off_t pack_size;
>  	const void *index_data;

Sort of a side note, but seeing these two list pointers together makes
me wonder what we should do with the list created by the "next" pointer.
It seems like there are three options:

  1. Convert it to "struct list_head", too, for consistency.

  2. Leave it as-is. We never delete from the list nor do any fancy
     manipulation, so it doesn't benefit from the reusable code.

  3. I wonder if we could drop it entirely, and just keep a single list
     of packs, ordered by mru. I'm not sure if anybody actually cares
     about accessing them in the "original" order. That order is
     reverse-chronological (by prepare_packed_git()), but I think that
     was mostly out of a sense that recent packs would be accessed more
     than older ones (but having a real mru strategy replaces that
     anyway).

What do you think?

> diff --git a/mru.c b/mru.c
> deleted file mode 100644
> index 8f3f34c..0000000

Yay, this hunk (and the one for mru.h) is satisfying.

> @@ -40,7 +40,7 @@ static unsigned int pack_max_fds;
>  static size_t peak_pack_mapped;
>  static size_t pack_mapped;
>  struct packed_git *packed_git;
> -struct mru packed_git_mru = {{&packed_git_mru.list, &packed_git_mru.list}};
> +LIST_HEAD(packed_git_mru);

Much nicer.

> @@ -859,9 +859,18 @@ static void prepare_packed_git_mru(void)
>  {
>  	struct packed_git *p;
>  
> -	mru_clear(&packed_git_mru);
> -	for (p = packed_git; p; p = p->next)
> -		mru_append(&packed_git_mru, p);
> +	struct list_head *pos;
> +	struct list_head *tmp;
> +	list_for_each_safe(pos, tmp, &packed_git_mru)
> +		list_del_init(pos);

This matches the original code, which did the clear/re-create, resetting
the mru to the "original" pack order. But I do wonder if that's actually
necessary. Could we skip that and just add any new packs to the list?

That goes hand-in-hand with the idea of dropping the "next" pointer that
I mentioned above.

> +	INIT_LIST_HEAD(&packed_git_mru);

I think this INIT_LIST_HEAD() isn't necessary anymore. In the original
code, we just freed each of the mru_entry structs, which meant we had to
forcibly reset the list head to be empty. But here you've used
list_del_init(), so after deleting everything, packed_git_mru should
already be empty.

> +	for (p = packed_git; p; p = p->next) {
> +		struct packed_git *cur = xmalloc(sizeof(*packed_git));
> +		cur = p;
> +		list_add_tail(&cur->mru, &packed_git_mru);
> +	}

This malloc can go away. The original mru code kept a separate entry,
but now we don't need that. So here you're just leaking it when you
assign "cur = p" (in fact, I think you can get rid of cur entirely).

> @@ -1830,10 +1839,11 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
>  	if (!packed_git)
>  		return 0;
>  
> -	list_for_each(pos, &packed_git_mru.list) {
> -		struct mru *p = list_entry(pos, struct mru, list);
> -		if (fill_pack_entry(sha1, e, p->item)) {
> -			mru_mark(&packed_git_mru, p);
> +	list_for_each(pos, &packed_git_mru) {
> +		struct packed_git *p = list_entry(pos, struct packed_git, mru);
> +		if (fill_pack_entry(sha1, e, p)) {
> +			list_del(&p->mru);
> +			list_add(&p->mru, &packed_git_mru);
>  			return 1;
>  		}
>  	}

And this hunk looks pretty good (though if we added a move-to-front
helper, it could be used here, too).

-Peff
