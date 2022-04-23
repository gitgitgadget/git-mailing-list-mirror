Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2F9C433F5
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 05:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiDWF6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 01:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiDWF6D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 01:58:03 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46EA306
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 22:55:06 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 42E6B18308E;
        Sat, 23 Apr 2022 01:55:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=S2vqOmJVU1Nv
        pKp++5hghEI6F6J8HZsMv3na9DYD/zc=; b=czJEdxu9cDIWuqAztGGGt6Ki3IKf
        wG3aAemUjUEPeVdff9TTlqe6QkYbC6lkgEVrhIX2xEucWb3+mVWrHSheqJecSdt3
        RLHIshtwCCMSfakUvAFXYTg5YKT7BoJRygC2N/OIvvIqmEuNOkvQzGiPn8WDW4Wa
        3fPTtn/pwrzQyEc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B86D18308C;
        Sat, 23 Apr 2022 01:55:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 09B2B183088;
        Sat, 23 Apr 2022 01:55:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: gitk regression in version 2.36.0
References: <AM0PR04MB6019ECF053F1FB7B29D75AB7A5F69@AM0PR04MB6019.eurprd04.prod.outlook.com>
Date:   Fri, 22 Apr 2022 22:54:58 -0700
In-Reply-To: <AM0PR04MB6019ECF053F1FB7B29D75AB7A5F69@AM0PR04MB6019.eurprd04.prod.outlook.com>
        ("Matthias =?utf-8?Q?A=C3=9Fhauer=22's?= message of "Sat, 23 Apr 2022
 07:25:15 +0200
        (CEST)")
Message-ID: <xmqqpml82vkd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E9557F1C-C2C9-11EC-9105-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias A=C3=9Fhauer <mha1993@live.de> writes:

> Git 2.36.0 (or more precisely 244c27242f (diff.[ch]: have diff_free()
> call clear_pathspec(opts.pathspec), 2022-02-16)) introduced some
> change in behaviour that causes gitks highlight feature not to work
> correctly anymore.

Nicely found.

I think what happens is that gitk REPEATEDLY calls log_tree_commit()
by opening a pipe to "git diff-tree -r -s --stdin $gdtargs" and feed
revisions from its standard input. =20

    builtin/diff-tree.c::diff_tree_stdin()
    -> builtin/diff-tree.c::stdin_diff_commit()
       -> log-tree.c::log_tree_commit()

Now, log-tree.c::log_tree_commit() is responsible for formating the
difference between the commit and its parent, using the
opt->diffopt.  After computing the pairwise diff for one tree pair
(commit and its parent), of course it calls diff_free() to flush the
queued diff and release other resources we allocated while showing
that single diff.  Before the broken commit 244c27242f, diff_free()
released ONLY the newly allocated resources that we needed to
compute one pair of trees.  Most importantly, the settings used to
compute diffs that are reused to compute the next pair of trees need
to be kept, e.g. pathspec.

Remember, we are talking about log-tree, the upstream of the pipe
going from the tip of the history and traversing the parent chain to
ancestors, so once we are done with showing the diff between our
current commit and its parent, we will move to the parent and
compute the same diff with its parent (i.e. our grand-parent).

But with the regression, we mistakenly release the pathspec, so the
first commit may use the specified pathspec, but the second and
subsequent ones will lose the pathspec the user gave us, making the
comparison tree-wide one, not limited with any pathspec.

I am reasonably sure that reverting that commit will be the right
thing to do.  It is somewhat unfortunate that it would reintroduce
resource leaks that having clear_pathspec() in a wrong place (i.e.
diff_free()) was covering up.  We should instead need to find the
place where a diff_opt struct goes out of scope (after being used
for zero or more times, calling diff_free() after each iteration to
release resources consumed per-iteration) and call clear_pathspec().

Thanks for a report.
