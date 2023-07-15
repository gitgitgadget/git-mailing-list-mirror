Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0284BC001B0
	for <git@archiver.kernel.org>; Sat, 15 Jul 2023 23:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjGOXPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jul 2023 19:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGOXPj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2023 19:15:39 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8AA2702
        for <git@vger.kernel.org>; Sat, 15 Jul 2023 16:15:36 -0700 (PDT)
Date:   Sat, 15 Jul 2023 23:15:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1689462934; x=1689722134;
        bh=/qwDMR3OC17t5jNk6+fPD9zPO/GPTdwfTsyXYQ/bvto=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=aUWCPmSOnVUA1LpyQkraUSh7a2OT8a56n2VbmZftDP/l6wRdnGm+0u6RQ6RpycqiH
         OF0t2mp4UeybyGFHUx/5qhkPIrFU4fU1uj+Pis5C8qegjEbODMKMsCARCFLQtO50Wn
         IIDAjlLQ9xIYyOFbFPT9CYvIg7zX+KU1i+zAvQCtJhehqAwoEBboH+MDUj+hEBp9IK
         to9Jkcv89elsJEptepjpp8qAq5grw/AiJIpEqRrgkwIfqALei5nnZn845ku64mJ78k
         n0Juk2K00qq5wfQcYTW0jZ1Y74PyTk9g+achq6ZVMEIYDdscraYZINuH7szRPlsBvX
         ZU4uWQYCmSdTg==
To:     phillip.wood@dunelm.org.uk
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t2400: Fix test failures when using grep 2.5
Message-ID: <vn5sylull5lqpitsanlyan5fafxj5dhrxgo6k65c462dhqjbno@uwghfyfdixtk>
In-Reply-To: <2e22a23f-576f-7a42-ace8-624a5362d9f4@gmail.com>
References: <20230715025512.7574-1-jacobabel@nullpo.dev> <2e22a23f-576f-7a42-ace8-624a5362d9f4@gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/07/15 09:59AM, Phillip Wood wrote:
> Hi Jocab
>=20
> On 15/07/2023 03:55, Jacob Abel wrote:
> > [...]
>=20
> Thanks for working on this fix. Having looked at the changes I think it
> would be better just be using a space character in a lot of these
> expressions - see below.
>=20
> > [...]
> >
> > -=09=09=09grep -E "^hint:\s+git worktree add --orphan -b \S+ \S+\s*$" a=
ctual
> > +=09=09=09grep -E "^hint:[[:space:]]+git worktree add --orphan -b [^[:s=
pace:]]+ [^[:space:]]+[[:space:]]*$" actual
>=20
> We know that "hint:" is followed by a single space and all we're really
> interested in is that we print something after the "-b " so we can
> simplify this to
>=20
> =09grep "^hint: git worktree add --orphan -b [^ ]"
>=20
> I think the same applies to most of the other expressions changed in
> this patch.

This wouldn't work as it's `hint: ` followed by a `\t` as the command
is indented in the text block. So I just went with `[[:space:]]+` as I
didn't want to have to worry about whether some platforms expand the
tab to spaces or how many spaces. I'll make the rest of the suggested
changes though.

> > [...]
> > @@ -998,8 +998,8 @@ test_dwim_orphan () {
> >   =09=09=09=09=09headpath=3D$(git $dashc_args rev-parse --sq --path-for=
mat=3Dabsolute --git-path HEAD) &&
>=20
> I'm a bit confused by the --sq here - why does it need to be shell
> quoted when it is always used inside double quotes?=20

To be honest I can't remember if this specifically needs to be in
quotes or not however I had a lot of trouble during the development of
that patchset with things escaping quotes and causing breakages in the
tests so if it isn't currently harmful I'd personally prefer to leave
it as is.

> Also when the reftable backend is used I'm not sure that HEAD is
> actually a file in $GIT_DIR anymore (that's less of an issue at the
> moment as that backend is not is use yet).

If there is documentation (or discussions) on how to use this backend
properly I'd appreciate a link and I can try workshopping a better
solution then. The warning included in the original patchset reads
from that HEAD file as well so it would also need to be adapted.=20

The reason I did it this way is because I didn't see any easy way to
get the raw contents of the HEAD when it was invalid. If there is a
cleaner/safer/more portable way to view those contents when HEAD
points to an invalid or unborn reference, I'd be willing to work on a
followup patch down the line.

> > [...]
>=20
> Using grep like this makes it harder to debug test failures as one has
> to run the test with "-x" in order to try and figure out which grep
> actually failed. I think here we can replace the sequence of "grep"s
> with "test_cmp"
>=20
> =09cat >expect <<-EOF &&
> =09HEAD points to an invalid (or orphaned) reference
> =09HEAD path: $headpath
> =09HEAD contents: $headcontents
> =09EOF
>=20
> =09test_cmp expect actual

I'll make these changes.

> [...]

