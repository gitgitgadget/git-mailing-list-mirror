From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Why so much time in the kernel?
Date: Fri, 16 Jun 2006 13:44:27 -0400
Message-ID: <9e4733910606161044h736c9675kc91ff77904c5a1d0@mail.gmail.com>
References: <9e4733910606160749t4d7a541ev72a67383e96d86da@mail.gmail.com>
	 <Pine.LNX.4.64.0606160755170.5498@g5.osdl.org>
	 <9e4733910606160825hb538d6fo4c9f1d7d9768e100@mail.gmail.com>
	 <Pine.LNX.4.64.0606160906250.5498@g5.osdl.org>
	 <9e4733910606161000t53328571u10a350eca894ccdc@mail.gmail.com>
	 <1150478968.6983.7.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1040_8919023.1150479867083"
Cc: "Linus Torvalds" <torvalds@osdl.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 16 19:44:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrIN1-0004Tr-Eu
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 19:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWFPRo3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 13:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWFPRo3
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 13:44:29 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:29377 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751504AbWFPRo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 13:44:28 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1055544nze
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 10:44:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=us8QR5jnO67uOhQRLQZGQUGnepINckXMmu69rOapGRKqhvx9LP68lmLOt7pHINYYLyhGhsGZjm/4E0qiObtKfXFNSTBntZ1/qYSR/TqtinRpXICDQv6FZtomKjCWXfnB1O8ij+k8dr3j+usP8vhJcEUsNzk5kOy8Lm4/tquhSp0=
Received: by 10.36.48.8 with SMTP id v8mr19416nzv;
        Fri, 16 Jun 2006 10:44:27 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 16 Jun 2006 10:44:27 -0700 (PDT)
To: "Keith Packard" <keithp@keithp.com>
In-Reply-To: <1150478968.6983.7.camel@neko.keithp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21952>

------=_Part_1040_8919023.1150479867083
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 6/16/06, Keith Packard <keithp@keithp.com> wrote:
> On Fri, 2006-06-16 at 13:00 -0400, Jon Smirl wrote:
> > Is it a crazy idea to read the cvs files, compute an sha1 on each
> > expanded delta and then write the delta straight into a pack file? Are
> > the cvs and git delta formats the same? What about CVS's forward and
> > reverse delta use?
>
> At this point, merging blobs into packs isn't a significant part of the
> computational cost. parsecvs is spending all of its time in the
> quadratic traversal of the diff chains; fixing that to emit all of the
> versions in a single pass should speed up that part of the conversion
> process dramatically.

That's not true for the state I am in. cvsps can compute the changeset
tree in 15 minutes, cvs2svn can compute their version in a couple of
hours. cvs2svn builds a much better tree.

I've been extracting versions from cvs and adding them to git now for
2.5 days and the process still isn't finished. It is completely CPU
bound. It's just a loop of cvs co, add it to git, make tree, commit,
etc.

> >  While this is going on, track the
> > branches/changsets in memory and then finish up by writing these trees
> > into the pack file too. This should take no more ram than cvsps needs
> > currently.
>
> cvsps drops too much state on the floor making branch point and branch
> contents inaccurate. What I'm hoping is that I can figure out a way to
> discard most of the per-version information by computing tree objects in
> reverse order, saving only the tree sha1 and other per-commit info, then
> stitch the commits together using that, without needing the full
> per-file data.

I agree cvsps is dropping a lot.  My screen is full of "Skipping
#CVSPS_NO_BRANCH" and
"Skipping SpiderMonkey140_NES40Rtm_Branch" and "Skipping
SpiderMonkey140_BRANCH" etc.

What about the cvs2svn algorithm described in the attachment? A ram
based version could be faster. Compression could be acheived by
switching from using the full path to a version to the sha1 for it.

-- 
Jon Smirl
jonsmirl@gmail.com

------=_Part_1040_8919023.1150479867083
Content-Type: text/plain; name=design-notes.txt; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Attachment-Id: f_eoittl3o
Content-Disposition: attachment; filename="design-notes.txt"

                         How cvs2svn Works
                         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

