From: Michael Nahas <mike.nahas@gmail.com>
Subject: File Systems and a Theory of Edits
Date: Sat, 30 Jul 2011 10:29:36 -0400
Message-ID: <CADo4Y9hG=-Bye5g7OWROJNbbUOcnH0hj0f3csws5V+YzEUKAMg@mail.gmail.com>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 16:29:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnAXw-0006Oq-Bh
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 16:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024Ab1G3O3j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jul 2011 10:29:39 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59235 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab1G3O3h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2011 10:29:37 -0400
Received: by ewy4 with SMTP id 4so2372939ewy.19
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 07:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=ax6YmXCf0Jegj3YfzQo0iCU833x2CFj9O4DT6ev0O08=;
        b=PXvdOOnxHhx/Tj8zIc4sqJ68LjBp/ZgH2HnT8cRboaR4i1gl/kE7eDTEdkUWfIHl6m
         +ZP1GpNa5JUdBfbnL7LFmemZysHmUNtENNb4/PklNHr3FweHl3P108+Dy2J+DbOaJo/x
         Qefs54b3GtVTiRL0Yuy6kyvhNHP68N0J0o8nc=
Received: by 10.14.10.83 with SMTP id 59mr942424eeu.154.1312036176158; Sat, 30
 Jul 2011 07:29:36 -0700 (PDT)
Received: by 10.14.53.3 with HTTP; Sat, 30 Jul 2011 07:29:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178200>

I've spent a month thinking about the design of git.=A0 This is the
result of that work.


My understand of git is that, at the lower level, it stores and
communicates snapshots of a file system.=A0 At the upper level, git
manipulates "edit"s: the change between two snapshots.

I'm proposing:
=A0=A0=A0 1) Creating git commands that mimic Unix's file system comman=
ds
=A0=A0=A0=A0=A0=A0 and operate on those snapshots.
=A0=A0=A0 2) A language for describing git's manipulations of edits
=A0=A0=A0 3) Creating aliases that will allow the working tree and stat=
e
=A0=A0=A0=A0=A0=A0 stored in the index to be treated like file systems


I want to thank Jeff King ("Peff") for being my sounding board for the
theory of edits.

1) Snapshots
2) A Theory of Edits
3) File Systems
3.1) Merge Conflict
4) Conclusion


1) Snapshots

Commits consist of:
=A0=A0=A0 1) A snapshot of the file system
=A0=A0=A0 2) Some meta-information
=A0=A0=A0 3) link(s) to past commit(s)

I'm only concerned about #1 here.

The way to make something both easy to learn and easy to remember is
to imitate something the user is already familiar with.=A0 Thus my
proposal is:


PROPOSAL 1: git should imitate the Unix file system commands for
accessing the snapshot of a commit.

=46or these commands to work, the git command will have to include an
argument that specifies which commit it operates on.=A0 So some basic
ones might be:
=A0=A0=A0 "git ls <commit> -- <path>"
=A0=A0=A0 "git cat <commit> -- <path>"
(There exists "git ls-files", "git ls-tree", and "git cat-file" but
they are not quite the same.)
=A0=A0=A0 "git find <commit> -- ..."
=A0=A0=A0 "git grep <commit> -- <path>" (Exists)
The Unix command "diff" compares two files/directories.=A0 So, the "git=
"
version requires two commits to be specified.
=A0=A0=A0 "git diff <commit> <commit> -- <path>"=A0=A0 (Exists)
I'd love to see something to apply a command to every file in a commit
or every file found by "git find".
=A0=A0=A0 "git xargs <commit> ..."=A0 (Is this possible?)
Since snapshots are a read-only version of a file system, git can't
implement the commands "rm", "mv", or "cp".


2) A Theory of Edits

Snapshots in the object store are easy to understand.=A0 But to go
further, we need to be able to look at the index file and the working
tree.=A0 During a merge conflict, the index file and working tree go
into an unusual state.=A0 To understand that state, I spent a month
coming up with a mathematical theory to describe what git does.

Git, at the upper level, manipulates edits.=A0 An "edit" here is a very
specific term.=A0 It is the changes between two specific snapshots.=A0 =
I'm
going to introduce some notation: if two snapshots are A and B, then
the edit is written A:B.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
WARNING: Great boredom ahead.=A0 Mathematicians and theoriticians:
enjoy!=A0 Everyone else: read as much as you can and when you start to
fall asleep, skip to the next subsection.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Edits have mathematical properties.=A0 It's easy to see that B:A is the
"inverse edit" of A:B.=A0 The edit A:A is the "empty edit" for snapshot
A.=A0 An edit A:B can be "split" using a snapshot C to make edits
A:C and C:B or, written another way, A:C:B.=A0 Likewise, edits A:B and
B:C can be "joined" to form A:C.

