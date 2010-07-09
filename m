From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix read-tree storing wrong tree reference with modified
 index
Date: Thu, 08 Jul 2010 17:45:28 -0700
Message-ID: <7v630po53r.fsf@alter.siamese.dyndns.org>
References: <20100708224653.GB50404@book.hvoigt.net>
 <7vvd8po804.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Jul 09 02:45:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX1ir-0000Hm-PL
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 02:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759008Ab0GIApi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 20:45:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758967Ab0GIAph (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 20:45:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ECCFCC2C10;
	Thu,  8 Jul 2010 20:45:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=JterL8WGwfgztbYJm8qIccT1rto=; b=eWHzruasPEic7i5k3lY2hDo
	A92xCkU/7BI6gUpbShP+BOpKxsyufXnjgaRVjqfqkig0TubZVhbvDm7fWnrGuYaw
	dYYeBj/P23nWPTScdqBbH5Liv6a8To6kY7z+yib3zaqpOdgxV1yRPpnvfL0Z1gsu
	+vfISF+88fvYkBtxaBLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=OsfbNrEd7+Awb+0nLGo7vqrQJQ9yoyNWudDhq5GzLlM+kjKcN
	Yq4bblZFsRQTvNU4GPl8xIuL+Gt2D4p2TypXN9ABp9vsjbpgfobxigNWA+JmHGcq
	HJ3eMciOdQs5fehtShQArPRAtEBglZFJrrKmE9BLCVwK1MdjuXkwsNEYM4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4CE9C2C0F;
	Thu,  8 Jul 2010 20:45:32 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D57C1C2C0E; Thu,  8 Jul
 2010 20:45:29 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 479ABB6C-8AF3-11DF-AC48-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150625>

Junio C Hamano <gitster@pobox.com> writes:

> Heiko Voigt <hvoigt@hvoigt.net> writes:
>
>>  	 * The same holds true if we are switching between two trees
>> -	 * using read-tree -m A B.  The index must match B after that.
>> +	 * using read-tree A B (without -m). The index must match B
>> +	 * after that. With given -m it can be a mix of the old index
>> +	 * and the read one.
>
> I think the justification of the original patch is completely bogus.  Why
> not just drop the priming instead?  Two-tree read-tree without -m does not
> make much sense but the result would look like an overlay of two trees,
> and is not likely to match either of the trees.

IOW, how about doing this (backported to 1.6.4 codebase) instead?

-- >8 --
Subject: [PATCH] Fix "read-tree -m A B" priming the cache-tree

In 456156d a shortcut to priming the index tree reference was
introduced, but the justification for it was completely bogus.

"read-tree -m A B" is to take the index (and the working tree)
that is largely based on (but does not have to match exactly) A
and update it to B, while carrying the local change that does
not overlap the difference between A and B, so there is no reason
to expect that the resulting index should match the tree B.

Noticed and test provided by Heiko Voigt.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-read-tree.c         |    5 -----
 t/t1001-read-tree-m-2way.sh |   16 ++++++++++++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 82e25ea..4fbf5f8 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -199,14 +199,9 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	 * "-m ent" or "--reset ent" form), we can obtain a fully
 	 * valid cache-tree because the index must match exactly
 	 * what came from the tree.
-	 *
-	 * The same holds true if we are switching between two trees
-	 * using read-tree -m A B.  The index must match B after that.
 	 */
 	if (nr_trees == 1 && !opts.prefix)
 		prime_cache_tree(&active_cache_tree, trees[0]);
-	else if (nr_trees == 2 && opts.merge)
-		prime_cache_tree(&active_cache_tree, trees[1]);
 
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_locked_index(&lock_file))
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 271bc4e..6e3b601 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -392,4 +392,20 @@ test_expect_success \
      git ls-files --stage | tee >treeMcheck.out &&
      test_cmp treeM.out treeMcheck.out'
 
+test_expect_success '-m references the correct modified tree' '
+	echo >file-a &&
+	echo >file-b &&
+	git add file-a file-b &&
+	git commit -a -m "test for correct modified tree"
+	git branch initial-mod &&
+	echo b >file-b &&
+	git commit -a -m "B" &&
+	echo a >file-a &&
+	git add file-a &&
+	git ls-tree $(git write-tree) file-a >expect &&
+	git read-tree -m HEAD initial-mod &&
+	git ls-tree $(git write-tree) file-a >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.2.rc2.191.gd2de1
