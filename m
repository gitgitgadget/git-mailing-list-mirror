From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFD] Deepen the git directory structure a bit.
Date: Thu, 18 Feb 2010 10:36:29 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1002181010590.4141@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 19:42:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiBKk-0008S8-GW
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 19:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949Ab0BRSm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 13:42:27 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37461 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754930Ab0BRSm0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 13:42:26 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o1IIaUTd013091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Feb 2010 10:36:31 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o1IIaTC7028932;
	Thu, 18 Feb 2010 10:36:29 -0800
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.948 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140360>


Ok, this is just a request-for-discussion. I'm trying out a patch like 
this, and I think it's a step in the right direction. The git directory 
structure is _very_ flat, and currently in a fully built git tree, the 
top-level directory has something like 750 files in it.

After this, it still has a ton of files, but it has shrunk to ~575 files 
instead, and at least for my (admittedly somewhat odd) setup, that 
actually matters for auto-completion etc.

I think this coul probably be done differently (I'm not proud of that ugly 
'-I. -Ibuiltin' addition to the CFLAGS, for example), and I think there 
are _other_ things we could also try to do to move files into 
subdirectories, but this was a fairly easy thing to basically script.

What do people think?

			Linus

---
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Feb 2010 10:11:32 -0800
Subject: [PATCH] Move 'builtin-*' into a 'builtin/' subdirectory

This shrinks the top-level directory a bit, and makes it much more
pleasant to use auto-completion on the thing. Instead of

	[torvalds@nehalem git]$ em buil<tab>
	Display all 180 possibilities? (y or n)
	[torvalds@nehalem git]$ em builtin-sh
	builtin-shortlog.c     builtin-show-branch.c  builtin-show-ref.c
	builtin-shortlog.o     builtin-show-branch.o  builtin-show-ref.o
	[torvalds@nehalem git]$ em builtin-shor<tab>
	builtin-shortlog.c  builtin-shortlog.o
	[torvalds@nehalem git]$ em builtin-shortlog.c

you get

	[torvalds@nehalem git]$ em buil<tab>		[type]
	[torvalds@nehalem git]$ em builtin/		[auto-completes to]
	[torvalds@nehalem git]$ em builtin/sh<tab>	[type]
	shortlog.c     shortlog.o     show-branch.c  show-branch.o  show-ref.c     show-ref.o
	[torvalds@nehalem git]$ em builtin/sho		[auto-completes to]
	[torvalds@nehalem git]$ em builtin/shor<tab>	[type]
	shortlog.c  shortlog.o
	[torvalds@nehalem git]$ em builtin/shortlog.c

which doesn't seem all that different, but not having that annoying
break in "Display all 180 possibilities?" is quite a relief.

NOTE! If you do this in a clean tree (no object files etc), or using an
editor that has auto-completion rules that ignores '*.o' files, you
won't see that annoying 'Display all 180 possibilities?' message - it
will just show the choices instead.  I think bash has some cut-off
around 100 choices or something.

