From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange merge failure (would be overwritten by merge / cannot
 merge)
Date: Sat, 05 Sep 2009 17:33:30 -0700
Message-ID: <7vzl98vrmt.fsf@alter.siamese.dyndns.org>
References: <4AA17874.7090905@debian.org>
 <7vr5ul99o2.fsf@alter.siamese.dyndns.org> <20090904234552.GA43797@gmail.com>
 <7vab191dz1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, Christoph Haas <haas@debian.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 06 02:35:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mk5ij-0007DK-Uz
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 02:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbZIFAdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 20:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753539AbZIFAdm
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 20:33:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbZIFAdl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 20:33:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A8EFE278A9;
	Sat,  5 Sep 2009 20:33:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N2/yKdRxzlsy51KdH9MweA0V9Ks=; b=E6OomS
	8/6Mygen5sBDAmxlXTouuMlcP45YpSucYz+D1fEt6KZdZvS+9T7mv/LC1MeeHJti
	Wi/n8erP1RMx3CvlUC34tjDckliPRMB4qbJnJn5lo4vGjUhkPQCDmM9HFYqNZHtb
	BtFkVj+WHEFhTWctTZ6p+uEqjbpZMGsqHbC+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nwzvHqa0EmvmeUtROm+xmfQu1z3Q2wm3
	P17Jt+JD36WdhPXtGqkwQgKVyAYv18Bv6WFms4S7v3KAYJ/WCpwa0Mqakx+5Qs8d
	tSzGuokhI2gBI7aPg6Yk+qJ4N2pVAzgNtHqNW9Ri6AIVR8FW7/7lcllpMmyffPp3
	59jZbY3/aKg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F880278A8;
	Sat,  5 Sep 2009 20:33:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9409F278A7; Sat,  5 Sep
 2009 20:33:32 -0400 (EDT)
In-Reply-To: <7vab191dz1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 05 Sep 2009 10\:46\:42 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EAD77044-9A7C-11DE-BE42-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127830>

Junio C Hamano <gitster@pobox.com> writes:

> David Aguilar <davvid@gmail.com> writes:
>
>> Does anyone else on the list have any insights?
>
> Yes; the problem does not have anything to do with renames but
> unfortunately is much deeper.  See $gmane/127783.
>
> Here is a reproduction recipe for the lowest-level ingredient of the
> breakage in "git read-tree -m"that needs to be fixed, before we can start
> looking at what "git merge-recursive" does incorrectly (if any) and what
> "git merge" does incorrectly (again, if any).

To summarize the expected failure in this test, we merge these three trees:

    $ git ls-tree -t -r ONE
    040000 tree fd43cc879db368e808a98b81005d6f21a8852a15    t
    100644 blob d00491fd7e5bb6fa28c517a0bb32b8b506539d4d    t/f
    $ git ls-tree -t -r TWO
    100644 blob 0cfbf08886fca9a91cb753ec8734c84fcbe52c9f    t
    100644 blob 0cfbf08886fca9a91cb753ec8734c84fcbe52c9f    t-f
    $ git ls-tree -t -r THREE
    100644 blob 00750edc07d6415dcc07ae0351e9397b0222b7ba    t-f
    040000 tree 5b372f88770ab124f5149bc6eae19714b16ee363    t
    100644 blob 00750edc07d6415dcc07ae0351e9397b0222b7ba    t/f

while the index matches TWO.  The callback to unpack_trees() wants to get
"t" fed by the tree-walk API in a single call, but it is hard to arrange,
as in tree TWO the name "t-f" comes after name "t" and in tree THREE it
comes before "t".  When other trees want to yield "t", somebody in the
callchain needs to notice the situation, and yield "t" from tree THREE,
and then later yield "t-f", to meet the expectation of unpack_trees().

I was staring at this a bit more until my head started aching, and my
tentative conclusion is that the cleanest solution would be to change
tree-walk API so that it returns the entries in the order as if everything
were blobs.  E.g. even though in tree THREE, a subtree "t" is stored after
blob "t-f", we return "t".  Later, when told to update_tree_entry(), skip
back and yield "t-f".  After that when told to update_tree_entry(), notice
we have already given "t" back and skip to finish traversing THREE.

This would be necessary because unpack_callback() in unpack-trees.c wants
to see if the entry of the same name happens to be at the o->pos in the
index.  What it means is if all trees being merged (including TWO, that is
supposed to be similar to the index) had "t" as tree and "t-f" as blob, if
the index had "t-f" and "t" both as blobs, we would not be able to match
up the "t" (tree) entries from the merged trees with "t" (blob) entry
taken from the index.

Unfortunately, the callers of tree-walk API checks desc->size to see if
the traversal reached at the end before calling update_tree_entry(), so
the safest and simplest fix might end up to be sorting the tree buffer in
init_tree_desc().

What do you think?  Am I completely off the track?

>  t/t1004-read-tree-m-u-wf.sh |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)
>
> diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
> index f19b4a2..055bb00 100755
> --- a/t/t1004-read-tree-m-u-wf.sh
> +++ b/t/t1004-read-tree-m-u-wf.sh
> @@ -238,4 +238,27 @@ test_expect_success 'D/F recursive' '
>  
>  '
>  
> +################################################################
> +
> +test_expect_failure 'D/F D-F' '
> +	git reset --hard &&
> +	git rm -f -r . &&
> +
> +	mkdir t && echo 1 >t/f && git add t &&
> +	git tag ONE $(git write-tree) &&
> +
> +	echo 3 >t-f && echo 3 >t/f && git add t-f t &&
> +	git tag THREE $(git write-tree) &&
> +
> +	git rm -f -r t &&
> +	echo 2 >t && echo 2 >t-f && git add t t-f &&
> +	git tag TWO $(git write-tree) &&
> +	git commit -a -m TWO &&
> +
> +	test_must_fail git read-tree -m -u ONE TWO THREE &&
> +	git ls-files -u >actual &&
> +	grep t/f actual &&
> +	grep t-f actual
> +'
> +
>  test_done
