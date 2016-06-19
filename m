Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B6BA20189
	for <e@80x24.org>; Sun, 19 Jun 2016 03:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbcFSDKI (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 23:10:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751178AbcFSDKH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 23:10:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CE30D2693D;
	Sat, 18 Jun 2016 23:10:04 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oLtKWQrBD7CQgJtjl3oSmzonNw8=; b=vMd3Y7
	7cz2eUL9B8rvRCzssKKb5P0AnwBfJIC9H6h5ip92BKEE7if5dFFauc31qD1b6SFs
	Qb5F6Jv2YEcwpq1LFKecHyzRhaZXAnwyUp5SNkfEzkCuZzIQL7rI89kLCAj9U33m
	DoN3S2w5Ik8h9U1TFXx4s60Y4ZnE0qfjrQNR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fBgYsrQot/ru9dVn3iB5C0ZbVfPVYzwG
	voP96o54WSAliqub2gKNe+prCwluj+u//xVtqUc0CbnqczmZFpcct3fkF2IpZBGZ
	/W3DGUSqetLriK907AtYVB9h2idN8P4yAUtpCK2rPQCNkWIGKrh0ryMPQVQGxol+
	nfySZe2LTFM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C64172693C;
	Sat, 18 Jun 2016 23:10:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 41CC02693B;
	Sat, 18 Jun 2016 23:10:04 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Emily Xie <emilyxxie@gmail.com>
Cc:	git@vger.kernel.org, novalis@novalis.org
Subject: Re: [PATCH] pathspec: prevent empty strings as pathspecs
References: <20160619005704.1771-1-emilyxxie@gmail.com>
Date:	Sat, 18 Jun 2016 20:10:02 -0700
In-Reply-To: <20160619005704.1771-1-emilyxxie@gmail.com> (Emily Xie's message
	of "Sat, 18 Jun 2016 20:57:04 -0400")
Message-ID: <xmqqmvmhyiut.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 517808D6-35CB-11E6-AFFC-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Emily Xie <emilyxxie@gmail.com> writes:

> For any command that takes a pathspec, passing an empty string will
> execute the command on all files in the current directory. This
> results in unexpected behavior. For example, git add "" adds all
> files to staging, while git rm -rf "" recursively removes all files
> from the working tree and index. This patch prevents such cases by
> throwing an error message whenever an empty string is detected as a
> pathspec.

This change is likely to break people's existing scripts.

For example, a script may want to inspect some state of the whole
working tree and then after the inspection was satisfactory do
something that affects paths that are inside the directory you were
originally in.  You would write something like this:

	#!/bin/sh
	original=$(git rev-parse --show-prefix)

        cd "$(git rev-parse --show-toplevel)"
        ... do the whole-tree pre-inspection
        ... using various git commands here

	# Then finally do the "action"
        git add "$original"

This works even if you happen to be at the top-level of the working
tree, but with your patch it suddenly breaks.  It may be trivial to
update the script to use "." when $original is empty, but that is
not an excuse.  The important thing is that they need to be told
about having to change their script before this change actually
happens.  Suddenly breaking other people without telling is simply
rude and unacceptable.

At least you would need two-step process to introduce a change like
this to warn the people whose tools and workflows you are breaking.
That is, (1) in one release, you add code to only detect the case
you will be changing the behaviour in a later version and give
warning messages, and (2) in another release that is several release
cycles later, stop warning and actually change the behaviour.

That is, if we assume that passing an empty string by mistake is a
problem in the real world that we want to save users from.  After
all, even though there is _no_ good reason why we _need_ to take
'git add ""' as the same as 'git add .', there is no need not to,
either.  When a user says 'git add sub/sub/' we would add everything
in that directory, 'git add sub/' would add even more, and it is
logically consistent for 'git add ""' to add everything.  This is a
border-line "doctor, if I pass an empty string, it is taken the same
way as a dot. -- don't do that then."

A kind of change that satisifies the following criteria:

 (1) I can tell that the author of the change really means well.

 (2) The problem the change is fixing does not seem to be a huge
     issue in real life.

 (3) The code with the patch would behave is not wrong per-se; it
     probably is how we would have designed the feature if we knew
     better.

 (4) However, we are not designing things from scratch without
     existing users, and the change potentially breaks uncountable
     number of existing users.

is something I really hate having to evaluate.  This is one of them.

So, I am of two minds.

I do not mind a two-step breaking of compatibility to address this
issue; I would also understand if the author thinks it is not worth
the hassle to do so.  The sudden behaviour change with this patch
alone is however not acceptable, I would think.
