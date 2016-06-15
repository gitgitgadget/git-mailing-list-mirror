From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: git-fast-import
Date: Mon, 5 Feb 2007 21:31:11 -0500
Message-ID: <20070206023111.GB9222@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 06 03:31:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEG7L-0004UL-MG
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 03:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965470AbXBFCbV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 21:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965464AbXBFCbV
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 21:31:21 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46815 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965450AbXBFCbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 21:31:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEG6n-0000lT-Lz
	for git@vger.kernel.org; Mon, 05 Feb 2007 21:31:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4A19E20FBAE; Mon,  5 Feb 2007 21:31:11 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38802>

I'm starting to get gfi (git-fast-import) prepared for a merge into
the main git.git tree.  For those who don't know, gfi is the result
of my work with Jon Smirl on trying to *quickly* import the massive
Mozilla CVS repository into Git.  Recently its been getting a lot
of attention from the KDE, OOo, Dragonfly BSD, and Qt projects.

When exactly we merge it in will depend a lot on Junio.  It should
be safe to merge before 1.5.0 as its strictly new source files,
but we may still want to wait until after 1.5.0 is out.

I'm mainly worried about breaking compliation on odd architectures.
gfi builds, runs and has been used for production level imports
on Mac OS X, Linux and Dragonfly BSD, using both 32 bit and 64 bit
architectures, but some of Git's other targets (e.g. AIX) haven't
seen any testing.

The gfi code is quite stable and has been getting a lot of use
(and discussion) lately.  A new test (t/t9300-fast-import.sh)
has been added and now, finally, documentation
(Documentation/git-fast-import.txt).

As gfi is 1962 lines of C and its development history consists of
74 commits made over the span of 7 months (first commit was Aug 5,
2006) and several versions of core Git code (which gfi calls into,
and which has gone through some non-trivial changes during that
time), I'm going to ask Junio to directly pull the topic branch
into git.git, rather than submitting it as patches.

My topic branch is published on repo.or.cz (thanks Pasky!).  I would
encourage all parties who would have otherwise been interested in
reviewing the patches on the mailing list to clone/fetch the topic
and review it locally instead.

	gitweb: http://repo.or.cz/w/git/fastimport.git
	clone:  git://repo.or.cz/git/fastimport.git

I'm particularly interested in feedback on the documentation,
so I am attaching it below.

-------
git-fast-import(1)
==================

NAME
----
git-fast-import - Backend for fast Git data importers.


SYNOPSIS
--------
frontend | 'git-fast-import' [options]

DESCRIPTION
-----------
This program is usually not what the end user wants to run directly.
Most end users want to use one of the existing frontend programs,
which parses a specific type of foreign source and feeds the contents
stored there to git-fast-import (gfi).

gfi reads a mixed command/data stream from standard input and
writes one or more packfiles directly into the current repository.
When EOF is received on standard input, fast import writes out
updated branch and tag refs, fully updating the current repository
with the newly imported data.

The gfi backend itself can import into an empty repository (one that
has already been initialized by gitlink:git-init[1]) or incrementally
update an existing populated repository.  Whether or not incremental
imports are supported from a particular foreign source depends on
the frontend program in use.


OPTIONS
-------
--max-pack-size=<n>::
	Maximum size of each output packfile, expressed in MiB.
	The default is 4096 (4 GiB) as that is the maximum allowed
	packfile size (due to file format limitations). Some
	importers may wish to lower this, such as to ensure the
	resulting packfiles fit on CDs.

--depth=<n>::
	Maximum delta depth, for blob and tree deltification.
	Default is 10.

--active-branches=<n>::
	Maximum number of branches to maintain active at once.
	See ``Memory Utilization'' below for details.  Default is 5.

--export-marks=<file>::
	Dumps the internal marks table to <file> when complete.
	Marks are written one per line as `:markid SHA-1`.
	Frontends can use this file to validate imports after they
	have been completed.

--branch-log=<file>::
	Records every tag and commit made to a log file.  (This file
	can be quite verbose on large imports.)  This particular
	option has been primarily intended to facilitate debugging
	gfi and has limited usefulness in other contexts.  It may
	be removed in future versions.


