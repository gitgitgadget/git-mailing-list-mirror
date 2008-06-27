From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 00/15] Build in merge
Date: Fri, 27 Jun 2008 18:21:53 +0200
Message-ID: <cover.1214581610.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:24:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGk3-0004E3-DU
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749AbYF0QWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 12:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754456AbYF0QWP
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:22:15 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:45324 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759705AbYF0QWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 12:22:09 -0400
Received: from vmobile.example.net (dsl5401C209.pool.t-online.hu [84.1.194.9])
	by yugo.frugalware.org (Postfix) with ESMTP id C798B1DDC5E;
	Fri, 27 Jun 2008 18:22:05 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 8DEF118E828; Fri, 27 Jun 2008 18:22:08 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86584>

Hello,

Dscho gave me a detailed review on builtin-merge, so I'm sending an
updated series.

It's based on 49646c5 in git.git, so hopefully it includes all the work
Junio did recently in 'pu'. (PARSE_OPT_ARGV0_IS_AN_OPTION removal, etc.)

Changes:

* "git-fmt-merge-msg: make it usable from other builtins"
  - Small cleanup.

* "Build in merge"
  - When a custom message was given for a merge, the result was not
    identical to the one git-merge.sh had. I added a testcase for this
    and fixed up builtin-merge to pass the test.
  - Memleak fix in restore_state()
  - Cleanup in finish_up_to_date() and squash_message()
  - run_hook() now first checks if the executable bit is set and returns
    immediately if not.
  - Make merge_name() a bit more readable, like *(ptr+1) -> ptr[1]. Also
    fixed a missing initialization in this function.
  - split_merge_strategies(): while (1) -> for (;;)
  - Simplified path_list_append_strategy() by removing unnecessary
    parameters.
  - cmd_merge(): Added more comments to make the code more readable,
    fixed a memory leak, optimized the case when --no-commit is used.
  - merge_one_remote(): Fixed a bug which for example caused a segfault
    when building with -fno-inline.
  - Fixed up color handling when showing the diff after a merge, as
    noticed by Olivier Marin.
  - Fixed up the "Updating foo..bar" message which was like "Updating
    bar..bar", as pointed out by Olivier Marin.

* Dscho's two patches: These introduces strbuf_initf() which can be used
  instead of strbuf_init() and strbuf_addf(). Modified builtin-merge.c
  to use strbuf_initf() where possible.

* Extended t7601-merge-pull-config.sh to make sure git-merge picks up
  the best strategy when no strategy can handle the merge without
  conflicts.

The "interdiff" is available via git diff 49646c5..d1c62b2 in
git://repo.or.cz/git/vmiklos.git.

I'm sending the whole series to avoid complexity, but in fact I only
changed the following patches:

* "git-fmt-merge-msg: make it usable from other builtins"
* "Add new test case to ensure git-merge prepends the custom merge
  message"
* "Build in merge"

Johannes Schindelin (2):
  Add strbuf_vaddf(), use it in strbuf_addf(), and add strbuf_initf()
  strbuf_vaddf(): support %*s, too

Junio C Hamano (2):
  Introduce get_merge_bases_many()
  Introduce reduce_heads()

Miklos Vajna (11):
  Move split_cmdline() to alias.c
  Move commit_list_count() to commit.c
  Move parse-options's skip_prefix() to git-compat-util.h
  Add new test to ensure git-merge handles pull.twohead and
    pull.octopus
  Move read_cache_unmerged() to read-cache.c
  git-fmt-merge-msg: make it usable from other builtins
  Introduce get_octopus_merge_bases() in commit.c
  Add new test to ensure git-merge handles more than 25 refs.
  Add new test case to ensure git-merge reduces octopus parents when
    possible
  Add new test case to ensure git-merge prepends the custom merge
    message
  Build in merge

 .gitignore                                    |    1 +
 Makefile                                      |    6 +-
 alias.c                                       |   54 ++
 builtin-fmt-merge-msg.c                       |  155 ++--
 builtin-merge-recursive.c                     |    8 -
 builtin-merge.c                               | 1143 +++++++++++++++++++++++++
 builtin-read-tree.c                           |   24 -
 builtin-remote.c                              |   39 +-
 builtin.h                                     |    4 +
 cache.h                                       |    3 +
 commit.c                                      |  136 +++-
 commit.h                                      |    4 +
 git-merge.sh => contrib/examples/git-merge.sh |    0 
 git-compat-util.h                             |    6 +
 git.c                                         |   54 +--
 parse-options.c                               |    6 -
 read-cache.c                                  |   31 +
 strbuf.c                                      |  140 +++-
 strbuf.h                                      |    3 +
 t/t0000-basic.sh                              |    8 +
 t/t7601-merge-pull-config.sh                  |  129 +++
 t/t7602-merge-octopus-many.sh                 |   52 ++
 t/t7603-merge-reduce-heads.sh                 |   63 ++
 t/t7604-merge-custom-message.sh               |   37 +
 test-strbuf.c                                 |   17 +
 25 files changed, 1917 insertions(+), 206 deletions(-)
 create mode 100644 builtin-merge.c
 rename git-merge.sh => contrib/examples/git-merge.sh (100%)
 create mode 100755 t/t7601-merge-pull-config.sh
 create mode 100755 t/t7602-merge-octopus-many.sh
 create mode 100755 t/t7603-merge-reduce-heads.sh
 create mode 100755 t/t7604-merge-custom-message.sh
 create mode 100644 test-strbuf.c
