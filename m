From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix recent 'unpack_trees()'-related changes breaking 'git stash'
Date: Fri, 14 Mar 2008 21:20:41 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803142023490.3557@woody.linux-foundation.org>
References: <20080315014133.GB32265@neumann>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: SZEDER G?bor <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 05:21:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaNtr-0002bt-Ax
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 05:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbYCOEU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 00:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbYCOEU7
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 00:20:59 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33851 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750796AbYCOEU6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Mar 2008 00:20:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2F4Lf8l010560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Mar 2008 21:21:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2F4Kfi5001080;
	Fri, 14 Mar 2008 21:20:42 -0700
In-Reply-To: <20080315014133.GB32265@neumann>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.322 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77303>



On Sat, 15 Mar 2008, SZEDER G?bor wrote:
>
> The testcase usually fails during the first 25 run, but sometimes it
> runs more than 100 times before failing.

Damn, this series has had more subtle issues than I ever expected.

'git stash' creates its saved working tree object with:

        # state of the working tree
        w_tree=$( (
                rm -f "$TMP-index" &&
                cp -p ${GIT_INDEX_FILE-"$GIT_DIR/index"} "$TMP-index" &&
                GIT_INDEX_FILE="$TMP-index" &&
                export GIT_INDEX_FILE &&
                git read-tree -m $i_tree &&
                git add -u &&
                git write-tree &&
                rm -f "$TMP-index"
        ) ) ||
                die "Cannot save the current worktree state"

which creates a new index file with the updates, and writes the tree from 
that.

We have this logic where we compare the timestamp of the index with the 
timestamp of the files and we then write them out "smudged" if they are 
the same, and it basically depends on the fact that the date on the index 
file is compared with the date encoded in the stat information itself.

And what is going on is:

 - we create a new index file with that "cp". We are careful to preserve 
   the timestamps by using "-p", so this one should be all ok.

 - then we *update* that index by resetting it to the tree with git 
   read-tree, but now we do *not* preserve the timestamp on this new copy 
   any more, even though we copy over all the timestamps on the files that 
   are indexed from the stat information!

Now, we always had that problem when re-writing the index, but we had this 
clever workaround in the writing part: if the source had racily clean 
entries, then when we wrote those out (and thus can't depend on the index 
fiel timestamp showing that they are racily clean any more!), we would 
smudge them when writing. 

IOW, we handle this issue by having write_index() do this:

	for (i = 0; i < entries; i++) {  
		...
		if (is_racy_timestamp(istate, ce))
			ce_smudge_racily_clean_entry(ce);
		..

when writing out entries. And that all took care of it, because now when 
we wrote the new index, we'd change the timestamp on the index, yes, but 
we'd smudge the entries we wrote out, so now the resulting index would 
still show that file as not-up-to-date any more.

But with commit 34110cd4e394e3f92c01a4709689b384c34645d8 ("Make 
'unpack_trees()' have a separate source and destination index"), this 
logic no longer triggers, because we now write out the "result" index, and 
that one never got its timestamp updated from the source index, so it had 
lost all that "is_racy_timestamp()" information!

This trivial patch fixes it. It looks trivial, and it's a simple fix, but 
boy did it take me way too much thinking and explaining to myself to 
explain why there was a problem in the first place!

The trivial fix is to just copy the index timestamp from the source index 
into the result index. But we only do this if we *have* a source index, of 
course, and if we will even bother to use the result.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 unpack-trees.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 91649f3..77d52db 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -336,6 +336,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	state.refresh_cache = 1;
 
 	memset(&o->result, 0, sizeof(o->result));
+	if (o->src_index && o->dst_index)
+		o->result.timestamp = o->src_index->timestamp;
 	o->merge_size = len;
 
 	if (!dfc)