Performance
-----------
The design of gfi allows it to import large projects in a minimum
amount of memory usage and processing time.  Assuming the frontend
is able to keep up with gfi and feed it a constant stream of data,
import times for projects holding 10+ years of history and containing
100,000+ individual commits are generally completed in just 1-2
hours on quite modest (~$2,000 USD) hardware.

Most bottlenecks appear to be in foreign source data access (the
source just cannot extract revisions fast enough) or disk IO (gfi
writes as fast as the disk will take the data).  Imports will run
faster if the source data is stored on a different drive than the
destination Git repository (due to less IO contention).


Development Cost
----------------
A typical frontend for gfi tends to weigh in at approximately 200
lines of Perl/Python/Ruby code.  Most developers have been able to
create working importers in just a couple of hours, even though it
is their first exposure to gfi, and sometimes even to Git.  This is
an ideal situation, given that most conversion tools are throw-away
(use once, and never look back).


Parallel Operation
------------------
Like `git-push` or `git-fetch`, imports handled by gfi are safe to
run alongside parallel `git repack -a -d` or `git gc` invocations,
or any other Git operation (including `git prune`, as loose objects
are never used by gfi).

However, gfi does not lock the branch or tag refs it is actively
importing.  After EOF, during its ref update phase, gfi blindly
overwrites each imported branch or tag ref.  Consequently it is not
safe to modify refs that are currently being used by a running gfi
instance, as work could be lost when gfi overwrites the refs.


Technical Discussion
--------------------
gfi tracks a set of branches in memory.  Any branch can be created
or modified at any point during the import process by sending a
`commit` command on the input stream.  This design allows a frontend
program to process an unlimited number of branches simultaneously,
generating commits in the order they are available from the source
data.  It also simplifies the frontend programs considerably.

gfi does not use or alter the current working directory, or any
file within it.  (It does however update the current Git repository,
as referenced by `GIT_DIR`.)  Therefore an import frontend may use
the working directory for its own purposes, such as extracting file
revisions from the foreign source.  This ignorance of the working
directory also allows gfi to run very quickly, as it does not
need to perform any costly file update operations when switching
between branches.

Input Format
------------
With the exception of raw file data (which Git does not interpret)
the gfi input format is text (ASCII) based.  This text based
format simplifies development and debugging of frontend programs,
especially when a higher level language such as Perl, Python or
Ruby is being used.

gfi is very strict about its input.  Where we say SP below we mean
*exactly* one space.  Likewise LF means one (and only one) linefeed.
Supplying additional whitespace characters will cause unexpected
results, such as branch names or file names with leading or trailing
spaces in their name, or early termination of gfi when it encounters
unexpected input.

Commands
~~~~~~~~
gfi accepts several commands to update the current repository
and control the current import process.  More detailed discussion
(with examples) of each command follows later.

`commit`::
	Creates a new branch or updates an existing branch by
	creating a new commit and updating the branch to point at
	the newly created commit.

`tag`::
	Creates an annotated tag object from an existing commit or
	branch.  Lightweight tags are not supported by this command,
	as they are not recommended for recording meaningful points
	in time.

`reset`::
	Reset an existing branch (or a new branch) to a specific
	revision.  This command must be used to change a branch to
	a specific revision without making a commit on it.

`blob`::
	Convert raw file data into a blob, for future use in a
	`commit` command.  This command is optional and is not
	needed to perform an import.

`checkpoint`::
	Forces gfi to close the current packfile, generate its
	unique SHA-1 checksum and index, and start a new packfile.
	This command is optional and is not needed to perform
	an import.

`commit`
~~~~~~~~
Create or update a branch with a new commit, recording one logical
change to the project.

....
	'commit' SP <ref> LF
	mark?
	('author' SP <name> SP LT <email> GT SP <time> SP <tz> LF)?
	'committer' SP <name> SP LT <email> GT SP <time> SP <tz> LF
	data
	('from' SP <committish> LF)?
	('merge' SP <committish> LF)?
	(filemodify | filedelete)*
	LF