A cvs2svn run consists of eight passes.  Each pass saves the data it
produces to files on disk, so that a) we don't hold huge amounts of
state in memory, and b) the conversion process is resumable.

Pass 1:
=3D=3D=3D=3D=3D=3D=3D

The goal of this pass is to write to 'cvs2svn-data.revs' a summary of
all the revisions for each RCS file.  Each revision will be
represented by one line.  At the end of this stage, the revisions
(i.e., the lines) will be grouped by RCS file, not by logical commits.

We walk over the repository, processing each RCS file with
rcsparse.parse(), using cvs2svn's CollectData class, which is a
subclass of rcsparse.Sink(), the parser's callback class.  For each
RCS file, the first thing the parser encounters is the administrative
header, including the head revision, the principal branch, symbolic
names, RCS comments, etc.  The main thing that happens here is that
CollectData.define_tag() is invoked on each symbolic name and its
attached revision, so all the tags and branches of this file get
collected.

Next, the parser hits the revision summary section.  That's the part
of the RCS file that looks like this:

   1.6
   date=092002.06.12.04.54.12;=09author captnmark;=09state Exp;
   branches
   =091.6.2.1;
   next=091.5;

   1.5
   date=092002.05.28.18.02.11;=09author captnmark;=09state Exp;
   branches;
   next=091.4;

   [...]

For each revision summary, CollectData.define_revision() is invoked,
recording that revision's metadata in various variables of the
CollectData class instance.

After finishing the revision summaries, the parser invokes
CollectData.tree_completed(), which loops over the revision
information stored, determining if there are instances where a higher
revision was committed "before" a lower one (rare, but it can happen
when there was clock skew on the repository machine).  If there are
any, it "resyncs" the timestamp of the earlier rev to be just before
that of the later rev, but saves the original timestamp in
self.rev_data[blah][2], so we can later write out a record to the
resync file indicating that an adjustment was made (this makes it
possible to catch the other parts of this commit and resync them
similarly, more details below).

Next, the parser encounters the *real* revision data, which has the
log messages and file contents.  For each revision, it invokes
CollectData.set_revision_info(), which writes a new line to
cvs2svn-data.revs.  The line is constructed by the CVSRevision class -
one of its many roles. Here is an example:

   3dc32955 5afe9b4ba41843d8eb52ae7db47a43eaa9573254 3dc32954 3dc32956 C 1.=
1 1.2 1.3 1 1 1024 N * 0 0 foo/bar,v

The fields are:

   1.  a fixed-width timestamp
   2.  a digest of the log message + author
   3.  a fixed-width timestamp indicating the timestamp of this
       revision's previous revision (or "*", if it's the first
       revision on this line of development).
   4.  a fixed-width timestamp indicating the timestamp of this
       revision's next revision (or "*", if it's the last revision on
       this line of development).
   5.  the type of change ("A"dd, "C"hange, or "D"elete)
   6.  the revision number of the previous revision along this line of
       development (or "*", if it's the first revision on this line of
       development).
   7.  the revision number
   8.  the revision number of the next revision along this line of
       development (or "*", if it's the last revision on this line of
       development).
   9.  1 if the RCS file is in the Attic, "*" if it isn't.
   10. 1 is the RCS file has the executable bit set, "*" if not.
   12. The size of the RCS file, in bytes.
   12. "N" if this revision has non-empty deltatext, else "E" for empty
   13. the RCS keyword substitution mode ("k", "b", etc), or "*" if none
   14. the branch on which this commit happened, or "*" if not on a branch
   15. the number of tags rooted at this revision (followed by their
       names, space-delimited)
   16. the number of branches rooted at this revision (followed by
       their names, space-delimited)
   17. the path of the RCS file in the repository

(Of course, in the above example, fields 15 and 16 are "0", so they have
no additional data.)

Also, for resync'd revisions, a line like this is written out to
'cvs2svn-data.resync':

   3d6c1329 18a215a05abea1c6c155dcc7283b88ae7ce23502 3d6c1328