So the reason I see this is that I'm using an odd editory, and thus
don't have the rules to cut down on auto-completion.  But you can
simulate that by using 'ls' instead, or something similar. And you can 
tell that there are fewer files in the top directory.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 Makefile                                           |  194 ++++++++++----------
 builtin-add.c => builtin/add.c                     |    0
 builtin-annotate.c => builtin/annotate.c           |    0
 builtin-apply.c => builtin/apply.c                 |    0
 builtin-archive.c => builtin/archive.c             |    0
 .../bisect--helper.c                               |    0
 builtin-blame.c => builtin/blame.c                 |    0
 builtin-branch.c => builtin/branch.c               |    0
 builtin.h => builtin/builtin.h                     |    0
 builtin-bundle.c => builtin/bundle.c               |    0
 builtin-cat-file.c => builtin/cat-file.c           |    0
 builtin-check-attr.c => builtin/check-attr.c       |    0
 .../check-ref-format.c                             |    0
 .../checkout-index.c                               |    0
 builtin-checkout.c => builtin/checkout.c           |    0
 builtin-clean.c => builtin/clean.c                 |    0
 builtin-clone.c => builtin/clone.c                 |    0
 builtin-commit-tree.c => builtin/commit-tree.c     |    0
 builtin-commit.c => builtin/commit.c               |    0
 builtin-config.c => builtin/config.c               |    0
 builtin-count-objects.c => builtin/count-objects.c |    0
 builtin-describe.c => builtin/describe.c           |    0
 builtin-diff-files.c => builtin/diff-files.c       |    0
 builtin-diff-index.c => builtin/diff-index.c       |    0
 builtin-diff-tree.c => builtin/diff-tree.c         |    0
 builtin-diff.c => builtin/diff.c                   |    0
 builtin-fast-export.c => builtin/fast-export.c     |    0
 builtin-fetch-pack.c => builtin/fetch-pack.c       |    0
 builtin-fetch.c => builtin/fetch.c                 |    0
 builtin-fmt-merge-msg.c => builtin/fmt-merge-msg.c |    0
 builtin-for-each-ref.c => builtin/for-each-ref.c   |    0
 builtin-fsck.c => builtin/fsck.c                   |    0
 builtin-gc.c => builtin/gc.c                       |    0
 builtin-grep.c => builtin/grep.c                   |    0
 builtin-hash-object.c => builtin/hash-object.c     |    0
 builtin-help.c => builtin/help.c                   |    0
 builtin-index-pack.c => builtin/index-pack.c       |    0
 builtin-init-db.c => builtin/init-db.c             |    0
 builtin-log.c => builtin/log.c                     |    0
 builtin-ls-files.c => builtin/ls-files.c           |    0
 builtin-ls-remote.c => builtin/ls-remote.c         |    0
 builtin-ls-tree.c => builtin/ls-tree.c             |    0
 builtin-mailinfo.c => builtin/mailinfo.c           |    0
 builtin-mailsplit.c => builtin/mailsplit.c         |    0
 builtin-merge-base.c => builtin/merge-base.c       |    0
 builtin-merge-file.c => builtin/merge-file.c       |    0
 builtin-merge-index.c => builtin/merge-index.c     |    0
 builtin-merge-ours.c => builtin/merge-ours.c       |    0
 .../merge-recursive.c                              |    0
 builtin-merge-tree.c => builtin/merge-tree.c       |    0
 builtin-merge.c => builtin/merge.c                 |    0
 builtin-mktag.c => builtin/mktag.c                 |    0
 builtin-mktree.c => builtin/mktree.c               |    0
 builtin-mv.c => builtin/mv.c                       |    0
 builtin-name-rev.c => builtin/name-rev.c           |    0
 builtin-pack-objects.c => builtin/pack-objects.c   |    0
 .../pack-redundant.c                               |    0
 builtin-pack-refs.c => builtin/pack-refs.c         |    0
 builtin-patch-id.c => builtin/patch-id.c           |    0
 builtin-prune-packed.c => builtin/prune-packed.c   |    0
 builtin-prune.c => builtin/prune.c                 |    0
 builtin-push.c => builtin/push.c                   |    0
 builtin-read-tree.c => builtin/read-tree.c         |    0
 builtin-receive-pack.c => builtin/receive-pack.c   |    0
 builtin-reflog.c => builtin/reflog.c               |    0
 builtin-remote.c => builtin/remote.c               |    0
 builtin-replace.c => builtin/replace.c             |    0
 builtin-rerere.c => builtin/rerere.c               |    0
 builtin-reset.c => builtin/reset.c                 |    0
 builtin-rev-list.c => builtin/rev-list.c           |    0
 builtin-rev-parse.c => builtin/rev-parse.c         |    0
 builtin-revert.c => builtin/revert.c               |    0
 builtin-rm.c => builtin/rm.c                       |    0
 builtin-send-pack.c => builtin/send-pack.c         |    0
 builtin-shortlog.c => builtin/shortlog.c           |    0
 builtin-show-branch.c => builtin/show-branch.c     |    0
 builtin-show-ref.c => builtin/show-ref.c           |    0
 builtin-stripspace.c => builtin/stripspace.c       |    0
 builtin-symbolic-ref.c => builtin/symbolic-ref.c   |    0
 builtin-tag.c => builtin/tag.c                     |    0
 builtin-tar-tree.c => builtin/tar-tree.c           |    0
 builtin-unpack-file.c => builtin/unpack-file.c     |    0
 .../unpack-objects.c                               |    0
 builtin-update-index.c => builtin/update-index.c   |    0
 builtin-update-ref.c => builtin/update-ref.c       |    0
 .../update-server-info.c                           |    0
 .../upload-archive.c                               |    0
 builtin-var.c => builtin/var.c                     |    0
 builtin-verify-pack.c => builtin/verify-pack.c     |    0
 builtin-verify-tag.c => builtin/verify-tag.c       |    0
 builtin-write-tree.c => builtin/write-tree.c       |    0
 91 files changed, 97 insertions(+), 97 deletions(-)
 rename builtin-add.c => builtin/add.c (100%)
 rename builtin-annotate.c => builtin/annotate.c (100%)
 rename builtin-apply.c => builtin/apply.c (100%)
 rename builtin-archive.c => builtin/archive.c (100%)
 rename builtin-bisect--helper.c => builtin/bisect--helper.c (100%)
 rename builtin-blame.c => builtin/blame.c (100%)
 rename builtin-branch.c => builtin/branch.c (100%)
 rename builtin.h => builtin/builtin.h (100%)
 rename builtin-bundle.c => builtin/bundle.c (100%)
 rename builtin-cat-file.c => builtin/cat-file.c (100%)
 rename builtin-check-attr.c => builtin/check-attr.c (100%)
 rename builtin-check-ref-format.c => builtin/check-ref-format.c (100%)
 rename builtin-checkout-index.c => builtin/checkout-index.c (100%)
 rename builtin-checkout.c => builtin/checkout.c (100%)
 rename builtin-clean.c => builtin/clean.c (100%)
 rename builtin-clone.c => builtin/clone.c (100%)
 rename builtin-commit-tree.c => builtin/commit-tree.c (100%)
 rename builtin-commit.c => builtin/commit.c (100%)
 rename builtin-config.c => builtin/config.c (100%)
 rename builtin-count-objects.c => builtin/count-objects.c (100%)
 rename builtin-describe.c => builtin/describe.c (100%)
 rename builtin-diff-files.c => builtin/diff-files.c (100%)
 rename builtin-diff-index.c => builtin/diff-index.c (100%)
 rename builtin-diff-tree.c => builtin/diff-tree.c (100%)
 rename builtin-diff.c => builtin/diff.c (100%)
 rename builtin-fast-export.c => builtin/fast-export.c (100%)
 rename builtin-fetch-pack.c => builtin/fetch-pack.c (100%)
 rename builtin-fetch.c => builtin/fetch.c (100%)
 rename builtin-fmt-merge-msg.c => builtin/fmt-merge-msg.c (100%)
 rename builtin-for-each-ref.c => builtin/for-each-ref.c (100%)
 rename builtin-fsck.c => builtin/fsck.c (100%)
 rename builtin-gc.c => builtin/gc.c (100%)
 rename builtin-grep.c => builtin/grep.c (100%)
 rename builtin-hash-object.c => builtin/hash-object.c (100%)
 rename builtin-help.c => builtin/help.c (100%)
 rename builtin-index-pack.c => builtin/index-pack.c (100%)
 rename builtin-init-db.c => builtin/init-db.c (100%)
 rename builtin-log.c => builtin/log.c (100%)
 rename builtin-ls-files.c => builtin/ls-files.c (100%)
 rename builtin-ls-remote.c => builtin/ls-remote.c (100%)
 rename builtin-ls-tree.c => builtin/ls-tree.c (100%)
 rename builtin-mailinfo.c => builtin/mailinfo.c (100%)
 rename builtin-mailsplit.c => builtin/mailsplit.c (100%)
 rename builtin-merge-base.c => builtin/merge-base.c (100%)
 rename builtin-merge-file.c => builtin/merge-file.c (100%)
 rename builtin-merge-index.c => builtin/merge-index.c (100%)
 rename builtin-merge-ours.c => builtin/merge-ours.c (100%)
 rename builtin-merge-recursive.c => builtin/merge-recursive.c (100%)
 rename builtin-merge-tree.c => builtin/merge-tree.c (100%)
 rename builtin-merge.c => builtin/merge.c (100%)
 rename builtin-mktag.c => builtin/mktag.c (100%)
 rename builtin-mktree.c => builtin/mktree.c (100%)
 rename builtin-mv.c => builtin/mv.c (100%)
 rename builtin-name-rev.c => builtin/name-rev.c (100%)
 rename builtin-pack-objects.c => builtin/pack-objects.c (100%)
 rename builtin-pack-redundant.c => builtin/pack-redundant.c (100%)
 rename builtin-pack-refs.c => builtin/pack-refs.c (100%)
 rename builtin-patch-id.c => builtin/patch-id.c (100%)
 rename builtin-prune-packed.c => builtin/prune-packed.c (100%)
 rename builtin-prune.c => builtin/prune.c (100%)
 rename builtin-push.c => builtin/push.c (100%)
 rename builtin-read-tree.c => builtin/read-tree.c (100%)
 rename builtin-receive-pack.c => builtin/receive-pack.c (100%)
 rename builtin-reflog.c => builtin/reflog.c (100%)
 rename builtin-remote.c => builtin/remote.c (100%)
 rename builtin-replace.c => builtin/replace.c (100%)
 rename builtin-rerere.c => builtin/rerere.c (100%)
 rename builtin-reset.c => builtin/reset.c (100%)
 rename builtin-rev-list.c => builtin/rev-list.c (100%)
 rename builtin-rev-parse.c => builtin/rev-parse.c (100%)
 rename builtin-revert.c => builtin/revert.c (100%)
 rename builtin-rm.c => builtin/rm.c (100%)
 rename builtin-send-pack.c => builtin/send-pack.c (100%)
 rename builtin-shortlog.c => builtin/shortlog.c (100%)
 rename builtin-show-branch.c => builtin/show-branch.c (100%)
 rename builtin-show-ref.c => builtin/show-ref.c (100%)
 rename builtin-stripspace.c => builtin/stripspace.c (100%)
 rename builtin-symbolic-ref.c => builtin/symbolic-ref.c (100%)
 rename builtin-tag.c => builtin/tag.c (100%)
 rename builtin-tar-tree.c => builtin/tar-tree.c (100%)
 rename builtin-unpack-file.c => builtin/unpack-file.c (100%)
 rename builtin-unpack-objects.c => builtin/unpack-objects.c (100%)
 rename builtin-update-index.c => builtin/update-index.c (100%)
 rename builtin-update-ref.c => builtin/update-ref.c (100%)
 rename builtin-update-server-info.c => builtin/update-server-info.c (100%)
 rename builtin-upload-archive.c => builtin/upload-archive.c (100%)
 rename builtin-var.c => builtin/var.c (100%)
 rename builtin-verify-pack.c => builtin/verify-pack.c (100%)
 rename builtin-verify-tag.c => builtin/verify-tag.c (100%)
 rename builtin-write-tree.c => builtin/write-tree.c (100%)

