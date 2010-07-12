From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] 'diff A...B' fails with multiple merge bases
Date: Mon, 12 Jul 2010 16:30:44 -0700
Message-ID: <7vaapw8ehn.fsf@alter.siamese.dyndns.org>
References: <3BA20DF9B35F384F8B7395B001EC3FB36CF674AE@azsmsx507.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Pickens\, James E" <james.e.pickens@intel.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 01:31:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYSSp-0004rg-NY
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 01:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab0GLXay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 19:30:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab0GLXax (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 19:30:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44A64C43BD;
	Mon, 12 Jul 2010 19:30:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OJb/b2xlIZm5tmB+29sbf4Hh52c=; b=vn9cjw
	hNqoeKrpccVva/HjumPCrlRDLX77VOiZKLQ5A0ogB9G8mFdTt37wlcBz3D84yQCQ
	GH+TgQDfHyZvyfXs9ohKu8KXAWD/LKmK+GS30W/1QvfsiT8kY1hlJGfvRt5sqkv9
	+y0TWEzr6/VnqUyuxjrSAnvLUwy/VK/Y3bL5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YnxELt9k6xDNiI2valDbuDbj3v4iwUoE
	MaSiJ/aOvmLzCFnZd60hqULVMR8Sg13dV5ZpfNphmUbU/5RfQuUjoW1y293Qy6eb
	F70cWROi0n5YZ5UFQ3ORg1yRYrZ/ObFZCgfqS2Ak9vpWhWzciTq2RhEALZsjJgi5
	UK/F0lqfSO8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 20EC7C43BC;
	Mon, 12 Jul 2010 19:30:49 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 231A6C43BB; Mon, 12 Jul
 2010 19:30:45 -0400 (EDT)
In-Reply-To: <3BA20DF9B35F384F8B7395B001EC3FB36CF674AE@azsmsx507.amr.corp.intel.com>
 (James E. Pickens's message of "Fri\, 9 Jul 2010 18\:15\:45 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 80CD7786-8E0D-11DF-8ABA-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150852>

"Pickens, James E" <james.e.pickens@intel.com> writes:

> The command 'git diff A...B' is supposed to be equivalent to 'git diff $(git
> merge-base A B) B'.  But when there are multiple merge bases between A and B,
> the former gives no output...
> ...
> The diff commands at the end will give different results.  It bisects to:
>
> commit b75271d93a9e4be960d53fc4f955802530e0e733
> Author: Matt McCutchen <matt@mattmccutchen.net>
> Date:   Fri Oct 10 21:56:15 2008 -0400

Thanks for a report, and for bisecting.

This unfortunately is somewhat an expected fallout from Matt's patch.

The low-level diff dispatcher in cmd_diff() function, where "ents" are
tree-ish given from the command line (either using 'diff A', 'diff A B',
'diff A..B', 'diff A...B' or 'diff A B C D E ...', syntaxes), says this:

	...
	else if ((ents == 3) && (ent[0].item->flags & UNINTERESTING)) {
		/* diff A...B where there is one sane merge base between
		 * A and B.  We have ent[0] == merge-base, ent[1] == A,
		 * and ent[2] == B.  Show diff between the base and B.
		 */
		ent[1] = ent[2];
		result = builtin_diff_tree(&rev, argc, argv, ent);
	}
	else
		result = builtin_diff_combined(&rev, argc, argv,
					     ent, ents);

I omitted the 1 or 2 trees case where we do naturally diff-index or
diff-tree from the above.

When the user gives more than two trees (e.g. "diff A B C"), we show a
combined diff that explains a merge of B and C that produces A, which was
introduced by 0fe7c1d (built-in diff: assorted updates., 2006-04-29).
Remember that the first tree is the merge result, and the user is asking
us to explain that result relative to its parents.

The special case with three trees, among which the first one being
uninteresting, came much later.  The revision parser parses A...B into a
list of "--not $(merge-bases A B)", A (SYMMETRIC_LEFT), and then B.  As
the purpose of "diff A...B" is to show what you did up to B since you
forked from A, showing the tree diff between the ent[0] (merge base) and
ent[2] (B) is the right thing to do.  But the codepath is of course
prepared to about dealing with a single-base merges, so your criss-cross
merge case does not trigger this special case.

So we fall into the "combined diff" case, which does this:

    git diff $(git merge-base --all A B) A B

As defined by 0fe7c1de, this should output the combined diff to explain as
if one of the merge bases (that happens to be the first one in merge-base
output) were the merge result of all the other merge bases, the refs A and
B you gave from the command line.  Which does not make _any_ sense, as it
is picking one of the criss-cross merge bases at random and forcing the
history to flow backwards.

Before Matt's patch, I think diff_combined() was giving a _slightly_ more
reasonable result because it (incorrectly) reversed the arguments to
explain as if B (typically yours) is the merge across all the merge bases
and the other tip A.  I say that is a "slightly" more reasonable, only
because what is explained is what you are familiar with, i.e. B.  I don't
think the way it explains it as a pseudo merge across all the merge bases
and the other tip makes any sense.

It should not be too hard to add logic to reverse the list of revisions as
another special case in the above else-if chain to support the old output
you saw before Matt's fix if such an output were useful.  You would detect
if the list begins with a run of UNINTERESTING ones followed by two
interesting ones (because that is how A...B parser gives its output to
us), and in that case feed diff_combined with a reversed list.

But I do not see how such an pseudo-merge output is useful, so please
enlighten me with an illustration.  Your "earlier it showed something, now
it doesn't show anything" is not good enough here, as I am doubting that
something we used to show in a criss-cross merge case was a useful output.

Thanks.
