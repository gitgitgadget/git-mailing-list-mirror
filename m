From: Jeff King <peff@peff.net>
Subject: [PATCH] hash: fix lookup_hash semantics
Date: Fri, 22 Feb 2008 14:47:27 -0500
Message-ID: <20080222194726.GA24532@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Dane Jensen <careo@fastmail.fm>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 20:49:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSdtE-0003O6-Sb
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 20:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758351AbYBVTrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 14:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758302AbYBVTrf
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 14:47:35 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3457 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757913AbYBVTrc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 14:47:32 -0500
Received: (qmail 24839 invoked by uid 111); 22 Feb 2008 19:47:30 -0000
Received: from lawn-128-61-21-22.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.21.22)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 22 Feb 2008 14:47:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2008 14:47:27 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74753>

We were returning the _address of_ the stored item (or NULL)
instead of the item itself. While this sort of indirection
is useful for insertion (since you can lookup and then
modify), it is unnecessary for read-only lookup. Since the
hash code splits these functions between the internal
lookup_hash_entry function and the public lookup_hash
function, it makes sense for the latter to provide what
users of the library expect.

The result of this was that the index caching returned bogus
results on lookup. We unfortunately didn't catch this
because we were returning a "struct cache_entry **" as a
"void *", and accidentally assigning it to a "struct
cache_entry *".

As it happens, this actually _worked_ most of the time,
because the entries were defined as:

  struct cache_entry {
	  struct cache_entry *next;
	  ...
  };

meaning that interpreting a "struct cache_entry **" as a
"struct cache_entry *" would yield an entry where all fields
were totally bogus _except_ for the next pointer, which
pointed to the actual cache entry. When walking the list, we
would look at the bogus "name" field, which was unlikely to
match our lookup, and then proceed to the "real" entry.

The reading of bogus data was silently ignored most of the
time, but could cause a segfault for some data (which seems
to be more common on OS X).

Signed-off-by: Jeff King <peff@peff.net>
---
This can be applied to maint, but there aren't actually any
callers of lookup_hash until Linus' recent patch series, so it really
only makes sense on top of that. Alternatively, his patches could be
altered to dereference the return from lookup_hash, but I think this
calling convention makes more sense (for the reasons I explained above).

This shuts up the valgrind errors I see under Linux; it would be nice to
get confirmation from OS X people that this fixes their "git status"
segfaults.

 hash.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/hash.c b/hash.c
index 7b492d4..d9ec82f 100644
--- a/hash.c
+++ b/hash.c
@@ -70,7 +70,7 @@ void *lookup_hash(unsigned int hash, struct hash_table *table)
 {
 	if (!table->array)
 		return NULL;
-	return &lookup_hash_entry(hash, table)->ptr;
+	return lookup_hash_entry(hash, table)->ptr;
 }
 
 void **insert_hash(unsigned int hash, void *ptr, struct hash_table *table)
-- 
1.5.4.2.262.g044a1.dirty
