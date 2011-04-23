From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 00/23] RFC: Introducing git-test, git-atomic, git-base and git-work
Date: Sat, 23 Apr 2011 17:22:29 +1000
Message-ID: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:24:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXCB-0004YJ-M8
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738Ab1DWHXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:23:42 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44129 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab1DWHXm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:23:42 -0400
Received: by pvg12 with SMTP id 12so585772pvg.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=kz6dStD8O0QxmwlXhqoONzW+Vuh9tT9TSynha+G2MpA=;
        b=AT/3aYSuiZ4wN1Cp/TDQNqy9kdybMVqhymuSt2nxUJyBYuR7rJ0Us8poNygDVugIDK
         r6H9IXqd5c0OOslqU9MSDO0tufEfPKjacnoAXgg7OTGa3BJ6ta1PGmjQxiEbexApq5bH
         Ifwi9F3UVUlKREjICG4qlc+fFA6eVyGasx/pw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JxaumY+zXdiVehRRaescHLG7qVEJmf1H0bVQCuj+12ab9j2lVUNf6MtzP/dG5/OKn0
         nrHRAwdQTyThKx0ScAL7FLWm45XrhUTIeKrmdiijYwl7p1RaH+uW59WQL0IEGGZktKbT
         MCIuJui77+ZAsN90oVnXERt0vtWgFEfQlmWSg=
Received: by 10.68.6.135 with SMTP id b7mr2302533pba.296.1303543421688;
        Sat, 23 Apr 2011 00:23:41 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.23.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:23:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171954>

This series is posted in order to solicit feedback about some commands I'd like to propose for inclusion in git. 

The commands are:
   git test
   git atomic
   git base
   git work

git work
========

git work depends on the other 3 commands. 

git work is the command I have been using every day myself for the last 8 months. It is the primary means
I use to manage my working tree.

The basic idea of git work is to help manage a private working tree using the following principles:

* all dependencies received from others are merged into the 'base' of the working tree

  git work merge some-dependency

     - merges some-dependency into $(git base) producing (1)
     - rebases $(git base)..HEAD onto (1) producing (2)
     - resets the current branch to (2)
     - updates $(git base) to refer to (1)

* all unpublished work is managed as a linear sequence of commits on top of the 'base' of the working tree

  so, 
   git work --as-refs # shows you a symbolic range for your current work
   git work # shows you a SHA1 range for your current work
   gitk $(git work) # shows you your unpublished work
   git diff $(git work) # shows you the diff of your current work

* prior to publishing work, you rebase it onto an appropriate base commit

  so,

  git branch topic upstream/master # choose the base commit for the topic
  git work update topic HEAD~3     # pull the top 3 commits off the working tree onto the topic

    - rebases HEAD~3..HEAD onto topic to produce (1)
    - merges topic into $(git base) to produce (2)
    - rebases $(git base)..HEAD~3 onto (2) to produce (3)
    - resets the current branch to (3)
    - resets $(git base) to (2)

The nice thing about managing your work tree this way is that your working tree remains
relatively stable (it always contains everything you have recently been working on)
and your topic branches remain clean (i.e. they never contain any other cruft from your 
working tree).

git base
========

git base is a command that is heavily relied on by git work, and is occasionally used by
the user to reset the base of their working tree.

git base tries to automagically maintain the base of the working tree by maintaining
an invariant that the path between the base and the tip of the current branch should
never traverse a merge. If it ever finds the invariant violated, it calls 'git base reset'
to attempt to restore the invariant. 

For more information about git base, refer to the Documentation/git-base.txt

git atomic
==========
git atomic is more an experiment than anything else. The idea is to run another git operation "atomically".
The git operation either succeeds or it fails. If it fails, git branch attempts to restore the
working tree and current branch to the state they were in to their original state prior to the comamnd being run.

The reason I need something like this is that git work performs several operations in sequence some
of which I can't guarantee will work. I don't want the user to work out what they have to do
to recover, so I try to restore to the state they were originally in.

Note: the current implementation doesn't handle rebase failures properly and would probably needed
to be cleaned up a little before being accepted into the mainline.

git test
========
This is another experiment. The idea is to provide a uniform way to test for various conditions
into the working tree, index and repo. For example:

    git test --not-unstaged --branch-exists foobar

will fail if there are unstaged files in the working tree or the branch foobar does not exist.

As I say, git atomic and git test are somewhat experimental. I don't really care about those commands
and if the consensus is that git doesn't need them, I am happy to rework git base and git work
to not use them.

However, I would like to propose git base and git work as being very useful additions to the git toolset.

Let me know if the consensus is that I should proceed with a submission and I will prepare one.

Jon Seymour (23):
  Introduce git-test.sh and git-test-lib.sh
  Introduce --unstaged.
  Introduce --staged
  Introduce --untracked.
  Introduce --conflicted
  Introduce --rebasing
  Introduce --detached
  Introduce --branch-exists
  Introduce --tag-exists
  Introduce --ref-exists
  Introduce --commit-exists.
  Introduce --checked-out
  Introduce --reachable
  Introduce --tree-same.
  Introduce --same
  misc
  whitespace fix.
  tests --conflicted.
  rebasing: add tests
  test: git test cleanups.
  Introduce git-atomic.
  Introduce git base.
  Introduce support for the git-work command.

 .gitignore                   |    7 +
 Documentation/config.txt     |   10 +
 Documentation/git-atomic.txt |   92 ++++++++
 Documentation/git-base.txt   |  216 ++++++++++++++++++
 Documentation/git-test.txt   |  182 +++++++++++++++
 Documentation/git-work.txt   |  163 ++++++++++++++
 Makefile                     |    7 +
 git-atomic-lib.sh            |   58 +++++
 git-atomic.sh                |    5 +
 git-base.sh                  |  378 +++++++++++++++++++++++++++++++
 git-conditions-lib.sh        |  176 +++++++++++++++
 git-test-lib.sh              |  188 ++++++++++++++++
 git-test.sh                  |   11 +
 git-work.sh                  |  323 +++++++++++++++++++++++++++
 t/t1520-test.sh              |  506 ++++++++++++++++++++++++++++++++++++++++++
 t/t3418-base.sh              |  214 ++++++++++++++++++
 t/t3419-atomic.sh            |   59 +++++
 t/t3421-work.sh              |  174 +++++++++++++++
 18 files changed, 2769 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-atomic.txt
 create mode 100644 Documentation/git-base.txt
 create mode 100644 Documentation/git-test.txt
 create mode 100644 Documentation/git-work.txt
 create mode 100644 git-atomic-lib.sh
 create mode 100755 git-atomic.sh
 create mode 100644 git-base.sh
 create mode 100644 git-conditions-lib.sh
 create mode 100644 git-test-lib.sh
 create mode 100755 git-test.sh
 create mode 100644 git-work.sh
 create mode 100755 t/t1520-test.sh
 create mode 100755 t/t3418-base.sh
 create mode 100755 t/t3419-atomic.sh
 create mode 100755 t/t3421-work.sh

-- 
1.7.5.rc1.23.g7f622
