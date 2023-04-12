Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CAAC77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 18:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjDLSdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 14:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLSdY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 14:33:24 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19CA19F
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 11:33:21 -0700 (PDT)
Received: (Authenticated sender: robin@jarry.cc)
        by mail.gandi.net (Postfix) with ESMTPSA id 8B8FC60004;
        Wed, 12 Apr 2023 18:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; s=gm1;
        t=1681324400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGnc10fa+loY/4zEd8dNSsDVjh0skBA/cHg7nKhm4xI=;
        b=W+oJwqYVC+/mxm4DFtJjqKPFBOBI4+XOEhWdLlFTjbc+FKFM6VNtHsvyqar4rMN2hT++zE
        D5vRQvwMSZWsRj/Cvw1Kc3+i29szbVn5pDeZOexwGulgKV5e5MLuE795QdSU8WoSZ3w4I+
        Uk0IJEe1Rx2yU2SdGmcVwZDF2cs25din/ukxn2olskeEwAfcGcny/dQZC526txTmjf1F8N
        Nxj2zqVtH2orhYMqEAwjv1H0wd+UdaEHwQ6di4mkmmHf7FKZxYIOMfgmUW1pIkZUtiMPG0
        FKStakArJ6M4mbDlXSX7O7F8S5rTwmYJfS5OZrPTMkLSnkrgUM3hvcr9hclotQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 12 Apr 2023 20:33:18 +0200
Message-Id: <CRUZR9IO75B2.3DTTR2N12SQRL@ringo>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, "Phillip Wood" <phillip.wood123@gmail.com>,
        =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, "Tim Culverhouse" <tim@timculverhouse.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Michael Strawbridge" <michael.strawbridge@amd.com>
Subject: Re: [PATCH v2] send-email: export patch counters in validate
 environment
From:   "Robin Jarry" <robin@jarry.cc>
X-Mailer: aerc/0.14.0-152-g2abc6042d510-dirty
References: <20230411114723.89029-1-robin@jarry.cc>
 <20230412095434.140754-1-robin@jarry.cc> <xmqqfs957zs4.fsf@gitster.g>
In-Reply-To: <xmqqfs957zs4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Junio C Hamano, Apr 12, 2023 at 19:53:
> See Documentation/CodingGuidelines, look for "For shell scripts
> specifically" and follow what is in the section.  There may be style
> violations of other kinds in the file.

I had missed that one. I'll have a look.

> > +	# Ensure that the patch applies without conflicts to the latest
> > +	# upstream version.
>
> That comment is true only for the first one.  The second patch needs
> to apply to the upstream plus the first patch, and so on.

Will adjust this as well.

> Style-wise, it is better to get rid of get_upstream_url and write
> the above more like
>
> 	workdir=3D$1 &&
> 	url=3D$(git config remote.originurl) &&
> 	rm -r -- "$workdir" &&
> 	git clone ... ||
> 	die "failed to ..."
>
> and that would be less error prone (e.g. you will catch failure from
> "rm" yourself, instead of relying on "git clone" to catch it for
> you).

I have added set -e at the beginning of the script, specifically to
avoid the chained && commands which make the code hard to read. If any
command returns/exits with a non-zero status which is not handled by an
if or by a ||, the shell script will exit.

I can probably get rid of the explicit die statements because of this.

> In any case, I would avoid network traffic and extra disk usage if I
> were showing an example for readers to follow, and would not
> recommend you to use "clone" here, even if it were a shallow one.
>
> It would make much more sense to create a secondary worktree based
> on this repository, with its HEAD detached at the copy of the target
> branch (e.g. refs/remotes/origin/HEAD), and use that secondary
> worktree, as the necessary objects for "am -3" to fall back on are
> more likely to be found in such a setting, compared to a shallow
> clone that only can have the blobs at the tip.

I have never used secondary worktrees. My original thinking was that the
local repository may not be up to date compared to the upstream and
running git fetch on the local repo seemed like a bad idea. Would there
be a proper way to do this with secondary worktree?

There may not be an elegant generic solution here. $(git config
remote.origin.url) may not even contain the proper upstream url...

Also, if I understand how worktrees function, applying patches in
a detached HEAD will create blobs in the current git dir. These will
eventually be garbage collected but I wonder if that could be a problem.

> It is a good discipline to always set GIT_DIR and GIT_WORK_TREE as a
> pair.  Working in a subdirectory of a working tree becomes awkward,
> because the presence of the former without the latter signals that
> your $(cwd) is at the top of the working tree.
>
> But that is more or less moot, because I am suggesting not to use
> "git clone" to prepare the playground and instead use a secondary
> worktree that is attached to the same current repository, so GIT_DIR
> would be the same as the current one.
>
> And because you are "cd"ing there anyway, it probably is much
> simpler to just
>
>     unset GIT_DIR GIT_WORK_TREE
>
> to let the repository discovery mechanism take care of it.

Depending on whether I use a worktree or not, I will unset these
variables.

> It is uneven that validate_patch and validate_cover_letter are
> responsible for dying when problem is found, but validate_series is
> not and the caller is made responsible for that.
>
> I would make the caller responsible for dying with message for all
> three by removing the calls to "die" or "exit" from the former two,
> if I were showing an example for readers to follow.

Agreed, this is inconsistent. My original intent was to provide more
explicit error messages but it is probably not necessary.

As explained above, `set -e` will force early exit if any command fails
without being explicitly handled. I will remove die/exit calls.

> Overall, a very well crafted patch, even though little details and
> some design choices can be improved.

Thanks for the careful review!
