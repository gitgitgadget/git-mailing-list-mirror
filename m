From: Junio C Hamano <gitster@pobox.com>
Subject: [non PATCH */2] preparatory analysis of remaining @{...} issues
Date: Wed, 08 May 2013 14:32:11 -0700
Message-ID: <7vwqr9cg4k.fsf@alter.siamese.dyndns.org>
References: <7vk3n9dvlu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 08 23:32:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaByK-0001E8-UQ
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 23:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051Ab3EHVcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 17:32:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44276 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822Ab3EHVcO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 17:32:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC9181C766;
	Wed,  8 May 2013 21:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xncINM9NTjC8wPw6IpmRF5NykaM=; b=J/VWkw
	/uVJor33JB5RILRmHUQHPHoVCzN/2eaLLM3giygYjtmFTdMzaYZhaRUonKwFtNju
	buvfs7j+Qm1+ZacO4DQ5CQc4AG7nrL4FJidxEIkcNWR5KWiql5cViR4a8hHOGuLT
	xEQCBRkNEoKz1364RP+ALbT5iGp7JUs2rHZVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oljOkKlauW9sl37SlQ7MmP1a8TQ0QgTY
	XamqYqNHfSQbvv1q/cNjk3JaVgrvuEAKXCAA6dnpwEX283OAms9P8isLRr35NbkM
	WDn7dWb0dIQDdEtXrDdJkO601e3ZfVqfZpcK/4Se4lBfuT6SsHTCI8y4lxEvvY10
	mSr5g6/gXM8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B20301C764;
	Wed,  8 May 2013 21:32:13 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2E541C763;
	Wed,  8 May 2013 21:32:12 +0000 (UTC)
In-Reply-To: <7vk3n9dvlu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 08 May 2013 14:12:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF2AFC7E-B826-11E2-B236-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223688>

Currently interpret_branch_name() takes either @{-N}, @{u}, or
some@{u} and returns an abbreviated refname, or a detached HEAD if
@{-N} resolves to such a state.  Local branch names coming back for
@{-N} are returned as branch names without "refs/heads/", upstream
names coming back for @{u} are given after cleaning it up with
shorten_unambiguous_ref().  @{-N} resolved to a detached HEAD yields
a bare 40-HEX.

This makes the caller unnecessarily fragile.  I started asking

(1) perhaps interpret_branch_name() can be updated to return a full
    refname when it does return a ref;

(2) perhaps it can also be updated to say if its input @{-N} refers
    to a detached HEAD state.

I looked at all existing callers of interpret_branch_name() to see
how feasible such a change is.  Here is a preparatory analysis.


refs.c: substitute_branch_name()

    The call to interpret_branch_name() by this function only wants to
    see the branch name replaced to a full refname for the consumption
    of dwim_ref() and dwim_log(), and does not want to see a detached
    HEAD state at all.

    Changing @{-N} that returns the bare branch name to return
    refs/heads/$name is welcome.  Changing $name@{u} that returns an
    abbreviation to return a full refname is also welcome.
    And we can error out early if @{-N} referred to a detached HEAD.

    [answer: Yes/Yes]


revision.c: add_pending_object_with_mode()

    The call to interpret_branch_name() by this function wants to turn
    @{-N} and $name@{u} to a refname so that it can be passed to
    add_reflog_for_walk().  Obviously it does not want to see a
    detached state.

    Again, this benefits if interpret_branch_name returned a full
    refname, as add_reflog_for_walk() eventually ends up passing the
    name to dwim_log().

    [answer: Yes/Yes]


sha1_name.c: get_sha1_basic()

    The call to interpret_branch_name() by this function wants to turn
    @{-N} and $name@{u} to a string that can be fed to get_sha1_1() to
    get an object name.  Returning full refname or full object name is
    a good change.

    [answer: Yes/Yes]


sha1_name.c: interpret_branch_name()

    @{-N}@{u} is first given to interpret_nth_prior_checkout() to turn
    @{-N} into a branch name, and then appends @{u} to the result and
    recursively call this function to expand $branch@{u}.  Expansion
    of @{-N} to full refname can break the second expansion, and needs
    to be adjusted, but if @{-N} turns out to be a detaches state, we
    would want to error out the resulting $HEX@{u} anyway, so updating
    the API would result in a pair of real bug fixes.

    [answer: Yes/Yes -- but this caller needs further adjustment]


sha1_name.c: strbuf_branchname()

    The function wants to return an abbreviated branch name.
    The callers of this function are:

    builtin/branch.c: delete_branches()

	"git branch -d -r master@{u}" may expand to "git branch -d -r
	origin/master" and delete "refs/remotes/origin/master", and "git
	branch -d @{-2}" would expand to "git branch -d next" and delete
	"refs/heads/next".

	strbuf_branchname() that returns a full refname would break
	this caller and the caller needs to be updated to shorten
	its output.

        But if strbuf_branchname() can tell @{-N} were detached, we
	can prevent removal of an unintended local branch.

    builtin/checkout.c: setup_branch_path()

        With the current code, "git checkout -b master@{u}" would
        expand to "git checkout -b origin/master" and end up creating
        "refs/heads/origin/master", which may not be a good thing.

	strbuf_branchname() that returns a full refname would break
	this caller and the caller needs to be updated to shorten
	its output.

        If strbuf_branchname() can tell @{-N} were detached, we can
	error out instead of creating a bogus local branch.

    builtin/merge.c: merge_name()

	Uses strbuf_branchname() to turn @{-N} and $name@{u} into
	something that can be fed to dwim_ref().

        This does benefit if strbuf_branchname() can find out the
	full refname.

        If strbuf_branchname() can tell @{-N} were detached, we can
	error out instead of creating a bogus local branch.

    sha1_name.c: strbuf_check_branch_ref()

	Used to see if the name is reasonable when appended to
	refs/heads/.

	strbuf_branchname() that returns a full refname would break
	this caller and the caller needs to be updated to shorten
	its output.

    So strbuf_branchname() itself can tolerate an updated
    interpret_branch_name() that returns full refname and it will
    benefit if it can learn about detached state (many of its
    callers would appreciate the latter).

    [answer: Yes/Yes -- but this caller and its callers need some
    adjustment].
