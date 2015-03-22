From: Wincent Colaiuta <win@wincent.com>
Subject: status hangs trying to get submodule summary
Date: Sat, 21 Mar 2015 22:56:54 -0700
Message-ID: <CAPx-p4sKD0Nut3E1jnWfPPx4=--ZOxBgiVdt3RRb5tktw31qDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 06:57:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZYsw-0001ni-MR
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 06:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbbCVF5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 01:57:12 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35382 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbbCVF5M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 01:57:12 -0400
Received: by wgdm6 with SMTP id m6so120990946wgd.2
        for <git@vger.kernel.org>; Sat, 21 Mar 2015 22:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=/xXjcXli6vXEKJGwSgvmKLhyyuoeYq+J7qY6sjciTgM=;
        b=Zuqn9LOj3uG8Tm4bWcD94hGt24t+bpxXUqeYAUl5MH7bFXpiVSY+kVMtvMMbhoEIWQ
         u824tpStsmmnXbwRYry2NMjGhosy39ceaGEro8OD5TN03DSnY+12t7R8mj5dnwDmO77m
         U8jVL66DXPdEbw3B7uRURDpImaQZguOP9pfRHHTcqKGrI8l7wP2DOakF/mcpIdTjcmNu
         RAixL3eQ6Qx6KVzx2rSiejxwKvIaUxQ3dMspEGUT39Wx75XZf+DJoWvCcxIuSivxt4pp
         RBk1+u0hFTV1Xat3+JchA+h1tD/AcR+3lVf3gUraMVajK9VeGe2WSO6v+PADVdu60JdU
         qnXA==
X-Gm-Message-State: ALoCoQkfrpVA/P6gL0Vd75mDurDxbNsLzhQHJJP65apKRJU+h081vZx7u3SfSV9JQ1oXskVfF3n2
X-Received: by 10.180.7.194 with SMTP id l2mr9221132wia.39.1427003830450; Sat,
 21 Mar 2015 22:57:10 -0700 (PDT)
Received: by 10.194.86.131 with HTTP; Sat, 21 Mar 2015 22:56:54 -0700 (PDT)
X-Originating-IP: [24.130.114.144]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266052>

Hi,

I just ran into some odd behavior trying to update a submodule in one
of my projects where it would hang indefinitely trying to run either
`git status` or `git commit`.

Here's the minimal repro recipe:

mkdir demo
cd demo
git init
git submodule add git://github.com/ansible/ansible.git ansible
(cd ansible && git checkout v1.6.10)
git add ansible
git commit -m "initial commit"
(cd ansible && git checkout v1.8.4)
git config status.submodulesummary true
git status # hangs...
git commit # hangs...

At the time `git status` is hanging, these are the Git processes
running on the system:

12431 git status
12462 git submodule summary --files --for-status --summary-limit -1
12463 /bin/sh /usr/libexec/git-core/git-submodule summary --files
--for-status --summary-limit -1
12507 /bin/sh /usr/libexec/git-core/git-submodule summary --files
--for-status --summary-limit -1
12522 git log --pretty=format:  %m %s --first-parent
8959338284f6c6e44890b8911434285848f34859...ebc8d48d34296fe010096f044e2b7591df37a622

And `strace` shows the processes `wait4`-ing, except for the `git log`
one which is doing a `write` but apparently blocked:

# strace -p 12431
Process 12431 attached
wait4(12462, ^CProcess 12431 detached
 <detached ...>
# strace -p 12462
Process 12462 attached
wait4(12463, ^CProcess 12462 detached
 <detached ...>
# strace -p 12463
Process 12463 attached
wait4(-1, ^CProcess 12463 detached
 <detached ...>
# strace -p 12507
Process 12507 attached
wait4(-1, ^CProcess 12507 detached
 <detached ...>
# strace -p 12522
Process 12522 attached
write(1, "\n  > Merge pull request #7814 fr"..., 108^CProcess 12522 detached
 <detached ...>

This repros for me on Mac OS X 10.10.2 with Git 1.9.5 and Git 2.3.3,
and on the Amazon LInux (a RHEL-like OS) with Git 2.1.0. Both of these
with an empty .gitconfig (other than user.email, user.name and the
status.submodulesummary value already mentioned above).

I've never seen this hang before despite frequent use of submodules.
Oddly, I was able to work around the hang by moving the submodule in
two hops (one from Ansible v1.6.10 to v1.7.0, then from v1.7.0 to
v1.8.4). I am not sure if this is specific to the Ansible repo, or
whether the length of the summary is crossing some threshold that
triggers the bug to manifest. If I run the forked commands manually
from an interactive shell, they complete just fine.

-Greg