....

where `<ref>` is the name of the branch to make the commit on.
Typically branch names are prefixed with `refs/heads/` in
Git, so importing the CVS branch symbol `RELENG-1_0` would use
`refs/heads/RELENG-1_0` for the value of `<ref>`.  The value of
`<ref>` must be a valid refname in Git.  As `LF` is not valid in
a Git refname, no quoting or escaping syntax is supported here.

A `mark` command may optionally appear, requesting gfi to save a
reference to the newly created commit for future use by the frontend
(see below for format).  It is very common for frontends to mark
every commit they create, thereby allowing future branch creation
from any imported commit.

The `data` command following `committer` must supply the commit
message (see below for `data` command syntax).  To import an empty
commit message use a 0 length data.  Commit messages are free-form
and are not interpreted by Git.  Currently they must be encoded in
UTF-8, as gfi does not permit other encodings to be specified.

Zero or more `filemodify` and `filedelete` commands may be
included to update the contents of the branch prior to the commit.
These commands can be supplied in any order, gfi is not sensitive
to pathname or operation ordering.

`author`
^^^^^^^^
An `author` command may optionally appear, if the author information
might differ from the committer information.  If `author` is omitted
then gfi will automatically use the committer's information for
the author portion of the commit.  See below for a description of
the fields in `author`, as they are identical to `committer`.

`committer`
^^^^^^^^^^^
The `committer` command indicates who made this commit, and when
they made it.

Here `<name>` is the person's display name (for example
``Com M Itter'') and `<email>` is the person's email address
(``cm@example.com'').  `LT` and `GT` are the literal less-than (\x3c)
and greater-than (\x3e) symbols.  These are required to delimit
the email address from the other fields in the line.  Note that
`<name>` is free-form and may contain any sequence of bytes, except
`LT` and `LF`.  It is typically UTF-8 encoded.

The time of the change is specified by `<time>` as the number of
seconds since the UNIX epoc (midnight, Jan 1, 1970, UTC) and is
written in base-10 notation using US-ASCII digits.  The committer's
timezone is specified by `<tz>` as a positive or negative offset
from UTC, in minutes.  For example EST would be expressed in `<tz>`
by ``-0500''.

`from`
^^^^^^
Only valid for the first commit made on this branch by this
gfi process.  The `from` command is used to specify the commit
to initialize this branch from.  This revision will be the first
ancestor of the new commit.

Omitting the `from` command in the first commit of a new branch will
cause gfi to create that commit with no ancestor. This tends to be
desired only for the initial commit of a project.  Omitting the
`from` command on existing branches is required, as the current
commit on that branch is automatically assumed to be the first
ancestor of the new commit.

As `LF` is not valid in a Git refname or SHA-1 expression, no
quoting or escaping syntax is supported within `<committish>`.

Here `<committish>` is any of the following:

* The name of an existing branch already in gfi's internal branch
  table.  If gfi doesn't know the name, its treated as a SHA-1
  expression.

* A mark reference, `:<idnum>`, where `<idnum>` is the mark number.
+
The reason gfi uses `:` to denote a mark reference is this character
is not legal in a Git branch name.  The leading `:` makes it easy
to distingush between the mark 42 (`:42`) and the branch 42 (`42`
or `refs/heads/42`), or an abbreviated SHA-1 which happened to
consist only of base-10 digits.
+
Marks must be declared (via `mark`) before they can be used.

* A complete 40 byte or abbreviated commit SHA-1 in hex.

* Any valid Git SHA-1 expression that resolves to a commit.  See
  ``SPECIFYING REVISIONS'' in gitlink:git-rev-parse[1] for details.

The special case of restarting an incremental import from the
current branch value should be written as:
----
	from refs/heads/branch^0
----
The `^0` suffix is necessary as gfi does not permit a branch to
start from itself, and the branch is created in memory before the
`from` command is even read from the input.  Adding `^0` will force
gfi to resolve the commit through Git's revision parsing library,
rather than its internal branch table, thereby loading in the
existing value of the branch.

