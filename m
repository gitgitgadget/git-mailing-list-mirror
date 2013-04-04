From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Fri,  5 Apr 2013 00:00:36 +0530
Message-ID: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:29:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNous-0007J4-BH
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764506Ab3DDS3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:29:13 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:65284 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764228Ab3DDS3M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:29:12 -0400
Received: by mail-pd0-f169.google.com with SMTP id 10so1590009pdc.28
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 11:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=ZDi7lUDiVW/isi6WQxNRZMyLbZ2x7zdGq4oDhU5210Y=;
        b=Mf2mLtqdbqxjPn2ktwBUcoJPXdH6QXG6jtsv8UZvjjd5XXgACUO+PD2Dk5p0AWDnuD
         lyaTEGO3SBtG2XehXSYTlEojUoNDQtfhWoq4iOQzdbGwLOZuk77nZSiM+vrhjp1crZxq
         CxgF+unOTpKHBf80kljGnheHUSy79nWYhPWIeomJ3f+GTg7UAotF7x1lkpOu2vU2UHFE
         Bp5RKY6Dy0OSgUwrjAVyUpnFcirxcUiYgJCQshfYWtp+lvy937wk3oCnBRMPFMu9C5r2
         2lgMC98XHPCT4+DUWMTqyQw+jZ11oTGkKzFQh86kYFNrOfIl1KefNkbMiC8V0KZv6Doq
         J2dw==
X-Received: by 10.66.172.36 with SMTP id az4mr10870697pac.103.1365100152039;
        Thu, 04 Apr 2013 11:29:12 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.36])
        by mx.google.com with ESMTPS id xl10sm12418525pac.15.2013.04.04.11.29.08
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 11:29:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.380.g0d4e79b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220047>

Hi,

The purpose of this series is to convince you that we've made a lot of
fundamental mistakes while designing submodules, and that we should
fix them now.  [1/7] argues for a new object type, and this is the
core of the idea.

It's an entire beautiful design + UI/UX package.  To demo it now:

    # Switch your git to https://github.com/artagnon/git/tree/link

    $ git config --global url."git://github.com/".insteadOf gh:
    $ git config --global clone.submodulegitdir /home/<user>/bare
    $ cd /tmp
    $ git clone gh:artagnon/varlog
    $ cd varlog
    $ git clone gh:artagnon/clayoven
    # Notice how it puts clayoven.git in ~/bare
    $ git add clayoven
    # Just works!
    $ git commit -a -m "add subproject clayoven"
    $ git ls-tree HEAD
    # Try to cat-file or show the link object
    $ cd clayoven/lib
    $ git clone gh:artagnon/sandbox
    $ git add sandbox
    # Again, just works!  No cd-to-toplevel nonsense
    $ git ci -a -m "add subproject sandbox"
    $ cd ../..
    $ git rm clayoven
    $ git ci -a -m "remove subproject clayoven"
    # start hacking: read the rest of this email
    # note that git diff is broken

>From a design perspective, the goal is to make possible various kinds
of compositions, essentially replacing repo, mr, gitslave,
git-subtree, (the old) git-submodule, and other similar tools.  All
submdodules are not equal: each one will have tweakable parameters
that will change how git-core treats them.

>From the UI/UX perspective, the goal is to get existing git commands
to work seamlessly with submodules without introducing any
submodule-specific commands (or atleast keeping it to a minimum).  The
deprecation path for git-submodule is clear: first, we have to strip
it down to be a very thin wrapper around existing git commands, and
then announce that it's no longer necessary.

This series is two days of unedited unrebased work ([5/7] is dead code
for instance).  I've written in a big hurry, and it's meant to be a
proof-of-concept only.  I discovered lots of core bugs along the way
that need to be fixed first.  Off the top of my head:

1. 'git add' should not go past submodule boundaries.  I should not be
   able to 'git add clayoven/' or 'git add clayoven/LICENSE'.  In
   addition, the shell completion also needs to be fixed.

2. An empty directory containing a .git file is a perfectly valid
   worktree, but does not show up in the superproject's 'git status'
   output.  How can it be treated like an empty directory?

3. sha1_file.c:index_path() should not return paths with trailing
   slashes, I think.

4. There really must be a better way to figure out if I'm in a
   worktree than setup_git_directory_gently().

Also, I'm going to need your help to finish this.  I was trying to
write the 8th patch when I got stuck.  I'm guessing I need to
understand how wt-status extracts the differences between two trees,
and filter it for added/removed link objects.  Then, I have to follow
the example of updating the HEAD ref to update my
refs/modules/<branch>/* refs.

If you think this is all a big waste of time, and that we should focus
on improving git-submodule.sh, you're probably deranged.  Because it's
_very_ clear to me.

Thank you for reading.

Ramkumar Ramachandra (7):
  link.c, link.h: introduce fifth object type
  sha1_file, link: write link objects to the database
  teach ce_compare_gitlink() about OBJ_LINK
  builtin/log: teach show about OBJ_LINK
  edit-link: add new builtin
  clone: introduce clone.submodulegitdir
  sha1_file: write ref_name to link object

 Makefile          |  2 ++
 alloc.c           |  3 ++
 builtin/clone.c   | 29 +++++++++++++++++++
 builtin/log.c     | 17 +++++++++++
 builtin/ls-tree.c |  4 +--
 cache.h           |  3 +-
 environment.c     | 11 -------
 git-edit-link.sh  | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 link.c            | 49 +++++++++++++++++++++++++++++++
 link.h            | 26 +++++++++++++++++
 object.c          |  9 ++++++
 read-cache.c      | 33 ++++++++++++++-------
 sha1_file.c       | 48 +++++++++++++++++++++++++++++-
 13 files changed, 296 insertions(+), 25 deletions(-)
 create mode 100644 git-edit-link.sh
 create mode 100644 link.c
 create mode 100644 link.h

-- 
1.8.2.380.g0d4e79b
