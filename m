From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 00/30] git notes
Date: Sat, 13 Feb 2010 22:28:08 +0100
Message-ID: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:29:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPYH-00018f-Fa
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758046Ab0BMV2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:28:55 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62065 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757717Ab0BMV2y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:28:54 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00FIIUC55490@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:28:53 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:28:52 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211545
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139836>

Hi,

Here is the 13th iteration of the git-notes series. Changes in this
iteration are as follows:

- Patch #1 has improved its commit message

- Patch #7 (the get_note() API function) improved its header file docs.

- Patch #12 (Builtin-ify git-notes) received code to add some details of the
  current object (the object whose notes are currently being edited)to the
  template text displayed in the editor. Similar details were originally
  present in git-notes.sh, but was lost in the initial builtin-ification.

- Patch #22 (the 'list' subcommand) has learned to fail (instead of segfault)
  when asked to list notes for an object that has none.

- Patch #23 has been inserted to provide --message/--file aliases to the -m/-F
  options. This improves consistency with other git commands.

- Patch #24 (was #23) has been redone to provide the "git notes add" semantics
  suggested by Junio in the discussion following the previous iteration.

- Patch #25 introduces the "git notes append" subcommand which takes on the
  semantics of "git notes add" from the previous iteration.

- Patch #26 deprecates the -m/-F options for "git notes edit", since their
  semantics now overlap with "git notes add -f", and the behaviour is more
  intuitively captured and better documented with "git notes add -f"

- Patch #27 refactors some code in builtin-notes, to allow mixing -m and -F
  options again. This was originally allowed in git-notes.sh, but was
  disabled by the builin-ification. The refactoring also helps with clear
  the way for the next patch...

- Patch #28 introduces the -c/-C options to "git notes add/append". This
  allows re-use of existing notes object when making new note.
  The option names and semantics were inspired by "git commit".

- Patch #29 refactors the argc and exit value handling of builtin-notes, in
  preparation for the next patch

- Patch #30 introduces the "git notes copy" subcommand for copying notes from
  one object to another. This will come in handy when we want to bring notes
  across a commit rewrite (such as rebase/cherry-pick/amend).


There are ongoing discussions on how to further develop and integrate the
notes feature. I try to summarize ideas below, although I don't plan to
put any more stuff into _this_ patch series:

- Better integration with rebase/amend/cherry-pick. Optionally bring
  notes across a commit rewrite. Controlled by command-line options
  and/or config variables. Junio says:
    I used to fix minor issues (styles, decl-after-stmt, etc.) using
    rebase-i long after running "am" in bulk, but these days I find
    myself going back to my "inbox" and fix them in MUA; this is
    only because I know these notes do not propagate across rebases
    and amends -- adjusting the workflow to the tool's limitation is
    not very good.

- Using multiple notes refs simultaneously. Junio says:
    The interface to tell tools to use which notes ref to use should be
    able to say "these refs", not just "this ref" i.e. GIT_NOTES_REF=a:b
    just like PATH=a:b:c...); I am fairly certain that we would want to
    store different kind of information in separate notes trees and
    aggregate them, as we gain experience with notes.
  When showing notes from multiple refs, we should also show from _which_
  note ref a given note originates.
  Of course, when _writing_ notes, only one ref should receive the created
  notes.

- Adding command-line options for specifying notes refs. Junio says:
    There should be an interface to tell tools to use which notes refs via
    command line options; "!alias" does not TAB-complete, and "git lgm"
    above doesn't, either. "git log --notes=notes/amlog --notes=notes/other"
    would probably be the way to go.
  Jakub suggests adding a --notes-ref="a:b:..." option, either to the git
  wrapper, or to all git subcommands that can do stuff with notes.
  Junio adds that the --notes-refs option should DWIM the given ref name
  (i.e. "foo" -> "refs/notes/foo").

- Add a "git notes grep" subcommand: Junio says:
    While reviewing the "inbox", I sometimes wonder if I applied a message
    to somewhere already, but there is no obvious way to grep in the notes
    tree and get the object name that a note is attached to.  Of course I
    know I can "git grep -c johan@herland.net notes/amlog" and it will give
    me something like:

      notes/amlog:65807ee697a28cb30b8ad38ebb8b84cebd3f255d:1
      notes/amlog:c789176020d6a008821e01af8b65f28abc138d4b:1

    but this won't scale and needs scripting to mechanize, once we start
    rebalancing the notes tree with different fan-outs.  The end user (me
    in this case) is interested in "set of objects that match this grep
    criteria", not "the pathnames the notes tree's implementation happens
    to use to store notes for them in the hierarchy".

- Add support for "^{notes}" (or "^@{}") to the rev-parse machinery, so
  that notes can be returned from e.g. "git cat-file --batch". This is
  somewhat complicated when combined with using multiple notes ref
  simultaneously (see above), but can be solved by using (Jakub's
  suggestions:) "^{notes:<namespace>}" (or "^@{<namespace>}").