`merge`
^^^^^^^
Includes one additional ancestor commit, and makes the current
commit a merge commit.  An unlimited number of `merge` commands per
commit are permitted by gfi, thereby establishing an n-way merge.
However Git's other tools never create commits with more than 15
additional ancestors (forming a 16-way merge).  For this reason
it is suggested that frontends do not use more than 15 `merge`
commands per commit.

Here `<committish>` is any of the commit specification expressions
also accepted by `from` (see above).

`filemodify`
^^^^^^^^^^
Included in a `commit` command to add a new file or change the
content of an existing file.  This command has two different means
of specifying the content of the file.

External data format::
	The data content for the file was already supplied by a prior
	`blob` command.  The frontend just needs to connect it.
+
....
	'M' SP <mode> SP <dataref> SP <path> LF
....
+
Here `<dataref>` can be either a mark reference (`:<idnum>`)
set by a prior `blob` command, or a full 40-byte SHA-1 of an
existing Git blob object.

Inline data format::
	The data content for the file has not been supplied yet.
	The frontend wants to supply it as part of this modify
	command.
+
....
	'M' SP <mode> SP 'inline' SP <path> LF
	data
....
+
See below for a detailed description of the `data` command.

In both formats `<mode>` is the type of file entry, specified
in octal.  Git only supports the following modes:

* `100644` or `644`: A normal (not-executable) file.  The majority
  of files in most projects use this mode.  If in doubt, this is
  what you want.
* `100755` or `755`: A normal, but executable, file.
* `140000`: A symlink, the content of the file will be the link target.

In both formats `<path>` is the complete path of the file to be added
(if not already existing) or modified (if already existing).

A `<path>` string must use UNIX-style directory seperators (forward
slash `/`), may contain any byte other than `LF`, and must not
start with double quote (`"`).

If an `LF` or double quote must be encoded into `<path>` shell-style
quoting should be used, e.g. `"path/with\n and \" in it"`.

The value of `<path>` must be in canoncial form. That is it must not:

* contain an empty directory component (e.g. `foo//bar` is invalid),
* end with a directory seperator (e.g. `foo/` is invalid),
* start with a directory seperator (e.g. `/foo` is invalid),
* contain the special component `.` or `..` (e.g. `foo/./bar` and
  `foo/../bar` are invalid).

It is recommended that `<path>` always be encoded using UTF-8.


`filedelete`
^^^^^^^^^^
Included in a `commit` command to remove a file from the branch.
If the file removal makes its directory empty, the directory will
be automatically removed too.  This cascades up the tree until the
first non-empty directory or the root is reached.

....
	'D' SP <path> LF
....

here `<path>` is the complete path of the file to be removed.
See `filemodify` above for a detailed description of `<path>`.

`mark`
~~~~~~
Arranges for gfi to save a reference to the current object, allowing
the frontend to recall this object at a future point in time, without
knowing its SHA-1.  Here the current object is the object creation
command the `mark` command appears within.  This can be `commit`,
`tag`, and `blob`, but `commit` is the most common usage.

....
	'mark' SP ':' <idnum> LF
....

where `<idnum>` is the number assigned by the frontend to this mark.
The value of `<idnum>` is expressed in base 10 notation using
US-ASCII digits.  The value 0 is reserved and cannot be used as
a mark.  Only values greater than or equal to 1 may be used as marks.

New marks are created automatically.  Existing marks can be moved
to another object simply by reusing the same `<idnum>` in another
`mark` command.

`tag`
~~~~~
Creates an annotated tag referring to a specific commit.  To create
lightweight (non-annotated) tags see the `reset` command below.

....
	'tag' SP <name> LF
	'from' SP <committish> LF
	'tagger' SP <name> SP LT <email> GT SP <time> SP <tz> LF
	data
	LF
....

where `<name>` is the name of the tag to create.

Tag names are automatically prefixed with `refs/tags/` when stored
in Git, so importing the CVS branch symbol `RELENG-1_0-FINAL` would
use just `RELENG-1_0-FINAL` for `<name>`, and gfi will write the
corresponding ref as `refs/tags/RELENG-1_0-FINAL`.

