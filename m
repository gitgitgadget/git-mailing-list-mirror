From: Jeff King <peff@peff.net>
Subject: Re: git commit -a reports untracked files after a clone
Date: Thu, 6 Oct 2011 12:06:09 -0400
Message-ID: <20111006160608.GA22920@sigill.intra.peff.net>
References: <7v39kgr5ln.fsf@alter.siamese.dyndns.org>
 <4501A58F-46F8-410C-BCEF-DD2FC10BC3A5@goli.at>
 <20110516103829.GA23889@sigill.intra.peff.net>
 <7C2AE1EE-4CAE-4E86-A53C-C97BE1F2573B@goli.at>
 <20110516120825.GA24418@sigill.intra.peff.net>
 <1D7CF554-A4AC-49EF-A095-9B05167BC458@goli.at>
 <20110516145535.GA25930@sigill.intra.peff.net>
 <20110527180045.GA29119@sigill.intra.peff.net>
 <20110527181321.GB29119@sigill.intra.peff.net>
 <loom.20111005T161522-357@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joerg Rosenkranz <Joerg.Rosenkranz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 18:06:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBqSj-0006wc-NB
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 18:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045Ab1JFQGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 12:06:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54424
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964996Ab1JFQGM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 12:06:12 -0400
Received: (qmail 9596 invoked by uid 107); 6 Oct 2011 16:06:12 -0000
Received: from 208.177.47.101.ptr.us.xo.net (HELO sigill.intra.peff.net) (208.177.47.101)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Oct 2011 12:06:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Oct 2011 12:06:09 -0400
Content-Disposition: inline
In-Reply-To: <loom.20111005T161522-357@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182965>

On Wed, Oct 05, 2011 at 02:26:30PM +0000, Joerg Rosenkranz wrote:

> > On Fri, May 27, 2011 at 02:00:45PM -0400, Jeff King wrote:
> >   1. We load the index, and for each entry, insert it into the index's
> >      name_hash. In addition, if ignorecase is turned on, we make an
> >      entry in the name_hash for the directory (e.g., "contrib/"), which
> >      uses the following code from 5102c61's hash_index_entry_directories:
> 
> Sorry for reactivating this old thread.
> We are running in this problem too. The behavior is the same in msysgit and on 
> Linux. Your patch resolves that problem for us.
> 
> Is there any chance to drive this patch forward?

Thanks for prodding. I wrote a big analysis at the end of that thread,
but didn't get much response. I've been meaning to pick it up again.

So I spent a few minutes revisiting the topic today. I think it's
definitely a bug, and the fix is definitely correct. The patch is below,
with what I hope is a coherent analysis adapted from the previous
thread.

The only question is whether or not it's OK to add a few bytes to
"struct cache_entry" to cater to an uncommon case (see the comments at
the end of the commit message). Junio might have thoughts on that.

-- >8 --
Subject: [PATCH] fix phantom untracked files when core.ignorecase is set

When core.ignorecase is turned on and there are stale index
entries, "git commit" can sometimes report directories as
untracked, even though they contain tracked files.

You can see an example of this with:

    # make a case-insensitive repo
    git init repo && cd repo &&
    git config core.ignorecase true &&

    # with some tracked files in a subdir
    mkdir subdir &&
    > subdir/one &&
    > subdir/two &&
    git add . &&
    git commit -m base &&

    # now make the index entries stale
    touch subdir/* &&

    # and then ask commit to update those entries and show
    # us the status template
    git commit -a

which will report "subdir/"  as untracked, even though it
clearly contains two tracked files. What is happening in the
commit program is this:

  1. We load the index, and for each entry, insert it into the index's
     name_hash. In addition, if ignorecase is turned on, we make an
     entry in the name_hash for the directory (e.g., "contrib/"), which
     uses the following code from 5102c61's hash_index_entry_directories:

        hash = hash_name(ce->name, ptr - ce->name);
        if (!lookup_hash(hash, &istate->name_hash)) {
                pos = insert_hash(hash, &istate->name_hash);
		if (pos) {
			ce->next = *pos;
			*pos = ce;
		}
        }

     Note that we only add the directory entry if there is not already an
     entry.

  2. We run add_files_to_cache, which gets updated information for each
     cache entry. It helpfully inserts this information into the cache,
     which calls replace_index_entry. This in turn calls
     remove_name_hash() on the old entry, and add_name_hash() on the new
     one. But remove_name_hash doesn't actually remove from the hash, it
     only marks it as "no longer interesting" (from cache.h):

      /*
       * We don't actually *remove* it, we can just mark it invalid so that
       * we won't find it in lookups.
       *
       * Not only would we have to search the lists (simple enough), but
       * we'd also have to rehash other hash buckets in case this makes the
       * hash bucket empty (common). So it's much better to just mark
       * it.
       */
      static inline void remove_name_hash(struct cache_entry *ce)
      {
              ce->ce_flags |= CE_UNHASHED;
      }

     This is OK in the specific-file case, since the entries in the hash
     form a linked list, and we can just skip the "not here anymore"
     entries during lookup.

     But for the directory hash entry, we will _not_ write a new entry,
     because there is already one there: the old one that is actually no
     longer interesting!

  3. While traversing the directories, we end up in the
     directory_exists_in_index_icase function to see if a directory is
     interesting. This in turn checks index_name_exists, which will
     look up the directory in the index's name_hash. We see the old,
     deleted record, and assume there is nothing interesting. The
     directory gets marked as untracked, even though there are index
     entries in it.

