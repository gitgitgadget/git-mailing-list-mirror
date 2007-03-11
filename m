From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: use binary search in tree_content_remove
Date: Sat, 10 Mar 2007 22:38:33 -0500
Message-ID: <20070311033833.GB10781@spearce.org>
References: <<20070310191515.GA3416@coredump.intra.peff.net>> <20070310192131.GB3875@coredump.intra.peff.net> <20070310192304.GB3416@coredump.intra.peff.net> <20070310194012.GA5126@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 04:38:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQEtb-00047X-13
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 04:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932805AbXCKDij (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 22:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932809AbXCKDij
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 22:38:39 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58752 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932805AbXCKDii (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 22:38:38 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQEt6-000484-BB; Sat, 10 Mar 2007 22:38:24 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EE68D20FBAE; Sat, 10 Mar 2007 22:38:33 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070310194012.GA5126@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41901>

Jeff King <peff@peff.net> wrote:
> And here it is. However, I should note that this patch is _not_
> necessary.

Well, its not necessary for you, as you aren't trying to remove
something from your huge tree.  ;-)

> I had originally thought that removal might destroy the
> sorting that I added in the last patch, but it looks like the entry
> isn't actually removed. Shawn, can you sanity check this?

Your patch is fine.  fast-import takes an "optimization" here and
does not bother to actually delete entries from a tree until *after*
we have written the tree data out to the packfile.  The reason
is we need to retain the version 0 tree entry objects to recreate
the delta base.  Since these are combined with the version 1 data
(the "new" data) we have to delay the actual deletes until after
we store the tree and have its SHA-1.

It turns out however that your entire series was broken. I had to
commit the following on top of it to fix it:

-->8--
From 0af148553a94f7e856089fa68395524932240145 Mon Sep 17 00:00:00 2001
From: Shawn O. Pearce <spearce@spearce.org>
Date: Sat, 10 Mar 2007 22:34:12 -0500
Subject: [PATCH] fast-import: Brown paper bag fix tree sorting

Jeff King's recent changes to sort trees by strictly name (and binary
search to locate an entry) works OK up until we have to write a
tree out that uses the funny name/mode sorting that native Git uses:

  b.
  b/
  ba

Here the subtree "b" must sort between files "b." and "ba", but
Jeff's changes have it sorting before "b.".  This means we would fail
to find entries during future modifications to that tree as Jeff's
binary search algorithm won't find subtree "b" between b.  and ba.

I'm plastering over the problem by resorting a tree strictly by
name after it has been written out and the deleted entries have
been filtered out.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 fast-import.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 716819f..fa3b766 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1136,6 +1136,13 @@ static int tecmp1 (const void *_a, const void *_b)
 		b->name->str_dat, b->name->str_len, b->versions[1].mode);
 }
 
+static int nmcmp (const void *_a, const void *_b)
+{
+	struct tree_entry *a = *((struct tree_entry**)_a);
+	struct tree_entry *b = *((struct tree_entry**)_b);
+	return strcmp(a->name->str_dat, b->name->str_dat);
+}
+
 static void mktree(struct tree_content *t,
 	int v,
 	unsigned long *szp,
@@ -1218,6 +1225,7 @@ static void store_tree(struct tree_entry *root)
 		}
 	}
 	t->entry_count -= del;
+	qsort(t->entries, t->entry_count, sizeof(t->entries[0]), nmcmp);
 }
 
 static int tree_content_set(
-- 
1.5.0.3.942.g299f