diff --git a/Makefile b/Makefile
index 7bf2fca..f023f9b 100644
--- a/Makefile
+++ b/Makefile
@@ -301,7 +301,7 @@ SPARSE_FLAGS = -D__BIG_ENDIAN__ -D__powerpc__
 # Those must not be GNU-specific; they are shared with perl/ which may
 # be built by a different compiler. (Note that this is an artifact now
 # but it still might be nice to keep that distinction.)
-BASIC_CFLAGS =
+BASIC_CFLAGS = -I. -Ibuiltin
 BASIC_LDFLAGS =
 
 # Guard against environment variables
@@ -368,8 +368,8 @@ PROGRAMS += git-upload-pack$X
 PROGRAMS += git-http-backend$X
 
 # List built-in command $C whose implementation cmd_$C() is not in
-# builtin-$C.o but is linked in as part of some other command.
-BUILT_INS += $(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
+# builtin/$C.o but is linked in as part of some other command.
+BUILT_INS += $(patsubst builtin/%.o,git-%$X,$(BUILTIN_OBJS))
 
 BUILT_INS += git-cherry$X
 BUILT_INS += git-cherry-pick$X
@@ -422,7 +422,7 @@ LIB_H += advice.h
 LIB_H += archive.h
 LIB_H += attr.h
 LIB_H += blob.h
-LIB_H += builtin.h
+LIB_H += builtin/builtin.h
 LIB_H += cache.h
 LIB_H += cache-tree.h
 LIB_H += commit.h
@@ -592,95 +592,95 @@ LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
 
-BUILTIN_OBJS += builtin-add.o
-BUILTIN_OBJS += builtin-annotate.o
-BUILTIN_OBJS += builtin-apply.o
-BUILTIN_OBJS += builtin-archive.o
-BUILTIN_OBJS += builtin-bisect--helper.o
-BUILTIN_OBJS += builtin-blame.o
-BUILTIN_OBJS += builtin-branch.o
-BUILTIN_OBJS += builtin-bundle.o
-BUILTIN_OBJS += builtin-cat-file.o
-BUILTIN_OBJS += builtin-check-attr.o
-BUILTIN_OBJS += builtin-check-ref-format.o
-BUILTIN_OBJS += builtin-checkout-index.o
-BUILTIN_OBJS += builtin-checkout.o
-BUILTIN_OBJS += builtin-clean.o
-BUILTIN_OBJS += builtin-clone.o
-BUILTIN_OBJS += builtin-commit-tree.o
-BUILTIN_OBJS += builtin-commit.o
-BUILTIN_OBJS += builtin-config.o
-BUILTIN_OBJS += builtin-count-objects.o
-BUILTIN_OBJS += builtin-describe.o
-BUILTIN_OBJS += builtin-diff-files.o
-BUILTIN_OBJS += builtin-diff-index.o
-BUILTIN_OBJS += builtin-diff-tree.o
-BUILTIN_OBJS += builtin-diff.o
-BUILTIN_OBJS += builtin-fast-export.o
-BUILTIN_OBJS += builtin-fetch-pack.o
-BUILTIN_OBJS += builtin-fetch.o
-BUILTIN_OBJS += builtin-fmt-merge-msg.o
-BUILTIN_OBJS += builtin-for-each-ref.o
-BUILTIN_OBJS += builtin-fsck.o
-BUILTIN_OBJS += builtin-gc.o
-BUILTIN_OBJS += builtin-grep.o
-BUILTIN_OBJS += builtin-hash-object.o
-BUILTIN_OBJS += builtin-help.o
-BUILTIN_OBJS += builtin-index-pack.o
-BUILTIN_OBJS += builtin-init-db.o
-BUILTIN_OBJS += builtin-log.o
-BUILTIN_OBJS += builtin-ls-files.o
-BUILTIN_OBJS += builtin-ls-remote.o
-BUILTIN_OBJS += builtin-ls-tree.o
-BUILTIN_OBJS += builtin-mailinfo.o
-BUILTIN_OBJS += builtin-mailsplit.o
-BUILTIN_OBJS += builtin-merge.o
-BUILTIN_OBJS += builtin-merge-base.o
-BUILTIN_OBJS += builtin-merge-file.o
-BUILTIN_OBJS += builtin-merge-index.o
-BUILTIN_OBJS += builtin-merge-ours.o
-BUILTIN_OBJS += builtin-merge-recursive.o
-BUILTIN_OBJS += builtin-merge-tree.o
-BUILTIN_OBJS += builtin-mktag.o
-BUILTIN_OBJS += builtin-mktree.o
-BUILTIN_OBJS += builtin-mv.o
-BUILTIN_OBJS += builtin-name-rev.o
-BUILTIN_OBJS += builtin-pack-objects.o
-BUILTIN_OBJS += builtin-pack-redundant.o
-BUILTIN_OBJS += builtin-pack-refs.o
-BUILTIN_OBJS += builtin-patch-id.o
-BUILTIN_OBJS += builtin-prune-packed.o
-BUILTIN_OBJS += builtin-prune.o
-BUILTIN_OBJS += builtin-push.o
-BUILTIN_OBJS += builtin-read-tree.o
-BUILTIN_OBJS += builtin-receive-pack.o
-BUILTIN_OBJS += builtin-reflog.o
-BUILTIN_OBJS += builtin-remote.o
-BUILTIN_OBJS += builtin-replace.o
-BUILTIN_OBJS += builtin-rerere.o
-BUILTIN_OBJS += builtin-reset.o
-BUILTIN_OBJS += builtin-rev-list.o
-BUILTIN_OBJS += builtin-rev-parse.o
-BUILTIN_OBJS += builtin-revert.o
-BUILTIN_OBJS += builtin-rm.o
-BUILTIN_OBJS += builtin-send-pack.o
-BUILTIN_OBJS += builtin-shortlog.o
-BUILTIN_OBJS += builtin-show-branch.o
-BUILTIN_OBJS += builtin-show-ref.o
-BUILTIN_OBJS += builtin-stripspace.o
-BUILTIN_OBJS += builtin-symbolic-ref.o
-BUILTIN_OBJS += builtin-tag.o
-BUILTIN_OBJS += builtin-tar-tree.o
-BUILTIN_OBJS += builtin-unpack-file.o
-BUILTIN_OBJS += builtin-unpack-objects.o
-BUILTIN_OBJS += builtin-update-index.o
-BUILTIN_OBJS += builtin-update-ref.o
-BUILTIN_OBJS += builtin-update-server-info.o
-BUILTIN_OBJS += builtin-upload-archive.o
-BUILTIN_OBJS += builtin-var.o
-BUILTIN_OBJS += builtin-verify-pack.o
-BUILTIN_OBJS += builtin-verify-tag.o
-BUILTIN_OBJS += builtin-write-tree.o
+BUILTIN_OBJS += builtin/add.o
+BUILTIN_OBJS += builtin/annotate.o
+BUILTIN_OBJS += builtin/apply.o
+BUILTIN_OBJS += builtin/archive.o
+BUILTIN_OBJS += builtin/bisect--helper.o
+BUILTIN_OBJS += builtin/blame.o
+BUILTIN_OBJS += builtin/branch.o
+BUILTIN_OBJS += builtin/bundle.o
+BUILTIN_OBJS += builtin/cat-file.o
+BUILTIN_OBJS += builtin/check-attr.o
+BUILTIN_OBJS += builtin/check-ref-format.o
+BUILTIN_OBJS += builtin/checkout-index.o
+BUILTIN_OBJS += builtin/checkout.o
+BUILTIN_OBJS += builtin/clean.o
+BUILTIN_OBJS += builtin/clone.o
+BUILTIN_OBJS += builtin/commit-tree.o
+BUILTIN_OBJS += builtin/commit.o
+BUILTIN_OBJS += builtin/config.o
+BUILTIN_OBJS += builtin/count-objects.o
+BUILTIN_OBJS += builtin/describe.o
+BUILTIN_OBJS += builtin/diff-files.o
+BUILTIN_OBJS += builtin/diff-index.o
+BUILTIN_OBJS += builtin/diff-tree.o
+BUILTIN_OBJS += builtin/diff.o
+BUILTIN_OBJS += builtin/fast-export.o
+BUILTIN_OBJS += builtin/fetch-pack.o
+BUILTIN_OBJS += builtin/fetch.o
+BUILTIN_OBJS += builtin/fmt-merge-msg.o
+BUILTIN_OBJS += builtin/for-each-ref.o
+BUILTIN_OBJS += builtin/fsck.o
+BUILTIN_OBJS += builtin/gc.o
+BUILTIN_OBJS += builtin/grep.o
+BUILTIN_OBJS += builtin/hash-object.o
+BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/index-pack.o
+BUILTIN_OBJS += builtin/init-db.o
+BUILTIN_OBJS += builtin/log.o
+BUILTIN_OBJS += builtin/ls-files.o
+BUILTIN_OBJS += builtin/ls-remote.o
+BUILTIN_OBJS += builtin/ls-tree.o
+BUILTIN_OBJS += builtin/mailinfo.o
+BUILTIN_OBJS += builtin/mailsplit.o
+BUILTIN_OBJS += builtin/merge.o
+BUILTIN_OBJS += builtin/merge-base.o
+BUILTIN_OBJS += builtin/merge-file.o
+BUILTIN_OBJS += builtin/merge-index.o
+BUILTIN_OBJS += builtin/merge-ours.o
+BUILTIN_OBJS += builtin/merge-recursive.o
+BUILTIN_OBJS += builtin/merge-tree.o
+BUILTIN_OBJS += builtin/mktag.o
+BUILTIN_OBJS += builtin/mktree.o
+BUILTIN_OBJS += builtin/mv.o
+BUILTIN_OBJS += builtin/name-rev.o
+BUILTIN_OBJS += builtin/pack-objects.o
+BUILTIN_OBJS += builtin/pack-redundant.o
+BUILTIN_OBJS += builtin/pack-refs.o
+BUILTIN_OBJS += builtin/patch-id.o
+BUILTIN_OBJS += builtin/prune-packed.o
+BUILTIN_OBJS += builtin/prune.o
+BUILTIN_OBJS += builtin/push.o
+BUILTIN_OBJS += builtin/read-tree.o
+BUILTIN_OBJS += builtin/receive-pack.o
+BUILTIN_OBJS += builtin/reflog.o
+BUILTIN_OBJS += builtin/remote.o
+BUILTIN_OBJS += builtin/replace.o
+BUILTIN_OBJS += builtin/rerere.o
+BUILTIN_OBJS += builtin/reset.o
+BUILTIN_OBJS += builtin/rev-list.o
+BUILTIN_OBJS += builtin/rev-parse.o
+BUILTIN_OBJS += builtin/revert.o
+BUILTIN_OBJS += builtin/rm.o
+BUILTIN_OBJS += builtin/send-pack.o
+BUILTIN_OBJS += builtin/shortlog.o
+BUILTIN_OBJS += builtin/show-branch.o
+BUILTIN_OBJS += builtin/show-ref.o
+BUILTIN_OBJS += builtin/stripspace.o
+BUILTIN_OBJS += builtin/symbolic-ref.o
+BUILTIN_OBJS += builtin/tag.o
+BUILTIN_OBJS += builtin/tar-tree.o
+BUILTIN_OBJS += builtin/unpack-file.o
+BUILTIN_OBJS += builtin/unpack-objects.o
+BUILTIN_OBJS += builtin/update-index.o
+BUILTIN_OBJS += builtin/update-ref.o
+BUILTIN_OBJS += builtin/update-server-info.o
+BUILTIN_OBJS += builtin/upload-archive.o
+BUILTIN_OBJS += builtin/var.o
+BUILTIN_OBJS += builtin/verify-pack.o
+BUILTIN_OBJS += builtin/verify-tag.o
+BUILTIN_OBJS += builtin/write-tree.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =
@@ -1445,8 +1445,8 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
-builtin-help.o: common-cmds.h
-builtin-help.s builtin-help.o: ALL_CFLAGS += \
+builtin/help.o: common-cmds.h
+builtin/help.s builtin/help.o: ALL_CFLAGS += \
 	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_SQ)"'
