Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419E7C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 17:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCVRpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjCVRpK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 13:45:10 -0400
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B471B31A
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:44:45 -0700 (PDT)
Date:   Wed, 22 Mar 2023 17:44:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1679507077; x=1679766277;
        bh=1i8b5V0pM530YzOwxB1tWLhNwMxL7DfazTdBgZ0PsPk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ea9eeVvG+YW6Z7p/Uxpbok0a0ckWRfud7zeLe0/pJahiMzxQ/fS8rClifoWh2IID/
         p4GztMChQPFD0S2+9Qo+ACBLIdZCsGeQuY3/rjxMX1tH147+cBiercLnj1pqyKFPwK
         +irfGX1iw+wnnrOoRIToVugO2xxxtUFj7JhKt23df3vyaCVnqCvN30NUPshfQju5eS
         TZt+/YxptCA54kTU4WTAemhu76sHC5l8B1awuGYuk6RsJ7wpoyV1mRCSqbAgmq5v6f
         fBhIqjk5gFPQrsczTrZ+9TjwbmKF8MqcZdSWAgu2g2m4YzM5ZAAp2xzc47b1LV3Uf8
         CZurBigT93MIg==
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
From:   dooagain <dooagain@protonmail.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug: git pull output and case sensitivity.
Message-ID: <RzFzlUstO3B5yEeHQADOAFSBeeieGLLv_Vbj4B9yss_8qB_kshBK5NvvOBKlfnHPg_7GDhdyWGxmak-jyczZCyjihDnqMp2oZRpiCyn6wU0=@protonmail.com>
In-Reply-To: <20230320191210.jzzq5c2ssxcltvoc@tb-raspi4>
References: <-Va6f9aA736sZCXChvTLaUUSpAq9-ooSELLBrqRSXR5zAQwT7QSRryN1SGBWQj7J_KowBmZuhDHwIwAkrFFfyelwtkXJ-ri4yLPpmDpBqBU=@protonmail.com> <20230319062239.w37x64knfhfapbsn@tb-raspi4> <20230320171602.GB2615782@coredump.intra.peff.net> <_XGWc87b9HPBCDZ95pSmwNOFcZO21Y6bVyNnhhNuowPcM2Fhs5HmCynAqq2nME257bMhQ4w7Qta1dICTCHTlxbQ2NHN_iPYO0NkBYmS9vTI=@protonmail.com> <20230320191210.jzzq5c2ssxcltvoc@tb-raspi4>
Feedback-ID: 5666827:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is probably overkill, but here is a script that replicates the issue

#! /usr/bin/env bash

# WARNING
# These are dangerous commands that create and delete
# disk volumes. Uncomment and execute at your own risk.

# [BEGIN DANGEROUS COMMANDS]
#=20
# This is the command to "cleanup" or remove the newly created Volume.
# This will delete the Volume with an id of `disk1s9` that is going to
# change depending on your drive setup. Execute `diskutil list` to see=20
# general disk info
#
# `diskutil apfs deleteVolume disk1s9`
#
# Create a case sensitive volume
# `diskutil apfs addVolume disk1 APFSX Casesensitive` # disk1s9
#
# [END DANGEROUS COMMANDS]

SCRIPT_DIR=3D$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pw=
d)
REMOTE=3D/Volumes/Casesensitive/casing
# Set REMOTE=3D"${SCRIPT_DIR}/casing-remote"
# If you do not want to create a case sensitive volume
REPO=3D"${SCRIPT_DIR}/casing-bob"
REPO_OTHER=3D"${SCRIPT_DIR}/casing-alice"

