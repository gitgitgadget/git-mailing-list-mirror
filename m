From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH] CE_REMOVE conversion
Date: Thu, 21 Feb 2008 00:39:28 -0800
Message-ID: <7v7igywvnj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 09:40:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS6yg-0005OS-E4
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 09:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbYBUIji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 03:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbYBUIji
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 03:39:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbYBUIjh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 03:39:37 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A72A9264B;
	Thu, 21 Feb 2008 03:39:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 77DC5264A; Thu, 21 Feb 2008 03:39:30 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74608>

You converted "ce->ce_mode = 0" to "ce->ce_flags |= CE_REMOVE" in an
earlier commit 7a51ed6 (Make on-disk index representation
separate from in-core one).

I am having two issues with this conversion, related to read-tree.

If you say "git reset --hard" with an unmerged path in the
index, the entry does not get resurrected from the HEAD.  It
instead just goes away (i.e. you lose a path in the index).
If you run "git reset --hard" twice, the second run will
resurrect it, of course, as the first one removed the unmerged
paths.

"git reset --hard" internally runs "read-tree -u --reset HEAD",
and the oneway_merge() misbehaves.

        commit 7a51ed66f653c248993b3c4a61932e47933d835e
        Author: Linus Torvalds <torvalds@linux-foundation.org>
        Date:   Mon Jan 14 16:03:17 2008 -0800

            Make on-disk index representation separate from in-core one

        diff --git a/builtin-read-tree.c b/builtin-read-tree.c
        index c0ea034..5785401 100644
        --- a/builtin-read-tree.c
        +++ b/builtin-read-tree.c
        @@ -45,8 +45,7 @@ static int read_cache_unmerged(void)
                                        continue;
                                cache_tree_invalidate_path(active_cache_tree, ce->name);
                                last = ce;
        -			ce->ce_mode = 0;
        -			ce->ce_flags &= ~htons(CE_STAGEMASK);
        +			ce->ce_flags |= CE_REMOVE;
                        }
                        *dst++ = ce;
                }

One issue is somewhat apparent.  The conversion forgot to drop
the stage information (i.e. it does not tell "that stage#0 path
is to be removed" anymore).

Another thing is a bit trickier.  Now because you do not smudge
ce->ce_mode, when oneway_merge in unpack-trees.c compares it
(which comes as *old) with what is read from HEAD, it triggers
this codepath:

	if (old && same(old, a)) {
		if (o->reset) {
			struct stat st;
			if (lstat(old->name, &st) ||
			    ce_match_stat(old, &st, CE_MATCH_IGNORE_VALID))
				old->ce_flags |= CE_UPDATE;
		}
		return keep_entry(old, o);
	}

Here, same(old, a) yields true, old->ce_flags gets CE_UPDATE,
and then keep_entry(old, o) keeps that old entry, which is at
stage #1 and has (CE_REMOVE|CE_UPDATE) flags set.  This index is
written out, making the resulting index empty.

The reason we keep an index entry with ce_mode = 0 (and now
CE_REMOVE) when we want to remive it is because we would want to
be able to say "propagate this change to the work tree" when run
with CE_UPDATE.  But I think the reason read_cache_unmerged()
says "this unmerged entry is gone" is _not_ because we would
want to remove the corresponding path from the work tree.

The old code happened to work because "ce_mode = 0" entries
would have never matched with what was read from the HEAD tree,
and we would never have triggered the keep_entry() codepath.

We could of course hack read_cache_unmerged() to:

	if (ce_stage(ce)) {
		if (last && !strcmp(ce->name, last->name))
			continue;
		cache_tree_invalidate_path(active_cache_tree, ce->name);
		last = ce;
		ce->ce_flags &= ~CE_STAGEMASK;
		/* Do not match with entries from trees! */
		ce->ce_mode = 0;
	}
	*dst++ = ce;

but I am wondering if we should instead really _remove_ entries
from the index instead, just like the attached patch.

Thoughts?

 builtin-read-tree.c |    2 +-
 t/t7104-reset.sh    |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 5785401..726fb0b 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -45,7 +45,7 @@ static int read_cache_unmerged(void)
 				continue;
 			cache_tree_invalidate_path(active_cache_tree, ce->name);
 			last = ce;
-			ce->ce_flags |= CE_REMOVE;
+			continue;
 		}
 		*dst++ = ce;
 	}
diff --git a/t/t7104-reset.sh b/t/t7104-reset.sh
new file mode 100755
index 0000000..831078c
--- /dev/null
+++ b/t/t7104-reset.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+test_description='reset --hard unmerged'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	>hello &&
+	git add hello &&
+	git commit -m world &&
+
+	H=$(git rev-parse :hello) &&
+	git rm --cached hello &&
+	for i in 1 2 3
+	do
+		echo "100644 $H $i	hello"
+	done | git update-index --index-info &&
+
+	rm -f hello &&
+	mkdir -p hello &&
+	>hello/world &&
+	test "$(git ls-files -o)" = hello/world
+
+'
+
+test_expect_failure 'reset --hard loses the index' '
+
+	git reset --hard &&
+	git ls-files --error-unmatch hello &&
+	test -f hello
+
+'
+
+test_done
