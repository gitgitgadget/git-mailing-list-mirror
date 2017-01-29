Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 645801F6DC
	for <e@80x24.org>; Sun, 29 Jan 2017 21:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750840AbdA2Vgz (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jan 2017 16:36:55 -0500
Received: from smtpq2.tb.mail.iss.as9143.net ([212.54.42.165]:49700 "EHLO
        smtpq2.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750757AbdA2Vgx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 29 Jan 2017 16:36:53 -0500
X-Greylist: delayed 1138 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Jan 2017 16:36:52 EST
Received: from [212.54.42.116] (helo=lsmtp2.tb.mail.iss.as9143.net)
        by smtpq2.tb.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <carlo@alinoe.com>)
        id 1cXwr9-000623-Mw
        for git@vger.kernel.org; Sun, 29 Jan 2017 22:17:51 +0100
Received: from h172167.upc-h.chello.nl ([62.194.172.167] helo=mail9.alinoe.com)
        by lsmtp2.tb.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <carlo@alinoe.com>)
        id 1cXwr9-0000AM-Kz
        for git@vger.kernel.org; Sun, 29 Jan 2017 22:17:51 +0100
Received: from carlo by mail9.alinoe.com with local (Exim 4.86_2)
        (envelope-from <carlo@alinoe.com>)
        id 1cXvES-0004sH-IP
        for git@vger.kernel.org; Sun, 29 Jan 2017 20:33:48 +0100
Date:   Sun, 29 Jan 2017 20:33:48 +0100
From:   Carlo Wood <carlo@alinoe.com>
To:     git@vger.kernel.org
Subject: git push failing when push.recurseSubmodules on-demand and git
 commit --amend was used in submodule.
Message-ID: <20170129203348.1a8c0722@hikaru>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: carlo@alinoe.com
X-SA-Exim-Scanned: No (on mail9.alinoe.com); SAEximRunCond expanded to false
X-SourceIP: 62.194.172.167
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.2 cv=YdnN30Zf c=1 sm=1 tr=0 a=Sr+rG1RSRvb2GKWoPpN/Zg==:17 a=kj9zAlcOel0A:10 a=IgFoBzBjUZAA:10 a=BjFOTwK7AAAA:8 a=PFQ1ToL-_P3CfuTonIkA:9 a=CjuIK1q_8ugA:10 a=N3Up1mgHhB-0MyeZKEz1:22
 none
X-Ziggo-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

there seems to be a problem with using 'git commit --amend' in
git submodules when using 'git push --recurse-submodules=on-demand'
in the parent.

The latter fails, saying "The following submodule paths contain changes
that can not be found on any remote:" for such submodule, even though
the submodule is clean, pushed and reports 'Everything up-to-date'
when trying to push it.

I believe that the reason has to be that the parent repository thinks
that the comment that was amended, but not pushed, must be on the remote
too, while the whole point of amend is that this commit is not pushed.

I wrote a little script that demonstrates the problem.
Please run in an empty directory.

START-OF-SCRIPT

#! /bin/bash

# This script demonstrates a bug in git where it reports
#
#   The following submodule paths contain changes that can
#   not be found on any remote:
#
# for a submodule that is clean and pushed.
#
# Create an empty directory, put this script in it
# and run the script.
#
# Carlo Wood, 2017/01/29

# Clean a possible previous run:
rm -rf parent remote.parent remote.subm

REMOTE_BASE="$(pwd)"

# Create a 'remote' for the submodule 'subm'.
mkdir remote.subm
pushd remote.subm
git init --bare
popd

# Create a 'remote' for the 'parent' repository.
mkdir remote.parent
pushd remote.parent
git init --bare
popd

# Create initial parent/subm directory structore.
mkdir -p parent/subm

# Create an initial subm git repository.
pushd parent/subm
git init
git remote add local "$REMOTE_BASE/remote.subm"
touch s ; git add s
git commit -m 'Initial commit.'
git push --set-upstream local master
popd

# Create an initial parent git repository with subm as submodule
# and push.recurseSubmodules = on-demand.
pushd parent
git init
git config push.recurseSubmodules on-demand
git remote add local "$REMOTE_BASE/remote.parent"
touch p ; git add p
git submodule add "$REMOTE_BASE/remote.subm" subm
git add .gitmodules subm
git commit -m 'Initial commit.'
git push --set-upstream local master
popd

# Do some commit in subm, but do not push it to the remote.
pushd parent/subm
echo "My frist commit." > s
git commit -a -m 'Change s'
popd

# Add the subm hash to the parent.
pushd parent
git add subm
git commit -m 'Updated subm.'
popd

# Amend the commit in subm (and optionally push it).
pushd parent/subm
echo "My first commit." > s
git commit -a --amend -m 'Change s'
popd

# Correct that in the parent too:
pushd parent
git add subm
git commit -m 'Updated subm.'
popd

# At this point nothing was published yes, so the
# amend shouldn't have caused a problem. But it did.
pushd parent
git push
popd

echo "THE ABOVE ERROR CAN NOW BE REPRODUCED INDEFINITELY,"
echo "FOR EXAMPLE, DO:"
echo
echo "cd parent/subm"
echo "git push"
echo "cd .."
echo "git push"


END-OF-SCRIPT

Tested with current master 4e59582ff70d299f5a88449891e78d15b4b3fabe

Regards,
Carlo

-- 
Carlo Wood <carlo@alinoe.com>
