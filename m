From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: I'm a total push-over..
Date: Tue, 22 Jan 2008 18:58:53 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801221844570.1741@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org> <7vabmxqnz8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 03:59:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHVpq-0005PZ-6U
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 03:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbYAWC7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 21:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbYAWC7B
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 21:59:01 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49553 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751775AbYAWC7A (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 21:59:00 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0N2wrc7014650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Jan 2008 18:58:54 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0N2wrVC020509;
	Tue, 22 Jan 2008 18:58:53 -0800
In-Reply-To: <7vabmxqnz8.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71502>



On Tue, 22 Jan 2008, Junio C Hamano wrote:
> 
>  - You might want to store the hash table (once computed) in the
>    index extension section, and lazily unpack the table the
>    first time index_name_exists() or set_index_entry() is called
>    on the given istate, instead of unpacking it immediately when
>    you read from the disk.  That way, ls-files does not have to
>    suffer at all.

I really hate that. 

Basically, I dislike having two copies of the same data. If something can 
be computed from something else, then only the original data should exist, 
and the other thing should be recomputed. Otherwise you easily get into 
situations where you spend a lot of time maintaining the other copy, or 
worse, you have inconsistent data and it's really subtle what is going on.

Also, one of the ideas behind the index is that would depend on your 
notion of what is "equivalent", which is actually somehing fairly fluid. 
In fact, it's likely going to depend on a config option.

So encoding the indexing on disk, when it can change when you do a simple 
"git config", or even just depending on your LANG environment variable, 
seems like a singularly bad idea, even if it wasn't for the coherence.

I did consider doing the indexing only on demand, and we can certainly 
simply just "turn it off" when we know it's never going to get used (ie 
"git ls-files"). So in that sense, it's easy to get rid of the overhead, 
but it didn't really seem like the conceptual complexity (even if it's 
just a couple of lines) is really worth it. It's not like git ls-files is 
really performance-critical anyway.

>  - You would need to get rid of the table in discard_index().

Now this, of course, is obviously true.

And the patch to do that is very simple too. No need to walk any chains, 
since the "free(istate->alloc);" will release all the pre-allocated 
cache_entry structures, and the rest are (necessarily) leaked anyway.

[ Side note for non-Junios: the leaking of cache_entry structures isn't 
  new, we've always done it, and it's even done on purpose. The common 
  case is that there is one *big* allocation (istate->alloc) that contains 
  all the original cache entries.

  There are usually none, or only a very few individual allocations, and 
  we don't even keep track of them. With the new in-memory format, we 
  could make a special flag that does "is this cache-entry an individual 
  allocation or not" (or we could even just see if they are inside the 
  "alloc" range), but the common case really should be that there's just a 
  couple of them, and we just drop them rather than tracking them. ]

Here.

		Linus

---
 read-cache.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 33a8ca5..abee0fc 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1142,6 +1142,7 @@ int discard_index(struct index_state *istate)
 	istate->cache_nr = 0;
 	istate->cache_changed = 0;
 	istate->timestamp = 0;
+	free_hash(&istate->name_hash);
 	cache_tree_free(&(istate->cache_tree));
 	free(istate->alloc);
 	istate->alloc = NULL;