The fields are:

   NEW_TIMESTAMP   DIGEST   OLD_TIMESTAMP

(The resync file will be explained later.)

That's it -- the RCS file is done.

When every RCS file is done, Pass 1 is complete, and:

   - cvs2svn-data.revs contains a summary of every RCS file's
     revisions.  All the revisions for a given RCS file are grouped
     together, but note that the groups are in no particular order.
     In other words, you can't yet identify the commits from looking
     at these lines; a multi-file commit will be scattered all over
     the place.

   - cvs2svn-data.resync contains a small amount of resync data, in
     no particular order.

Pass 2:
=3D=3D=3D=3D=3D=3D=3D

This is where the resync file is used.  The goal of this pass is to
convert cvs2svn-data.revs to a new file, 'cvs2svn-data.c-revs' (clean
revs).  It's the same as the original file, except for some resync'd
timestamps.

First, read the whole resync file into a hash table that maps each
author+log digest to a list of lists.  Each sublist represents one of
the timestamp adjustments from Pass 1, and looks like this:

   [old_time_lower, old_time_upper, new_time]

The reason to map each digest to a list of sublists, instead of to one
list, is that sometimes you'll get the same digest for unrelated
commits (for example, the same author commits many times using the
empty log message, or a log message that just says "Doc tweaks.").  So
each digest may need to "fan out" to cover multiple commits, but
without accidentally unifying those commits.

Now we loop over cvs2svn-data.revs, writing each line out to
'cvs2svn-data.c-revs'.  Most lines are written out unchanged, but
those whose digest matches some resync entry, and appear to be part of
the same commit as one of the sublists in that entry, get tweaked.
The tweak is to adjust the commit time of the line to the new_time,
which is taken from the resync hash and results from the adjustment
described in Pass 1.

The way we figure out whether a given line needs to be tweaked is to
loop over all the sublists, seeing if this commit's original time
falls within the old<-->new time range for the current sublist.  If it
does, we tweak the line before writing it out, and then conditionally
adjust the sublist's range to account for the timestamp we just
adjusted (since it could be an outlier).  Note that this could, in
theory, result in separate commits being accidentally unified, since
we might gradually adjust the two sides of the range such that they are
eventually more than COMMIT_THRESHOLD seconds apart.  However, this is
really a case of CVS not recording enough information to disambiguate
the commits; we'd know we have a time range that exceeds the
COMMIT_THRESHOLD, but we wouldn't necessarily know where to divide it
up.  We could try some clever heuristic, but for now it's not
important -- after all, we're talking about commits that weren't
important enough to have a distinctive log message anyway, so does it
really matter if a couple of them accidentally get unified?  Probably
not.

NOTE: We currently have a fairly major bug in our resync code.  The
resync_bug test demonstrates it.  The bug is that, when resyncing in
pass 2, we take no care not to move cvs revisions before previous
cvs revisions of the same file, thus creating the very problem we were
attempting to avoid.

Pass 3:
=3D=3D=3D=3D=3D=3D=3D

This is where we deduce the changesets, that is, the grouping of file
changes into single commits.

It's very simple -- run 'sort' on cvs2svn-data.c-revs, converting it
to 'cvs2svn-data.s-revs'.  Because of the way the data is laid out,
this causes commits with the same digest (that is, the same author and
log message) to be grouped together.  Poof!  We now have the CVS
changes grouped by logical commit.

In some cases, the changes in a given commit may be interleaved with
other commits that went on at the same time, because the sort gives
precedence to date before log digest.  However, Pass 4 detects this by
seeing that the log digest is different, and reseparates the commits.

Pass 4:
=3D=3D=3D=3D=3D=3D=3D

This pass has two primary objectives:

1. Create a database that maps CVSRevision unique keys to the actual
   CVSRevision string from the revs file (whose format is described
   above in pass 1).  This results in a database containing one
   key-value pair for each line in the revs file.  This gives us the
   ability to pass around these smaller keys instead of whole CVS
   revisions (which look like lines from the s-revs file).  See the
   CVSRevision class for more details on what the unique key is.

