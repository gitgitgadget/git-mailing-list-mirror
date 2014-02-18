From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 00/25] Support multiple checkouts
Date: Tue, 18 Feb 2014 20:39:49 +0700
Message-ID: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:40:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkuL-0005iF-2J
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580AbaBRNkO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:40:14 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46685 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755332AbaBRNkK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:40:10 -0500
Received: by mail-pa0-f46.google.com with SMTP id rd3so16811108pab.33
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=6txd2RXwihgGFPtJQIyyF/hh8RQy4zzmkNLbhwdJSvI=;
        b=t6XiIywKjF/2JDadgNJPfbYYjQeyVwpBaGAUP0TriGXGmDsmzJdICsZdTptkBsLt4S
         3Qp38sMSJFSzIXr2jrBOe113y8N+UICXu4ad6CRmO5T9zqH7Qdskt3s8gHILtLwR2Lln
         bo6Asqu8Xv+b4FcXWrJQv7AO2OQ9bmUFVg3iZfE/+JjlNjlJAaAWqyDntu7tvKXgK0d5
         jwMTmn2E2A+nfJvp3jeptt0tdTmhgfewQDeZhArK5qYJIr7mePKmBzXO/Ewop5mEszo1
         P0GG5VCUXZu/Kq2ldFe5y4R7OtjjBUX87Oca5v3whEBjKUH0KXtrQirbqd6x7vmk9XUK
         3tnQ==
X-Received: by 10.67.22.100 with SMTP id hr4mr32827214pad.112.1392730810069;
        Tue, 18 Feb 2014 05:40:10 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id vx10sm142614968pac.17.2014.02.18.05.40.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:40:09 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:40:23 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242300>

In short you can attach multiple worktrees to the same git repository
with "git checkout --to <somewhere>". This is basically what
git-new-workdir is for. Previous discussion here

http://thread.gmane.org/gmane.comp.version-control.git/239194/focus=3D2=
39581

Compared to last time:

- .git file format remains unchanged. It was a stupid idea to tie
  $GIT_COMMON_DIR pointer to .git file because you will have to pass
  that info another way if you don't go through .git file. Now it's
  stored in $GIT_DIR/commondir

- Last time, checking out an already checked out branch will detach
  the previous checkout. Junio wanted to error out for less user
  confusion. I go with a (good, imo) compromise in this reroll: the
  new checkout detaches itself in this case, hinting where the branch
  is truly checked out so the user can go there and do things

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (25):
  path.c: make get_pathname() return strbuf instead of static buffer
  Convert git_snpath() to strbuf_git_path()
  path.c: rename vsnpath() to do_git_path()
  path.c: group git_path(), git_pathdup() and strbuf_git_path() togethe=
r
  Make git_path() aware of file relocation in $GIT_DIR
  *.sh: respect $GIT_INDEX_FILE
  reflog: avoid constructing .lock path with git_path
  fast-import: use git_path() for accessing .git dir instead of get_git=
_dir()
  commit: use SEQ_DIR instead of hardcoding "sequencer"
  Add new environment variable $GIT_COMMON_DIR
  git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
  *.sh: avoid hardcoding $GIT_DIR/hooks/...
  git-stash: avoid hardcoding $GIT_DIR/logs/....
  setup.c: convert is_git_directory() to use strbuf
  setup.c: detect $GIT_COMMON_DIR in is_git_directory()
  setup.c: convert check_repository_format_gently to use strbuf
  setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
  setup.c: support multi-checkout repo setup
  wrapper.c: wrapper to open a file, fprintf then close
  use new wrapper write_file() for simple file writing
  checkout: support checking out into a new working directory
  checkout: clean up half-prepared directories in --to mode
  checkout: detach if the branch is already checked out elsewhere
  prune: strategies for linked checkouts
  gc: support prune --repos

 Documentation/config.txt               |   9 +-
 Documentation/git-checkout.txt         |  34 +++++
 Documentation/git-prune.txt            |   3 +
 Documentation/git-rev-parse.txt        |   8 +
 Documentation/git.txt                  |   8 +
 Documentation/gitrepository-layout.txt |  26 ++++
 builtin/branch.c                       |   4 +-
 builtin/checkout.c                     | 272 +++++++++++++++++++++++++=
++++++--
 builtin/commit.c                       |   2 +-
 builtin/gc.c                           |  17 +++
 builtin/init-db.c                      |   7 +-
 builtin/prune.c                        |  75 +++++++++
 builtin/reflog.c                       |   2 +-
 builtin/rev-parse.c                    |  11 ++
 cache.h                                |  10 +-
 daemon.c                               |  11 +-
 environment.c                          |  24 ++-
 fast-import.c                          |   5 +-
 git-am.sh                              |  22 +--
 git-pull.sh                            |   2 +-
 git-rebase--interactive.sh             |   6 +-
 git-rebase--merge.sh                   |   6 +-
 git-rebase.sh                          |   4 +-
 git-sh-setup.sh                        |   2 +-
 git-stash.sh                           |   6 +-
 path.c                                 | 201 +++++++++++++++---------
 refs.c                                 |  66 +++++---
 refs.h                                 |   2 +-
 setup.c                                | 117 ++++++++++----
 strbuf.c                               |   8 +
 strbuf.h                               |   5 +
 submodule.c                            |   9 +-
 t/t0060-path-utils.sh                  |  34 +++++
 t/t1501-worktree.sh                    |  76 +++++++++
 t/t1510-repo-setup.sh                  |   1 +
 t/t2025-checkout-to.sh (new +x)        |  48 ++++++
 templates/hooks--applypatch-msg.sample |   4 +-
 templates/hooks--pre-applypatch.sample |   4 +-
 trace.c                                |   1 +
 transport.c                            |   8 +-
 wrapper.c                              |  31 ++++
 41 files changed, 976 insertions(+), 215 deletions(-)
 create mode 100755 t/t2025-checkout-to.sh

--=20
1.8.5.2.240.g8478abd
