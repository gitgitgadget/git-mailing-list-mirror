From: Junio C Hamano <gitster@pobox.com>
Subject: Re* file deletion in index lost after checkout -b
Date: Sun, 07 Sep 2008 19:49:25 -0700
Message-ID: <7vprnfic7e.fsf_-_@gitster.siamese.dyndns.org>
References: <20080901034414.GR6619@jabba.hq.digizenstudio.com>
 <7vljy7xgs5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 04:50:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcWpy-0005Uh-RM
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 04:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbYIHCte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 22:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbYIHCtd
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 22:49:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39809 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbYIHCtc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 22:49:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B83615FEA1;
	Sun,  7 Sep 2008 22:49:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BD9995FE9F; Sun,  7 Sep 2008 22:49:27 -0400 (EDT)
In-Reply-To: <7vljy7xgs5.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 04 Sep 2008 23:12:26 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C2A4DAC0-7D50-11DD-9D57-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95207>

Junio C Hamano <gitster@pobox.com> writes:

> Jing Xue <jingxue@digizenstudio.com> writes:
> ...
>> In Git 1.6.0 the following sequence:
>> ...
>> The deletion of 2.txt appears lost during 'checkout -b foo', while the
>> modification and addition were both brought over. Is it a bug?
>
> This behaviour is unchanged since early June 2005.
>
>     http://thread.gmane.org/gmane.comp.version-control.git/4641/focus=4646
>
> This is exactly the case marked as *0*, which both Linus and I said "it
> feels somewhat wrong but otherwise we cannot start from an empty index".
>
> We may want to do better this time around, though.

Try this patch.

 Documentation/git-read-tree.txt |   11 ++++++++++-
 builtin-checkout.c              |    1 +
 builtin-read-tree.c             |    1 +
 unpack-trees.c                  |   11 ++++++++++-
 unpack-trees.h                  |    1 +
 5 files changed, 23 insertions(+), 2 deletions(-)

diff --git c/Documentation/git-read-tree.txt i/Documentation/git-read-tree.txt
index 6f4b9b0..24155ab 100644
--- c/Documentation/git-read-tree.txt
+++ i/Documentation/git-read-tree.txt
@@ -160,7 +160,10 @@ Here are the "carry forward" rules:
       0 nothing             nothing  nothing  (does not happen)
       1 nothing             nothing  exists   use M
       2 nothing             exists   nothing  remove path from index
-      3 nothing             exists   exists   use M
+      3 nothing             exists   exists,  use M if index is empty
+				     H == M   keep index otherwise
+				     exists   fail
+				     H != M
 
         clean I==H  I==M
        ------------------
@@ -207,6 +210,12 @@ you picked it up via e-mail in a patch form), `git diff-index
 merge, but it would not show in `git diff-index --cached $M`
 output after two-tree merge.
 
+Case #3 is slightly tricky and needs explanation.  The result from this
+rule logically should be to remove the path if the user staged the removal
+of the path and then swiching to a new branch.  That however will prevent
+the initial checkout from happening, so the rule is modified to use M (new
+tree) only when the contents of the index is empty.  Otherwise the removal
+of the path is kept as long as $H and $M are the same.
 
 3-Way Merge
 ~~~~~~~~~~~
diff --git c/builtin-checkout.c i/builtin-checkout.c
index efdb1e0..c73a815 100644
--- c/builtin-checkout.c
+++ i/builtin-checkout.c
@@ -242,6 +242,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		}
 
 		/* 2-way merge to the new branch */
+		topts.index_was_empty = !active_nr;
 		topts.update = 1;
 		topts.merge = 1;
 		topts.gently = opts->merge;
diff --git c/builtin-read-tree.c i/builtin-read-tree.c
index dddc304..41ece57 100644
--- c/builtin-read-tree.c
+++ i/builtin-read-tree.c
@@ -160,6 +160,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 				die("you need to resolve your current index first");
 			stage = 1;
 			opts.merge = 1;
+			opts.index_was_empty = !active_nr;
 			continue;
 		}
 
diff --git c/unpack-trees.c i/unpack-trees.c
index ef21c62..43ff477 100644
--- c/unpack-trees.c
+++ i/unpack-trees.c
@@ -941,8 +941,17 @@ int twoway_merge(struct cache_entry **src, struct unpack_trees_options *o)
 			return -1;
 		}
 	}
-	else if (newtree)
+	else if (newtree) {
+		if (oldtree && !o->index_was_empty) {
+			/*
+			 * deletion of the path was staged;
+			 */
+			if (same(oldtree, newtree))
+				return 1;
+			return reject_merge(oldtree, o);
+		}
 		return merged_entry(newtree, current, o);
+	}
 	return deleted_entry(oldtree, current, o);
 }
 
diff --git c/unpack-trees.h i/unpack-trees.h
index 94e5672..61d82ce 100644
--- c/unpack-trees.h
+++ i/unpack-trees.h
@@ -26,6 +26,7 @@ struct unpack_trees_options {
 		     verbose_update:1,
 		     aggressive:1,
 		     skip_unmerged:1,
+		     index_was_empty:1,
 		     gently:1;
 	const char *prefix;
 	int pos;
