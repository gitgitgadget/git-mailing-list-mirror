From: Geoffrey Irving <irving@naml.us>
Subject: bug with .git file and aliases
Date: Mon, 20 Jul 2009 09:54:12 -0400
Message-ID: <7f9d599f0907200654q2e068e6aq3051c122f6596053@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 15:54:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MStKH-0005vM-8I
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 15:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729AbZGTNye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 09:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753708AbZGTNye
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 09:54:34 -0400
Received: from mail-vw0-f202.google.com ([209.85.212.202]:61133 "EHLO
	mail-vw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbZGTNyd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 09:54:33 -0400
Received: by vwj40 with SMTP id 40so118546vwj.33
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=suo2B+vDWqVYjwg52fnMlm6oxQgnYpsEJokIViQajAY=;
        b=hNGnNVAOKZsUucIiLspWARgSXpmuxb/eqsCylf5L41GnqHWoyxb0dULJM3vjUD54An
         2HFyVvClrbOwO0mEpG3ZwQRc3VW27WqXZKiAptn4Nrdnt8vdW9O4effULmLTSEZaM94a
         lLb6nK8tWphCjYnNbEdDSAVueA5R+x2gWlENc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        b=JZCcJ6hxeJSdFhsqxKZxgnUUwFhQLtIPaNRQ2v3DWretQ0DBsdPAs5Knc4B4xDlZLs
         XZWkX+UsToUXQYE+cqzb2NvDzxN/779OVcWe5GMzFHpHs2DvKspvc5kVmzeb4QS24Gm7
         mPx0gFv+OqaVbtVYlbXKqc+Nh1g2nwmszo5wU=
Received: by 10.220.76.1 with SMTP id a1mr5885629vck.80.1248098072168; Mon, 20 
	Jul 2009 06:54:32 -0700 (PDT)
X-Google-Sender-Auth: 28660f0ed9a817cf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123601>

git 1.6.3.3 has a bug related to .git file support and aliases.
Specifically, if you make an alias for status and call it from a
subdirectory, git status chdirs into the true .git dir but then
chdir's back to the wrong place in order to run the lstats for status.
 The result is that git status thinks all files have disappeared.

Here's a self-contained test script:

    #!/bin/bash
    set -x

    # make a simple repository
    mkdir repo
    cd repo
    git init
    mkdir a
    echo content > a/b
    git add a/b
    git commit -m "a commit"

    # replace the gitdir with a gitfile
    mv .git ../repo.git
    echo gitdir: `pwd`.git > .git

    # normal git status works
    cd a
    git status

    # an alias for git status fails
    git config alias.st status
    git st

which produces output

top:tmp% ./bug
++ mkdir repo
++ cd repo
++ git init
Initialized empty Git repository in /Users/irving/tmp/tmp/repo/.git/
++ mkdir a
++ echo content
++ git add a/b
++ git commit -m 'a commit'
[master (root-commit) 6b07ec4] a commit
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 a/b
++ mv .git ../repo.git
+++ pwd
++ echo gitdir: /Users/irving/tmp/tmp/repo.git
++ cd a
++ git status
# On branch master
nothing to commit (working directory clean)
++ git config alias.st status
++ git st
# On branch master
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	deleted:    a/b
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	b
no changes added to commit (use "git add" and/or "git commit -a")

.git file support also doesn't work on a repository with no commits
(which is why the test script makes a commit normally before switching
to a gitfile).  However, I care about this second problem much less,
and didn't notice it until I made the test script.

Finally, huge thanks to Lars for implementing this.  I'm storing git
working directories inside vesta, and symlink support is currently
disabled.  It's very pleasant to grep through the source and find that
someone already fixed exactly my problem. :)

Geoffrey
