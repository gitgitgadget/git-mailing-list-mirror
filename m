From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 09 Aug 2007 16:38:51 -0700
Message-ID: <7vps1wwa5w.fsf@assigned-by-dhcp.cox.net>
References: <20070809163026.GD568@mbox.bz>
	<alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
	<7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net>
	<7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
	<20070809165218.9b76ebf7.seanlkml@sympatico.ca>
	<alpine.LFD.0.999.0708091426050.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091444550.25146@woody.linux-foundation.org>
	<7vtzr8wemb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, moe <moe-git@mbox.bz>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 01:39:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJHap-0005W6-12
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 01:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbXHIXi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 19:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbXHIXi7
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 19:38:59 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:34739 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbXHIXi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 19:38:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070809233854.YHTS23215.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 9 Aug 2007 19:38:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Zzeq1X00N1kojtg0000000; Thu, 09 Aug 2007 19:38:51 -0400
In-Reply-To: <7vtzr8wemb.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 09 Aug 2007 15:02:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55484>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Thu, 9 Aug 2007, Linus Torvalds wrote:
>>> 
>>> So "builtin-read-tree.c" (or rather unpack-trees.c) would need the same 
>>> kind of logic.
>>
>> The path seems to be:
>>
>>   cmd_read_tree ->
>>     unpack_trees ->
>>       unpack_trees_rec ->
>>         [ recursive .. unpack_trees_rec ] ->
>> 	  oneway_merge ->
>> 	    keep_entry ->
>> 	      add_index_entry()
>>
>> and here again we end up having the same insertion sort issue.
>
> Quite honestly, I was this (shows the "thumb and index finger
> almost touching" gesture) close to declare that unpack-trees is
> unsalvageable, and was planning to redo the one-tree (and
> perhaps two-tree) read-tree without using that mess after 1.5.3.

While I do not think the previous one was hacky at all, this one
IS a hack, not meant for inclusion.  It makes the partial commit
codepath to use vanilla "git read-tree" without any single tree
merge semantics, and rewrite that codepath to use read_tree()
which was changed with my previous patch.



---

 builtin-read-tree.c |    5 ++++-
 git-commit.sh       |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index a3b17a3..61ea15c 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -258,7 +258,10 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			opts.head_idx = 1;
 	}
 
-	unpack_trees(trees, &opts);
+	if (!opts.merge && !opts.prefix && trees && !trees->next)
+		read_tree((struct tree*) trees->item, 0, NULL);
+	else
+		unpack_trees(trees, &opts);
 
 	/*
 	 * When reading only one tree (either the most basic form,
diff --git a/git-commit.sh b/git-commit.sh
index d7e7028..b50468f 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -386,7 +386,7 @@ t,)
 		if test -z "$initial_commit"
 		then
 			GIT_INDEX_FILE="$THIS_INDEX" \
-			git read-tree --index-output="$TMP_INDEX" -i -m HEAD
+			git read-tree --index-output="$TMP_INDEX" HEAD
 		else
 			rm -f "$TMP_INDEX"
 		fi || exit
