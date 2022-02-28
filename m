Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB44C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 22:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiB1WyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 17:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiB1WyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 17:54:16 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C80259
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 14:53:35 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 35C05184AF3;
        Mon, 28 Feb 2022 17:53:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rEpg+jpY0Ttt
        MQclUqWDu+Y6oxcZgrUcxCMQUUTtQhs=; b=VELgx1/XXURO2hfzyO7jMcGRwnzL
        Beqp5dLLGnTOhMFC/zS8MJHqO0lDhJPqRnI7lZADOF+vJ0tx+LN52awuASyE3K5v
        8G5K8LgWBLHMNaJgEnuI1JplU3oWFfERe0ENmRJBwOGK9OPruySgef2F/p/yU9fW
        Kjwv9/EnKz6/O4U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E882184AF2;
        Mon, 28 Feb 2022 17:53:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ACE0C184AF0;
        Mon, 28 Feb 2022 17:53:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Rolf Eike Beer <eb@emlix.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Please add support for "git merge --continue -S"
References: <3769291.LUJhsIL6D6@mobilepool36.emlix.com>
        <220228.86fso35k61.gmgdl@evledraar.gmail.com>
Date:   Mon, 28 Feb 2022 14:53:31 -0800
In-Reply-To: <220228.86fso35k61.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 28 Feb 2022 11:58:11 +0100")
Message-ID: <xmqq1qzmy55g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4103B1E4-98E9-11EC-8E9D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> You can just drop the use of "merge --continue" entirely and use
> "commit" instead.
>
> Caveats related to this were recently discussed on-list:
> https://lore.kernel.org/git/CALRdAfcyfesNqfLhhe2GW_5V9s2hf++i6mZS1Lw5hq=
QYTca85w@mail.gmail.com/

Ah, that one.  We need to close the #leftoverbits on the topic.
Here is a starter.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: merge: 'git merge --continue' is merely 'git commit'

Among the commands with "--continue", "merge --continue" came much
later, and it did not even need to exist.  The other commands with
"--continue", e.g. "rebase", deal with multi-step operations, and it
is worth to have a way to say "I am finished with this step, let's
CONTINUE WITH THE REST".  But in "merge", there is no remaining
thing to do after you are done with the conflict you saw.

In hindsight, we probably should have resisted the urge to add
"merge --continue", just for the sake of misguided "consistency"
perceived on non-existent similarity with other commands that truly
need "--continue".  What is called "merge --continue" should have
been called "merge --finish", if we needed to add something back
then.

The way to finish a conflicted merge has always been to run "git
commit" before "merge --continue" was added, and it still is not
just accepted but is the right way to finish a conflicted merge.

There is an argument that it makes it somehow "safer" to use "merge
--continue" because the command fails when there is no interrupted
merge going on, but what the user sees from "git commit" when there
is and there is not interrupted merge are so different, there is not
much "safety" benefit in practice.  We probably should deprecate and
eventually remove "git merge --continue" eventually, but one step at
a time.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-merge.txt | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git c/Documentation/git-merge.txt w/Documentation/git-merge.txt
index 3125473cc1..95f252598e 100644
--- c/Documentation/git-merge.txt
+++ w/Documentation/git-merge.txt
@@ -122,9 +122,9 @@ list.
 	stash entry will be saved to the stash list.
=20
 --continue::
-	After a 'git merge' stops due to conflicts you can conclude the
-	merge by running 'git merge --continue' (see "HOW TO RESOLVE
-	CONFLICTS" section below).
+	After a 'git merge' stops due to conflicts, you can conclude
+	the merge with "git commit" (see "HOW TO RESOLVE CONFLICTS"
+	section below).  'git merge --continue' is a synonym for it.
=20
 <commit>...::
 	Commits, usually other branch heads, to merge into our branch.
@@ -326,10 +326,9 @@ After seeing a conflict, you can do two things:
=20
  * Resolve the conflicts.  Git will mark the conflicts in
    the working tree.  Edit the files into shape and
-   'git add' them to the index.  Use 'git commit' or
-   'git merge --continue' to seal the deal. The latter command
-   checks whether there is a (interrupted) merge in progress
-   before calling 'git commit'.
+   'git add' them to the index.  Use 'git commit' (or
+   'git merge --continue', which stops if there is no=20
+   interrupted merge in progress) to seal the deal.
=20
 You can work through the conflict with a number of tools:
=20
