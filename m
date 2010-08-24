From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFD PATCH 00/32] subtree clone v2
Date: Wed, 25 Aug 2010 08:19:50 +1000
Message-ID: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:20:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1rS-0000Ee-8G
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259Ab0HXWUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 18:20:45 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:41818 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932250Ab0HXWUf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:20:35 -0400
Received: by pxi10 with SMTP id 10so2812732pxi.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=e1ll5G4SsQSz/R6pqLYoLuaniIPMd/OuDjDj73plt34=;
        b=jOkCNM35FfvD/y+CUH3u89UldQAHk8aSATPjG/aa+2OCQFHg5/PxAofaKbPP6ELonL
         7TxireufT4Cc0Xh/CAf7XlsUq1zO/MML/gOBUJUDzHANafvoUqWJvxn44MP78HZGz9UZ
         RotCof6Q1l9cH37OpBc2K0jJLMewJxgH8BB/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=RfRS5xsm6+szzPFpyLieo3GGvzfZAqDrJt50eIq4b/3lXYq7e5loGjLYMG0rCVvHGl
         hWXcAvxiEoKmfG24sqJfhqGxDOHbJcQokZgauHZzWoPxGrSpHILUdEBY0MljBW8naGUZ
         ed+m/OxtqC/NICrwsYTRr6nSQGokQ0vi+4L14=
Received: by 10.114.89.15 with SMTP id m15mr8469613wab.106.1282688435110;
        Tue, 24 Aug 2010 15:20:35 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id d39sm946584wam.4.2010.08.24.15.20.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:20:29 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:20:24 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154343>

This is a follow-up from the subtree clone proof of concept [1] I
posted a few weeks ago. I think it's getting closer to an acceptable
design. Hence the purpose of this post: to ask for opinions about the
design issues I'm facing.

The good news is that tree rewrite/replace has gone. The repo now is
perfectly "normal". Git client has to be modified to live peacefully
within a narrow tree. How much modification is still a question ahead.

Other things from the previous series are pretty much unchanged:
single narrow tree, only send necessary trees, can be used together
with shallow clone, can't be fetch source.

A new thing is the index is now narrowed down, because I don't have
all trees to fully populate it, and tree rewrite mechanism is now
gone. One item for RFD.

Another major thing (you guys are going to hate me) is merge could not
always be done locally. So I introduce "trivial 3-way remote
merge". RFD material (any other aproaches?). More details in commit
messages.

Is there any other full-tree operations, like merge, that I should pay
attention to? What commands can be troublesome?

Last note, please don't look too closely. The code is full of bugs :-)


Patches 1..7
  add const to ce_write()
  cache-tree: abstract out write_sha1_file from cache_tree_update()
  cache-tree: ignore CE_REMOVE entries in verify_cache()
  move do_compress() from pack-objects.c to pack-write.c
  pack-write: add functions for creating simple packs
  tree.c: Add {set,clear}_tree_marks
  tree.c: find_subtree() to search for a tree

Helper patches. You can skip these if you are only interested in the
narrow ideas.


Patches 8..14
  Add $GIT_DIR/narrow check
  index: make narrow index incompatible with older git
  rev-list: support traversing in narrow repository mode
  rev-list: support --narrow-tree
  pack-objects: support --narrow-tree
  upload-pack: support narrow-tree capability
  fetch-pack: support --narrow-tree

Narrow clone. traverse_commit_list() does not change much since the
last series.


Patches 15..19
  unpack_trees: only unpack $GIT_DIR/narrow subtree in narrow
    repository
  cache-tree: only cache tree within narrow area
  tree-diff: add narrow versions of diff_{root_,}tree_sha1
  log-tree: use narrow version of diff_tree_sha1
  clone: support --narrow option

Client support so that you can check files out, diff them... This is WIP.
Basically if you stay inside narrow tree, you'd be safe :-) Elijah may
want to reuse some of these code in his sparse clone, if he can extend
it to support multiple narrow trees, I think.


Patches 20..25
  narrow-tree: add join_narrow_tree to do tree fixup for commits
  commit: add narrow's commit_tree version
  commit: use commit_narrow_tree() to support narrow repo
  commit-tree: require --narrow-base in narrow repo
  merge: refuse to merge if narrow bases are different
  merge: prepare commit properly in narrow mode

Commit part, how to use narrow index and make proper commits. This is
where merge issue arises. Because a merge can have many parents, which
parent can be used as a base to create new commits?


Patches 26..30
  Add upload-narrow-base command
  rev-list: traverse some more trees to make upload-narrow-base happy
  narrow-tree: add oldest_narrow_base()
  Add command fetch-narrow-base
  merge: support merging when narrow bases are different

Remote merge part.

Split a merge operation into two parts, the real merge will be done
within narrow tree. Conflicts can happen and be resolved in the narrow
index, locally.

Everything outside narrow tree will be merged (trivially) by
server. Then server sends the base tree back, so join_narrow_tree() in
patch 20 can be used to create proper commit.

Server can disable this remote merge feature, which means users are
forced to do rebase/fast-forward. Not too bad.


Patches 31..32
  send-pack: do not use thin pack in narrow mode
  daemon: support upload-narrow-base

Misc stuff..

[1] http://mid.gmane.org/1280593105-22015-1-git-send-email-pclouds@gmail.com

 Makefile                     |    4 +
 builtin.h                    |    2 +
 builtin/clone.c              |   15 +++-
 builtin/commit-tree.c        |   20 ++++-
 builtin/commit.c             |   10 ++-
 builtin/fetch-narrow-base.c  |   89 +++++++++++++++++
 builtin/fetch-pack.c         |   11 ++
 builtin/merge.c              |   45 +++++++++-
 builtin/pack-objects.c       |   33 +++----
 builtin/send-pack.c          |    4 +
 builtin/upload-narrow-base.c |  215 ++++++++++++++++++++++++++++++++++++++++++
 cache-tree.c                 |   37 ++++++--
 cache-tree.h                 |    3 +
 cache.h                      |    4 +
 commit.c                     |   21 ++++
 commit.h                     |    5 +
 daemon.c                     |    7 ++
 diff.h                       |    5 +
 environment.c                |    2 +
 git.c                        |    2 +
 list-objects.c               |   91 +++++++++++++++++-
 log-tree.c                   |   23 ++++-
 narrow-tree.c                |  200 +++++++++++++++++++++++++++++++++++++++
 narrow-tree.h                |    9 ++
 pack-write.c                 |  112 ++++++++++++++++++++++
 pack.h                       |   18 ++++
 read-cache.c                 |   37 ++++++-
 revision.c                   |    5 +
 revision.h                   |    4 +-
 t/t1013-read-tree-narrow.sh  |   72 ++++++++++++++
 t/t6060-narrow-tree.sh       |   28 ++++++
 t/t6061-rev-list-narrow.sh   |  185 ++++++++++++++++++++++++++++++++++++
 tree-diff.c                  |   74 ++++++++++++++
 tree.c                       |   79 +++++++++++++++
 tree.h                       |    4 +
 unpack-trees.c               |   70 ++++++++++++++-
 upload-pack.c                |   31 ++++++-
 37 files changed, 1528 insertions(+), 48 deletions(-)
 create mode 100644 builtin/fetch-narrow-base.c
 create mode 100644 builtin/upload-narrow-base.c
 create mode 100644 narrow-tree.c
 create mode 100644 narrow-tree.h
 create mode 100755 t/t1013-read-tree-narrow.sh
 create mode 100755 t/t6060-narrow-tree.sh
 create mode 100755 t/t6061-rev-list-narrow.sh
