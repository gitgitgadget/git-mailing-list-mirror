From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 00/22] cache cursors: an introduction
Date: Mon, 12 Sep 2005 12:53:01 -0700
Message-ID: <7vaciiawrm.fsf@assigned-by-dhcp.cox.net>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 21:53:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEuMZ-0005w8-R2
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 21:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVILTxI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 15:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbVILTxI
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 15:53:08 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:1790 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751063AbVILTxH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 15:53:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050912195302.ILNI20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Sep 2005 15:53:02 -0400
To: Chuck Lever <cel@citi.umich.edu>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8418>

I've only skimmed the surface of your patchset and cannot
comment on the correctness of all the conversion of active_cache
users; today is my day-job day not a GIT day.

I have to say you did quite a lot of work, and I am pleasantly
surprised to see the massive clean-up this change brings us.  It
seems like this makes the active_cache users a lot easier to
read.

I have a couple of comments on the API, though.

* Doesn't function to be applied usually want to have its own
  data when passed to walk, maybe something like this?

  typedef int (*cache_iterator_fn_t) (struct cache_cursor *cc,
			 struct cache_entry *ce, void *udata);
  static inline int walk_cache(cache_iterator_fn_t func, void *udata)
  {
          struct cache_cursor cc;

          init_cc(&cc);
          while (!cache_eof(&cc)) {
                  int status = func(&cc, cc_to_ce(&cc), udata);
                  if (status < 0)
                          return status;
          }
          return 0;
  }

  This was a question I had when I read [PATCH 01/22] before
  reading the rest of the patches, but the actual conversion
  does not seem to find much need for it.  A new global variable
  pathspec is introduced to pass information the API is unable
  to pass to diff_one() in diff-index.c, which may be a sign
  that an extra "user data" parameter might help.  Your call.

* It may make sense to give another param to describe which
  cache the caller is talking about so that we can later have
  more than one cache at the same time:

  struct cache {
      struct cache_entry **cache_array;
      unsigned int nr;
      unsigned int alloc;
      unsigned int cache_changed;
  };
  struct cache active_cache;

  and use it like this:

  static inline struct cache_entry *cc_to_ce(struct cache_cursor *cc,
                                             struct cache *cache)
  {
          return cache->cache_array[cc->pos];
  }

  We could argue that this should be left for later rounds.  On
  the other hand, we will be changing all the cc_* function call
  sites during that round, which is by definition the places you
  are touching in this round anyway.  Also I suspect that the
  "later job" is made larger if we do something like this during
  this round:

  diff --git a/cache.h b/cache.h
  --- a/cache.h
  +++ b/cache.h
  @@ -157,7 +157,7 @@ extern char *prefix_path(const char *pre

   /* Initialize and use the cache information */
   extern int read_cache(void);
  -extern int write_cache(int newfd, struct cache_entry **cache, int entries);
  +extern int write_cache(int newfd);
   extern int cache_name_pos(const char *name, int namelen);
   #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
   #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */

  This function could already act on more than one active_cache,
  although nobody uses it like that.