=A0=A0=A0 * The inverse edit is generated by "git revert".
=A0=A0=A0 * The empty edit can be written by "git commit --allow-empty"=
=2E
=A0=A0=A0 * Splitting an edit will be demonstrated later using "git add=
".
=A0=A0=A0 * Joining an edit is done "git commit --amend"

An edit has a specific start and end snapshot.=A0 If you want to do a
similar change with a different starting snapshot, you need to
"patch"; patch() is a function that takes an edit and a new starting
state and returns the ending snapshot of a new edit.=A0 So, patch(A:B,
C) may return D, where C:D is a new edit containing a change similar
to A:B.=A0 I say "may return" because a patch starting at snapshot C
might not exist.=A0 For example, if the edit A:B moves file "foo.txt" t=
o
"bar.txt" and snapshot C does not have a file "foo.txt" nor "bar.txt",
then the patch cannot exist.=A0 [Note, there can be many definitions of
a patch() function. I'm not picking one; I'm just saying one exists.]

=A0=A0=A0 * patch() is most easily seen in "git cherry-pick"

The last definition concerns reordering edits A:B and B:C.=A0 The edits
are reorderable if a patch of B:C can put in front of a patch for A:B
and the resulting edit still ends up at the same final snapshot
C. Formally, A:B:C is "reorderable" if there exists A:D:C such that
patch(B:C, A) =3D D and patch(A:B, D) =3D C.

=A0=A0=A0 "git rebase --interactive" can reorder (and do anything else!=
)


PROPOSAL 2: adopt a term like edit and rigorous terms
like split, join, and reorder to describe the operations of git
commands.
We should also use exacting vocabulary to describe git commands.=A0 It'=
s
not unusual to use the word "commit" when referring to:
=A0=A0=A0 * a snapshot=A0 (stored in the commit's tree object)
=A0=A0=A0 * an edit=A0=A0 (the difference between this commit's snapsho=
t and its
=A0=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0 parent's (if it has =
only one parent...))
=A0=A0=A0 * a complete history of edits going back to the initial snaps=
hot
=A0=A0=A0 * the commit object itself (e.g., when tagged)
While often the appropriate definition can be picked up from context,
we should be precise if possible.
It would be good to define a term like "snapshot tree" that refers to
a tree object that is the root of a snapshot, to differentiate it from
other tree objects that store subdirectories.


3) File Systems : There exist snapshots outside the object store!

This statement may surprise you: The current state of the working tree
is a snapshot.=A0 The working tree is a file system so its state at any
one point, is a snapshot of a file system.=A0 For brevity, I'm going to
call that snapshot WTREE.=A0 We can talk about the edit between any
other snapshot (like ones stored in a commit) and WTREE.=A0 Usually,
we'll talk about the edit from HEAD to WTREE.

If the edit from HEAD to WTREE contains more than one feature and we
want to package each feature into its own edit, we need to split the
HEAD to WTREE edit.=A0 And, to split an edit, we need another
snapshot...

Another surprising statement: A snapshot can be computed from the
index file and HEAD (when not in merge-conflict state).=A0 My validatio=
n
for this statement is that at any point, we can type "commit
--allow-empty" and a new commit will be written to the current branch.
That commit contains a snapshot generated from the index file and
HEAD.=A0 Since the snapshot computed from the index file and HEAD will
become the next commit written, I'll refer to it as NEXT.

I want to be clear that NEXT is not the index file.=A0 NEXT is a
snapshot.=A0 The index file is a file.=A0 The index file (with HEAD) is
just one way to store a snapshot.=A0 Since we can modify the files that
will go in the next commit, NEXT is actually a file system like WTREE.
Although the man page for "git add" says it "add[s] file contents to
the index", I think a better way to say it is that it copies the files
into the NEXT file system.

To recap: a common operation in git is to split the HEAD to WTREE edit
by "git add"ing files to the NEXT file system and then using "git
commit" to write a snapshot of NEXT into the object store, making the
edit permanent.=A0 (You may want to reread that sentence a few times
until it becomes clear.)

Now, the concepts of WTREE and NEXT work most of the time.=A0 However,
when there is a merge conflict, the index file takes on a special
state.=A0 This is why I developed a theory around edits: I need it to
describe what happens then and why.


4) Merge Conflict

I'm going to use "git cherry-pick" for my example.=A0 It involves
merging a single edit, so it's the easiest case.

A cherry-pick is almost a direct application of patch().=A0 We have an
edit A:B and we want to move it onto snapshot C.=A0 But we said earlier=
,
the result of a patch() function may or may not exist.