2. Find and create a database containing the last CVS revision that is
   a source (also referred to as an "opening" revision) for all
   symbolic names.  This will result in a database containing
   key-value pairs whose key is the unique key for a CVSRevision, and
   whose value is a list of symbolic names for which that CVSRevision
   is the last "opening."

   The format for this file is:

       cvs-symname-last-revs.db:
            Key                      Value
            CVS Revision             array of Symbolic names

       For example:

            1.38/foo/bar/baz.txt,v  --> [TAG11, BRANCH38]
            1.93/foo/qux/bat.c,v    --> [TAG39]
            1.4/foo/bar/baz.txt,v   --> [BRANCH48, BRANCH37]
            1.18/foo/bar/quux.txt,v --> [TAG320, TAG1178]

Pass 5:
=3D=3D=3D=3D=3D=3D=3D

Primarily, this pass gathers CVS revisions into Subversion revisions
(a Subversion revision is comprised of one or more CVS revisions)
before we actually begin committing (where "committing" means either
to a Subversion repository or to a dump file).

This pass does the following:

1. Creates a database file to map Subversion Revision numbers to their
   corresponding CVS Revisions (cvs2svn-svn-revnums-to-cvs-revs.db).
   Creates another database file to map CVS Revisions to their
   Subversion Revision numbers (cvs2svn-cvs-revs-to-svn-revnums.db).

2. When a file is copied to a symbolic name in cvs2svn, there are a
   range of valid Subversion revisions that we can copy the file from.
   The first valid Subversion revision number for a symbolic name is
   called the "Opening", and the first *invalid* Subversion revision
   number encountered after the "Opening" is called the "Closing".  In
   this pass, the SymbolingsLogger class writes one line to
   cvs2svn-symbolic-names.txt per CVS file, per symbolic name, per
   opening or closing.

3. For each CVS Revision in s-revs, we write out a line (for each
   symbolic name that it opens) to a symbolic-names.txt file if it is
   the first possible source revision (the "opening" revision) for a
   copy to create a branch or tag, or if it is the last possible
   revision (the "closing" revision) for a copy to create a branch or
   tag.  Not every opening will have a corresponding closing.

   The format of each line is:

       SYMBOLIC_NAME SVN_REVNUM TYPE CVSRevision.unique_key()

   For example:

       MY_TAG1 234 O 1.3/foo/bar/baz.txt,v
       MY_BRANCH3 245 O 1.13/foo/qux/bat.c,v
       MY_TAG1 241 C 1.4/foo/bar/baz.txt,v
       MY_BRANCH_BLAH 201 O 1.1/foo/bar/quux.txt,v

   Here is what the columns mean:

   SYMBOLIC_NAME: The name of the branch or tag that starts or ends
                  in this CVS Revision (There can be multiples per
                  CVS rev)

   SVN_REVNUM: The Subversion revision number that is the opening or
               closing for this SYMBOLIC_NAME.

   TYPE: "O" for Openings and "C" for Closings.

   CVSRevision.unique_key(): This is a unique key that identifies
                             the CVSRevision where this opening or
                             closing happened.

   See SymbolingsLogger for more details.

Pass 6:
=3D=3D=3D=3D=3D=3D=3D

This pass merely sorts cvs2svn-symbolic-names.txt into
cvs2svn-symbolic-names-s.txt.  This orders the file first by symbolic
name, and second by Subversion revision number, thus grouping all
openings and closings for each symbolic name together.

Pass 7:
=3D=3D=3D=3D=3D=3D=3D

This pass iterates through all the lines in
cvs2svn-symbolic-names-s.txt, writing out a database file mapping
SYMBOLIC_NAME to the file offset in SYMBOL_OPENINGS_CLOSINGS_SORTED
where SYMBOLIC_NAME is first encountered.  This will allow us to seek
to the various offsets in the file and sequentially read only the
openings and closings that we need.

