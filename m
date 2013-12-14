From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/21] Support multiple worktrees
Date: Sat, 14 Dec 2013 17:54:46 +0700
Message-ID: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 11:51:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrmom-0000oL-Ha
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab3LNKvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:51:11 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44743 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981Ab3LNKvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:51:09 -0500
Received: by mail-pa0-f46.google.com with SMTP id kl14so1052160pab.19
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pn9PZthFqtjWpUOWpZTkDngikplBtFibh5K7tFdhG3s=;
        b=o+isFr8wSpStUvJz+BsRC7mwMO4WCZ5gDZ1Pc7aPb7NJpUYG9D8nZVLNF40K0smIe/
         sX61U2tZQLfDJ5P2N8SDNUCvIziPySrpcASN8uHgNQMFA63iWQtv+1nvR0HWzhC8vnDw
         9UY0AXjJ/8+bwxCVpQ5cAQXqYumE21HoDf8fWogw6Lf07gyuRfT4Dli04InWpch5tA61
         iZfWN/bu2/E6C3ouyRiDa4P7Pj8VszMquWCNgGnou8HUQfYMp0dFMkGAWa5SaCQsaxvy
         03a8FffzqlYdV/lLlEAqiIb3GgWT+6saupSkppcPoC3YA7qFcjEN5TjOKsTT/Uf+TElG
         50sQ==
X-Received: by 10.68.236.133 with SMTP id uu5mr8620757pbc.153.1387018268796;
        Sat, 14 Dec 2013 02:51:08 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id de1sm11432903pbc.7.2013.12.14.02.51.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:51:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:56:01 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239282>

The UI and behavior are taking shape now. On the UI side, you do

  git checkout --to /somewhere -b newbranch origin/master

which will create worktree-only repo at /somewhere. "git prune --repos"
could be used to remove cruft in .git/repos.

On the behavior side, you should be able to do everything in
/somewhere just like in a normal repository. If a ref is updated (from
any repository) that also happens to be your HEAD, it will be
detached. "git rev-list --all" is also taught to take repos/.../HEAD
into account.

The structure of repos/XXX is documented in 17/21. Known issues

 - naming ($GIT_SUPER_DIR, the name of the shared repo and the
   dependent one, the reuse of "gitdir" in .git files)

 - gc --auto support, support for manually pruning .git/repos

 - should probably support the new .git format in enter_repo() so that
   we can push to it

 - not sure if we need UI for deleting repositories created with
   checkout --to, or just "rm -r" and let "gc --auto" clean
   things up. The thing about "rm -r(f)" is that if .git happens to be
   a real repo, the user is screwed so I don't really like to
   encourage doing it.

 - more tests


Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (21):
  path.c: avoid PATH_MAX as buffer size from get_pathname()
  path.c: rename vsnpath() to git_vsnpath()
  path.c: move git_path() closer to similar functions git_pathdup()
  Make git_path() aware of file relocation in $GIT_DIR
  reflog: use avoid constructing .lock path with git_path
  fast-import: use git_path() for accessing .git dir instead of get_git=
_dir()
  Add new environment variable $GIT_SUPER_DIR
  setup.c: refactor path manipulation out of read_gitfile()
  setup.c: add split-repo support to .git files
  setup.c: add split-repo support to is_git_directory()
  setup.c: reduce cleanup sites in setup_explicit_git_dir()
  environment.c: support super .git file specified by $GIT_DIR
  setup: support $GIT_SUPER_DIR as well as super .git files
  checkout: support checking out into a new working directory
  checkout: clean up half-prepared directories in --to mode
  setup.c: keep track of the .git file location if read
  prune: strategies for split repositories
  refs: adjust reflog path for repos/<id>/HEAD
  refs: detach split repos' HEAD when the linked ref is updated/deleted
  refs.c: refactor do_head_ref(... to do_one_ref("HEAD", ...
  revision: include repos/../HEAD in --all

 Documentation/config.txt               |   3 +-
 Documentation/git-checkout.txt         |   6 +
 Documentation/git-prune.txt            |   4 +
 Documentation/git.txt                  |   8 ++
 Documentation/gitrepository-layout.txt |  30 ++++
 builtin/checkout.c                     | 173 ++++++++++++++++++++++
 builtin/prune.c                        |  65 +++++++++
 builtin/reflog.c                       |   2 +-
 builtin/rev-parse.c                    |   6 +
 cache.h                                |   5 +
 environment.c                          |  37 ++++-
 fast-import.c                          |   5 +-
 path.c                                 | 140 ++++++++++++++----
 refs.c                                 |  88 ++++++++++--
 refs.h                                 |   1 +
 revision.c                             |   1 +
 setup.c                                | 253 ++++++++++++++++++++++++-=
--------
 t/t0060-path-utils.sh                  | 133 +++++++++++++++++
 t/t1501-worktree.sh                    |  52 +++++++
 t/t1510-repo-setup.sh                  |   1 +
 test-path-utils.c                      |   7 +
 trace.c                                |   1 +
 22 files changed, 904 insertions(+), 117 deletions(-)

--=20
1.8.5.1.77.g42c48fa
