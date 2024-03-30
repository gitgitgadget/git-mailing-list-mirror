Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFC31C0DE0
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711834644; cv=none; b=s4wFrDANxpVT9vewCQxxJjM80h2sQRlyfd90ql8J4ik3H25E5oAWB1rpNT9iQNGPlocUyRB/wP/X7202tqeiicj9gx/FRBbaybrOqkDH3zKuqLutw5tFHxdyoqIlemB6mDqFJkDtIkU2MekRxXO6gdgDm1RnCaOyx6a0FYOjplc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711834644; c=relaxed/simple;
	bh=zT9HeTbvA2cb8yTqN5jaNteGkkC3taBIZEi3W/KeBBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tE6k04WHxaBsGN5cbR7UTfjrSDHxwcBenU9jLupkiSPoakPyOk8ngzU3l7GCgnN9D5sAzQ0a0aUUyiyZ+sjSkKibTpgoVXSBWu6Ff8G+6OdvfGtLbKMgme3ksHKpziq81RogdpgTntqa3w+RufdS736GTCYQR0AMZVkDmNcGF+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YeoC3GwO; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YeoC3GwO"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6452518E4B;
	Sat, 30 Mar 2024 17:37:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zT9HeTbvA2cb8yTqN5jaNteGkkC3taBIZEi3W/
	KeBBY=; b=YeoC3GwOYqW9O8XIeRVJa7KaRZJ5LPEvnMaA2IJX1ofWMWBfsYudxd
	K7VHsR74qqj//qeKqGUd7naljACzTyNmczr4PAkYwmQzJrnqzcBfoTbsm/Ld/Dfk
	MweeYbSFtJ6F+78oVUS3A9eci89Jqs3FWLpdYcbGCxSvUVECErOY8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D3A618E4A;
	Sat, 30 Mar 2024 17:37:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C973218E49;
	Sat, 30 Mar 2024 17:37:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: mirth hickford <mirth.hickford@gmail.com>
Subject: [PATCH] checkout: do not bother "tracking" report on detached HEAD
In-Reply-To: <CAKcCxfAVGr2QoaXiT81gVZ0mfq3zJs7TywRhJzevwKX7wChJ4w@mail.gmail.com>
	(mirth hickford's message of "Sat, 30 Mar 2024 07:49:58 +0000")
References: <CAKcCxfAVGr2QoaXiT81gVZ0mfq3zJs7TywRhJzevwKX7wChJ4w@mail.gmail.com>
Date: Sat, 30 Mar 2024 14:37:14 -0700
Message-ID: <xmqqa5mfl7ud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AD56AD8C-EEDD-11EE-B10B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

By definition, a detached HEAD state is tentative and there is no
configured "upstream" that it always wants to integrate with.  But
if you detach from a branch that is behind its upstream, e.g.,

    $ git checkout -t -b main origin/main
    $ git checkout main
    $ git reset --hard HEAD^
    $ git checkout --detach main

you'd see "you are behind your upstream origin/main".  This does not
happen when you replace the last step in the above with any of these

    $ git checkout HEAD^0
    $ git checkout --detach HEAD
    $ git checkout --detach origin/main

Before 32669671 (checkout: introduce --detach synonym for "git
checkout foo^{commit}", 2011-02-08) introduced the "--detach"
option, the rule to decide if we show the tracking information
used to be:

    If --quiet is not given, and if the given branch name is a real
    local branch (i.e. the one we can compute the file path under
    .git/, like 'refs/heads/master' or "HEAD" which stand for the
    name of the current branch", then give the tracking information.

to exclude things like "git checkout master^0" (which was the
official way to detach HEAD at the commit before that commit) and
"git checkout origin/master^0" from showing tracking information,
but still do show the tracking information for the current branch
for "git checkout HEAD".  The introduction of an explicit option
"--detach" broke this subtley.  The new rule should have been

    If --quiet is given, do not bother with tracking info.
    If --detach is given, do not bother with tracking info.

    Otherwise, if we know that the branch name given is a real local
    branch, or if we were given "HEAD" and "HEAD" is not detached,
    then attempt to show the tracking info.

but it allowed "git checkout --detach master" to also show the
tracking info by mistake.  Let's tighten the rule to fix this.

Reported-by: mirth hickford <mirth.hickford@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    mirth hickford <mirth.hickford@gmail.com> writes:

    >> git switch --detach main
    > HEAD is now at 5a07c3bde Refactor...
    > Your branch is behind 'origin/main' by 1 commit, and can be fast-forwarded.
    >   (use "git pull" to update your local branch)
    >
    >> git pull
    > You are not currently on a branch.

    I think the instruction meant to say "use 'git pull' with
    appropriate options to update" but had to ellide the details due
    to limited screen real estate.  And it is quite expected that a
    "git pull" from a detached HEAD would not do anything.

    Because my local branches do not track any upstream branches, I
    have little experience with the message in question.  Given
    that, I doubt that I am the best person to comment on this
    issue, but having said that, I observe that this is shared
    between "checkout" and "switch".

    Having said that, I think that the instruction is what is wrong.
    What is wrong is the fact that the command assumed that you want
    to keep up with the upstream of the branch you detached from.

 builtin/checkout.c         | 3 ++-
 t/t2020-checkout-detach.sh | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2e8b0d18f4..26e1a64569 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1030,7 +1030,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	remove_branch_state(the_repository, !opts->quiet);
 	strbuf_release(&msg);
 	if (!opts->quiet &&
-	    (new_branch_info->path || (!opts->force_detach && !strcmp(new_branch_info->name, "HEAD"))))
+	    !opts->force_detach &&
+	    (new_branch_info->path || !strcmp(new_branch_info->name, "HEAD")))
 		report_tracking(new_branch_info);
 }
 
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index bce284c297..8d90d02850 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -176,7 +176,10 @@ test_expect_success 'tracking count is accurate after orphan check' '
 	git config branch.child.merge refs/heads/main &&
 	git checkout child^ &&
 	git checkout child >stdout &&
-	test_cmp expect stdout
+	test_cmp expect stdout &&
+
+	git checkout --detach child >stdout &&
+	test_grep ! "can be fast-forwarded\." stdout
 '
 
 test_expect_success 'no advice given for explicit detached head state' '
-- 
2.44.0-413-gd6fd04375f



