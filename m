From: Greg Ward <greg@gerg.ca>
Subject: Inconsistent result from git diff --quiet after untar'ing
 repo+working dir
Date: Sun, 12 Sep 2010 21:24:22 -0400
Message-ID: <AANLkTikqrn0MKLFAt2D71fNyFkG1T3ncrrHx-LoSZLAH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 03:24:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ouxma-00045a-06
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 03:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116Ab0IMBYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 21:24:25 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51879 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832Ab0IMBYY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 21:24:24 -0400
Received: by iwn5 with SMTP id 5so4608943iwn.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 18:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=JIGQ47xJF3p2PYH96pzP/pPtwGwRpGyLDbAt1RrmCr0=;
        b=t/M3bXgIvAfQAX2geXCyfsK3/Fi9HbYZ1yehRXz6dHfeLawvpoTIQN8/DYhxch1Arw
         PAquTCG1Qy9bmklmajzfEdRHMgwx+pL3bgJWzOQMLEMpv6wdv6QgMCOwjk7NvNcSZAX7
         qrSAuo9bSPALBC/iLuP91h4XnEiJMDOofnGBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=ZUz0bAvl3LjRplO2EuHqgbB252NR+O+CdN5Yua53B2ENg+MKh3RgGstylcwte785o6
         lgEIpcB+lbSVcnihVrEil8W0phSPsPVvi1JWg8YdeEZXaAUjV+x+PNxVHnWZWp6nkxEc
         59WEYMVR/wKgAESNtKNVSMt+3Uq4LNwLqdIgM=
Received: by 10.231.170.21 with SMTP id b21mr5244445ibz.122.1284341062885;
 Sun, 12 Sep 2010 18:24:22 -0700 (PDT)
Received: by 10.231.121.82 with HTTP; Sun, 12 Sep 2010 18:24:22 -0700 (PDT)
X-Google-Sender-Auth: Vvkjun-evXEMxYZx3qGrEIdXFVc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156066>

Hi all --

I'm writing some automated tests that need a tiny git repo [1].  So I
have a shell script create the repo + working dir and tar it up, then
each test case untars the repo and does stuff inside it.  The working
dir deliberately has uncommitted changes and an untracked file.

Some of the test cases involve running "git diff --quiet", and I'm
getting inconsistent results.  Specifically, the first run after
untar'ing the repo+working dir incorrectly reports no changes (exit
status 0).  Subsequent runs correctly report changes (exit status 1).
Morever, if I run "git status" or regular non-quiet "git diff" first,
then "git diff --quiet" correctly reports changes.

Here's my shell script to create the tiny test repo:

"""
#!/bin/sh

# Output is git-repo.tar, which can be unpacked for each test -- that
# way tests can modify the repo and/or working dir without harming
# other tests.

set -ex
rm -rf git-repo
git init git-repo
cd git-repo

# two files tracked by git
echo a > a
echo b > b
git add -A
git commit -m"add a, b"

# uncommitted change to b
echo foo >> b

# some ignored files
echo "*.o" > .git/info/exclude
touch a.o

# an unknown file ("other" in git-speak)
touch junk

cd ..
tar -cf git-repo.tar git-repo
rm -rf git-repo
"""

If you run that in a temp dir, you'll get git-repo.tar.  To reproduce the bug:

  $  tar -xf git-repo.tar
  $ cd git-repo
  $ git diff --quiet && echo "no changes" || echo "changes"
  no changes                    # WRONG
  $ git diff --quiet && echo "no changes" || echo "changes"
  changes                         # CORRECT

Or at least, that's what I'm getting running git 1.7.2.3 on Arch Linux x86_64.

Do I totally misunderstand things, or is there a bug here?

Thanks --

Greg

[1] this is for my vcprompt project, which prints info about the
working dir for hg, git, svn, cvs, and bzr working dirs for use in
your shell prompt: see http://hg.gerg.ca/vcprompt/ .
