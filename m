From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: [long] worktree setup cases
Date: Wed, 20 Oct 2010 15:59:00 +0700
Message-ID: <20101020085859.GA13135@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: fbriere@fbriere.net, drizzd@aon.at, 575917@bugs.debian.org
To: Jonathan Niedier <jrnieder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 20 10:59:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8UW1-00032D-1Z
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 10:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211Ab0JTI7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 04:59:12 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59397 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab0JTI7L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 04:59:11 -0400
Received: by pva18 with SMTP id 18so653191pva.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 01:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:mime-version:content-type:content-disposition
         :user-agent;
        bh=zJwDc+fp9ouMq2TgD1VTOn+VrS56L0jiNA9yZH2cJGE=;
        b=dIuW0ZllDpNbDVME+xpAqz5DC3OTnDghzfKuIyiWuPlV6ohFYy0+SymjLiC4HI1C60
         NlGKQyMU2bm+/l8A4Tiphdy1/gCf2QNdAKEHkxN8i7USCHJwUx9HABNVS8i4+BiwEfui
         UjukSFl4DwHtcRzskEr1jQbHb5n56KqPqmG9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=PaiKpHyhAp852dV/tAkqvwPY84ukAhuD1c+oka5FDHBrAeeCrGYByVHyuxGxZEQMe1
         XSobjBh0ZDx/qFZn7LDjZCQJvW3n4QdL63KMpCH1cxvxL1638+FGgPylrsHf11OubpUV
         0ecMzs866F2D5McmjscyLTPAbbhDyBQhyUP3g=
Received: by 10.142.11.5 with SMTP id 5mr5580122wfk.312.1287565150281;
        Wed, 20 Oct 2010 01:59:10 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.198.15])
        by mx.google.com with ESMTPS id w42sm18133250wfh.15.2010.10.20.01.59.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 01:59:08 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 20 Oct 2010 15:59:00 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159402>

Hi,

I want to know how I expect setup code to work and whether it matches
my expectation. So I list every possible cases and try to sum up what
git does and what I expect. Hopefully all corner cases are covered
(and fixed later). It's not an easy read, but any comments are
appreciated. If all go well, this document should be turned into test
cases.

