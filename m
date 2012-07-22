From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Only call record_resolve_undo() when coming from
 add/rm
Date: Sun, 22 Jul 2012 11:37:19 -0700
Message-ID: <7vtxwzskv4.fsf@alter.siamese.dyndns.org>
References: <e0e9ce3599d898c974c56c818d9858638e343f5b.1342819276.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jul 22 20:38:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St12c-0000xP-7z
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 20:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339Ab2GVShY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 14:37:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61052 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324Ab2GVShX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 14:37:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD1188C56;
	Sun, 22 Jul 2012 14:37:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wSRYmDnHJTIHjlJj/TWvZHcJ1zM=; b=ExIZKf
	jZkYw8bi3zjcWTW6it7SPl6eOcigmk/cgjijIksMVDHm61yEKrX26hNu07PfmHsC
	GGdNBJCMIb9ppEUoPIuoNtFxpzAY2bJZZ+emifl1ABDmRgSYwxskKQYLUxJCMT6s
	n5nAo6rCM2XZm6GDkwfwek35Gp0jzK+sXTVS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jFXwzoLyiiN5wS6CDpiOh4KL0GtUtmLH
	piXtbVAY1Eu6RCSRahec/JgcGoelUsSMt1T5FapjDnov91T8sV5Fl2dsm0WvYs9d
	gXhJJHkDBb2bjtF1zR8CN+XgK8K1FhAAmYwhRyDKyqg7DDMCuN1u1kAAx1ftgj9X
	I+VHLqdJnHk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA2A28C54;
	Sun, 22 Jul 2012 14:37:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C50108C4D; Sun, 22 Jul 2012
 14:37:21 -0400 (EDT)
In-Reply-To: <e0e9ce3599d898c974c56c818d9858638e343f5b.1342819276.git.trast@student.ethz.ch> (Thomas Rast's message of "Fri, 20 Jul 2012 23:28:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46228768-D42C-11E1-85FC-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201854>

Thomas Rast <trast@student.ethz.ch> writes:

> The REUC extension stores the stage 1/2/3 data of entries which were
> marked resolved by the user, to enable 'git checkout -m <name>' to
> restore the conflicted state later.

Yes.

> When a file was deleted on one side of the merge and unmodified on the
> other, merge-recursive uses remove_file_from_cache() to remove it from
> the result index.  This uses remove_index_entry_at(), which calls
> record_resolve_undo().

What is missing from here which confused me during my initial read
of this patch is "But such a removal is the natural resolution for
the three-way merge. It is not a resolution by the end user, and
should not be unresolved with 'checkout -m'. Recording REUC entry
for such a path is wrong."

Perhaps you thought it was so obvious that it can be left unsaid,
but combined with the "in fact _even_ useless" below, I had to
re-read it to find something that says why it was _wrong_, did not
find any, and had to scratch my head.

> Such REUC entries are in fact even useless: neither 'git checkout -m'
> nor 'git update-index --unresolve' can resurrect the file (the former
> because there is no corresponding index entry, the latter because the
> file is missing one side).

I do not think that "they are not used the current implementation of
the commands that are supposed to use the information" automatically
qualifies as a good reason to remove them. If the conflict were "we
modified while they removed", the resolution may either be "keep
some stuff we added" or "delete the path", we may want to be able to
resurrect the conflicted state with "checkout -m" for them, and we
may want to fix "checkout -m" and "update-index --unresolve" to deal
with such a case if they don't already, which is an independent topic.

For the "one side untouched, the other side removed" case, removing
is the natural resolution, so we do not want to have REUC entry to
begin with, so there is nothing to fix in "checkout -m" for that
case.

> Solve this by taking a more specific approach to record_resolve_undo():

Just a sanity check.

Are there cases we would want to have _any_ REUC entries in the
index, after running any mergy operation, not just merge-recursive,
but cherry-pick and friends that share the same machinery?

> * git-rm and 'git update-index --remove' go through
>   remove_file_from_cache(), just like merge-recursive.  Make them use
>   a new _extended version that optionally records REUC.

I wonder if it is better have two functions, one records REUC (and
does nothing else) and the other that removes a path from the
in-core index (and does nothing else), instead of two functions that
both remove a path from the in-core index (one with REUC and the
other without).  Would it be less error-prone for the callers and
make the resulting code easier to follow?

	if (path is conflicted and we are resolving as removal)
		record_REUC(&the_index, path);
	remove_file_from_cache(&the_index, path);

Not a suggestion "I think it is better", but just a question.

> * git-add and 'git update-index conflicted_file' go through the
>   add_index_entry() call chain.  git-apply and git-read-tree use
>   add_index_entry() too.  However, they insert stage-0 entries, which
>   already means resolving.  So even if these cases were not caught
>   earlier, saving the unresolved state would be correct.
>   So we can unconditionally record REUC deeper in the call chain.

Are there cases where an automerge use add_index_entry() to insert a
stage#0 entry to the index (which already means resolving) to record
a clean automerge?  Doesn't the same "a natural three-way resolution
should not be unresolved with 'checkout -m'" reasoning as the original
motivation of this patch apply to it?