rm -rf "${REPO}" "${REPO_OTHER}" "${REMOTE}" && \
  mkdir "${REPO}" "${REPO_OTHER}" "${REMOTE}" && \
  cd "${REMOTE}" && \
  git init --bare && \
  cd "${REPO}" && \
  git init && \
  echo "#casing" > README.md && \
  git add README.md && \
  git commit -m "init commit" && \
  git branch -M master && \
  git remote add origin "${REMOTE}" && \
  git push -u origin master && \
  git clone "${REMOTE}" "${REPO_OTHER}" && \
  cd "${REPO}" && \
  git checkout -b Bug/foo && \
  touch foo && \
  git add foo && \
  git commit -m "adding foo file" && \
  git push --set-upstream origin Bug/foo && \
  cd "${REPO_OTHER}" && \
  git checkout -b bug/bar && \
  touch bar && \
  git add bar && \
  git commit -m "added bar file" && \
  git push --set-upstream origin bug/bar && \
  cd "${REPO_OTHER}" && \

  # casing-alice always thinks that Bug/foo is a new branch
  # because it has a loacl ref of ".git/refs/remotes/origin/bug/bar"
  # so it doesn't know Bug/foo and bug/foo are the same branch.
  # It does seem that local "bug/foo"=20
  # is in sync with remote "Bug/foo" despite the warning

  git pull
  git pull


------- Original Message -------
On Monday, March 20th, 2023 at 1:12 PM, Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:


> On Mon, Mar 20, 2023 at 06:01:30PM +0000, dooagain wrote:
>=20
> > I'm not sure if this is helpful, but I documented a simple way to recre=
ate the issue I am seeing in the README in the https://github.com/spencerdc=
arlson/test-casing repository.
>=20
>=20
> It is helpful, thanks.
> In general, we prefer to have all informartion in emails ;-)
> Anyway.
>=20
> To reply on Peff's comment:
>=20
> > So I think this is just a known gotcha, and the path forward is probabl=
y
> > a new ref storage format that doesn't rely on storing names directly in
> > the filesystem (reftable, or some system based on packed-ref slices).
>=20
>=20
> Yes, it is.
> The thing is, that Git at the moment is unable to handle to branches
> like Foo and foo on case-insensitive file systems.
> Because branch names are stored as files, and that doesn't typially work
> well under Windows or MacOs.
>=20
> As a workaround,
> git pack-refs
> can be used.
>=20
> side-note 1: a better backend for refs may make it's way into Git
> in the long term.
>=20
> side-note 2:
> I always recommend to stick to a naming convention when working in
> a cross-platform project.
> You can keep filenames only lowercase.
> That is debatable, some people prefer camel-case rather then snake-case.
> So go for either way.
> But the same restriction/recommendation is valid for branch names as well=
,
> stick to one convention and avoid possible collisions under Mac or Window=
s.
>=20
> Or run `git pack-refs`, but be aware the the performance may suffer,
> if you use zillions of refs.
>=20
> HTH
> /Torsten
>=20
> > ------- Original Message -------
> > On Monday, March 20th, 2023 at 11:16 AM, Jeff King peff@peff.net wrote:
> >=20
> > > On Sun, Mar 19, 2023 at 07:22:40AM +0100, Torsten B=C3=B6gershausen w=
rote:
> > >=20
> > > > On Sat, Mar 18, 2023 at 07:21:10PM +0000, dooagain wrote:
> > > >=20
> > > > > Thank you for filling out a Git bug report!
> > > > > Please answer the following questions to help us understand your =
issue.
> > > > >=20
> > > > > What did you do before the bug happened? (Steps to reproduce your=
 issue)
> > > > >=20
> > > > > I configured my git repository to ignore case by executing `git c=
onfig core.ignorecase true` then I executed `git pull` multiple times.
> > > >=20
> > > > What do you mean by "I configured my git repository" ?
> > > > The answer is already there, so let's re-rephrase it:
> > > > Are you working on a case-insensitive file system ?
> > > >=20
> > > > What happens if you create a test directory, like this:
> > > > mkdir test-case
> > > > cd test-case
> > > > git init
> > > > git config --get core.ignorecase
> > >=20
> > > I think this is kind of a red herring, isn't it? The bug report is ab=
out
> > > refs, and I don't think those really respect core.ignorecase either w=
ay,
> > > and inconsistencies are known to happen on case-insensitive filesyste=
ms
> > > (because the refs are sometimes case-sensitive and sometimes not
> > > depending on whether they are packed or loose in the filesystem).
> > >=20
> > > So I think this is just a known gotcha, and the path forward is proba=
bly
> > > a new ref storage format that doesn't rely on storing names directly =
in
> > > the filesystem (reftable, or some system based on packed-ref slices).
> > >=20
> > > -Peff
