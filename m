From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/48] t6039: Ensure rename/rename conflicts leave index
 and workdir in sane state
Date: Mon, 18 Jul 2011 16:40:28 -0700
Message-ID: <7vaacbb1jn.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-8-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 01:40:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QixQb-0003Wr-GG
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 01:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746Ab1GRXkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 19:40:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38358 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114Ab1GRXka (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 19:40:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67F244212;
	Mon, 18 Jul 2011 19:40:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=7yF063fiHc3weRNoZlQbaogrPUE=; b=g5G5mc7veATdS1nlxu7l
	afKbwARO/GSzDDbubZ/ejmAWa8yORPEwwEN5lTnLFzcZqtCV406pZMJPAyyJ/o32
	Npuv8ZyCtNvBDe4NLX08eXbZjEmlUanP7CZrQ1PjAy//WhUcgL27uYxQCKpdc+vG
	uYHgeQl1DD+gHz2K+68Fkvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=q3KA0b6Jn3ycfXVWouA6F4a2HtZz2BO9C+P8nO/Y6FI4hl
	X/770Eq7yQ3ofpk89aV0aFMAtzg6aIFY8oQUD3z7e4nygPWvrQ8VxhU9qcgJhNwT
	scbl4YvSrOs7PKet7lg2qXKSHrfOJYByHvjsPAbJ2nsq+sMlx/m7O3DbESPS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F5AD4211;
	Mon, 18 Jul 2011 19:40:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A65DD420F; Mon, 18 Jul 2011
 19:40:29 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 521CDE28-B197-11E0-AB4D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177426>

Elijah Newren <newren@gmail.com> writes:

> +test_expect_success 'setup simple rename/rename (1to2) conflict' '
> +	git rm -rf . &&
> +	git clean -fdqx &&
> +	rm -rf .git &&
> +	git init &&
> +
> +	echo stuff >a &&
> +	git add a &&
> +	test_tick &&
> +	git commit -m A &&
> +	git tag A &&
> +
> +	git checkout -b B A &&
> +	git mv a b &&
> +	test_tick &&
> +	git commit -m B &&
> +
> +	git checkout -b C A &&
> +	git mv a c &&
> +	test_tick &&
> +	git commit -m C
> +'

This looks like a simpler variant of the last test in 06/48; shouldn't it
come before the more complex one?

> +
> +test_expect_success 'merge has correct working tree contents' '
> +	git checkout C^0 &&
> +
> +	test_must_fail git merge -s recursive B^0 &&
> +
> +	test 3 -eq $(git ls-files -s | wc -l) &&
> +	test 3 -eq $(git ls-files -u | wc -l) &&
> +	test 0 -eq $(git ls-files -o | wc -l) &&
> +
> +	test -f b &&
> +	test -f c
> +'

This test is being a bit too lazy, compared to the better ones in 06/48,
no? What do we want to see here? Perhaps

 - "a" at stage #1 with "stuff", not in the working tree;
 - "b" at stage #3 with "stuff", same in the working tree; and
 - "c" at stage #2 with "stuff", same in the working tree

> +# Test for all kinds of things that can go wrong with rename/rename (2to1):
> +#   Commit A: new files: a & b
> +#   Commit B: rename a->c, modify b
> +#   Commit C: rename b->c, modify a
> +#
> +# Merging of B & C should NOT be clean.  Questions:
> +#   * Both a & b should be removed by the merge; are they?
> +#   * The two c's should contain modifications to a & b; do they?
> +#   * The index should contain two files, both for c; does it?
> +#   * The working copy should have two files, both of form c~<unique>; does it?
> +#   * Nothing else should be present.  Is anything?

What is the most useful thing to leave in the index and in the working
tree for the person who needs to resolve such a merge using the working
tree, starting from B and merging C? The above "Questions" lists what the
current code might try to do but I am not sure if it is really useful. For
example, in the index, you would have to stuff two stage #1 entries ("a"
from A and "b" from A) for path "c", with stage #2 ("c" from B) and stage
#3 ("c" from C) entries, and represent what B tried to do to "a" (in the
above you said "rename a->c" but it does not have to be a rename without
content change) and what C tried to do to "b" in the half-conflicted
result that is in a single file "c". Because the result are totally
unrelated files (one side wants a variant of original "a" there, the other
side wants a variant of "b"), such a half-merge result is totally useless
to help the person to come up with anything.

Also renaming "c" to "c~<unique>", if they do not have corresponding
entries in the index to let you check with "git diff", would make the
result _harder_ to use, not easier. So if you are going to rename "c" to
"c-B" and "c-C", at least it would make much more sense to have in the
index:

 - "c-B", with stage #1 ("a" from A), stage #2 ("c" from B) and stage #3
   ("a" from C);
 - "c-C", with stage #1 ("b" from A), stage #2 ("b" from B) and stage #3
   ("c" from C); and
 - No "a" nor "b" in the index nor in the working tree.

no?

That way, you could run "git diff" to get what happened to the two
variants of "a" and "b" at the content level, and decide to clean things
up with:

    $ git diff ;# view content level merge
    $ edit c-B c-C; git add c-B c-C
    $ git mv c-B c-some-saner-name
    $ git mv c-C c-another-saner-name
    $ edit other files that refer to c like Makefile
    $ git commit

To take it one step further to the extreme, it might give us a more
reasonable and useful conflicted state if we deliberately dropped some
information instead in a case like this, e.g.:

 - We may want to have "a" at stage #1 (from A) in the index;
 - No "a" remains in the working tree;
 - "b" at stage #1 (from A), stage #2 (from B) and stage #3 ("c" from C);
 - "b" in the working tree a conflicted-merge of the above three;
 - "c" at stage #1 ("a" from A), stage #2 (from B), and stage #3 ("a" from
   C); and
 - "c" in the working tree a conflicted-merge of the above three.

Note that unlike the current merge-recursive that tries to come up with a
temporary pathname to store both versions of C, this would ignore "mv b c"
on the A->C branch, and make the conflicted tentative merge asymmetric
(merging B into C and merging C into B would give different conflicts),
but I suspect that the asymmetry may not hurt us.

Whether the merger wants to keep "c" that was derived from "a" (in line
with the HEAD) or "c" that was derived from "b" (in line with MERGE_HEAD),
if the result were to keep both files in some shape, the content level
edit, renaming of at least one side, and adjusting other files that refer
to it, are all required anyway, e.g.

    $ git diff ;# view content level merge
    $ edit b c; git add b c
    $ edit other files that refer to c line Makefile (the content C's
      change wants is now in "b").
    $ git commit

would be a way to pick "c" as "c-some-saner-name" and "b" as
"c-another-saner-name" in the previous workflow, but needs much less
typing. The complexity of the workflow would be the same if the final
resolution is to take what one side did and dropping the other's work,
I think.