@@ -1594,7 +1594,7 @@ exec_cmd.s exec_cmd.o: ALL_CFLAGS += \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
 	'-DPREFIX="$(prefix_SQ)"'
 
-builtin-init-db.s builtin-init-db.o: ALL_CFLAGS += \
+builtin/init-db.s builtin/init-db.o: ALL_CFLAGS += \
 	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
 
 config.s config.o: ALL_CFLAGS += -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
@@ -1636,7 +1636,7 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o $(GITLIBS)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H) $(wildcard */*.h)
-builtin-revert.o wt-status.o: wt-status.h
+builtin/revert.o wt-status.o: wt-status.h
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
diff --git a/builtin-add.c b/builtin/add.c
similarity index 100%
rename from builtin-add.c
rename to builtin/add.c
diff --git a/builtin-annotate.c b/builtin/annotate.c
similarity index 100%
rename from builtin-annotate.c
rename to builtin/annotate.c
diff --git a/builtin-apply.c b/builtin/apply.c
similarity index 100%
rename from builtin-apply.c
rename to builtin/apply.c
diff --git a/builtin-archive.c b/builtin/archive.c
similarity index 100%
rename from builtin-archive.c
rename to builtin/archive.c
diff --git a/builtin-bisect--helper.c b/builtin/bisect--helper.c
similarity index 100%
rename from builtin-bisect--helper.c
rename to builtin/bisect--helper.c
diff --git a/builtin-blame.c b/builtin/blame.c
similarity index 100%
rename from builtin-blame.c
rename to builtin/blame.c
diff --git a/builtin-branch.c b/builtin/branch.c
similarity index 100%
rename from builtin-branch.c
rename to builtin/branch.c
diff --git a/builtin.h b/builtin/builtin.h
similarity index 100%
rename from builtin.h
rename to builtin/builtin.h
diff --git a/builtin-bundle.c b/builtin/bundle.c
similarity index 100%
rename from builtin-bundle.c
rename to builtin/bundle.c
diff --git a/builtin-cat-file.c b/builtin/cat-file.c
similarity index 100%
rename from builtin-cat-file.c
rename to builtin/cat-file.c
diff --git a/builtin-check-attr.c b/builtin/check-attr.c
similarity index 100%
rename from builtin-check-attr.c
rename to builtin/check-attr.c
diff --git a/builtin-check-ref-format.c b/builtin/check-ref-format.c
similarity index 100%
rename from builtin-check-ref-format.c
rename to builtin/check-ref-format.c
diff --git a/builtin-checkout-index.c b/builtin/checkout-index.c
similarity index 100%
rename from builtin-checkout-index.c
rename to builtin/checkout-index.c
diff --git a/builtin-checkout.c b/builtin/checkout.c
similarity index 100%
rename from builtin-checkout.c
rename to builtin/checkout.c
diff --git a/builtin-clean.c b/builtin/clean.c
similarity index 100%
rename from builtin-clean.c
rename to builtin/clean.c
diff --git a/builtin-clone.c b/builtin/clone.c
similarity index 100%
rename from builtin-clone.c
rename to builtin/clone.c
diff --git a/builtin-commit-tree.c b/builtin/commit-tree.c
similarity index 100%
rename from builtin-commit-tree.c
rename to builtin/commit-tree.c
diff --git a/builtin-commit.c b/builtin/commit.c
similarity index 100%
rename from builtin-commit.c
rename to builtin/commit.c
diff --git a/builtin-config.c b/builtin/config.c
similarity index 100%
rename from builtin-config.c
rename to builtin/config.c
diff --git a/builtin-count-objects.c b/builtin/count-objects.c
similarity index 100%
rename from builtin-count-objects.c
rename to builtin/count-objects.c
diff --git a/builtin-describe.c b/builtin/describe.c
similarity index 100%
rename from builtin-describe.c
rename to builtin/describe.c
diff --git a/builtin-diff-files.c b/builtin/diff-files.c
similarity index 100%
rename from builtin-diff-files.c
rename to builtin/diff-files.c
diff --git a/builtin-diff-index.c b/builtin/diff-index.c
similarity index 100%
rename from builtin-diff-index.c
rename to builtin/diff-index.c
diff --git a/builtin-diff-tree.c b/builtin/diff-tree.c
similarity index 100%
rename from builtin-diff-tree.c
rename to builtin/diff-tree.c
diff --git a/builtin-diff.c b/builtin/diff.c
similarity index 100%
rename from builtin-diff.c
rename to builtin/diff.c
diff --git a/builtin-fast-export.c b/builtin/fast-export.c
similarity index 100%
rename from builtin-fast-export.c
rename to builtin/fast-export.c
diff --git a/builtin-fetch-pack.c b/builtin/fetch-pack.c
similarity index 100%
rename from builtin-fetch-pack.c
rename to builtin/fetch-pack.c
diff --git a/builtin-fetch.c b/builtin/fetch.c
similarity index 100%
rename from builtin-fetch.c
rename to builtin/fetch.c
diff --git a/builtin-fmt-merge-msg.c b/builtin/fmt-merge-msg.c
similarity index 100%
rename from builtin-fmt-merge-msg.c
rename to builtin/fmt-merge-msg.c
diff --git a/builtin-for-each-ref.c b/builtin/for-each-ref.c
similarity index 100%
rename from builtin-for-each-ref.c
rename to builtin/for-each-ref.c
diff --git a/builtin-fsck.c b/builtin/fsck.c
similarity index 100%
rename from builtin-fsck.c
rename to builtin/fsck.c
diff --git a/builtin-gc.c b/builtin/gc.c
similarity index 100%
rename from builtin-gc.c
rename to builtin/gc.c
diff --git a/builtin-grep.c b/builtin/grep.c
similarity index 100%
rename from builtin-grep.c
rename to builtin/grep.c
diff --git a/builtin-hash-object.c b/builtin/hash-object.c
similarity index 100%
rename from builtin-hash-object.c
rename to builtin/hash-object.c
diff --git a/builtin-help.c b/builtin/help.c
similarity index 100%
rename from builtin-help.c
rename to builtin/help.c
diff --git a/builtin-index-pack.c b/builtin/index-pack.c
similarity index 100%
rename from builtin-index-pack.c
rename to builtin/index-pack.c
diff --git a/builtin-init-db.c b/builtin/init-db.c
similarity index 100%
rename from builtin-init-db.c
rename to builtin/init-db.c
diff --git a/builtin-log.c b/builtin/log.c
similarity index 100%
rename from builtin-log.c
rename to builtin/log.c
diff --git a/builtin-ls-files.c b/builtin/ls-files.c
similarity index 100%
rename from builtin-ls-files.c
rename to builtin/ls-files.c
diff --git a/builtin-ls-remote.c b/builtin/ls-remote.c
similarity index 100%
rename from builtin-ls-remote.c
rename to builtin/ls-remote.c
diff --git a/builtin-ls-tree.c b/builtin/ls-tree.c
similarity index 100%
rename from builtin-ls-tree.c
rename to builtin/ls-tree.c
diff --git a/builtin-mailinfo.c b/builtin/mailinfo.c
similarity index 100%
rename from builtin-mailinfo.c
rename to builtin/mailinfo.c
diff --git a/builtin-mailsplit.c b/builtin/mailsplit.c
similarity index 100%
rename from builtin-mailsplit.c
rename to builtin/mailsplit.c
diff --git a/builtin-merge-base.c b/builtin/merge-base.c
similarity index 100%
rename from builtin-merge-base.c
rename to builtin/merge-base.c
diff --git a/builtin-merge-file.c b/builtin/merge-file.c
similarity index 100%
rename from builtin-merge-file.c
rename to builtin/merge-file.c
diff --git a/builtin-merge-index.c b/builtin/merge-index.c
similarity index 100%
rename from builtin-merge-index.c
rename to builtin/merge-index.c
diff --git a/builtin-merge-ours.c b/builtin/merge-ours.c
similarity index 100%
rename from builtin-merge-ours.c
rename to builtin/merge-ours.c
diff --git a/builtin-merge-recursive.c b/builtin/merge-recursive.c
similarity index 100%
rename from builtin-merge-recursive.c
rename to builtin/merge-recursive.c
diff --git a/builtin-merge-tree.c b/builtin/merge-tree.c
similarity index 100%
rename from builtin-merge-tree.c
rename to builtin/merge-tree.c
diff --git a/builtin-merge.c b/builtin/merge.c
similarity index 100%
rename from builtin-merge.c
rename to builtin/merge.c
diff --git a/builtin-mktag.c b/builtin/mktag.c
similarity index 100%
rename from builtin-mktag.c
rename to builtin/mktag.c
diff --git a/builtin-mktree.c b/builtin/mktree.c
similarity index 100%
rename from builtin-mktree.c
rename to builtin/mktree.c
diff --git a/builtin-mv.c b/builtin/mv.c
similarity index 100%
rename from builtin-mv.c
rename to builtin/mv.c
diff --git a/builtin-name-rev.c b/builtin/name-rev.c
similarity index 100%
rename from builtin-name-rev.c
rename to builtin/name-rev.c
diff --git a/builtin-pack-objects.c b/builtin/pack-objects.c
similarity index 100%
rename from builtin-pack-objects.c
rename to builtin/pack-objects.c
diff --git a/builtin-pack-redundant.c b/builtin/pack-redundant.c
similarity index 100%
rename from builtin-pack-redundant.c
rename to builtin/pack-redundant.c
diff --git a/builtin-pack-refs.c b/builtin/pack-refs.c
similarity index 100%
rename from builtin-pack-refs.c
rename to builtin/pack-refs.c
diff --git a/builtin-patch-id.c b/builtin/patch-id.c
similarity index 100%
rename from builtin-patch-id.c
rename to builtin/patch-id.c
diff --git a/builtin-prune-packed.c b/builtin/prune-packed.c
similarity index 100%
rename from builtin-prune-packed.c
rename to builtin/prune-packed.c
diff --git a/builtin-prune.c b/builtin/prune.c
similarity index 100%
rename from builtin-prune.c
rename to builtin/prune.c
diff --git a/builtin-push.c b/builtin/push.c
similarity index 100%
rename from builtin-push.c
rename to builtin/push.c
diff --git a/builtin-read-tree.c b/builtin/read-tree.c
similarity index 100%
rename from builtin-read-tree.c
rename to builtin/read-tree.c
diff --git a/builtin-receive-pack.c b/builtin/receive-pack.c
similarity index 100%
rename from builtin-receive-pack.c
rename to builtin/receive-pack.c
diff --git a/builtin-reflog.c b/builtin/reflog.c
similarity index 100%
rename from builtin-reflog.c
rename to builtin/reflog.c
diff --git a/builtin-remote.c b/builtin/remote.c
similarity index 100%
rename from builtin-remote.c
rename to builtin/remote.c
diff --git a/builtin-replace.c b/builtin/replace.c
similarity index 100%
rename from builtin-replace.c
rename to builtin/replace.c
diff --git a/builtin-rerere.c b/builtin/rerere.c
similarity index 100%
rename from builtin-rerere.c
rename to builtin/rerere.c
diff --git a/builtin-reset.c b/builtin/reset.c
similarity index 100%
rename from builtin-reset.c
rename to builtin/reset.c
diff --git a/builtin-rev-list.c b/builtin/rev-list.c
similarity index 100%
rename from builtin-rev-list.c
rename to builtin/rev-list.c
diff --git a/builtin-rev-parse.c b/builtin/rev-parse.c
similarity index 100%
rename from builtin-rev-parse.c
rename to builtin/rev-parse.c
diff --git a/builtin-revert.c b/builtin/revert.c
similarity index 100%
rename from builtin-revert.c
rename to builtin/revert.c
diff --git a/builtin-rm.c b/builtin/rm.c
similarity index 100%
rename from builtin-rm.c
rename to builtin/rm.c
diff --git a/builtin-send-pack.c b/builtin/send-pack.c
similarity index 100%
rename from builtin-send-pack.c
rename to builtin/send-pack.c
diff --git a/builtin-shortlog.c b/builtin/shortlog.c
similarity index 100%
rename from builtin-shortlog.c
rename to builtin/shortlog.c
diff --git a/builtin-show-branch.c b/builtin/show-branch.c
similarity index 100%
rename from builtin-show-branch.c
rename to builtin/show-branch.c
diff --git a/builtin-show-ref.c b/builtin/show-ref.c
similarity index 100%
rename from builtin-show-ref.c
rename to builtin/show-ref.c
diff --git a/builtin-stripspace.c b/builtin/stripspace.c
similarity index 100%
rename from builtin-stripspace.c
rename to builtin/stripspace.c
diff --git a/builtin-symbolic-ref.c b/builtin/symbolic-ref.c
similarity index 100%
rename from builtin-symbolic-ref.c
rename to builtin/symbolic-ref.c
diff --git a/builtin-tag.c b/builtin/tag.c
similarity index 100%
rename from builtin-tag.c
rename to builtin/tag.c
diff --git a/builtin-tar-tree.c b/builtin/tar-tree.c
similarity index 100%
rename from builtin-tar-tree.c
rename to builtin/tar-tree.c
diff --git a/builtin-unpack-file.c b/builtin/unpack-file.c
similarity index 100%
rename from builtin-unpack-file.c
rename to builtin/unpack-file.c
diff --git a/builtin-unpack-objects.c b/builtin/unpack-objects.c
similarity index 100%
rename from builtin-unpack-objects.c
rename to builtin/unpack-objects.c
diff --git a/builtin-update-index.c b/builtin/update-index.c
similarity index 100%
rename from builtin-update-index.c
rename to builtin/update-index.c
diff --git a/builtin-update-ref.c b/builtin/update-ref.c
similarity index 100%
rename from builtin-update-ref.c
rename to builtin/update-ref.c
diff --git a/builtin-update-server-info.c b/builtin/update-server-info.c
similarity index 100%
rename from builtin-update-server-info.c
rename to builtin/update-server-info.c
diff --git a/builtin-upload-archive.c b/builtin/upload-archive.c
similarity index 100%
rename from builtin-upload-archive.c
rename to builtin/upload-archive.c
diff --git a/builtin-var.c b/builtin/var.c
similarity index 100%
rename from builtin-var.c
rename to builtin/var.c
diff --git a/builtin-verify-pack.c b/builtin/verify-pack.c
similarity index 100%
rename from builtin-verify-pack.c
rename to builtin/verify-pack.c
diff --git a/builtin-verify-tag.c b/builtin/verify-tag.c
similarity index 100%
rename from builtin-verify-tag.c
rename to builtin/verify-tag.c
diff --git a/builtin-write-tree.c b/builtin/write-tree.c
similarity index 100%
rename from builtin-write-tree.c
rename to builtin/write-tree.c
