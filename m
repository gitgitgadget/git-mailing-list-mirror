From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb using "--cc"?
Date: Thu, 09 Feb 2006 14:26:54 -0800
Message-ID: <7v3bis88y9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
	<43EAA560.8030504@didntduck.org>
	<Pine.LNX.4.64.0602081817040.2458@g5.osdl.org>
	<7vu0b9jkad.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602090822100.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602091029310.2458@g5.osdl.org>
	<7v3bisb9qn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602091216460.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602091235210.2458@g5.osdl.org>
	<7v8xsk9s3v.fsf@assigned-by-dhcp.cox.net>
	<7v4q389rwi.fsf@assigned-by-dhcp.cox.net>
	<7voe1g8air.fsf@assigned-by-dhcp.cox.net>
	<7vk6c48a69.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 23:27:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7KFn-0006sG-Cd
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 23:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWBIW1A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 17:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWBIW1A
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 17:27:00 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:41974 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750810AbWBIW05 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 17:26:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209222436.ZBMZ17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 17:24:36 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vk6c48a69.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 09 Feb 2006 14:00:30 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15834>

Junio C Hamano <junkio@cox.net> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> On top of your patch, it was quite easy ;-)
>>
>> After the "Evil merge" in your test script, I added these:
>>
>>...
>>
>>         git diff-tree -M --cc HEAD
>
> Sorry for the noise.  The test was broken.

Second try.  Sorry again for the previous noise.

This time I made sure I am getting double-colon output;
here is what I added after your test script:

        for i in a b c d e f g h i j k l m n; do echo $i; done >d
        git-update-index --add d
        git commit -m 'Add d'

        git checkout other
        git merge fast HEAD master

        echo o >>d
        git-update-index d
        git commit -m 'Edit d'

        git checkout master
        echo 'Another' >>a
        git-update-index a
        git commit -m 'Modify a'
        git merge --no-commit 'Merge' HEAD other
        echo Extra >>a
        mv d e
        echo extra >>e
        git update-index --add --remove a d e
        git commit -m 'Evil again'

        git diff-tree -M -c HEAD

But you are right.  Rename detection with combined diff has a
funny semantics:

    diff-tree 9df5f2d... (from parents)
    Merge: 1da47fa... 09eee61...
    Author: Junio C Hamano <junkio@cox.net>
    Date:   Thu Feb 9 14:11:13 2006 -0800

        Evil again

    ::100644 100644 100644 8c3beaf... aad9366... c54c990... M	a
    ::100644 100644 100644 4f7cbe7... f8c295c... 19d5d80... M	e

This is showing that what was "d" was somehow magically called
"e" in the merge result with its own changes.  --cc output is
more interesting but the point is there is no sign of "d" in its
output, which does not feel right.

If we really care, we could show a status letter for each parent
(both are renames in this case but it is plausible one parent is
rename-edit and another is modify) and the original path in each
parent.

Does it matter?  I presume that a Porcelain that cares would
rather use the traditional "diff-tree -m -r" to look at diff
with each parent.  I dunno.

---
diff --git a/combine-diff.c b/combine-diff.c
index 15f369e..6d78305 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -829,7 +829,7 @@ const char *diff_tree_combined_merge(con
 	struct combine_diff_path *p, *paths = NULL;
 	int num_parent, i, num_paths;
 
-	diff_setup(&diffopts);
+	diffopts = *opt;
 	diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diffopts.recursive = 1;
 
@@ -846,6 +846,7 @@ const char *diff_tree_combined_merge(con
 		struct commit *parent = parents->item;
 		diff_tree_sha1(parent->object.sha1, commit->object.sha1, "",
 			       &diffopts);
+		diffcore_std(&diffopts);
 		paths = intersect_paths(paths, i, num_parent);
 		diff_flush(&diffopts);
 	}