Pass 8:
=3D=3D=3D=3D=3D=3D=3D

The 8th pass will has very little "thinking" to do--it basically going
opens the svn-nums-to-cvs-revs.db and, starting with Subversion
revision 2 (revision 1 creates /trunk, /tags, and /branches), and
sequentially play out all the commits to either a Subversion
repository or to a dumpfile.

In --dump-only mode, the result of this pass is a Subversion
repository dumpfile (suitable for input to 'svnadmin load').  The
dumpfile is the data's last static stage: last chance to check over
the data, run it through svndumpfilter, move the dumpfile to another
machine, etc.

However, when not in --dump-only mode, no full dumpfile is created for
subsequent load into a Subversion repository.  Instead, miniature
dumpfiles represent a single revision are created, loaded into the
repository, and then removed.

In both modes, the dumpfile revisions are created by walking through
cvs2svn-data.s-revs.

                  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
                      Branches and Tags Plan.
                  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This pass is also where tag and branch creation is done.  Since
subversion does tags and branches by copying from existing revisions
(then maybe editing the copy, making subcopies underneath, etc), the
big question for cvs2svn is how to achieve the minimum number of
operations per creation.  For example, if it's possible to get the
right tag by just copying revision 53, then it's better to do that
than, say, copying revision 51 and then sub-copying in bits of
revision 52 and 53.

Also, since CVS does not version symbolic names, there is the
secondary question of *when* to create a particular tag or branch.
For example, a tag might have been made at any time after the youngest
commit included in it, or might even have been made piecemeal; and the
same is true for a branch, with the added constraint that for any
particular file, the branch must have been created before the first
commit on the branch.

Answering the second question first: cvs2svn creates tags as soon as
possible and branches as late as possible.

Tags are created as soon cvs2svn encounters the last CVS Revision that
is a source for that tag.  The whole tag is created in one Subversion
commit.

For branches, this is "just in time" creation -- the moment it sees
the first commit on a branch, it snaps the entire branch into
existence (or as much of it as possible), and then outputs the branch
commit.

The reason we say "as much of it as possible" is that it's possible to
have a branch where some files have branch commits occuring earlier
than the other files even have the source revisions from which the
branch sprouts (this can happen if the branch was created piecemeal,
for example).  In this case, we create as much of the branch as we
can, that is, as much of it as there are source revisions available to
copy, and leave the rest for later.  "Later" might mean just until
other branch commits come in, or else during a cleanup stage that
happens at the end of this pass (about which more later).

How just-in-time branch creation works:

In order to make the "best" set of copies/deletes when creating a
branch, cvs2svn keeps track of two sets of trees while it's making
commits:

   1. A skeleton mirror of the subversion repository, that is, an
      array of revisions, with a tree hanging off each revision.  (The
      "array" is actually implemented as an anydbm database itself,
      mapping string representations of numbers to root keys.)

   2. A tree for each CVS symbolic name, and the svn file/directory
      revisions from which various parts of that tree could be copied.

Both tree sets live in anydbm databases, using the same basic schema:
unique keys map to marshal.dumps() representations of dictionaries,
which in turn map entry names to other unique keys:

   root_key  =3D=3D> { entryname1 : entrykey1, entryname2 : entrykey2, ... =
}
   entrykey1 =3D=3D> { entrynameX : entrykeyX, ... }
   entrykey2 =3D=3D> { entrynameY : entrykeyY, ... }
   entrykeyX =3D=3D> { etc, etc ...}
   entrykeyY =3D=3D> { etc, etc ...}

(The leaf nodes -- files -- are also dictionaries, for simplicity.)

The repository mirror allows cvs2svn to remember what paths exist in
what revisions.

For details on how branches and tags are created, please see the
docstring the SymbolingsLogger class (and its methods).

-*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*-
- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -
-*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*- -*-

Some older notes and ideas about cvs2svn.  Not deleted, because they
may contain suggestions for future improvements in design.

-----------------------------------------------------------------------

An email from John Gardiner Myers <jgmyers@speakeasy.net> about some
considerations for the tool.

