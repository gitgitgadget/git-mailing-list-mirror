From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git diff-index" broken in 'next'
Date: Mon, 10 Mar 2008 20:20:12 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803101958350.5896@woody.linux-foundation.org>
References: <7vmyp7j8ui.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803100735530.5896@woody.linux-foundation.org> <7vk5kagexu.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 04:21:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYv3N-0001si-SE
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 04:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbYCKDUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 23:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbYCKDUr
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 23:20:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60644 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750699AbYCKDUq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2008 23:20:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2B3KroD009546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Mar 2008 20:20:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2B3KCl3019624;
	Mon, 10 Mar 2008 20:20:12 -0700
In-Reply-To: <7vk5kagexu.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.416 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76790>



On Mon, 10 Mar 2008, Junio C Hamano wrote:
> 
> I think it is somewhere around ll. 280 in unpack_callback() that causes
> this, but I don't have time to dig this further for now.

Yes indeed. I was confused. I even knew I was confused about the whole 
difference between "skip_unmerged" and not skipping unmerged entries in 
the tree unpacking, but nothing seemed to care, so I was lazy.

Now that I remember what the heck that oneway_diff thing wanted, it all 
makes sense to me again.

This should fix it.

That oneway_diff() thing is magic, and used to have a "count_skip()" 
function to skip over unmerged entries. In my confusion, I had instead 
skipped them in the generic unpack-trees.c code, and thus removed the 
skipping from oneway_diff().

That wasn't correct - we should pass the unmerged entries down and let the callback handle it.

[ Side note: nobody else than the diff code should ever have them in the 
  source index anyway - that would be a bug, since we cannot merge with a 
  source index that has unmerged entries ]

Sorry about that. Holler if you notice anythign else.

		Linus

---
 diff-lib.c     |   18 ++++++++++++++++++
 unpack-trees.c |    2 --
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 9520773..52dbac3 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -641,6 +641,21 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	show_modified(revs, tree, idx, 1, cached, match_missing);
 }
 
+static inline void skip_same_name(struct cache_entry *ce, struct unpack_trees_options *o)
+{
+	int len = ce_namelen(ce);
+	const struct index_state *index = o->src_index;
+
+	while (o->pos < index->cache_nr) {
+		struct cache_entry *next = index->cache[o->pos];
+		if (len != ce_namelen(next))
+			break;
+		if (memcmp(ce->name, next->name, len))
+			break;
+		o->pos++;
+	}
+}
+
 /*
  * The unpack_trees() interface is designed for merging, so
  * the different source entries are designed primarily for
@@ -662,6 +677,9 @@ static int oneway_diff(struct cache_entry **src, struct unpack_trees_options *o)
 	struct cache_entry *tree = src[1];
 	struct rev_info *revs = o->unpack_data;
 
+	if (idx && ce_stage(idx))
+		skip_same_name(idx, o);
+
 	/*
 	 * Unpack-trees generates a DF/conflict entry if
 	 * there was a directory in the index and a tree
diff --git a/unpack-trees.c b/unpack-trees.c
index da68557..7a30361 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -116,7 +116,6 @@ static int unpack_index_entry(struct cache_entry *ce, struct unpack_trees_option
 			add_entry(o, ce, 0, 0);
 			return 0;
 		}
-		return 0;
 	}
 	return call_unpack_fn(src, o);
 }
@@ -287,7 +286,6 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 						add_entry(o, ce, 0, 0);
 						return mask;
 					}
-					continue;
 				}
 				src[0] = ce;
 			}
