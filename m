From: Jeff King <peff@peff.net>
Subject: Re: git commit -a reports untracked files after a clone
Date: Fri, 27 May 2011 14:00:45 -0400
Message-ID: <20110527180045.GA29119@sigill.intra.peff.net>
References: <7B399C74-8048-42BA-8672-9D7964F24888@goli.at>
 <7v39kgr5ln.fsf@alter.siamese.dyndns.org>
 <4501A58F-46F8-410C-BCEF-DD2FC10BC3A5@goli.at>
 <20110516103829.GA23889@sigill.intra.peff.net>
 <7C2AE1EE-4CAE-4E86-A53C-C97BE1F2573B@goli.at>
 <20110516120825.GA24418@sigill.intra.peff.net>
 <1D7CF554-A4AC-49EF-A095-9B05167BC458@goli.at>
 <20110516145535.GA25930@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Philipp Metzler <phil@goli.at>
X-From: git-owner@vger.kernel.org Fri May 27 20:01:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ1LB-0001hp-Lv
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 20:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757031Ab1E0SAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 14:00:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45536
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756957Ab1E0SAr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 14:00:47 -0400
Received: (qmail 25523 invoked by uid 107); 27 May 2011 18:00:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 May 2011 14:00:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 May 2011 14:00:45 -0400
Content-Disposition: inline
In-Reply-To: <20110516145535.GA25930@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174634>

[+cc Joshua, as the problem is in his 5102c61 (Add case insensitivity
 support for directories when using git status, 2010-10-03)]

On Mon, May 16, 2011 at 10:55:35AM -0400, Jeff King wrote:

> OK, I'm making some progress. I can replicate on Linux with:
> 
>   $ git config --global core.ignorecase true
>   $ git clone git foo
>   $ cd foo && git commit -a
>   # On branch private
>   # Untracked files:
>   #       Documentation/
>   #       block-sha1/
>   #       builtin/
>   #       compat/
>   #       contrib/
>   #       git-gui/
>   #       git_remote_helpers/
>   #       gitk-git/
>   #       gitweb/
>   #       perl/
>   #       po/
>   #       ppc/
>   #       t/
>   #       templates/
>   #       vcs-svn/
>   #       xdiff/
>   nothing added to commit but untracked files present
>
> [i.e., all of those directories are listed as containing untracked
>  contents even though they clearly have tracked files in them]

OK, I figured it out. Unfortunately, the fix is non-trivial. Basically
we are getting bogus data out of the index's name_hash for directories.

What is happening is this:

  1. We load the index, and for each entry, insert it into the index's
     name_hash. In addition, if ignorecase is turned on, we make an
     entry in the name_hash for the directory (e.g., "contrib/"), which
     uses the following code from 5102c61's hash_index_entry_directories:

        hash = hash_name(ce->name, ptr - ce->name);
        if (!lookup_hash(hash, &istate->name_hash)) {
                pos = insert_hash(hash, &istate->name_hash);
                ce->next = *pos;
                *pos = ce;
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

And that explains the three prerequisites I needed for replicating the
bug:

  1. You must be using ignore-case. The bug is in that code path.

  2. You must have an index with stale stat information; this is what
     provokes add_files_to_cache to update the index entries.

  3. You must stop traversal at the directory boundary (i.e., not using
     "-uall"). Otherwise we end up looking for the exact filenames,
     which do get found.

The problem is in the code I showed above:

        hash = hash_name(ce->name, ptr - ce->name);
        if (!lookup_hash(hash, &istate->name_hash)) {
                pos = insert_hash(hash, &istate->name_hash);
                ce->next = *pos;
                *pos = ce;
        }

Having a single cache entry that represents the directory is not enough;
that entry may go away if the index is changed. It may be tempting to
say that the problem is in our removal method; if we removed the entry
entirely instead of simply marking it as "not here anymore", then we
would know we need to insert a new entry. But that only covers this
particular case of remove-replace. In the more general case, consider
something like this:

  1. We add "foo/bar" and "foo/baz" to the index. Each gets their own
     entry in name_hash, plus we make a "foo/" entry that points to
     "foo/bar".

  2. We remove the "foo/bar" entry from the index, and from the
     name_hash.

  3. We ask if "foo/" exists, and see no entry, even though "foo/baz"
     exists.

So we need that directory entry to have the list of _all_ cache entries
that indicate that the directory is tracked. So that implies making a
linked list as we do for other entries, like:

  hash = hash_name(ce->name, ptr - ce->name);
  pos = insert_hash(hash, &istate->name_hash);
  ce->next = *pos;
  *pos = ce;

But that's not right either. In fact, it shows a second bug in the
current code, which is that the "ce->next" pointer is supposed to be
linking entries for a specific filename entry, but here we are
overwriting it for the directory entry. I _think_ this can't be
triggered as a bug, because:

  1. This is the first entry in the directory (otherwise lookup_hash
     would not have returned NULL), and is therefore the first entry
     for this specific file. So ce->next must already be NULL.

  2. lookup_hash returned NULL, which means "*pos" is going to be NULL.

So even though it looks like we might be truncating an existing list,
it's not possible to do so in practice. But if we start actually keeping
a directory list, we will run into problems, because we'll be splicing
unrelated lists together.

So we need to have a separate next pointer for the list in the directory
bucket, and we need to traverse that list in index_name_exists when we
are looking up a directory.

The patch below seems to fix it for me. I'm not 100% happy with adding
extra icase-only cruft to "struct cache_entry", but I don't really see a
way around it, short of separating out the "next" pointers from
cache_entry entirely (i.e., having a separate "cache_entry_list"
struct that gets stored in the name_hash). In practice, it probably
doesn't matter; we have thousands of cache entries, compared to the
millions of objects (where adding 4 bytes to the struct _does_ impact
performance).

---
diff --git a/cache.h b/cache.h
index 96cfc9a..2868dac 100644
--- a/cache.h
+++ b/cache.h
@@ -153,6 +153,7 @@ struct cache_entry {
 	unsigned int ce_flags;
 	unsigned char sha1[20];
 	struct cache_entry *next;
+	struct cache_entry *dir_next;
 	char name[FLEX_ARRAY]; /* more */
 };
 
diff --git a/name-hash.c b/name-hash.c
index 1a8c619..30cb2e3 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -57,11 +57,9 @@ static void hash_index_entry_directories(struct index_state *istate, struct cach
 		if (*ptr == '/') {
 			++ptr;
 			hash = hash_name(ce->name, ptr - ce->name);
-			if (!lookup_hash(hash, &istate->name_hash)) {
-				pos = insert_hash(hash, &istate->name_hash);
-				ce->next = *pos;
-				*pos = ce;
-			}
+			pos = insert_hash(hash, &istate->name_hash);
+			ce->dir_next = *pos;
+			*pos = ce;
 		}
 	}
 }
@@ -162,7 +160,10 @@ struct cache_entry *index_name_exists(struct index_state *istate, const char *na
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