The problem is in the code I showed above:

        hash = hash_name(ce->name, ptr - ce->name);
        if (!lookup_hash(hash, &istate->name_hash)) {
                pos = insert_hash(hash, &istate->name_hash);
		if (pos) {
			ce->next = *pos;
			*pos = ce;
		}
        }

Having a single cache entry that represents the directory is
not enough; that entry may go away if the index is changed.
It may be tempting to say that the problem is in our removal
method; if we removed the entry entirely instead of simply
marking it as "not here anymore", then we would know we need
to insert a new entry. But that only covers this particular
case of remove-replace. In the more general case, consider
something like this:

  1. We add "foo/bar" and "foo/baz" to the index. Each gets
     their own entry in name_hash, plus we make a "foo/"
     entry that points to "foo/bar".

  2. We remove the "foo/bar" entry from the index, and from
     the name_hash.

  3. We ask if "foo/" exists, and see no entry, even though
     "foo/baz" exists.

So we need that directory entry to have the list of _all_
cache entries that indicate that the directory is tracked.
So that implies making a linked list as we do for other
entries, like:

  hash = hash_name(ce->name, ptr - ce->name);
  pos = insert_hash(hash, &istate->name_hash);
  if (pos) {
	  ce->next = *pos;
	  *pos = ce;
  }

But that's not right either. In fact, it shows a second bug
in the current code, which is that the "ce->next" pointer is
supposed to be linking entries for a specific filename
entry, but here we are overwriting it for the directory
entry. So the same cache entry ends up in two linked lists,
but they share the same "next" pointer.

As it turns out, this second bug can't be triggered in the
current code. The "if (pos)" conditional is totally dead
code; pos will only be non-NULL if there was an existing
hash entry, and we already checked that there wasn't one
through our call to lookup_hash.

But fixing the first bug means taking out that call to
lookup_hash, which is going to activate the buggy dead code,
and we'll end up splicing the two linked lists together.

So we need to have a separate next pointer for the list in
the directory bucket, and we need to traverse that list in
index_name_exists when we are looking up a directory.

This bloats "struct cache_entry" by a few bytes. Which is
annoying, because it's only necessary when core.ignorecase
is enabled. There's not an easy way around it, short of
separating out the "next" pointers from cache_entry entirely
(i.e., having a separate "cache_entry_list" struct that gets
stored in the name_hash). In practice, it probably doesn't
matter; we have thousands of cache entries, compared to the
millions of objects (where adding 4 bytes to the struct
actually does impact performance).

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     |    1 +
 name-hash.c |   15 ++++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 607c2ea..1334fbf 100644
--- a/cache.h
+++ b/cache.h
@@ -168,6 +168,7 @@ struct cache_entry {
 	unsigned int ce_flags;
 	unsigned char sha1[20];
 	struct cache_entry *next;
+	struct cache_entry *dir_next;
 	char name[FLEX_ARRAY]; /* more */
 };
 
diff --git a/name-hash.c b/name-hash.c
index c6b6a3f..225dd76 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -57,12 +57,10 @@ static void hash_index_entry_directories(struct index_state *istate, struct cach
 		if (*ptr == '/') {
 			++ptr;
 			hash = hash_name(ce->name, ptr - ce->name);
-			if (!lookup_hash(hash, &istate->name_hash)) {
-				pos = insert_hash(hash, ce, &istate->name_hash);
-				if (pos) {
-					ce->next = *pos;
-					*pos = ce;
-				}
+			pos = insert_hash(hash, ce, &istate->name_hash);
+			if (pos) {
+				ce->dir_next = *pos;
+				*pos = ce;
 			}
 		}
 	}
@@ -166,7 +164,10 @@ struct cache_entry *index_name_exists(struct index_state *istate, const char *na
 			if (same_name(ce, name, namelen, icase))
 				return ce;
 		}
-		ce = ce->next;
+		if (icase && name[namelen - 1] == '/')
+			ce = ce->dir_next;
+		else
+			ce = ce->next;
 	}
 
 	/*
-- 
1.7.7.37.g0e376
