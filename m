From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH 0/9] new git check-ignore sub-command
Date: Sun,  2 Sep 2012 01:12:02 +0100
Message-ID: <1346544731-938-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 02:20:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7xvD-0001VH-2E
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 02:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038Ab2IBATy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 20:19:54 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:55517 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418Ab2IBAS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 20:18:56 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id E5C1B2E5DE;
	Sun,  2 Sep 2012 01:12:11 +0100 (BST)
X-Mailer: git-send-email 1.7.12.155.ge5750d5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204661>

I was browsing stackoverflow the other day and came across this question:

    http://stackoverflow.com/questions/12144633/which-gitignore-rule-is-ignoring-my-file/

A quick google revealed this thread from 2009:

    http://thread.gmane.org/gmane.comp.version-control.git/108671/focus=108815

where Junio and Jeff discussed the possibility of adding a new `git
check-ignore' subcommand somewhat analogous to the existing `git
check-attr', and suggested the beginnings of an implementation.  It
struck me that it might not be too hard to follow these ideas to their
natural conclusion, so I decided it would make a fun project :-)

The following series of patches is the outcome.  I am completely new
to git hacking, so whilst I have tried very hard to follow all the
conventions and documented guidelines, please go easy on me if there
are any glaring errors ;-)  However, the added test suite should cover
the new code paths thoroughly, and I also ran check-ignore through
valgrind and made some improvements accordingly, so hopefully it's
pretty near the mark.

I have a question and some comments about my current patch series.

Firstly, I re-used pathspec-handling code from builtin/add.c, so I
moved it to a new pathspec.c file.  It looks like setup.c might have
been a better candidate, but that library is already a fairly large
collection of apparently loosely associated things, so I wasn't sure.
According to the comments, get_pathspec() is due to be superceded by
the "struct pathspec" interface, so perhaps it would make sense to
split setup.c up into pathspec.c and one or two other files so as to
move towards a clean demarcation of this new API?

Secondly, in the course of trying to understand the code base, my
little brain got confused and I noticed a few areas where I thought
there was potential to make things a bit clearer.  So some of my
commits are janitorial in nature.

Thirdly, currently the new sub-command hardly looks at the cache.
This is partially because it doesn't need to in the most common use
case (i.e. user is confused about why files are/aren't being ignored).
It's also because this whole project took a lot longer than I
expected, so I'm running out of time :-) Perhaps someone can add this
in the future if it's needed.  Right now the cache is only used to
prevent recursing into submodules.

Thanks,
Adam

Adam Spiers (9):
  Update directory listing API doc to match code
  Improve documentation and comments regarding directory traversal API
  Rename cryptic 'which' variable to more consistent name
  Refactor excluded_from_list
  Refactor excluded and path_excluded
  For each exclude pattern, store information about where it came from
  Extract some useful pathspec handling code from builtin/add.c into a
    library
  Provide free_directory() for reclaiming dir_struct memory
  Add git-check-ignores

 .gitignore                                        |   1 +
 Documentation/git-check-ignore.txt                |  58 +++++
 Documentation/gitignore.txt                       |   6 +-
 Documentation/technical/api-directory-listing.txt |  23 +-
 Makefile                                          |   3 +
 builtin.h                                         |   1 +
 builtin/add.c                                     |  84 +-----
 builtin/check-ignore.c                            | 150 +++++++++++
 builtin/clean.c                                   |   2 +-
 builtin/ls-files.c                                |   3 +-
 command-list.txt                                  |   1 +
 contrib/completion/git-completion.bash            |   1 +
 dir.c                                             | 183 ++++++++++---
 dir.h                                             |  37 ++-
 git.c                                             |   1 +
 pathspec.c                                        |  87 +++++++
 pathspec.h                                        |   6 +
 t/t0007-ignores.sh                                | 301 ++++++++++++++++++++++
 18 files changed, 811 insertions(+), 137 deletions(-)
 create mode 100644 Documentation/git-check-ignore.txt
 create mode 100644 builtin/check-ignore.c
 create mode 100644 pathspec.c
 create mode 100644 pathspec.h
 create mode 100755 t/t0007-ignores.sh

-- 
1.7.12.155.ge5750d5.dirty