The value of `<name>` must be a valid refname in Git and therefore
may contain forward slashes.  As `LF` is not valid in a Git refname,
no quoting or escaping syntax is supported here.

The `from` command is the same as in the `commit` command; see
above for details.

The `tagger` command uses the same format as `committer` within
`commit`; again see above for details.

The `data` command following `tagger` must supply the annotated tag
message (see below for `data` command syntax).  To import an empty
tag message use a 0 length data.  Tag messages are free-form and are
not interpreted by Git.  Currently they must be encoded in UTF-8,
as gfi does not permit other encodings to be specified.

Signing annotated tags during import from within gfi is not
supported.  Trying to include your own PGP/GPG signature is not
recommended, as the frontend does not (easily) have access to the
complete set of bytes which normally goes into such a signature.
If signing is required, create lightweight tags from within gfi with
`reset`, then create the annotated versions of those tags offline
with the standard gitlink:git-tag[1] process.

`reset`
~~~~~~~
Creates (or recreates) the named branch, optionally starting from
a specific revision.  The reset command allows a frontend to issue
a new `from` command for an existing branch, or to create a new
branch from an existing commit without creating a new commit.

....
	'reset' SP <ref> LF
	('from' SP <committish> LF)?
	LF
....

For a detailed description of `<ref>` and `<committish>` see above
under `commit` and `from`.

The `reset` command can also be used to create lightweight
(non-annotated) tags.  For example:

====
	reset refs/tags/938
	from :938
====

would create the lightweight tag `refs/tags/938` referring to
whatever commit mark `:938` references.

`blob`
~~~~~~
Requests writing one file revision to the packfile.  The revision
is not connected to any commit; this connection must be formed in
a subsequent `commit` command by referencing the blob through an
assigned mark.

....
	'blob' LF
	mark?
	data
....

The mark command is optional here as some frontends have chosen
to generate the Git SHA-1 for the blob on their own, and feed that
directly to `commit`.  This is typically more work than its worth
however, as marks are inexpensive to store and easy to use.

`data`
~~~~~~
Supplies raw data (for use as blob/file content, commit messages, or
annotated tag messages) to gfi.  Data can be supplied using an exact
byte count or delimited with a terminating line.  Real frontends
intended for production-quality conversions should always use the
exact byte count format, as it is more robust and performs better.
The delimited format is intended primarily for testing gfi.

Exact byte count format:

....
	'data' SP <count> LF
	<raw> LF
....

where `<count>` is the exact number of bytes appearing within
`<raw>`.  The value of `<count>` is expressed in base 10 notation
using US-ASCII digits.  The `LF` on either side of `<raw>` is not
included in `<count>` and will not be included in the imported data.

Delimited format:

....
	'data' SP '<<' <delim> LF
	<raw> LF
	<delim> LF
....

where `<delim>` is the chosen delimiter string.  The string `<delim>`
must not appear on a line by itself within `<raw>`, as otherwise
gfi will think the data ends earlier than it really does.  The `LF`
immediately trailing `<raw>` is part of `<raw>`.  This is one of
the limitations of the delimited format, it is impossible to supply
a data chunk which does not have an LF as its last byte.

`checkpoint`
~~~~~~~~~~~~
Forces gfi to close the current packfile and start a new one.
As this requires a significant amount of CPU time and disk IO
(to compute the overall pack SHA-1 checksum and generate the
corresponding index file) it can easily take several minutes for
a single `checkpoint` command to complete.

....
	'checkpoint' LF
	LF
....

Packfile Optimization
---------------------
When packing a blob gfi always attempts to deltify against the last
blob written.  Unless specifically arranged for by the frontend,
this will probably not be a prior version of the same file, so the
generated delta will not be the smallest possible.  The resulting
packfile will be compressed, but will not be optimal.

Frontends which have efficient access to all revisions of a
single file (for example reading an RCS/CVS ,v file) can choose
to supply all revisions of that file as a sequence of consecutive
`blob` commands.  This allows gfi to deltify the different file
revisions against each other, saving space in the final packfile.
Marks can be used to later identify individual file revisions during
a sequence of `commit` commands.

