From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 0/3] die_errno()
Date: Mon,  8 Jun 2009 23:02:17 +0200
Message-ID: <cover.1244494646.git.trast@student.ethz.ch>
References: <cover.1244299302.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>,
	Alexander Potashev <aspotashev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 23:03:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDlzN-0002u3-96
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 23:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996AbZFHVC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 17:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755733AbZFHVC0
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 17:02:26 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:19743 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755295AbZFHVC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 17:02:26 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Jun 2009 23:02:11 +0200
Received: from localhost.localdomain ([77.58.128.129]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Jun 2009 23:02:10 +0200
X-Mailer: git-send-email 1.6.3.2.333.g27636
In-Reply-To: <cover.1244299302.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 08 Jun 2009 21:02:10.0864 (UTC) FILETIME=[64088B00:01C9E87C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121107>

First off, thanks for the extensive review and discussion...

[1/3] I changed the snprintf handling to tack the error onto the
  format and pass that to die_routine().  I still think it's crazy to
  invent new format characters, but who knows.

[2/3] Fixed as per Johannes Sixt's comments.

[3/3] Removed the terrible empty-lines mess caused by pilot error.

  Johannes Sixt wrote:
  > > @@ -1018,8 +1017,10 @@ int cmd_commit(int argc, const char **argv, const
  > > char *prefix)
  > >
  > >  	if (commit_index_files())
  > >  		die ("Repository has been updated, but unable to write\n"
  > > -		     "new_index file. Check that disk is not full or quota is\n"
  > > -		     "not exceeded, and then \"git reset HEAD\" to recover.");
  > > +		     "new_index file: %s.\n"
  > > +		     "Check that disk is not full or quota is not exceeded,\n"
  > > +		     "and then \"git reset HEAD\" to recover.",
  > > +		     strerror(errno));
  > 
  > This change should probably not be in this patch.

  Removed...  I'm not enough of an expert to say if
  commit_index_files() can only fail because the disk is full, so I
  figured it would still be an improvement to show the real error.

  If you just meant that it should go in a separate patch because it's
  not a die->die_errno change, I can do that, it just feels like
  overkill because it is morally the same change, but in a case where
  I cannot apply the die_errno shortcut.


Thomas Rast (3):
  Introduce die_errno() that appends strerror(errno) to die()
  Convert existing die(..., strerror(errno)) to die_errno()
  Use die_errno() instead of die() when checking syscalls

 abspath.c                |   12 ++++++------
 bisect.c                 |    5 ++---
 branch.c                 |    4 ++--
 builtin-add.c            |    2 +-
 builtin-apply.c          |   12 ++++++------
 builtin-archive.c        |    4 ++--
 builtin-blame.c          |   15 +++++++--------
 builtin-clone.c          |   21 ++++++++++-----------
 builtin-commit-tree.c    |    2 +-
 builtin-commit.c         |   28 +++++++++++++---------------
 builtin-config.c         |    4 ++--
 builtin-diff.c           |    2 +-
 builtin-fast-export.c    |    4 ++--
 builtin-fetch--tool.c    |    2 +-
 builtin-fmt-merge-msg.c  |    5 ++---
 builtin-fsck.c           |   10 +++++-----
 builtin-grep.c           |    2 +-
 builtin-init-db.c        |   21 +++++++++++----------
 builtin-log.c            |    4 ++--
 builtin-mailsplit.c      |    6 +++---
 builtin-merge.c          |   29 ++++++++++++++++-------------
 builtin-mv.c             |    2 +-
 builtin-pack-objects.c   |   14 +++++---------
 builtin-rev-parse.c      |    2 +-
 builtin-revert.c         |    2 +-
 builtin-rm.c             |    2 +-
 builtin-send-pack.c      |    2 +-
 builtin-stripspace.c     |    2 +-
 builtin-tag.c            |    9 ++++-----
 builtin-tar-tree.c       |    2 +-
 builtin-unpack-objects.c |    2 +-
 combine-diff.c           |    2 +-
 csum-file.c              |    5 ++---
 daemon.c                 |   15 +++++++--------
 diff.c                   |   10 +++++-----
 dir.c                    |    2 +-
 entry.c                  |   10 +++++-----
 fast-import.c            |    8 ++++----
 git-compat-util.h        |    1 +
 git.c                    |    6 +++---
 hash-object.c            |    2 +-
 index-pack.c             |   21 ++++++++++-----------
 ll-merge.c               |    2 +-
 merge-recursive.c        |    6 +++---
 mktag.c                  |    2 +-
 pack-refs.c              |    7 +++----
 pack-write.c             |   10 +++++-----
 pkt-line.c               |    4 ++--
 read-cache.c             |    8 ++++----
 refs.c                   |    2 +-
 run-command.c            |    4 ++--
 setup.c                  |   18 +++++++++---------
 sha1_file.c              |    2 +-
 shell.c                  |    2 +-
 test-sha1.c              |    2 +-
 transport.c              |    4 ++--
 unpack-file.c            |    2 +-
 usage.c                  |   12 ++++++++++++
 wrapper.c                |    8 ++++----
 write_or_die.c           |    6 +++---
 60 files changed, 209 insertions(+), 207 deletions(-)
