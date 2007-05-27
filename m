From: Johan Herland <johan@herland.net>
Subject: [PATCH 00/15] git-note: A mechanisim for providing free-form
 after-the-fact annotations on commits
Date: Sun, 27 May 2007 16:08:01 +0200
Message-ID: <200705271608.02122.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <200705102006.08624.johan@herland.net>
 <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 16:08:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsJPv-0006N1-LB
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbXE0OIL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 10:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752804AbXE0OIL
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:08:11 -0400
Received: from smtp.getmail.no ([84.208.20.33]:45501 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752367AbXE0OIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 10:08:09 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIP00N03DXJ2P00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:08:07 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP004Q2DXE9OC0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:08:02 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP000X3DXEJB40@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:08:02 +0200 (CEST)
In-reply-to: <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48540>

On Thursday 10 May 2007, Linus Torvalds wrote:
> On Thu, 10 May 2007, Johan Herland wrote:
> > 
> > BTW, I'm wondering whether anybody has ever thought about allowing 
> > after-the-fact annotations on commits. Kinda like free-form 
> > continuations on the commit message. It would allow people to make 
> > notes on previous commits that were either forgotten at commit-time, or 
> > only became apparent after the commit was done.
> 
> We kind of have some of that.
> 
> Tag objects can be used that way, and the "grafts" file is a very special 
> case. 
> 
> But if you want to do it on a larger scale, you'd need something that is 
> really optimized for that. For example, git internally now has a notion of 
> "decorating" arbitrary objects with arbitrary data, and if you just had an 
> efficient file format to create such decorations (for blame or other 
> special ops), the *code* is easy to write. It's how
> 
> 	git log --decorate
> 
> works right now (the "data" is just the tag names, but you could make it 
> read other decorations, and the git data structures are very efficient, 
> and allow different types of decorations to be used independently of 
> each other).

I've been working on combining tag objects and --decorate into a useful
proof-of-concept that provides the after-the-fact commit annotations I
requested above, and here's the result:

<quote src="Documentation/git-note.txt">
A git note provides an after-the-fact text annotation associated with an
exiting object in the git object database. The note itself is also stored
in the database (as a special case of a tag object). Note object are therefore
-- as all other objects in the database -- immutable, i.e. once added they
cannot be edited, although they can be deleted.

As with regular tag objects, notes are useless unless they have a
corresponding reference stored in `.git/refs`. For notes, these references
are stored in a hierarchy under `.git/refs/notes`. For each object that has
one or more associated notes, there is a subdirectory under
`.git/refs/notes` named after the object identifier (SHA1 sum). The
object's subdirectory contains one file per note associated with that object.
The end result is that notes are easily accessible from the name/identifier
of the object they are associated with.

Note that deleting a note with `git-note -d` only deletes the reference to
the note. The note itself is still present in the object database, but will
be considered unreachable by gitlink:git-fsck[1], and may be removed with
gitlink:git-prune[1].
</quote>


Here are some more details from the design notes I based my work on:

- Notes must not run counter to the existing design (and design goals) of git

- A note is itself stored as a git tag object:
	- "object" has SHA1 of this note's object (as with regular tag objects)
	- "type" has type of this note's object (as with regular tag objects)
	- "tag" is fundamentally unimportant to the note. However, in order
	  to provide a unique tag name (so as not to be confused with any
	  other tag object) this is automatically set to "note-{$sha1}",
	  where {$sha1} is the SHA1 sum of the "object" and "tagger" fields
	  and the note message. If uniqueness of tag names within tag objects
	  is not important, we may consider dropping this
	- "tagger" has the note author and date (same as regular tag objects)
	- The rest of the tag object contains the note message, similar in
	  form to a commit message

- External mapping of objects to associated notes is kept below .git/refs/notes:
	- One file per note object (as with tag refs in .git/refs/tags)
	- Located at .git/refs/notes/{$object-sha1}/{$note-sha1}
	- File contains SHA1 of the note object (same as refs in .git/refs/tags)
	- Yes, this means that the filename (minus directory part) is identical
	  to the contents of the file

Some of the properties that result from the above decisions:

- A note is uniquely identified by its SHA1 sum (as are all other git objects)

- Notes are trivially packable

- The entire set of note refs can be fully recreated by trawling the object db
  for tag objects with the tag name field matching the "note-{$sha1}" pattern

- Notes behave like regular tags under clone/push/fetch

- Notes are automatically checked by fsck (although some extra checking has
  has been added)

- Little impact to existing git architecture


However, there are still some remaining questions:

- Is the creation of a unique tag name (i.e. the 'tag' field _inside_ the
  object) for note objects really necessary? Which parts of the system rely
  on these names to be unique across tag objects?

- Should notes have their own object type instead of piggy-backing on "tag"?

- What about having a note object type with minimal header fields, and make
  tags just a special case of a note object with an extra tag name header?

- What about notes on notes? How are tags on tags treated? How should they be
  treated?

- Currently noted objects (notees?) are treated as reachable from their
  associated notes, i.e. like tags. This means that an otherwise dangling
  object will not be detected and removed if it has associated notes.
  This may not be what we want. If not, the following needs to be done:
	- Notes should probably have their own object type at this point
	- An object is no longer considered reachable from the associated notes
	  This mostly affects git-fsck and git-prune, which should now be able
	  to remove dangling objects with notes


Finally, here's the shortlog of the patches that will follow this email:

Johan Herland (15):
      git-note: Add git-note command for adding/listing/deleting git notes
      git-note: (Documentation) Add git-note manual page
      git-note: (Administrivia) Add git-note to Makefile, .gitignore, etc.
      git-note: (Plumbing) Add plumbing-level support for git notes
      git-note: (Plumbing) Add support for git notes to git-rev-parse and git-show-ref
      git-note: (Documentation) Explain the new '--notes' option to git-rev-parse and git-show-ref
      git-note: (Almost plumbing) Add support for git notes to git-pack-refs and git-fsck
      git-note: (Decorations) Add note decorations to "git-{log,show,whatchanged} --decorate"
      git-note: (Documentation) Explain new behaviour of --decorate in git-{log,show,whatchanged}
      git-note: (Transfer) Teach git-clone how to clone notes
      git-note: (Transfer) Teach git-fetch to auto-follow notes
      git-note: (Transfer) Teach git-push to push notes when --all or --notes is given
      git-note: (Documentation) Explain the new --notes option to git-push
      git-note: (Tests) Add tests for git-note and associated functionality
      git-note: Add display of notes to gitk

 .gitignore                        |    3 +-
 Documentation/cmd-list.perl       |    5 +-
 Documentation/git-log.txt         |    3 +-
 Documentation/git-note.txt        |   95 ++++++++++++
 Documentation/git-push.txt        |    7 +-
 Documentation/git-rev-parse.txt   |    5 +-
 Documentation/git-show-ref.txt    |   14 +-
 Documentation/git-show.txt        |    4 +
 Documentation/git-whatchanged.txt |    4 +
 Makefile                          |    2 +-
 builtin-fetch--tool.c             |   11 ++
 builtin-fsck.c                    |   61 ++++++++
 builtin-log.c                     |  108 +++++++++++++-
 builtin-pack-refs.c               |    5 +-
 builtin-push.c                    |   20 ++-
 builtin-rev-parse.c               |    5 +
 builtin-show-ref.c                |   16 ++-
 commit.h                          |    7 +
 generate-cmdlist.sh               |    1 +
 git-clone.sh                      |    5 +-
 git-fetch.sh                      |   27 ++++
 git-note.sh                       |  227 +++++++++++++++++++++++++++
 git-parse-remote.sh               |    4 +-
 gitk                              |   38 +++++-
 log-tree.c                        |   67 ++++++++-
 refs.c                            |   20 +++
 refs.h                            |    4 +
 t/t3850-note.sh                   |  303 +++++++++++++++++++++++++++++++++++++
 28 files changed, 1033 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/git-note.txt
 create mode 100755 git-note.sh
 create mode 100755 t/t3850-note.sh


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
