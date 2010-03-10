From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v6 00/13] several notes refs, post-rewrite, notes rewriting
Date: Wed, 10 Mar 2010 15:03:35 +0100
Message-ID: <cover.1268229087.git.trast@student.ethz.ch>
References: <7vd3zurmoa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 10 15:04:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpMWK-0003iT-Ki
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 15:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335Ab0CJOEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 09:04:15 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:7878 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932198Ab0CJOEO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 09:04:14 -0500
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 10 Mar
 2010 15:04:11 +0100
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 10 Mar
 2010 15:03:50 +0100
X-Mailer: git-send-email 1.7.0.2.407.g21ebda
In-Reply-To: <7vd3zurmoa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141889>

Hi all,

Here's (finally) the reroll.  Sorry for the long wait, I was been
swamped at work up until yesterday :-(

I hope I collected all changes that Junio requested; of note are

* the new interface in notes.h actually comes with comments,

* doc update to git-notes(1) in the patch that introduces
  notes.displayRef

I'm not aware of comments by anyone else, so if I missed them please
point them out.

I did some other tweaks, including the new patch 12 that in particular
avoids creating any new commits for notes refs that exist but did not
have anything copied, if you have copying enabled.


On Thursday 25 February 2010 04:58:45 Junio C Hamano wrote:
>  - The log messages are mostly useless.  The scripted implementation said
>    "Annotate 6d8094a8aa32c30ff39c6b8609acb8d057ccb5e5" which was not the
>    most informative, but the new one says "Notes added by 'git notes add'".

I hesitated making it "more informative" in the direction of "Annotate
$sha1" because the same answer can be found with a simple 'git log
--stat'.  So I consider the "Notes added by '<command>'" to actually
be more useful since it conveys something that is not readily
available.

That being said, I think

>  - "git notes add" already uses -m option to take the text used as note
>    (i.e. payload of the commit); the user may need a way to affect the
>    commit log message to record why the note is added (or modified).

is a good idea, even if only to let people write down which
note-adding script recorded this note.


>  - "git notes add" and friends honor GIT_COMMITER_* and GIT_AUTHOR_* as
>    usual.  Since I use post-applypatch hook to record the message-id from
>    "git am", I ended up getting my notes written by original submitters.
[...]
>  - As to the determination of committer/author identity, I think what the
>    code currently does (i.e. honor the environment and user.* config) is
>    perfectly sane, but at the same time I think it would be surprising for
>    unsuspecting users.  We may want to advise users about this in the
>    documentation.

I added a small patch that writes this and the history recording down
in git-notes(1).  However, I'm hesitating to directly say "and this
will bite you if you use it in post-applypatch"; isn't the latter an
implementation detail of git-am?



Thomas Rast (13):
  test-lib: unset GIT_NOTES_REF to stop it from influencing tests
  Support showing notes from more than one notes tree
  Documentation: document post-rewrite hook
  commit --amend: invoke post-rewrite hook
  rebase: invoke post-rewrite hook
  rebase -i: invoke post-rewrite hook
  notes: implement 'git notes copy --stdin'
  notes: implement helpers needed for note copying during rewrite
  rebase: support automatic notes copying
  commit --amend: copy notes to the new commit
  notes: add shorthand --ref to override GIT_NOTES_REF
  notes: track whether notes_trees were changed at all
  git-notes(1): add a section about the meaning of history

 Documentation/config.txt         |   53 +++++-
 Documentation/git-notes.txt      |   46 ++++-
 Documentation/githooks.txt       |   38 ++++
 Documentation/pretty-options.txt |   11 +-
 builtin.h                        |   18 ++
 builtin/commit.c                 |   45 +++++
 builtin/log.c                    |    2 +
 builtin/notes.c                  |  197 ++++++++++++++++++++-
 cache.h                          |    3 +
 git-am.sh                        |   13 ++
 git-rebase--interactive.sh       |   52 +++++-
 git-rebase.sh                    |    6 +
 notes.c                          |  195 +++++++++++++++++++-
 notes.h                          |   67 +++++++
 pretty.c                         |    6 +-
 refs.c                           |    4 +-
 refs.h                           |    5 +
 revision.c                       |   21 ++
 revision.h                       |    5 +
 t/t3301-notes.sh                 |  377 +++++++++++++++++++++++++++++++++++++-
 t/t3400-rebase.sh                |   17 ++
 t/t3404-rebase-interactive.sh    |   24 +++
 t/t5407-post-rewrite-hook.sh     |  183 ++++++++++++++++++
 t/t7501-commit.sh                |   12 ++
 t/test-lib.sh                    |    4 +
 25 files changed, 1371 insertions(+), 33 deletions(-)
 create mode 100755 t/t5407-post-rewrite-hook.sh
