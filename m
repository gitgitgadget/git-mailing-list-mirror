From: Junio C Hamano <gitster@pobox.com>
Subject: [RFD] Making "git push [--force/--delete]" safer?
Date: Tue, 02 Jul 2013 13:57:53 -0700
Message-ID: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 02 22:58:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu7eZ-0001QO-Qo
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 22:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888Ab3GBU6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 16:58:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47000 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754283Ab3GBU6H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 16:58:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC5762D931;
	Tue,  2 Jul 2013 20:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=k
	ASZxZC7PBgucDHeRD+35wj+xEM=; b=kjtLhICbc9xO3EX8LeUXSUK+FHlyZHTef
	w++4+RFfwkVz+25hpvMEAO6RpBTRvAhlKFd1ZUAcoO04oM/mXpsUf1gzkbMLSjz8
	lC5YyGkvsLuTDs6fjuX3q5SATYaB288H6trA3+J6lx7sHB/x30eiUiuGqXJEDHJR
	/pmJb5p4Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=wDg
	VT7yCKHbvuSWbHCkC+Oe0GwLdA1y8Zkn7F94CpF7fLlGTJR3vA02yId3+ReI/d0r
	xw2NrVA5aOxsMtxxWCdElE2Mp3+i5CXJmVoSbUUwQX0RT7FbogDDNaM7nM+B3Wqk
	XMlH27tOx4N/iXwp+GFXYD6NAd0DRHd3nVJr0gZ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0DD02D930;
	Tue,  2 Jul 2013 20:58:03 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8AD52D92D;
	Tue,  2 Jul 2013 20:58:02 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15CF2AC4-E35A-11E2-AC4E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229430>

Consider these two scenarios.

1. If you are collaborating with others and you have arranged with
   the participants to rewind a shared branch, you would do
   something like this:

        $ git fetch origin branch
        ... fetch everything so that we won't lose anything ...
        $ git checkout -b rebase-work FETCH_HEAD
        $ git rebase -i
        $ git push origin +HEAD:branch

   The last step has to be "--force", as you are deliberately
   pushing a history that does not fast-forward.

2. If you know a branch you pushed over there has now been fully
   merged to the "trunk" and want to remove it, you would do this:

        $ git fetch origin branch:tmp-branch trunk:tmp-trunk
        ... double check to make sure branch is fully merged ...
        $ git merge-base --is-ancestor tmp-branch tmp-trunk; echo $?
        0
        ... good, branch is part of trunk ...
        $ git push origin --delete branch

   The last step would delete the branch, but you made sure it
   has been merged to the trunk, not to lose anybody's work.

But in either of these cases, if something happens at 'origin' to
the branch you are forcing or deleting since you fetched to inspect
it, you may end up losing other people's work.

 - In the first scenario, somebody who is unaware of the decision to
   rewind and rebuild the branch may attempt to push to the branch
   between the time you fetched to rebase it and the time you pushed
   to replace it with the result of the rebasing.

 - In the second scenario, somebody may have pushed a new change to
   the branch since you fetched to inspect.

We can make these pushes safer by optionally allowing the user to
tell "git push" this:

        I am forcing/deleting, based on the assumption that the
        value of 'branch' is still at this object.  If that
        assumption no longer holds, i.e. if something happened to
        the branch since I started preparing for this push, please
        do not proceed and fail this push.

With such a mechanism, the first example would say "'branch' must be
at $(git rev-parse --verify FETCH_HEAD)", and the second example
would say "'branch' must be at $(git rev-parse --verify tmp-branch)".

The network protocol of "git push" conveys enough information to
make this possible.  An early part of the exchange goes like this:

        receiver -> sender
                list of <current object name, refname>
        sender -> receiver
                list of <current object name, new object name, refname>
        sender -> receiver
                packfile payload
                ...

When the "git push" at the last step of the above two examples
contact the other end, we would immediately know what the current
value of 'branch' is.  We can locally fail the command if the value
is different from what we expect.

Now at the syntax level, I see three possibilities to let the user
express this new constraints:

  (1) Extend "refspec" syntax to "src:dst:expect", e.g.

      $ git push there HEAD:branch:deadbabecafe

      would say "update 'branch' with the object at my HEAD, only if
      the current value of 'branch' is deadbabecafe".

      An reservation I have against this syntax is that it does not
      mesh well with the "update the upstream of the currrent
      branch" and other modes, and instead you have to always spell
      three components out.  But perhaps requiring the precondition
      is rare enough that it may be acceptable.

  (2) Add --compare-and-swap=dst:expect parameters, e.g.

      $ git push --cas=master:deadbabecafe --cas=next:cafebabe ":"

      This removes the "reservation" I expressed against (1) above
      (i.e. we are doing a "matching" push in this example, but we
      will fail if 'master' and 'next' are not pointing at the
      expected objects).

  (3) Add a mechanism to call a custom validation script after "git
      push" reads the list of <current object name, refname> tuples,
      but before responding with the proposed update.  The script
      would be fed a list of <current object name, new object
      name, refname> tuples (i.e. what the sender _would_ tell the
      receiving end if there weren't this mechanism), and can tell
      "git push" to fail with its exit status.

      This would be the most flexible in that the validation does
      not have to be limited to "the ref must be still pointing at
      the object we expect" (aka compare-and-swap); the script could
      implement other semantics (e.g. "the ref must be pointing at
      the object or its ancestor").

      But it may be cumbersome to use and the added flexibility may
      not be worth it.

      - The way to specify the validation script could be an
        in-repository hook but then there will need a way to pass
        additional per-invocation parameters (in the earlier sample
        scenarios, values of FETCH_HEAD and tmp-branch).

      - Or it could be a "--validate-script=check.sh" option, and it
        is up to the caller how to tailor that check.sh script
        customized for this particular invocation (i.e. embedding
        the values of FETCH_HEAD and tmp-branch in the script in the
        earlier sample scenarios).

I am inclined to say, if we were to do this, we should do (2) among
the above three.

But of course, others may have better ideas ;-).