If patch(A:B, C) exists and equals D, then git just writes the
snapshot D as the new commit.

But what if patch(A:B, C) does not exist?=A0 Git does something amazing=
:
it splits A:B!=A0 So, we'll introduce a new state S to get A:S:B.=A0 No=
w,
the first edit, A:S, contains all the parts of A:B that can be
patch()ed onto state C, and the second edit, S:B, contains all the
parts of A:B that cannot be patch()ed onto state C.=A0 Obviously,
patch(A:S, C) exists and the resulting snapshot is copied into NEXT.

But what happens to the unpatchable part in edit S:B?=A0 We don't want
this change thrown away - it could be important.=A0 We want it presente=
d
to the user and let the user fix or dismiss it.=A0 If we had a GUI, the
window's border might turn red and tabs for each affected file might
open, but a command-line interface doesn't have that.=A0 So, git writes
something reflecting the unpatachable part into files in the working
tree and marks the files as "needs review" in the index file.=A0 (It
also caches some files SHAs in the index, but we can ignore that.)

Now that we know what happens during a conflicted merge, the question
is: do there exist any snapshots here?=A0 We defined NEXT using the
snapshot that would go in the next commit.=A0 But if you run "git commi=
t
--allow-empty" during a merge conflict, you get an error!=A0 We said th=
e
current working tree state was a snapshot, but git just wrote
"<<<<""=3D=3D=3D=3D"">>>>" into the files - if they did obey any syntax=
 before
that, they certainly don't now!

The answer is unclear.=A0 My opinion is that there's little harm in
viewing the result of patch(A:S,C) as NEXT.=A0 (This would be "the
snapshot generated using stage 0 of the index file" to some.)=A0 I also
think that, during a merge conflict, the working tree is in an
unsyntactic, unnatural state.=A0 While I think there is value to always
treating the working tree as a file system, I can understand with
those who might argue that git should treat it differently during a
merge conflict.


PROPOSAL 3: Add aliases NEXT and WTREE that work in place of a
snapshot in any commands.
=A0=A0=A0 =A0e.g., "git diff HEAD NEXT"
=A0=A0=A0 =A0e.g., "git ls NEXT etc/"
During a conflicted merge state, we _may_ want commands to treat WTREE
differently.

ADDITION TO PROPOSAL 2: Since NEXT and WTREE are writeable file
systems, the Unix filesystem commands that write should be implemented
as part of git to work with them.
=A0=A0=A0 "git cp <snapshot> <writeable_filesys> -- <src_path> <dest_fi=
le>"
=A0=A0=A0 "git mv <snapshot> <writeable_filesys> -- <src_path> <dest_fi=
le>"
=A0=A0=A0 "git rm <writeable_filesys> -- <file>"
I believe "git cp" would be similar to the proposed "git put".  The cur=
rent
"git mv" and "git rm" does operation on both NEXT and WTREE by default.
(Which I think is a sensible default in those cases.)
We may want to consider "mkdir", "rmdir", "chmod".


4) Conclusion

I've proposed that git give snapshots the same interface that a Unix
command line would provide to a read-only file system.

I've presented a mathematical language for defining edits and
proposed using it and clearer words for describing git command's
operations.

I've proposed creating the aliases WTREE and NEXT and allowing them to
be used anywhere a snapshot is used and in Unix commands that operate
on a writeable filesystem.


Mike Nahas




Appendix: Features and Edits

I said above "If the edit from HEAD to WTREE contains more than one
feature and we want to package each feature into its own edit, ...".
I believe this concept of one-feature=3Done-edit is at the heart of goo=
d
git usage.=A0 We want to manipulate features - add a feature to a
branch, remove a feature, etc. - but we can only manipulate edits.
So, as long as each feature is in its own edit, we can easily manipulat=
e
it.

Unfortunately, features and edits are not the same.=A0 We can merge two
edits, but that doesn't mean the result has both features.=A0 For
example, consider a project that branches and one branch's feature is
a new Makefile target and the edit explicitly lists the source files.
The other branch's feature is support for a new protocol and that edit
adds a new source file.=A0 The merge of these two branches may succeed
and contain both edits, but it doesn't have both features.

The git glossary calls a merge "evil" if the commit contains a change
that is not present in either parent.=A0 I say that's a bad
definition.=A0 In the example above, I think it's a good thing to edit
the merge so that the commit contains both features.

This is why I think this theory of edits has value:=A0we want to
manipulate features and if we have one-feature=3Done-edit and we know
how to manipulate edits, then we can manipulate features.=A0 I don't
think it is a new concept; I think it has been implied any number of
places; I just hope with clear terms to describe manipulation of edits
like split/join/inverse/patch/reorder that we have clearer description
of what we do.
