From: Artur Skawina <art.08.09@gmail.com>
Subject: git failing to create new branches, depending on the name
Date: Sat, 08 Aug 2009 17:32:55 +0200
Message-ID: <4A7D9AA7.1030709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 17:33:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZnuw-0007Mv-Rs
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 17:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbZHHPdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 11:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbZHHPdB
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 11:33:01 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:62988 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbZHHPdA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 11:33:00 -0400
Received: by fxm28 with SMTP id 28so265103fxm.17
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 08:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=4jJzmKtNN0JPFpOedvIK3qGrsOgu3QVXALkV7RVjx44=;
        b=mpMTq5oyw3zwnfPuFTuzbGxkib69PBHw7FNw5s4w6hvKmmqV5HS62S+mF56efQCi5B
         g5iojWYSQUbftWlk5zXMa9IzJfMQJTduVIcsD88f9BGWFBZBbM4FKE/7tNQlGWAmzLqI
         ZNP2WkiLzcCsg+9mNcs+035zDJ1oeL/BPUsl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=Nh4lJwB+lyknmxKuWXVFuYop6KuVkjx4n9u/RaJMUAg63CHLOz7BxZlTDSqCFkL+CK
         tNATdcrNIDIyPA+PIXbrtP4MgT0HJYYg5hTEm/kRaWDsIFxyyqB3nzCQ5ibX7eKQRx2p
         YwbVluMRoEi+FRERfa0CknjWE6GnaYr1D6jlQ=
Received: by 10.204.69.66 with SMTP id y2mr2763867bki.40.1249745578522;
        Sat, 08 Aug 2009 08:32:58 -0700 (PDT)
Received: from ?172.19.43.221? (ip-94-42-1-199.multimo.pl [94.42.1.199])
        by mx.google.com with ESMTPS id 13sm4220677fks.22.2009.08.08.08.32.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Aug 2009 08:32:58 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125282>

One of my build scripts, which takes a 'work' git tree, clones it to
make a build tree, then creates an unique branch there and goes on
to do the rest of the work, started mysteriously failing recently
.
Turns out git doesn't like the branch names that my script is
choosing and git-checkout fails with a misleading fatal error.
I don't remember changing the script recently and it used to work
for months, something must have changed.

This is what i did while trying to find why the checkout is failing:

+ git --version
git version 1.6.4
+ rm -rf /tmp/build-tree
+ git clone -l -s -n -o askern --reference /tmp/work-tree /tmp/work-tree /tmp/build-tree
Initialized empty Git repository in /tmp/build-tree/.git/
+ cd /tmp/build-tree
+ git branch -a | grep g90bc1a6 
+ git checkout -f -b branch-g90bc1a6 askern/release
fatal: git checkout: branch branch-g90bc1a6 already exists
# WTF?
+ (
+  cd /tmp/work-tree
+  git branch -a | grep g90bc1a6
+ )
# nothing in parent repo either.
+ git checkout -f branch-g90bc1a6 
Checking out files: 100% (29109/29109), done.
Note: moving to 'branch-g90bc1a6' which isn't a local branch
If you want to create a new branch from this checkout, you may do so
(now or later) by using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>
HEAD is now at 90bc1a6... Merge branch 'upstream' of git://ftp.linux-mips.org/pub/scm/upstream-linus
# so where is coming from?
+ git branch -a | grep g90bc1a6
+ git status
# Not currently on any branch.
nothing to commit (working directory clean)
+  git show --pretty=short 90bc1a6 | cat
commit 90bc1a658a53f8832ee799685703977a450e5af9
Merge: 6ce90c4 54822de
Author: Linus Torvalds <torvalds@linux-foundation.org>

    Merge branch 'upstream' of git://ftp.linux-mips.org/pub/scm/upstream-linus
# Aha

So what appears to be happening is that the script picks up the
90bc1a6 suffix (it gets it from git-describe), uses it as part
of the branch name and then git misinterprets it.
(the actual names used by the script are much longer, i used
"branch-g90bc1a6" only to figure what was going on)

artur
