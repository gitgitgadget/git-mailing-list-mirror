From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 00/18] Add --index-only option to git merge
Date: Fri, 08 Apr 2016 11:08:24 -0700
Message-ID: <xmqqlh4ovuqv.fsf@gitster.mtv.corp.google.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 20:08:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoape-0005G8-Eg
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 20:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbcDHSI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 14:08:28 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62483 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753723AbcDHSI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 14:08:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2B546529D6;
	Fri,  8 Apr 2016 14:08:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WG4hMvKa6Qp+aJxcv3gAyildWA4=; b=oachcZ
	lR6HEEsyxXn9RbRjer3UQMywgT/ICGkhv4XA6BRXJrDpFdTipIesbwoNj7dypPvO
	M63DzsCXHBQELRhlyhuZ3ABpXlOwYZLx1jM9CNMLHB4F8qkTQbVIDtcIGsO6wbAa
	bK7cB4dLqbI2RQ4tD/cin1hEdBtgnUowHKNFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vrrzWepa0pUB+PyuTd7LlCXXqEFmpwFZ
	Zbo31DRrftXsdQij6hWC7NSwD1kZ2U2z5YbGMO2CbH/RxJErf8OMlMbHFJxeB88e
	Qyjf/yRPTOZi134/2MqZk8WkKJlBRoUgNhO13HhN/bWMCpDUBEPfaoGthlsIZ4gq
	18SMGy/rI+0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 221B4529D5;
	Fri,  8 Apr 2016 14:08:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8C705529D4;
	Fri,  8 Apr 2016 14:08:25 -0400 (EDT)
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com> (Elijah
	Newren's message of "Thu, 7 Apr 2016 23:58:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E368B1A4-FDB4-11E5-A813-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291047>

Elijah Newren <newren@gmail.com> writes:

> This patch series adds an --index-only flag to git merge, the idea
> being to allow a merge to be performed entirely in the index without
> touching (or even needing) a working tree.

The goal is stated rather vaguely--when you have a working tree and
perform this "in index" merge, you would obviously update the index
with the merge result and write it out as a tree to record the merge,
and update HEAD to point at the new commit, but "without touching"
would imply that you would not be checking out the result to the
working tree.  That sounds crazy and probably you didn't mean it
that way.

One worry immediately comes to mind is what should happen when
conflicts occur.  A knee-jerk reaction only after reading the above
explanation is to error out; there could be other sensible
alternatives, but I do not think of any offhand.

Another thing that comes to mind is if that should be an option to
the end-user facing "git merge" command that can be run in a
repository _with_ a working tree.  When used in a repository with a
working tree, I am not sure what the next step the end user wants to
make after the "only in index" merge succeeds.  The index has been
updated with the merge result at that point and I am guessing that
the merge would also have created a new commit and updated the HEAD
to point at it.  The contents of the working tree for paths that
were not changed when the user initiated the merge can be safely
checked out, but what should happen to the ones that were dirty wrt
the index (I am again guessing that you do not allow a "git merge
only in index" if the index already has changes wrt the HEAD)?

I can understand if the option only worked in a bare repository,
though.

> The core fix, to merge-recursive, was actually quite easy.  The
> recursive merge logic already had the ability to ignore the working
> directory and operate entirely on the index -- it needed to do this
> when creating a virtual merge base, i.e. when o->call_depth > 0.

You need to be careful here, though.  The creation of a virtual
parent accepts (actually it wants to have) conflicted blobs as if
that is a valid merge result--"git merge but only in index" probably
does not want that behaviour.

> A brief-ish summary of the series:
>
> * Patches 1 and 2 are unrelated cleanups, which could be submitted
>   independently.  However, submitting them as separate patches would
>   result in a minor conflict, so I'm just including them together.
>
> * Patches 3 and 4 add some testcases and a fix for a separate issue
>   found while testing this series which could be split off and
>   submitted separately, but fixing this problem and enforcing the
>   starting state I expected permitted me to reduce the range of
>   testcases I needed to consider for the --index-only merges.  So I
>   thought it made sense to include in this series.

I'd prefer these as a separate series if they are truly unrelated
cleanups, so that we can quickly review and have them graduated
without waiting for the remainder.  You can still submit the main
series with a comment that says it applies on that separate clean-up
series and the right things should happen ;-)

>   In particular, I was worried about how git merge behaved when the
>   index differed from HEAD prior to the merge starting.  I discovered
>   that it wasn't just allowed for fast-forward merges (where behavior
>   is well-defined) but that it was also (accidentally I'm assuming)
>   allowed for octopus merges with weird/surprising behavior.

I briefly looked at these tests and I agree with your expectation,
i.e. we want to allow a merge as long as there is no conflicts with
the change already in the index (i.e. the changed paths have the
same contents in ORIG_HEAD and HEAD).

> Some things I am concerned about:
>
> * The option name (--index-only) may be slightly misleading since the
>   index isn't the only thing modified within the git directory, other
>   normal things under there are still modified (e.g. writing MERGE_*
>   files, sticking blobs/trees/commits in objects/*, and updating refs
>   and reflogs).  I personally prefer this name and think the confusion
>   would be minor, but I'm a bit unsure and wanted some other opinions
>   on this.

When you say "index only", I'd say people would understand that to
be saying "as opposed to using and updating both the index and the
working tree", so I do not think there is no confusion.

An established convention to spell "index only" found in "apply" and
"grep" is to say "--cached", though (cf. "git help cli").

> * I didn't add this option to the separate git-merge-recursive
>   executable and make the worktree-optional modification to the git
>   subcommands merge-recursive, merge-recursive-ours,
>   merge-recursive-theirs, and merge-subtree in git.c.  Should I, or
>   are these separate binaries and subcommands just present for
>   historical backward compatibility reasons with people expected to
>   call e.g. "git merge -s recursive" these days?

If you have to assume, assume that there are people who use these
programs in their scripts and workflows, because it is a relatively
new development to make "git merge" directly calling into the
recursive machinery bypassing these commands.

> * Expanding on the last item, git-merge-one-file.sh is of particular
>   concern; it seemed to strongly assume exactly seven arguments and
>   that the position of each mattered.  I didn't want to break that, so
>   I added --index-only as an optional 8th argument, even though it
>   seems slightly odd force an option argument to always come after
>   positional ones (and it made the changes to merge_entry in
>   merge-index.c slightly easier to implement).  Does that seem okay?

I have a suspicion that this would become moot, as the conclusion
may become that "git merge" that works only in index does not make
sense unless you are in a bare repository---in which case, these
external merge drivers has to be given a temporary working tree
anyway, and they can keep writing their result out to what they
consider is the working tree (i.e. via GIT_WORK_TREE or something).
You read the result of them from that temporary working tree into
the index before cleaning the temporary working tree.  That way,
you do not have to touch them at all, no?  In fact, the temporary
working tree trick may be applicable even when you are working in a
repository with a tree working tree.