As a side note, Debian bug #575917 is case #17. I did not take into
account what setup_git_directory() does (which causes #575917)
though. Once the cleanup is done, setup_git_directory() should become
a one-liner around setup_git_directory_gently().

Assumptions:

1. When .git is a file and contains a relative path, I assume it is
   relative to .git file's parent directory.  read_gitfile_gently()
   function will make the path absolute, but it depends on (maybe
   wrong) cwd.

2. Relative path is preferred over absolute path.

3. core.worktree is overidden by GIT_WORK_TREE

There are a few factors that affect gitdir/worktree/cwd/prefix setup.
Those are:

 - GIT_DIR (or --git-dir)
 - GIT_WORK_TREE (or --work-tree)
 - core.worktree
 - .git is a file pointing to real .git directory
 - Bare repo

So there are 2^5 = 32 cases in total. Let's look at them one by
one. What describes here usually matches current code, except for
"should" phrases/sentences. Note that I did not look at the code
carefully so I might misunderstand things.

The following questions must be answered for each case:

0. What setup function handles that case?
1. Is worktree available?
2. Where is new cwd? Is it at worktree root?
3. Prefix?
4. Is (relative) $GIT_DIR accessible from current cwd?
5. What if original cwd is outside worktree, or new cwd if it's not at
   worktree root?

Table of Contents
=================
1 Cases
    1.1 Case 0, 8
    1.2 Case 1, 4, 5, 9, 12, 13
        1.2.1 cwd outside worktree
    1.3 Case 2, 10
    1.4 Case 3, 6, 7, 11, 14, 15
        1.4.1 cwd outside worktree
    1.5 Case 16, 24
    1.6 Case 17, 20, 21, 25, 28, 29
        1.6.1 cwd outside worktree
    1.7 Case 18, 26
    1.8 Case 19, 22, 23, 27, 30, 31


1 Cases
~~~~~~~~

Case#  Bare  .git-file  core.worktree  GIT_DIR  GIT_WORK_TREE
0      0     0          0              0        0
1      0     0          0              0        1
2      0     0          0              1        0
3      0     0          0              1        1
4      0     0          1              0        0
5      0     0          1              0        1
6      0     0          1              1        0
7      0     0          1              1        1
8      0     1          0              0        0
9      0     1          0              0        1
10     0     1          0              1        0
11     0     1          0              1        1
12     0     1          1              0        0
13     0     1          1              0        1
14     0     1          1              1        0
15     0     1          1              1        1
16     1     0          0              0        0
17     1     0          0              0        1
18     1     0          0              1        0
19     1     0          0              1        1
20     1     0          1              0        0
21     1     0          1              0        1
22     1     0          1              1        0
23     1     0          1              1        1
24     1     1          0              0        0
25     1     1          0              0        1
26     1     1          0              1        0
27     1     1          0              1        1
28     1     1          1              0        0
29     1     1          1              0        1
30     1     1          1              1        0
31     1     1          1              1        1

1.1 Case 0, 8
==============

The most used case, nothing special is set.

0. setup_discovered_git_dir()
1. work tree is .git dir's parent directory
2. cwd is at worktree root, i.e. .git dir's parent dir
3. prefix is calculated from original cwd
4. git_dir is set to ".git" (#0) or according to .git file, made
   absolute (#8)
5. N/A

TODO: turn git_dir to relative in #8

1.2 Case 1, 4, 5, 9, 12, 13
============================

0. setup_discovered_git_dir()
1. work tree is set according to GIT_WORK_TREE (#1, #5, #9, #13) or
   core.worktree (#4, #12)
2. cwd is at worktree root, i.e. .git dir's parent dir
3. prefix is calculated from original cwd
4. git_dir is set to ".git" (#1, #4, #5) or according to .git file,
   made absolute (#9, #12, #13)

TODO: turn git_dir to relative in #9, #12, #13

1.2.1 cwd outside worktree
---------------------------

FIXME

1.3 Case 2, 10
===============

0. setup_explicit_git_dir()
1. worktree is set at cwd for legacy reason
2. cwd is unchanged
3. prefix is NULL
4. git_dir is set according to GIT_DIR (#2) or according to .git file,
   made absolute (#10)

TODO: turn git_dir to relative path

Note on #10: setup_git_env() is used to read .git file

1.4 Case 3, 6, 7, 11, 14, 15
=============================

Another normal case where worktree is at an unsual case.

0. setup_explicit_git_dir()
1. worktree is set according to GIT_WORK_TREE (#3, #7, #11, #15) or
   core.worktree (#6, #14)
2. cwd is moved to worktree root dir if original cwd is inside
   worktree
3. prefix is calculated if original cwd is inside worktree
4. git_dir is set to GIT_DIR (#3, #6, #7) or according to .git file,
   made absolute (#11, #14, #15)

TODO: if GIT_DIR is relative, it is assumed relative to original cwd,
so it breaks because cwd now is changed. Right now this does not
happen because git_dir is turned absolute. Although it's better to be
relative.

TODO: turn git_dir to relative in #11, #14, #15

FIXME on #11, #14, #15: setup_git_env() is used to read .git file. cwd
by that time is worktree root, not .git's parent dir anymore.

1.4.1 cwd outside worktree
---------------------------

cwd is left unchanged, prefix is NULL, which is sensible for full tree
operations. is_inside_work_tree() returns 0, operations that require
worktree should check and error out.

TODO: File path output however may not be what user expected because
it will be relative to worktree root, not original cwd.

1.5 Case 16, 24
================

The most used case, nothing special is set.

0. setup_bare_git_dir()
1. no worktree
2. cwd is unchanged (actually it is moved back to original cwd)
3. prefix is NULL
4. git_dir is set in form "../../../" (or ".") (#16) or according to
   .git file, made absolute (#24)
5. N/A

TODO on #24: turn git_dir to relative

FIXME on #24: cwd is not at .git's parent dir, so relative git_dir
fails assumption #1.

1.6 Case 17, 20, 21, 25, 28, 29
================================

0. setup_bare_git_dir()
1. work tree is set according to GIT_WORK_TREE (#17, #21, #25, #29) or
   core.worktree (#20, #28)
2. cwd is unchanged (actually it is moved back to original
   cwd).
3. prefix is calculated from original cwd
4. git_dir is set in form "../../../" (or ".") (#17, #20, #21) or according to
   .git file, made absolute (#25 , #28, #29).

TODO: if core.bare = true, die()

FIXME: cwd should be moved to worktree's root instead. Similarly,
git_dir should be recalculated relative to worktree's root

TODO: turn git_dir to relative in #25, #28, #29 (or all if the above
FIXME turns everything to absolute)

Note on #25, #28, #9: pay attention to assumption #1 when the above
FIXME is done.

1.6.1 cwd outside worktree
---------------------------

FIXME

1.7 Case 18, 26
================

This is bare repo because of core.bare = true.

0. setup_explicit_git_dir()
1. no worktree
2. cwd is unchanged
3. prefix is NULL
4. git_dir is set according to GIT_DIR (#18) or according to .git file,
   made absolute (#126)

FIXME: in current code, I believe this is actually #2/#10 (worktree is
set). Should that be fixed??? "Legacy reason" hanging around so I'm
not sure.

TODO: turn git_dir to relative path

Note on #26: setup_git_env() is used to read .git file

1.8 Case 19, 22, 23, 27, 30, 31
================================

This is bare repo because of core.bare = true.

0. setup_explicit_git_dir()
1. worktree is set according to GIT_WORK_TREE (#19, #23, #27, #31) or
   core.worktree (#22, #30)
2. cwd is moved to worktree root dir if original cwd is inside
   worktree
3. prefix is calculated if original cwd is inside worktree
4. git_dir is set to GIT_DIR (#19, #22, #23) or according to .git file,
   made absolute (#27, #30, #31)
5. N/A

FIXME: just die() in check_repository_format_gently().
-- 
Duy
