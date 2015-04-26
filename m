From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/14] Teach "git merge FETCH_HEAD" octopus merges
Date: Sat, 25 Apr 2015 22:25:53 -0700
Message-ID: <1430025967-24479-1-git-send-email-gitster@pobox.com>
References: <xmqqiocqli1c.fsf@gitster.dls.corp.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 07:26:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmF5H-0002kU-Cl
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 07:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbbDZF0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 01:26:11 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751004AbbDZF0J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 01:26:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB5C3466DC;
	Sun, 26 Apr 2015 01:26:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=p0KD
	rMGiNqAYxwHwZBOznReBwJM=; b=rf7TWc7+bT2SJnsVWiIAJ/tvVXPV6BZaK3DJ
	jva+sWgpKGmofhFmgjjbox0r895RppomCxGCFLW93CQJ2CEV+Grj7PGibHssaZfQ
	W1bimEkDVuc7Zzt99UX1FuyLx6PsF64i/ix0ccpqqi+X3fQudgD+L048jBBkTkWO
	sLD6F8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=IjVKZ2
	t0WphstAwm0bk05IuYq/E25hbhcvrRm03hZcvMjtFiw4WcM9j8KrBoSNJ+ge+bin
	uNMs/GngWxdfYMa980J/d2wTuBqrmSz2nY3GF0/PUCh1azijWe2hcW1FQ8666Nvh
	aA8knItu+e+vzbb987k4pZsXyXC9lW53zM1Po=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C4102466DB;
	Sun, 26 Apr 2015 01:26:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 48CA0466DA;
	Sun, 26 Apr 2015 01:26:08 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-238-g36f5934
In-Reply-To: <xmqqiocqli1c.fsf@gitster.dls.corp.google.com>
X-Pobox-Relay-ID: BE1C9D0E-EBD4-11E4-AC4A-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267809>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>> On Mon, Apr 20, 2015 at 11:59:04AM -0700, Junio C Hamano wrote:
>>
>>> Unfortunately, "git merge"'s parsing of FETCH_HEAD forgets that we
>>> may be creating an Octopus.  Otherwise the above should work well.
>>
>> That sounds like a bug we should fix regardless.
>
> But I am not sure how it should behave. "git fetch $there A B C"
> followed by "git merge FETCH_HEAD" merges only A, and I do not know
> if people have come to depend on this behaviour.
>
> I suspect there may be larger fallout from such a change, namely,
> what should "git log FETCH_HEAD" do?  Should it traverse the history
> starting from all things that are not marked as not-for-merge, or
> should it just say "git rev-parse FETCH_HEAD" and use only the first
> one as the starting point?

So, I thought we may want to try this and see how it goes.

Tentatively, I am saying that "FETCH_HEAD" is a magic token
understood by "git merge", like "git merge <msg> HEAD commits..."
syntax was a magic that made "git merge" work differently from "git
merge -m <msg> <commits>..."; no changes to get_sha1() or anything
heavy like that is intended.


Earlier, we thought that it would just be the matter of turning
existing invocation of "git merge <msg> HEAD $commits..." in "git
pull" into "git merge -m <msg> $commits..." to deprecate the ugly
original "merge" command line syntax.

This unfortunately failed for two reasons.

 * "-m <msg>" stops the editor from running; recent "git pull"
   encourage the users to justify the merge in the log message,
   and the auto-generated <msg> that comes from format-merge-msg
   should still be shown to the user in the editor to be edited.

 * "-m <msg>" also adds auto-generated summary when merge.log
   configuration is enabled, but "git pull" calls "git merge" with
   the message _with_ that log already in there.

Invoking "git merge FETCH_HEAD" (no messages fed by the caller) from
"git pull" almost works.  "git merge" knows how to extract the name
of the repository and the branch from FETCH_HEAD to use in the merge
log message it auto-generates.  However, this is done only for a
single branch; if you did "git pull $there topic-A topic-B", and
then invoked "git merge FETCH_HEAD" from there, we would end up
recording a merge with only one branch, which is not what we want.

This teaches "git merge FETCH_HEAD" that FETCH_HEAD may describe
multiple branches that were fetched for merging.  With that, the
last step eradicates the "merge <msg> HEAD <commit>..." syntax from
our codebase, finally.

This may be rough in a few places and some patches that are done as
preparatory clean-up steps may want to be squashed into the patch
that follows them that implements the real change.

These patches are designed to apply on top of v2.2.2; I'll push them
out on 'pu' later, on 'jc/merge' topic.

Junio C Hamano (14):
  merge: simplify code flow
  t5520: style fixes
  t5520: test pulling an octopus into an unborn branch
  merge: clarify "pulling into void" special case
  merge: do not check argc to determine number of remote heads
  merge: small leakfix and code simplification
  merge: clarify collect_parents() logic
  merge: split reduce_parents() out of collect_parents()
  merge: narrow scope of merge_names
  merge: extract prepare_merge_message() logic out
  merge: make collect_parents() auto-generate the merge message
  merge: decide if we auto-generate the message early in
    collect_parents()
  merge: handle FETCH_HEAD internally
  merge: deprecate 'git merge <message> HEAD <commit>' syntax

 Documentation/git-merge.txt   |   4 +
 builtin/merge.c               | 248 +++++++++++++++++++++++++++---------------
 git-cvsimport.perl            |   2 +-
 git-pull.sh                   |   3 +-
 t/t3402-rebase-merge.sh       |   2 +-
 t/t5520-pull.sh               |  31 +++---
 t/t6020-merge-df.sh           |   2 +-
 t/t6021-merge-criss-cross.sh  |   6 +-
 t/t9402-git-cvsserver-refs.sh |   2 +-
 9 files changed, 188 insertions(+), 112 deletions(-)

-- 
2.4.0-rc3-238-g36f5934