- Merging notes trees. Junio suspects that we need a specialized merge
  strategy for notes trees. One example of such a strategy is to
  auto-concatenate conflicting notes, instead of forcing the user to
  edit away conflict markers. Note that such a solution should be fairly
  easy to implement on top of the current notes API, by loading both
  notes trees into the same struct notes_tree, while using combine_notes
  == combine_notes_concatenate().

- Matthieu Moy and Sverre Rabbelier suggests to add notes support to
  format-patch: Notes stored in e.g. the "refs/notes/format-patch" ref
  are added to the "comments section" (i.e. following the '---' separator)
  of generated patches. There is also some discussion on whether notes
  should be added as custom headers to the email generated by format-patch.

- Special handling of notes on fetch? Tags are autofollowed; does it make
  sense to do something similar for notes? Guiseppe notes:
    Tags have the idiosincracy of living in the same namespace regardless
    of where they come from, and I believe there a little too high a risk
    of conflicts to do this with notes too. It might make sense to add a
    default fetch of +refs/notes/*:refs/notes/remotes/<remote>/*, but the
    real question is what would pushing do, in case of conflicting notes.

- Note objects that are trees (instead of blobs). Peff originally proposed
  the idea of storing multiple notes for one object in a single notes ref
  by having the note object itself be a tree which contained note blobs
  (with well-defined names). Jon Seymour wanted to expand this idea to
  allow _arbitrary_ tree structures to be stored as notes. However, this
  will cause problems when trying to interpret notes in a consistent
  manner (i.e. how would "git log" display a tree of notes attached to a
  single commit). Problems may also arise when optimizing the notes tree
  structure itself. Peff instead suggests to add another level of
  indirection, and store the tree _SHA1_ in the note (instead of the tree
  object itself), and then teach a few tools (git-fsck, git-metadata?) to
  dereference the SHA1 when needed.

(- Rewrite fast-import notes code to use new notes API with support for
   non-notes.)


Have fun! :)

...Johan


Johan Herland (30):
  Minor cosmetic fixes to notes.c
  Notes API: get_commit_notes() -> format_note() + remove the commit restriction
  Add tests for checking correct handling of $GIT_NOTES_REF and core.notesRef
  Notes API: init_notes(): Initialize the notes tree from the given notes ref
  Notes API: add_note(): Add note objects to the internal notes tree structure
  Notes API: remove_note(): Remove note objects from the notes tree structure
  Notes API: get_note(): Return the note annotating the given object
  Notes API: for_each_note(): Traverse the entire notes tree with a callback
  Notes API: write_notes_tree(): Store the notes tree in the database
  Notes API: Allow multiple concurrent notes trees with new struct notes_tree
  Refactor notes concatenation into a flexible interface for combining notes
  Builtin-ify git-notes
  t3301: Verify successful annotation of non-commits
  t3305: Verify that adding many notes with git-notes triggers increased fanout
  Teach notes code to properly preserve non-notes in the notes tree
  Teach builtin-notes to remove empty notes
  builtin-notes: Add "remove" subcommand for removing existing notes
  t3305: Verify that removing notes triggers automatic fanout consolidation
  Notes API: prune_notes(): Prune notes that belong to non-existing objects
  builtin-notes: Add "prune" subcommand for removing notes for missing objects
  Documentation: Generalize git-notes docs to 'objects' instead of 'commits'
  builtin-notes: Add "list" subcommand for listing note objects
  builtin-notes: Add --message/--file aliases for -m/-F options
  builtin-notes: Add "add" subcommand for adding notes to objects
  builtin-notes: Add "append" subcommand for appending to note objects
  builtin-notes: Deprecate the -m/-F options for "git notes edit"
  builtin-notes: Refactor handling of -F option to allow combining -m and -F
  builtin-notes: Add -c/-C options for reusing notes
  builtin-notes: Misc. refactoring of argc and exit value handling
  builtin-notes: Add "copy" subcommand for copying notes between objects

 Documentation/git-notes.txt                   |   91 +++-
 Makefile                                      |    2 +-
 builtin-notes.c                               |  459 ++++++++++++++
 builtin.h                                     |    3 +
 git-notes.sh => contrib/examples/git-notes.sh |    0
 git.c                                         |    1 +
 notes.c                                       |  843 +++++++++++++++++++++----
 notes.h                                       |  196 ++++++-
 pretty.c                                      |    9 +-
 t/t3301-notes.sh                              |  510 ++++++++++++++-
 t/t3303-notes-subtrees.sh                     |   28 +-
 t/t3304-notes-mixed.sh                        |   36 +-
 t/t3305-notes-fanout.sh                       |   95 +++
 t/t3306-notes-prune.sh                        |   94 +++
 14 files changed, 2171 insertions(+), 196 deletions(-)
 create mode 100644 builtin-notes.c
 rename git-notes.sh => contrib/examples/git-notes.sh (100%)
 create mode 100755 t/t3305-notes-fanout.sh
 create mode 100755 t/t3306-notes-prune.sh
