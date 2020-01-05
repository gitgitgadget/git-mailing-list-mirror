Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0F2C00523
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 23:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DE82085B
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 23:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g+euhHUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgAEXLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jan 2020 18:11:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53720 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgAEXLi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jan 2020 18:11:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADD62447E1;
        Sun,  5 Jan 2020 18:11:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HXakbkqB4+de8AIV/4tj7NBr9uM=; b=g+euhH
        UW5g4Zini6m5Fv0ZjsG0NYTfui61K8imwj1rvnBaRscLXcnRvfoOuUyrs+9Podf+
        a2XDgwLuWb9iIuGFjTtz2Zia3S+RSHT00lN3/qLnFuDDml6rk7XE+POTfIFNhY4V
        U/vwyNLGyLStw48LwCfnwOAELxK/8mdobIxQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ase4U6LHUeGSZBS/HDecB3gFnADgeBSl
        LK/2rEF0oXKh39tQScmkQ31rfwwyzenSMM8hWR2t5p5Af87rS8psV9R2VJlQTMww
        nZBPBo2z3x69vsTwy2tt4YvQU96CgZEHtGNYN6AxdWAWh5AcP6ohkKQQoUpMofuo
        2lU46+VmTYI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A535D447E0;
        Sun,  5 Jan 2020 18:11:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10A06447DF;
        Sun,  5 Jan 2020 18:11:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] refactor gpg-interface and add gpg verification for clones
References: <20200105135616.19102-1-hji@dyntopia.com>
Date:   Sun, 05 Jan 2020 15:11:35 -0800
In-Reply-To: <20200105135616.19102-1-hji@dyntopia.com> (Hans Jerry
        Illikainen's message of "Sun, 5 Jan 2020 13:56:11 +0000")
Message-ID: <xmqq36ctbis8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B91249E6-3010-11EA-87D1-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

> And finally, signature verification is added to the clone builtin.  It
> obeys --(no-)verify-signatures, clone.verifySignatures and
> gpg.verifySignatures (in decreasing order of significance).

It is clear for a merge or a pull what it means to verify
signature---you trust your local history, and you are willing to
merge in a commit only when it has a trusted signature (which
automatically means that you trust the hash function and also the
signer did some reasonable vetting of the history behind the tip
commit, or you never check out your intermediate state, depending
on your threat model).

I am not sure what it should mean to verify signature on clone.  I'd
assume that our threat model and verification policy are consistent
with what we use for a merge/pull, in that we trust all history
behind a commit that has a trusted signature, so it is clear that
you would want the tip commit of the default branch (or if you are
naming a single branch to clone, then the tip of that branch) to
carry a trusted signature.  But what about the commits that are
reachable from other branches and tags that are *not* contained
in the branch that is initially checked out?

Later in the proposed log message of 5/5 you allude to risk of
merely checking out a potentially untrustworthy contents to the
working tree.  This is far stricter than the usual threat model we
tend to think about as the developers of source code management
system, where checking out is perfectly OK but running "make" or its
equivalent is the first contact between the victim's system with
malicious contents.

Verifying the tip of the default/sole branch upon cloning before the
tree of the commit is checked out certainly would cover that single
case (i.e. the initial checkout after cloning), but I am not sure if
it is the best way, and I am reasonably certain it is insufficient
against your threat model.  After such a clone is made, when the
user checks out another branch obtained from the "origin" remote,
there is no mechanism that protects the user from the same risk you
just covered with the new signature verification mechanism upon
cloning, without validating the tip of that other branch, somewhere
between the time the clone is made and that other branch gets
checked out.

It almost makes me suspect that what you are trying to do with the
"verification upon cloning" may be much better done as a "verify the
tree for trustworthyness before checking it out to the working tree"
mechanism, where the trustworthyness of a tree-ish object may be
defined (and possibly made customizable by the policy of the project
the user is working on) like so:

 - A tree is trustworthy if it is the tree of a trustworthy commit.

 - A commit is trustworthy if

   . it carries a trusted signature, or
   . it is pointed by a tag that carries a trusted signature, or
   . it is reachable from a trustworthy commit.

Now, it is prohibitively expensive to compute the trusttworthiness
of a tree, defined like the above, when checking it out, UNLESS you
force each and every commit to carry a trusted signature, which is
not necessarily practical in the real world.

Another approach to ensure that any and all checkout would work only
on a trustworthy tree might be to make sure that tips of *all* the
refs are trustworthy commits immediately after cloning (instead of
verifying only the branch you are going to checkout, which is what
your patch does IIUC).  That way, any subsequent checkout in the
repository would either be checking out a commit that was

 - originally cloned from the remote, and is reachable from some ref
   that was validated back when the repository was cloned, or

 - created locally in this repository, which we trust, or

 - fetched from somewhere else, and is reachable from the commit
   that was validated back when "git pull" validated what was about
   to be integrated into the history of *this* repository.

Hmm?
