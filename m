Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038C9C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 19:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiIZTIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiIZTHp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 15:07:45 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD6357BE5
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 12:06:31 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B5921C67FF;
        Mon, 26 Sep 2022 15:05:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dImsq0s+QC5ty3rccjsh/b36hFB6t+DrrEgdIb
        Tdz3A=; b=VX/eqgY8LppdexCaaMMwrNDqNaI1FDoDPmDpM7d/hdaMyTv4Mi0ugF
        prkWF3GAb63Xg+DgHTcZ1CTBQjeM9PHJg3sqZoJRfvQ7ehxINNePZw8CvpJ+iWGq
        eHAnjwiu8O2tKebcasQGMtKzwWHc9R7dPCwo+swYdmoB2HYhCpMao=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 231231C67FE;
        Mon, 26 Sep 2022 15:05:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 43C641C67FB;
        Mon, 26 Sep 2022 15:05:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] receive.txt: Describe effect of denyDeleteCurrent on
 bare repositories
References: <mvmmtammrnt.fsf@suse.de>
Date:   Mon, 26 Sep 2022 12:05:26 -0700
In-Reply-To: <mvmmtammrnt.fsf@suse.de> (Andreas Schwab's message of "Mon, 26
        Sep 2022 11:05:58 +0200")
Message-ID: <xmqqsfkeneh5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F35371E-3DCE-11ED-8B7D-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@suse.de> writes:

> Subject: Re: [PATCH] receive.txt: Describe effect of denyDeleteCurrent on bare repositories

"Describe" -> "describe"

> The receive.denyDeleteCurrent config option not only affects non-bare
> repositories, but also the default branch of a bare repository.

We call a branch that is pointed at with the HEAD symbolic-ref the
"current" branch and I think that is why the configuration variable
is called "deny delet(ing) current (branch)".  I do not know if I
have heard the current branch in a bare repository called "the
default", though.

The glossary says

[[def_branch]]branch::
	A "branch" is a line of development.  The most recent
	<<def_commit,commit>> on a branch is referred to as the tip of
	that branch.  The tip of the branch is referenced by a branch
	<<def_head,head>>, which moves forward as additional development
	is done on the branch.  A single Git
	<<def_repository,repository>> can track an arbitrary number of
	branches, but your <<def_working_tree,working tree>> is
	associated with just one of them (the "current" or "checked out"
	branch), and <<def_HEAD,HEAD>> points to that branch.

and does not even mention a bare repository.  

Stepping back a bit.

The primary reason for denying deletion of the "current" branch was
to help those who "clone" from a repository with unborn HEAD
(i.e. HEAD pointing at a branch that has no commits on it yet), so
the current behaviour, unlike receive.denyCurrentBranch that
triggers only in a non-bare repository, that prevents deletion in
either a bare or a non-bare repository does make sense.  "git clone"
in recent versions of Git is much better handling such a situation,
so it may no longer be necessary to keep this restriction, but it is
a different topic.  I agree with this patch that we should document
the behaviour first.

It probably makes sense to update the glossary to talk about the
branch pointed at by HEAD in a bare repository.  It is what the
project that owns the bare repository considers the primary branch
its members would want to follow.  Perhaps like the attached patch
(if we want to keep the introduction of "default branch" phrase in
the patch I am responding to).

A simpler alternative may be to say:

     ... deny a ref update that deletes the current branch that is
     pointed at by HEAD.

in the patch I am responding to.  I am OK with either approach.

Thanks.



 Documentation/glossary-content.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git i/Documentation/glossary-content.txt w/Documentation/glossary-content.txt
index 67c7a50b96..b20ded70d4 100644
--- i/Documentation/glossary-content.txt
+++ w/Documentation/glossary-content.txt
@@ -26,7 +26,10 @@
 	<<def_repository,repository>> can track an arbitrary number of
 	branches, but your <<def_working_tree,working tree>> is
 	associated with just one of them (the "current" or "checked out"
-	branch), and <<def_HEAD,HEAD>> points to that branch.
+	branch) at one time, and <<def_HEAD,HEAD>> points to that branch.
+	A <<def_bare_repository,bare repository>> also has
+	<<def_HEAD,HEAD>> that points at the primary branch (the
+	"default" branch) of the project.
 
 [[def_cache]]cache::
 	Obsolete for: <<def_index,index>>.
@@ -197,6 +200,10 @@ for a more flexible and robust system to do the same thing.
 	<<def_head,heads>> in your repository, except when using a
 	<<def_detached_HEAD,detached HEAD>>, in which case it directly
 	references an arbitrary commit.
++
+In a <<def_bare_repository,bare repository>>, HEAD points at a branch
+that is considered the primary branch (the "default" branch) of the
+project.
 
 [[def_head_ref]]head ref::
 	A synonym for <<def_head,head>>.




