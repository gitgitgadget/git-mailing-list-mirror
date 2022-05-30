Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD42C433EF
	for <git@archiver.kernel.org>; Mon, 30 May 2022 02:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiE3CP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 May 2022 22:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiE3CP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 May 2022 22:15:56 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D5F5DE5A
        for <git@vger.kernel.org>; Sun, 29 May 2022 19:15:54 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 24U2Fp4X036846
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 29 May 2022 22:15:52 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <Graham.Menhennitt@c4i.com>, <git@vger.kernel.org>
References: <BN2P110MB17460C18D525E831A63C4376C5DD9@BN2P110MB1746.NAMP110.PROD.OUTLOOK.COM>
In-Reply-To: <BN2P110MB17460C18D525E831A63C4376C5DD9@BN2P110MB1746.NAMP110.PROD.OUTLOOK.COM>
Subject: RE: request for development/build workflow suggestion/fix
Date:   Sun, 29 May 2022 22:15:47 -0400
Organization: Nexbridge Inc.
Message-ID: <033c01d873cb$3001f6a0$9005e3e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJjMJJp3guUt66S5MWyJlyUbigDDKwhNOHA
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 29, 2022 9:45 PM, Graham Menhennitt wrote:
>We have a (small) problem in our development/build workflow. I'd like to
request
>suggestions on either:
>- how we can improve the workflow to avoid the problem, or
>- how we can fix our build system so that the problem doesn't occur.
>
>Our (simplified) development workflow for fixing a bug or adding
functionality:
>- clone the repo and create a private branch off the Integration branch
>- fix the bug or develop the functionality (and test)
>- merge the private branch to Integration
>- create a tag to identify the fix
>
>Our build system:
>- clone the repo's Integration branch
>- edit a 'version' file in the repo that contains the current build number
and
>increment that number
>- build the software
>- commit the edited version file
>- create a tag identifying the build number
>- produce a list of changes since the previous build by diffing between the
newly
>created tag and the previous build tag
>
>The problem:
>- if a developer merges to Integration and creates a tag while the build is
in
>progress, his tag gets included in the diffs even though his changes aren't
actually
>included in the build.
>
>Below is a shell script that demonstrates the problem. A quick description:
>- create an empty git repo 'origin'
>- clone it to repo 'buildClone', create an Integration branch, add a source
file and
>'version' file with version = 1, tag that as build 1, push
>- increment the version to 2 as if we were doing build 2, commit and tag as
build 2
>but don't push yet
>- create a second clone 'develClone', create a development branch, modify
the
>source file, commit, merge the branch to Integration, tag with 'develTag',
push to
>origin
>- in the build clone, pull and then push to origin
>- increment the version file as if doing build 3, commit, tag as build 3,
pull and push
>- get the diffs between builds 1 & 2, and 2 & 3 - develTag should not be in
the first
>set of diffs but it should be in the second set
>
>So, my question: can anybody please suggest an improvement to our
>development or build workflows to fix/avoid the problem? The obvious change
of
>omitting the pulls before pushing from buildClone doesn't work - git won't
allow
>the push.
>
>Many thanks in advance for any suggestions.
>	Graham
>
>
>========================================== shell script
>========================== export GIT_COMMITTER_NAME=committer
>export GIT_COMMITTER_EMAIL=committer@example.com
>export GIT_AUTHOR_NAME=author
>export GIT_AUTHOR_EMAIL=author@example.com
>
>set -e # exit on error
>
>set -x # for debugging
>
># clean up any previous leftovers and start afresh rm -rf origin buildClone
>develClone mkdir -p origin buildClone develClone
>
># create a bare repo in 'origin'
>git -C origin init --bare
>
># and a clone for building
>git -C buildClone clone ../origin .
>
># create an Integration branch and check it out git -C buildClone checkout
-b
>Integration
>
># create a source file, commit it, and push echo "this is some source code"
>
>buildClone/sourceFile git -C buildClone add sourceFile git -C buildClone
commit --
>all --message "add source file"
>git -C buildClone push --set-upstream origin
>refs/heads/Integration:refs/heads/Integration
>
># create a version file, commit it, and push (as if build 1 had just been
completed)
>echo "version=1" > buildClone/version git -C buildClone add version git -C
>buildClone commit --all --message "add version"
>git -C buildClone push
># and add a tag to it
>git -C buildClone tag build1
>git -C buildClone push --tags
>
># edit the file to increment the version, and commit it (but don't push it
yet) sed --
>in-place --expression "s/1/2/" buildClone/version git -C buildClone commit
--all --
>message "increment version"
># and create a tag on the build
>git -C buildClone tag build2
>
>
>                        # develClone repo
>
>                        # clone again for development work and checkout
Integration branch
>                        git -C develClone clone -b Integration ../origin .
>
>                        # create a branch and check it out, edit the source
file, commit it, and
>push it (as if a developer was making changes)
>                        git -C develClone checkout -b develBranch
>                        sed --in-place --expression "s/$/ with a change/"
>develClone/sourceFile
>                        git -C develClone commit --all --message "edit
source file"
>                        git -C develClone push --set-upstream origin
>refs/heads/develBranch:refs/heads/develBranch
>
>                        # merge the branch into Integration
>                        git -C develClone checkout Integration
>                        git -C develClone merge --no-ff --commit -m "merge
develBranch to
>Integration" develBranch
>
>                        # create a development tag
>                        git -C develClone tag develTag
>
>                        # and push everything
>                        git -C develClone push
>                        git -C develClone push --tags
>
># back in buildClone
>
># get any changes from origin that have occurred since we originally cloned
git -C
>buildClone pull --ff --no-edit
>
># and push everything
>git -C buildClone push --force
>git -C buildClone push --tags --force
>
># now do build 3
>
># edit the file to increment the version, and commit it (but don't push it
yet) sed --
>in-place --expression "s/2/3/" buildClone/version git -C buildClone commit
--all --
>message "increment version"
># and create a tag on the build
>git -C buildClone tag build3
>
># get any changes from origin that have occurred since we originally cloned
git -C
>buildClone pull --ff --no-edit
>
># and push everything
>git -C buildClone push --force
>git -C buildClone push --tags --force
>
># finally, test the results
>failed=false
>
># we do not want the following to contain develTag (but, of course, it
does) if git -
>C buildClone tag --contains build1 --no-contains build2 | grep develTag;
then
>    echo "build2 contains develTag when it shouldn't"
>    failed=true
>fi
>
># and we do want the following to contain develTag (but, of course, it
doesn't) if !
>git -C buildClone tag --contains build2 --no-contains build3 | grep
develTag; then
>    echo "build3 doesn't contain develTag when it should"
>    failed=true
>fi
>
>if $failed; then
>    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!! failed !!!!!!!!!!!!!!!!!!!!!!"
>    exit 1
>fi

I don't know whether your process might be able to distinguish between
annotated and unannotated tags. git describe does. Maybe using one or the
other might enhance what you are trying to do.
--Randall

