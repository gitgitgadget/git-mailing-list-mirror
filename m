From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v5 00/11] several notes refs, post-rewrite, notes rewriting
Date: Tue, 23 Feb 2010 01:42:18 +0100
Message-ID: <cover.1266885599.git.trast@student.ethz.ch>
References: <cover.1266703765.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 01:42:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjirG-0002Uq-Lb
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 01:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493Ab0BWAmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 19:42:32 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:31799 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422Ab0BWAmc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 19:42:32 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 01:42:29 +0100
Received: from localhost.localdomain (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 01:42:30 +0100
X-Mailer: git-send-email 1.7.0.218.g73a398
In-Reply-To: <cover.1266703765.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140745>

On Tuesday 23 February 2010 00:20:06 Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> > diff --git a/notes.c b/notes.c
[...]
> > +struct string_list display_notes_refs;
> > +struct notes_tree **display_notes_trees;
> 
> Do these need to be extern?

Don't think so?  After all it's in the .c and just another static
variable.

> Nice use of strbuf_split().  I wonder if we should automatically add
> "refs/" and/or "refs/notes/" when the input is missing the prefix.  I
> don't have strong preference myself but the users might make noises.
> 
> Either way it needs to be documented in the final version before the
> series goes to 'master'.

I decided to do such dwimmery only on the command line, but not for
the config.  This is consistent with what's currently happening for
core.notesRef.  I also documented this.

> > +static int notes_display_config(const char *k, const char *v, void *cb)
> > +{
> > +	/* Warning!  This is currently not executed if
> > +	 * GIT_NOTES_DISPLAY_REF is set.  Move the git_config() call
> > +	 * outside the test if you add more options. */
> 
> Yuck.  If you know what needs to be done, do that before other poeple add
> more options, please.

*shrug*

I was trying to be smart and save a call to git_config() when we know
we don't care about the config anyway.  After all it does read a bunch
of files.

> >> > +	if (flags & NOTES_SHOW_HEADER_WITH_REF && t->ref) {
[...]
> >> > +	} else if (flags & (NOTES_SHOW_HEADER|NOTES_SHOW_HEADER_WITH_REF))
> >> >  		strbuf_addstr(sb, "\nNotes:\n");
> 
> Meaning nobody will go through the latter "Notes:\n" codepath?  Then what
> is that else clause for?
> 
> Perhaps I am not reading your code right in which case this part needs a
> bit more commenting?

The catch is in the '&& t->ref'.  Again I'm just trying to be a bit
defensive.  Anyway, I ripped out the old formatting and put the NULL
test first this time.

> >> I expected to see "Notes:\n" regardless of the mode if the notes is coming
> >> from the default refs/notes/commits tree, but it probably is better to say
> >> "Notes (commits):\n" like your patch does.
> >
> > I special-cased GIT_NOTES_DEFAULT_REF (which is "refs/notes/commits")
> > above *at your request* to not change the output in the default case.
> 
> > So which way do you want it?
> 
> I don't have strong preference anymore with the above code.
[...]
> But if everybody calls with HEADER_WITH_REF, no matter what the end user
> preference is, then it becomes unclear what the right answer would be.

Well, I think we're into bikeshedding territory now, so I just left it
as it was.


The rest of the changes are listed in each email.


Thomas Rast (11):
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

 Documentation/config.txt         |   53 +++++-
 Documentation/git-notes.txt      |   21 ++-
 Documentation/githooks.txt       |   38 ++++
 Documentation/pretty-options.txt |   11 +-
 builtin-commit.c                 |   45 +++++
 builtin-log.c                    |    2 +
 builtin-notes.c                  |  195 +++++++++++++++++++-
 builtin.h                        |   18 ++
 cache.h                          |    3 +
 git-am.sh                        |   13 ++
 git-rebase--interactive.sh       |   52 +++++-
 git-rebase.sh                    |    6 +
 notes.c                          |  191 +++++++++++++++++++-
 notes.h                          |   27 +++
 pretty.c                         |    6 +-
 refs.c                           |    4 +-
 refs.h                           |    5 +
 revision.c                       |   21 ++
 revision.h                       |    5 +
 t/t3301-notes.sh                 |  377 +++++++++++++++++++++++++++++++++++++-
 t/t3400-rebase.sh                |   17 ++
 t/t3404-rebase-interactive.sh    |   24 +++
 t/t5407-post-rewrite-hook.sh     |  172 +++++++++++++++++
 t/t7501-commit.sh                |   12 ++
 t/test-lib.sh                    |    4 +
 25 files changed, 1294 insertions(+), 28 deletions(-)
 create mode 100755 t/t5407-post-rewrite-hook.sh
