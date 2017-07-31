Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 410201F991
	for <e@80x24.org>; Mon, 31 Jul 2017 22:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbdGaWSZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 18:18:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53201 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751157AbdGaWSY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 18:18:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 847A7A7472;
        Mon, 31 Jul 2017 18:18:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZPfVHJDJWnvNK++G6IPDzqO389E=; b=owL+vU
        YeqFSHzJ750vUvafw5zxx7HW+6e5rQCKrB63DEbfWaOvUrx8/j3Fnoxsfl6dGBg3
        UueACgsj7BSCvU+aLpYSAtK+vRSy3gQw85CZAro/kUrYg6ORCnUuYztMDA4db/ER
        CbEXwdEfCytNuyhbJjm50L0N6YV2sLzVvt6r8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IUziC1Y9JnbkwP85LK2fQe4yWIqxTXQg
        jMTxeSqdtzWUBhUAIVUFvvxqEBOmeijqMKPWpkdx6RK69wFOz/f1PMwiBiZG+56G
        qXhxBytfL3/ZFgg/tYymuM6QmndM7md0djsqimi9tuixtDIqDXcClLa1M3+f4jUB
        hvaGHglk6h4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D7B4A7471;
        Mon, 31 Jul 2017 18:18:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E07ACA746F;
        Mon, 31 Jul 2017 18:18:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Spiers <git@adamspiers.org>
Cc:     git list <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] add git-splice subcommand for non-interactive branch splicing
References: <cover.55495badd28b73b39c60ca4107b50aae7ee95028.1501535033.git-series.git@adamspiers.org>
Date:   Mon, 31 Jul 2017 15:18:21 -0700
In-Reply-To: <cover.55495badd28b73b39c60ca4107b50aae7ee95028.1501535033.git-series.git@adamspiers.org>
        (Adam Spiers's message of "Mon, 31 Jul 2017 22:18:48 +0100")
Message-ID: <xmqqo9s0gsia.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A63DDC4-763E-11E7-BF38-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Spiers <git@adamspiers.org> writes:

> Therefore there is a risk that each new UI for higher-level workflows
> will end up re-implementing these mid-level operations.  This
> undesirable situation could be avoided if git itself provided those
> mid-level operations.

Let me make sure if I get your general idea right, first.

Is your aim is to give a single unified mid-layer that these other
tools can build on instead of rolling their own "cherry-pick these
ranges, then squash that in, and then merge the other one in, ..."
sequencing machinery?

If so, I think that is a very good goal.

>     # Remove commits A..B (i.e. excluding A) from the current branch.
>     git splice A..B
>     # Remove commit A from the current branch.
>     git splice A^!
>     # Remove commits A..B from the current branch, and cherry-pick
>     # commits C..D at the same point.
>     git splice A..B C..D

We need to make sure that the mid-layer tool offers a good set of
primitive operations that serve all of these other tools' needs.  I
do not know offhand if what you implemented that are illustrated by
these examples is or isn't that "good set".

Assuming that there is such a "good set of primitives" surfaced at
the UI level so that these other tools can express what they want to
perform with, I'd personally prefer to see a solution that extends
and uses the common "sequencer" machinery we have been using to
drive cherry-picks, reverts and interactive rebases that work on
multiple commits.  IOW, it would be nice to see that the only thing
"git splice A..B" does is to prepare a series of instructions in a
file, e.g. .git/sequencer/todo, just like "git cherry-pick A..B"
would, and let the sequencer machinery to handle the sequencing.

E.g. In a history like

    ---o---A---o---B---X---Y---Z   HEAD

"git splice A..B" command would write something like this:

    reset to A
    pick X
    pick Y
    pick Z

to the todo file and drive the sequencer.  As you notice, you would
need to extend the vocabulary of the sequencer a bit to allow
various things that the current users of the sequencer machinery do
not need, like resetting the HEAD to a specific commit, merging a
side branch, remembering the result of an operation, and referring
to such a commit in later operation.  For example, if you tell "git
splice" to expunge A from this sample history (I am not sure how you
express that operation in your UI):

         B---C---D
        /         \
    ---o---A---E---F---G   HEAD

it might create a "todo" list like this to rebuild the history:

    reset to A^
    pick B
    pick C
    pick D
    mark :1
    reset to A^
    pick E
    merge :1 using F's log message and conflict resolution as reference
    pick G

to result in:

         B---C---D
        /         \
    ---o-------E---F---G   HEAD

Do not pay too much attention to how the hypothetical "extended todo
instruction set" is spelled in the above illustration (e.g. I am not
advocating for multi-word command like "reset to"); these are only
to illustrate what kind of features would be needed for the job.  In
the final shape of the system, "merge" in the illustration above may
be a more succinct "merge F :1", for example (i.e. the first
parameter would name an existing merge to use as reference, the
remainder is a list of commits to be merged to the current HEAD),
just like "pick X" is a succinct way to say "cherry-pick the change
introduced by existing commit X to HEAD, reusing X's log message
and author information".

Something like that may have a place in the git-core, I would think. 

I am not sure if a bash script that calls rebase/cherry-pick/commit
manually can serve as a good "universal mid-layer" or just adding
another random command to the set of existing third-party commands
for "higher-level workflows".
