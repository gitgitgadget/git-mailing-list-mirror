From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH 0/9] remerge diff proof of concept/RFC
Date: Tue,  4 Feb 2014 23:17:29 +0100
Message-ID: <cover.1391549294.git.tr@thomasrast.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 23:18:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAoJi-0001oN-7E
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935758AbaBDWSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 17:18:01 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:54751 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934443AbaBDWRw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 17:17:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 2609F4D65EF
	for <git@vger.kernel.org>; Tue,  4 Feb 2014 23:17:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id X7fXSBZ1tASh for <git@vger.kernel.org>;
	Tue,  4 Feb 2014 23:17:40 +0100 (CET)
Received: from linux.local (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id D31764D64BD
	for <git@vger.kernel.org>; Tue,  4 Feb 2014 23:17:39 +0100 (CET)
X-Mailer: git-send-email 1.9.rc2.232.gdd31389
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241565>

Hi,

This may look intimidating, but it's actually 3.5 separate things:

  merge-recursive: remove dead conditional in update_stages()
  merge-recursive: internal flag to avoid touching the worktree
  merge-recursive: -Xindex-only to leave worktree unchanged

These are unchanged from tr/merge-recursive-index-only.  I'm just
resending them here because it's been a while, the rest depends on it,
and it makes it more obvious how patch 8 fits in.

  pretty: refactor add_merge_info() into parts
  log: add a merge base inspection option

This seemed a good idea when I wrote it, but the more I think about
it, the less useful it appears to me.  I left it here as a
demonstration that computing the merge bases as we go is feasible.

  combine-diff: do not pass revs->dense_combined_merges redundantly
  Fold all merge diff variants into an enum

Some initial refactoring.

  merge-recursive: allow storing conflict hunks in index
  log --remerge-diff: show what the conflict resolution changed

The real meat.

I'll only describe the last patches here.

Context: last summer (yes, it's been a while) I investigated some
angles of looking at merges that make it easier to investigate
mismerges.  The problem space is: it is exceedingly hard to find
instances of

  git merge -s ours foo
  git merge -Xours foo
  manually resolve some hunks in favor of one side

after some time has passed.  The only ways I found with existing
machinery involve too much manual inspection.

At the time I made some scripts that look at the problem in various
ways:

  https://github.com/trast/evilmergediff

This series explores another angle, which I call "remerge diff".  It
works by re-doing the merge in core, using features from patches 1-3
and 7.  Likely that will result in conflicts, which are formatted in
the usual <<<<<<< way.  Then it diffs this "remerge" against the
merge's tree that is recorded in history.

This tends to give nice results in practice; I pasted a particularly
pretty example at the bottom.


However, this is RFC because nontrivial merges can easily lead to
states that I cannot handle with the current -- pretty neat and
simple, I think -- implementation.

For example, a delete/modify conflict does not result in a nice
conflict-hunk formatted file, it just leaves 2 (out of 3) stages in
the index.  I can then not write a tree from that.

This could be fixed by adding a pass that turns a missing stage 2 or 3
into an empty file at that stage, so that the resulting file looks
like

  <<<<<<<
  =======
  ... stage 3 content goes here ...
  >>>>>>>

(analogously for stage 3 missing).

But that still doesn't handle at least directory/file conflicts.

So I would welcome comments, and/or better ideas, on the following
proposed resolution:

* Implement what I described last, to take care of delete/modify
  conflicts.

* Punt on more complex conflicts, by removing those files from the
  index, and emitting a warning about those files instead.

Note that even without delete/modify handling, this covers the vast
majority of merges: among some 8090 merges I sampled from git.git,
there are only 13 that trigger the "BUG: ..." message, and 34
octopuses.


Example run:

  $ git show --remerge-diff a39b15b4f6a3f08b67b17d968935d177821e680f
  [...]
  diff --git a/builtin/ls-files.c b/builtin/ls-files.c
  index 0f4473e..175e6e3 100644
  --- a/builtin/ls-files.c
  +++ b/builtin/ls-files.c
  @@ -490,16 +490,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
   		OPT_BOOLEAN('u', "unmerged", &show_unmerged,
   			N_("show unmerged files in the output")),
   		OPT_BOOLEAN(0, "resolve-undo", &show_resolve_undo,
  -<<<<<<< f12e49ae877ad0644b9b9939b7cb742da98691d2
   			    N_("show resolve-undo information")),
  -		{ OPTION_CALLBACK, 'x', "exclude", &dir.exclude_list[EXC_CMDL], N_("pattern"),
  +		{ OPTION_CALLBACK, 'x', "exclude", &exclude_list, N_("pattern"),
   			N_("skip files matching pattern"),
  -=======
  -			    "show resolve-undo information"),
  -		{ OPTION_CALLBACK, 'x', "exclude",
  -			&exclude_list, "pattern",
  -			"skip files matching pattern",
  ->>>>>>> 72aeb18772deeb386da7dd8997b969877bd29e41
   			0, option_parse_exclude },
   		{ OPTION_CALLBACK, 'X', "exclude-from", &dir, N_("file"),
   			N_("exclude patterns are read from <file>"),
  diff --git a/dir.c b/dir.c
  index 8c58ce4..cf1e6b0 100644
  --- a/dir.c
  +++ b/dir.c
  @@ -1674,14 +1674,14 @@ void free_pathspec(struct pathspec *pathspec)
   	pathspec->items = NULL;
   }
   
  -<<<<<<< f12e49ae877ad0644b9b9939b7cb742da98691d2
   int limit_pathspec_to_literal(void)
   {
   	static int flag = -1;
   	if (flag < 0)
   		flag = git_env_bool(GIT_LITERAL_PATHSPECS_ENVIRONMENT, 0);
   	return flag;
  -=======
  +}
  +
   /*
    * Frees memory within dir which was allocated for exclude lists and
    * the exclude_stack.  Does not free dir itself.
  @@ -1710,5 +1710,4 @@ void clear_directory(struct dir_struct *dir)
   		free(stk);
   		stk = prev;
   	}
  ->>>>>>> 72aeb18772deeb386da7dd8997b969877bd29e41
   }




 Documentation/merge-strategies.txt |   9 +++
 Documentation/rev-list-options.txt |  14 ++++
 builtin/diff-files.c               |   5 +-
 builtin/diff-tree.c                |   2 +-
 builtin/diff.c                     |  12 +--
 builtin/fmt-merge-msg.c            |   2 +-
 builtin/log.c                      |   9 +--
 builtin/merge.c                    |   1 -
 combine-diff.c                     |  13 ++--
 commit.h                           |   1 +
 diff-lib.c                         |  13 ++--
 diff.h                             |   6 +-
 log-tree.c                         |  69 +++++++++++++++++-
 merge-recursive.c                  |  52 +++++++------
 merge-recursive.h                  |   3 +
 pretty.c                           |  41 +++++++----
 revision.c                         |  17 ++---
 revision.h                         |  26 ++++++-
 submodule.c                        |   3 +-
 t/t3030-merge-recursive.sh         |  33 +++++++++
 t/t4202-log.sh                     |  34 +++++++++
 t/t4213-log-remerge-diff.sh        | 145 +++++++++++++++++++++++++++++++++++++
 22 files changed, 426 insertions(+), 84 deletions(-)
 create mode 100755 t/t4213-log-remerge-diff.sh

-- 
1.9.rc2.232.gdd31389