The packfile(s) created by gfi do not encourage good disk access
patterns.  This is caused by gfi writing the data in the order
it is received on standard input, while Git typically organizes
data within packfiles to make the most recent (current tip) data
appear before historical data.  Git also clusters commits together,
speeding up revision traversal through better cache locality.

For this reason it is strongly recommended that users repack the
repository with `git repack -a -d` after gfi completes, allowing
Git to reorganize the packfiles for faster data access.  If blob
deltas are suboptimal (see above) then also adding the `-f` option
to force recomputation of all deltas can significantly reduce the
final packfile size (30-50% smaller can be quite typical).

Memory Utilization
------------------
There are a number of factors which affect how much memory gfi
requires to perform an import.  Like critical sections of core
Git, gfi uses its own memory allocators to ammortize any overheads
associated with malloc.  In practice gfi tends to ammoritize any
malloc overheads to 0, due to its use of large block allocations.

per object
~~~~~~~~~~
gfi maintains an in-memory structure for every object written in
this execution.  On a 32 bit system the structure is 32 bytes,
on a 64 bit system the structure is 40 bytes (due to the larger
pointer sizes).  Objects in the table are not deallocated until
gfi terminates.  Importing 2 million objects on a 32 bit system
will require approximately 64 MiB of memory.

The object table is actually a hashtable keyed on the object name
(the unique SHA-1).  This storage configuration allows gfi to reuse
an existing or already written object and avoid writing duplicates
to the output packfile.  Duplicate blobs are surprisingly common
in an import, typically due to branch merges in the source.

per mark
~~~~~~~~
Marks are stored in a sparse array, using 1 pointer (4 bytes or 8
bytes, depending on pointer size) per mark.  Although the array
is sparse, frontends are still strongly encouraged to use marks
between 1 and n, where n is the total number of marks required for
this import.

per branch
~~~~~~~~~~
Branches are classified as active and inactive.  The memory usage
of the two classes is significantly different.

Inactive branches are stored in a structure which uses 96 or 120
bytes (32 bit or 64 bit systems, respectively), plus the length of
the branch name (typically under 200 bytes), per branch.  gfi will
easily handle as many as 10,000 inactive branches in under 2 MiB
of memory.

Active branches have the same overhead as inactive branches, but
also contain copies of every tree that has been recently modified on
that branch.  If subtree `include` has not been modified since the
branch became active, its contents will not be loaded into memory,
but if subtree `src` has been modified by a commit since the branch
became active, then its contents will be loaded in memory.

As active branches store metadata about the files contained on that
branch, their in-memory storage size can grow to a considerable size
(see below).

gfi automatically moves active branches to inactive status based on
a simple least-recently-used algorithm.  The LRU chain is updated on
each `commit` command.  The maximum number of active branches can be
increased or decreased on the command line with `--active-branches=`.

per active tree
~~~~~~~~~~~~~~~
Trees (aka directories) use just 12 bytes of memory on top of the
memory required for their entries (see ``per active file'' below).
The cost of a tree is virtually 0, as its overhead ammortizes out
over the individual file entries.

per active file entry
~~~~~~~~~~~~~~~~~~~~~
Files (and pointers to subtrees) within active trees require 52 or 64
bytes (32/64 bit platforms) per entry.  To conserve space, file and
tree names are pooled in a common string table, allowing the filename
``Makefile'' to use just 16 bytes (after including the string header
overhead) no matter how many times it occurs within the project.

The active branch LRU, when coupled with the filename string pool
and lazy loading of subtrees, allows gfi to efficiently import
projects with 2,000+ branches and 45,114+ files in a very limited
memory footprint (less than 2.7 MiB per active branch).


Author
------
Written by Shawn O. Pearce <spearce@spearce.org>.

Documentation
--------------
Documentation by Shawn O. Pearce <spearce@spearce.org>.

GIT
---
Part of the gitlink:git[7] suite
