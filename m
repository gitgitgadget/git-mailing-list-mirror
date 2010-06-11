From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH] unpack-trees: Make index lookahead less pessimal
Date: Thu, 10 Jun 2010 21:59:07 -0500
Message-ID: <20100611025907.GG2635@glaurung.lavos.net>
References: <20100610001005.GA2635@glaurung.lavos.net> <20100610170804.GB2635@glaurung.lavos.net> <20100610181421.GC2635@glaurung.lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 04:59:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMuSj-00009w-Ri
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 04:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760077Ab0FKC7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 22:59:12 -0400
Received: from glaurung.lavos.net ([69.162.133.92]:53446 "EHLO
	glaurung.lavos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab0FKC7K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 22:59:10 -0400
Received: by glaurung.lavos.net (Postfix, from userid 1000)
	id 9FB937417D; Thu, 10 Jun 2010 21:59:07 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20100610181421.GC2635@glaurung.lavos.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148921>

When traversing trees with an index, the current index pointer
(o->cache_base) occasionally has to be temporarily advanced forwards to
match the traversal order of the tree, which is not the same as the sort
order of the index.  The existing algorithm that did this (introduced in
730f72840cc50c523fe4cdd796ea2d2fc4571a28) would get "stuck" when the
cache_base was popped and then repeatedly check the same index entries
over and over.  This represents a serious performance regression for
large repositories compared to the old "broken" traversal order.

This commit makes a simple change to mitigate this.  Whenever
find_cache_pos sees that the current pos is also the cache_base, and it
has already been unpacked, it advances the cache_base as well as the
current pos.  This prevents the above "sticking" behavior without
dramatically changing the algorithm.

In addition, this commit moves the unpacked check above the
ce_in_traverse_path() check.  The simple bitmask check is cheaper, and
in the case described above will be firing quite a bit to advance the
cache_base after a tree pop.

This yields considerable performance improvements for large trees.
The following are the number of function calls for "git diff HEAD" on
the Linux kernel tree, with 33,307 files:

   Symbol               Calls Before   Calls After
   -------------------  ------------   -----------
   unpack_callback            35,332        35,332
   find_cache_pos             37,357        37,357
   ce_in_traverse_path     4,979,473        37,357
   do_compare_entry        6,828,181       251,925
   df_name_compare         6,828,181       251,925

And on a repository of 187,456 files:

   Symbol               Calls Before   Calls After
   -------------------  ------------   -----------
   unpack_callback           197,958       197,958
   find_cache_pos            208,460       208,460
   ce_in_traverse_path    37,308,336       208,460
   do_compare_entry      156,950,469     2,690,626
   df_name_compare       156,950,469     2,690,626

On the latter repository, user time for "git diff HEAD" was reduced from
5.58 to 0.42 seconds.  This is compared to 0.30 seconds before the
traversal order fix was implemented.

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
    So, yeah.  I admit frobbing cache_bottom from inside find_cache_pos
    feels a little ugly, but it does minimize changes to the algorithm,
    and the performance results speak for themselves.

    As far as I can tell, there's no way this modified algorithm can
    return different results from the original.  (Obviously all the
    working tests still pass.)  Both reordered cases simply called
    continue, so the order wouldn't matter unless ce_in_traverse_path
    has side effects, and the "continue" for the unpacked test is just
    a bit more permanent now.  Still, I'd appreciate it if somebody who
    knows what they are doing with this code could confirm this.

    I'd like to see this on maint if possible, since I have repo that's
    pretty unpleasant to use with the current release.

    -bcd

 unpack-trees.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index c29a9e0..94b8ecd 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -520,9 +520,17 @@ static int find_cache_pos(struct traverse_info *info,
 		const char *ce_name, *ce_slash;
 		int cmp, ce_len;
 
-		if (!ce_in_traverse_path(ce, info))
+		if (ce->ce_flags & CE_UNPACKED) {
+			/*
+			 * cache_bottom entry is already unpacked, so
+			 * we can never match it; don't check it
+			 * again.
+			 */
+			if (pos == o->cache_bottom)
+				++o->cache_bottom;
 			continue;
-		if (ce->ce_flags & CE_UNPACKED)
+		}
+		if (!ce_in_traverse_path(ce, info))
 			continue;
 		ce_name = ce->name + pfxlen;
 		ce_slash = strchr(ce_name, '/');
-- 
1.7.1

On Thu, Jun 10, 2010 at 01:14:21PM -0500, Brian Downing wrote:
> On Thu, Jun 10, 2010 at 12:08:04PM -0500, Brian Downing wrote:
> > I also ran this through callgrind to see how often the above were called:
> 
> (187,456 files)
> 
> >         Calls  Symbol
> >   -----------  -------------------
> >       197,958  unpack_callback
> >       208,460  find_cache_pos
> >    37,308,336  ce_in_traverse_path
> >   156,950,469  do_compare_entry
> >   156,950,469  df_name_compare
> 
> Here is an identical run (git-diff HEAD) from the Linux kernel tree
> (33,307 files):
> 
>         Calls  Symbol
>    -----------  -------------------
>         35,332  unpack_callback
>         37,357  find_cache_pos
>      4,979,473  ce_in_traverse_path
>      6,828,181  do_compare_entry
>      6,828,181  df_name_compare
> 
> That makes it look sort of exponential (perhaps around files^1.5),
> though from what I can understand of the find_cache_pos code in
> unpack-trees it would depend on the exact shape of the repository.  It
> does seem to linear-search over whole directory trees of the index
> repeatedly, though, which would support the exponential theory.
> 
> Unfortunately I don't really understand what the code is trying to do.
> Is it not the case that trees and the index are always stored sorted in
> the same order?  The examples given in the commit messages that
> introduced this fix would imply not, but I'm not sure how that could
> come about.
> 
> -bcd
> 