------
From: John Gardiner Myers <jgmyers@speakeasy.net>
Subject: Thoughts on CVS to SVN conversion
To: gstein@lyra.org
Date: Sun, 15 Apr 2001 17:47:10 -0700

Some things you may want to consider for a CVS to SVN conversion utility:

If converting a CVS repository to SVN takes days, it would be good for
the conversion utility to keep its progress state on disk.  If the
conversion fails halfway through due to a network outage or power
failure, that would allow the conversion to be resumed where it left off
instead of having to start over from an empty SVN repository.

It is a short step from there to allowing periodic updates of a
read-only SVN repository from a read/write CVS repository.  This allows
the more relaxed conversion procedure:

1) Create SVN repository writable only by the conversion tool.
2) Update SVN repository from CVS repository.
3) Announce the time of CVS to SVN cutover.
4) Repeat step (2) as needed.
5) Disable commits to CVS repository, making it read-only.
6) Repeat step (2).
7) Enable commits to SVN repository.
8) Wait for developers to move their workspaces to SVN.
9) Decomission the CVS repository.

You may forward this message or parts of it as you seem fit.
------

-----------------------------------------------------------------------

Further design thoughts from Greg Stein <gstein@lyra.org>

* timestamp the beginning of the process. ignore any commits that
  occur after that timestamp; otherwise, you could miss portions of a
  commit (e.g. scan A; commit occurs to A and B; scan B; create SVN
  revision for items in B; we missed A)

* the above timestamp can also be used for John's "grab any updates
  that were missed in the previous pass."

* for each file processed, watch out for simultaneous commits. this
  may cause a problem during the reading/scanning/parsing of the file,
  or the parse succeeds but the results are garbaged. this could be
  fixed with a CVS lock, but I'd prefer read-only access.

  algorithm: get the mtime before opening the file. if an error occurs
  during reading, and the mtime has changed, then restart the file. if
  the read is successful, but the mtime changed, then restart the
  file.

* use a separate log to track unique branches and non-branched forks
  of revision history (Q: is it possible to create, say, 1.4.1.3
  without a "real" branch?). this log can then be used to create a
  /branches/ directory in the SVN repository.

  Note: we want to determine some way to coalesce branches across
  files. It can't be based on name, though, since the same branch name
  could be used in multiple places, yet they are semantically
  different branches. Given files R, S, and T with branch B, we can
  tie those files' branch B into a "semantic group" whenever we see
  commit groups on a branch touching multiple files. Files that are
  have a (named) branch but no commits on it are simply ignored. For
  each "semantic group" of a branch, we'd create a branch based on
  their common ancestor, then make the changes on the children as
  necessary. For single-file commits to a branch, we could use
  heuristics (pathname analysis) to add these to a group (and log what
  we did), or we could put them in a "reject" kind of file for a human
  to tell us what to do (the human would edit a config file of some
  kind to instruct the converter).

* if we have access to the CVSROOT/history, then we could process tags
  properly. otherwise, we can only use heuristics or configuration
  info to group up tags (branches can use commits; there are no
  commits associated with tags)

* ideally, we store every bit of data from the ,v files to enable a
  complete restoration of the CVS repository. this could be done by
  storing properties with CVS revision numbers and stuff (i.e. all
  metadata not already embodied by SVN would go into properties)

* how do we track the "states"? I presume "dead" is simply deleting
  the entry from SVN. what are the other legal states, and do we need
  to do anything with them?

* where do we put the "description"? how about locks, access list,
  keyword flags, etc.

* note that using something like the SourceForge repository will be an
  ideal test case. people *move* their repositories there, which means
  that all kinds of stuff can be found in those repositories, from
  wherever people used to run them, and under whatever development
  policies may have been used.

  For example: I found one of the projects with a "permissions 644;"
  line in the "gnuplot" repository.  Most RCS releases issue warnings
  about that (although they properly handle/skip the lines), and CVS
  ignores RCS newphrases altogether.


------=_Part_1040_8919023.1150479867083--
