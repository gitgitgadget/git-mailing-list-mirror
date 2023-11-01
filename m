Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876A82599
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 23:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZYDkW4uI"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27056A6
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 16:05:28 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B1CD1B0123;
	Wed,  1 Nov 2023 19:05:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gDVw1lH1NjOb
	Co+PjbR7XhnmgjbS6f2OgP5MCgWlGd0=; b=ZYDkW4uI3EiTJKQWAQbLS6GEJ18g
	ZdYZ/YvXppezXfu50lwCAwYPB+MMRioWT9bbHaWZzmH1mcoI9Pph0w9ABC6fjOq2
	lKqhG28RfrjRvmAD/BsSkgovkqw3YQ77yhwDsmsPfRSzqtZ5w196Z7WJOOcgpq5r
	FvMFlzJqjLNyUFE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 420F51B0121;
	Wed,  1 Nov 2023 19:05:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 989B11B0120;
	Wed,  1 Nov 2023 19:05:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Ruslan Yakauleu" <ruslan.yakauleu@gmail.com>
Cc: git@vger.kernel.org,
    "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
    "Taylor Blau" <me@ttaylorr.com>
Subject: Re: [PATCH] merge: --ff-one-only to apply FF if commit is one
In-Reply-To: <a457e24c-3375-49c6-8cf7-d2dd945827fe@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 01 Nov 2023 11:09:34 +0100")
References: <pull.1599.git.git.1698224280816.gitgitgadget@gmail.com>
	<ZUALkdSJZ70+KBYq@nand.local> <xmqq1qdb8wzk.fsf@gitster.g>
	<cb166ed4-b8b5-4120-b546-e878445573b6@app.fastmail.com>
	<xmqqa5ryxn8i.fsf@gitster.g>
	<a457e24c-3375-49c6-8cf7-d2dd945827fe@app.fastmail.com>
Date: Thu, 02 Nov 2023 08:05:25 +0900
Message-ID: <xmqqv8aloz0q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 24F08DE8-790B-11EE-BCBD-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Wed, Nov 1, 2023, at 02:42, Junio C Hamano wrote:
>> Strictly speaking, the log message on a merge commit serves two
>> purposes, one is to summarize commit(s) on the side branch that gets
>> merged with the merge, and as you said above, it is not needed when
>> merging a topic with just one commit.  But the other is to justify
>> why the topic suits the objective of the line of history (which is
>> needed even when merging a single commit topic---imagine a commit
>> that is not incorrect per-se.  It may or may not be suitable for the
>> maintenance track, and a merge commit of such a commit into the
>> track can explain if/how the commit being merged is maint-worthy).
>
> Yes. If you have multiple release/maintenance branches which you need t=
o
> apply something to then you can=E2=80=99t use this .

OK.  I do not mind a feature to help maintain the first-parent worldview
better to exist, but have a few comments on the patch.

 * Nowhere in the name of feature --ff-one-only, the proposed commit
   log message, added documentation and in-code comments, it is made
   clear to readers that it is to maintain the first-parent view
   better.  The "first-parent" was only brought up between you and I
   as our conjecture on what the feature is for.  The should explain
   the feature a bit better to our readers and users.

   SIDE NOTE: in general, it is not the best way to name and explain
   a feature after what it does (e.g., "fast-forward only when it
   has one commit"); it is better to include why the user want it to
   do what it does.  It it especially true because "fast-forward
   only when the other branch is ahead by one commit" may later turn
   out not to be the best design to ensure "maintain first-parent
   worldview", if the latter is what the feature is really about.

 * The proposed commit log message needs a bit of proofreading and
   polishing, paying attention to the grammar.

 * The "allow fast-forward only when the other branch is ahead by
   one commit" design misses an important case you would want to,
   and you can detect easily, fast-forward.

   Imagine that a developer has a rather complex topic with multiple
   commits, asks the maintainer (or the auto-merger at their forge)
   to pull, but due to modification on the upstream side, there are
   heavy conflicts.  The maintainer can tell (and Git was designed
   to support this mode of operation better---it is called
   "distributed development") the developer:=20

       Since you know your topic much better than I do, can you do
       the merge into the upstream for me?

   The contributor would then help the maintainer, perhaps like so:

    $ git checkout origin/main
    $ git merge [--no-ff] my-topic

   to pretend as if the contributer were the maintainer, merge and
   resolve the conflicts, and then summarizes the topic in the log
   message of the merge commit.  The contributor then updates their
   topic locally, perhaps with

    $ git push . HEAD:my-topic

   which would of course fast-forward, and then ask the maintainer
   (or the auto-merger at their forge) to pull again from "my-topic".

   Now, the updated "my-topic" is ahead of the origin by many
   commits (i.e., the number of commits on the topic, plus the merge
   commit the controbutor created to help the maintainer), but if we
   want to see the resulting history as if the original pull request
   was handled with the "--ff-one-only" option by the maintainer who
   did the merge themself, then we should fast-forward this merge.
   Even though the tip commit of "my-topic" has more commits behind
   it, it is already the binding merge of the side topic that
   "--ff-one-only" would have forced to create if the maintainer did
   the merge.

   So, a better design than "allow fast-forward, only if the branch
   being merged is ahead by one commit" is to allow fast-forward
   when the branch's first-parent is the current tip of the branch
   pull/merge is trying to update.  "only by one commit" can be
   handled as a natural degenerate case of this more general
   criteria, and a good thing is that it is much easier and more
   efficient to compute (i.e., in "git merge OTHER", allow ff if
   "OTHER^1" and "HEAD" are the same).

As I said, I do not mind a feature to help maintain the first-parent
worldview better to exist; thanks for working on the topic.
