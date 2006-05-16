From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merge with local conflicts in new files
Date: Tue, 16 May 2006 15:40:52 -0700
Message-ID: <7v1wut61aj.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160605161500m1dd8428cj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 00:41:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg8EL-0002dS-Jc
	for gcvg-git@gmane.org; Wed, 17 May 2006 00:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWEPWk4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 18:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWEPWkz
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 18:40:55 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:36018 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932260AbWEPWky (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 18:40:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060516224053.DBTQ18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 May 2006 18:40:53 -0400
To: Santi <sbejar@gmail.com>
In-Reply-To: <8aa486160605161500m1dd8428cj@mail.gmail.com> (sbejar@gmail.com's
	message of "Wed, 17 May 2006 00:00:10 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20143>

Santi <sbejar@gmail.com> writes:

>       In the case of:
>
> - You merge from a branch with new files
> - You have these files in the working directory
> - You do not have these files in the HEAD.

and

 - You have not told git that these files matter.

>...
> test_expect_success 'prepare repository' \
> 'echo "Hello" > init &&
> git add init &&
> git commit -m "Initial commit" &&
> git branch B &&
> echo "foo" > foo &&
> git add foo &&
> git commit -m "File: foo" &&
> git checkout B &&
> echo "bar" > foo '

At this point, you have not told git that foo is a file that is
relevant on branch B, so git considers it a fair game to
overwrite.

At least, that was the original reasoning.

It happens not just during the ordinary "git-merge", by the way.
If you are on branch B that did not have 'foo', created 'foo'
and switched to branch A (which has 'foo') before telling the
index that you care about your version of 'foo' on branch B,
'foo' from branch A will overwrite your throwaway copy in the
working tree:

	$ git branch
	* master
        $ git branch another
	$ echo 'New file' >afile
        $ git add afile
        $ git commit -m 'Add afile'
        $ git checkout another
        $ ls afile
	ls: afile: No such file or directory
        $ echo 'Lost file' >afile
        $ git checkout master
        $ cat afile
        New file

We acquired "git apply" which does take notice when you have
such an untracked file in the working tree that conflicts with
what it does to the index, and I think its behaviour sometimes
is more user friendly and safer than what the merge does
currently (but it irritates people some other times).

This is totally untested, but on top of "next" you could do
something like this, perhaps.

We _might_ want to do this conditionally, only when the user
asks, though.  I dunno.  Being able to blow away irrelevant
files is sometimes a good thing, so we _might_ want to have a
reverse logic to "git apply" that makes it blow away untracked
working tree files under "--index" option.

-- >8 --

diff --git a/read-tree.c b/read-tree.c
index aa6172b..185a73f 100644
--- a/read-tree.c
+++ b/read-tree.c
@@ -453,8 +453,18 @@ static int merged_entry(struct cache_ent
 			invalidate_ce_path(old);
 		}
 	}
-	else
+	else {
+		/*
+		 * Originally we did not have a cache entry here but
+		 * are creating a new file as a result of the merge.
+		 * Do we want to lose the untracked working tree files?
+		 */
+		struct stat st;
+
+		if (!lstat(merge->name, &st))
+			die("Untracked working tree file '%s' would be overwritten by merge.", merge->name);
 		invalidate_ce_path(merge);
+	}
 	merge->ce_flags &= ~htons(CE_STAGEMASK);
 	add_cache_entry(merge, ADD_CACHE_OK_TO_ADD);
 	return 1;
@@ -701,7 +711,7 @@ static int bind_merge(struct cache_entry
 		return error("Cannot do a bind merge of %d trees\n",
 			     merge_size);
 	if (!a)
-		return merged_entry(old, NULL);
+		return merged_entry(old, old);
 	if (old)
 		die("Entry '%s' overlaps.  Cannot bind.", a->name);
 
@@ -736,7 +746,7 @@ static int oneway_merge(struct cache_ent
 		}
 		return keep_entry(old);
 	}
-	return merged_entry(a, NULL);
+	return merged_entry(a, old);
 }
 
 static int read_cache_unmerged(void)
