From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Requirements for integrating a new git subcommand
Date: Thu, 22 Nov 2012 00:30:12 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121122053012.GA17265@thyrsus.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 20:06:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbc6k-0007mc-9i
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756421Ab2KVTF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 14:05:59 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:54029
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693Ab2KVTF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:05:57 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 66DE24065F; Thu, 22 Nov 2012 00:30:12 -0500 (EST)
Content-Disposition: inline
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210190>

I have completed work on git-weave (the tool I had called 'gitpacker' in some
previous postings).  I want to submit a patch that integrates it into git;
in hopes of smoothing the process I have some technical and procedural 
questions.  

First, however, let me present the git-weave documentation for design
review:

----------------------------------------------------------------------
git-weave(1)
============

NAME
----
git-weave - Weave a sequence of trees and log data into a repository

SYNOPSIS
--------
[verse]
'git-weave' [-v] [-m limit] [-q] indir outdir

DESCRIPTION
-----------
git-weave accepts an input directory containing a sequence of
subdirectories and a metadata file, and composes them into a 
git repository created under the specified output directory
(which must not exist).

If the input directory is identifiably a git repository, the weave
operation is reversed; tree states from each commit are unraveled into
the output directory with a log holding commit metadata
(committer/author/comment information and parent headers representing
links of the repository DAG) and tags.

This tool is primarily intended for importing and working with project
histories that have been preserved only as linear sequences of release
snapshots.  It may also be useful for surgery on linear repositories

While the weave operation can build a commit graph with any structure
desired, an important restriction of the inverse (unraveling)
operation is that it operates on *master branches only*. The unravel
operation discards non-master-branch content, emitting a warning 
to standard error when it has to do so.

Commits from the repository's master branch are unraveled into
directories named for integers from 1 increasing, but their order of
composition when re-woven is actually set by the sequence of entries
in the metadata file.  File trees may be inserted or removed without
hindering re-weaving provided the pointers in the log's parent fields
are fixed up properly.

METADATA FILE FORMAT
--------------------
The metadata file format will contain three kinds of stanzas: entries
for commits, entries for lightweight tags, and entries for annotated
tags.

A commit stanza has headers similar to those in a commit raw log:
commit, committer, author, and optionally parent headers.  The header
contents are not hash IDs, but arbitrary text cookies either declared
by a previous commit stanza or referencing one.  The following example
declares "8" to be a commit ID, and references a previous commit
identified as '7'.  Note that commit IDs are not required to be
numeric strings, though the unravel operation generates them that way.

------------
commit 8
parent 7
author Eric S. Raymond <esr@thyrsus.com> 1325026869 +0000
committer Eric S. Raymond <esr@thyrsus.com> 1325026869 +0000

Initial revision
.
------------

The text body of a commit comment or tag comment entry is delimited
from the headers by an empty line; the text body must always end with
"." on a line by itself; and text lines beginning with "."  will have
an additional "." prepended to them.

A commit stanza may also have a "directory" header.  If present, this 
sets the name of the subdirectory in which git-weave expects to
find the content tree for this commit.  For example

------------
commit 24
directory intercal-0.17
parent 23
author Eric S. Raymond <esr@thyrsus.com> 1325026489 +0000
committer Eric S. Raymond <esr@thyrsus.com> 1325026489 +0000

The state of the INTERCAL project at release 0.17.
.
------------

A label stanza declares a lightweight tag.  This example declares a
tag 'sample' pointing at the commit identified as 102.

------------
label sample
refers-to 102
------------

A tag stanza declares an annotated tag.  This one declares a tag named
'annotated1' pointing at the commit declared as 99.

------------
tag annotated1
refers-to 99
tagger Eric S. Raymond <esr@thyrsus.com> Sat Nov 17 03:16:26 2012 -0500

This is an example annotated tag.
.
------------

When you are composing commit and tag stanzas by hand, you can count
on any of the date formats normally acceptable to git to be
recognized.

If, when weaving, any committer or author or tagger line, the date is omitted,
git-weave will supply as a default the latest modification time of
any file in the corresponding tree.

If a committer or author or tagger line is omitted entirely, the
user's name and email address as retrieved by ''git-config'' will
be supplied as defaults, and the date will default as above.

Thus, the following variation on one of the previous examples 
is a valid stanza:

------------
commit 24
directory intercal-0.17
parent 23

The state of the INTERCAL project at release 0.17.
.
------------

OPTIONS
-------
-q::
	Be quiet.  Suppress the normal spinning-baton progress meter
	with timing information.

-m::
	Limit the number of commits or trees processed to a specified
	integer maximum. '0' means process all of them.

-v::
	Be verbose, enabling progress and command-execution messages
	This option will probably be of interest only to developers;
	consult the source code for details.

EXAMPLES
--------
* Weave a sequence of trees in the directory 'unraveled' 
into a git repository in the directory 'repo'. 
+
------------
$ rm -fr repo; git-weave unraveled repo
------------
+
The metadata is expected to be in 'unraveled/log'.  This mode of
operation is triggered when there is no file 'unraveled/.git', 

* Unravel a repository in the directory 'repo' into a sequence
of file trees and a metadata log in the directory 'unraveled'.
+
------------
$ rm -fr unraveled; git-weave repo unraveled
------------
+
This mode of operation is triggered when there is a 'repo/.git' file.

SEE ALSO
--------
linkgit:git-log[1]
linkgit:git-checkout[1]
linkgit:git-add[1]
linkgit:git-mktree[1]
linkgit:git-ls-tree[1]
linkgit:git-update-references[1]

GIT
---
Not yet part of the linkgit:git[1] suite
----------------------------------------------------------------------

Yes, there are scripts in contrib that do similar things.  git-weave
is an improvement is several ways:  (a) it is documented, (b) I am
shipping it with a functional test, (c) I am prepared to maintain it 
and am quite unlikely to drop out of sight :-), (d) it does both
the import operation *and its inverse*, and (e) it is rather more
powerful, including the ability to decorate the import with 
annotated tags.

Now *my* questions:

1. I have a round-trip test for the tool that I can very easily adapt
to speak TAP.  To function, the test will require a small linear
history to operate on in the form of an import-stream file (so the
result of round-tripping through a weave-unravel can be diffed against
the original).  Does the distribution include any test repos?  If
so, where can I find them?

2. I understand that a "git foo" command is typically implemented
as "git-foo" binary or script in /usr/lib/git-core.  What I don't
know is what the other interfacing requirements are.  Are they
documented anywhere?  In particular...

3. Is there any registration protocol other than simply installing 
the extension in the subcommand library?

4. How does "git help" work?  That is, how is a subcommand expected
to know when it is being called to export its help text?

5. I don't see any extensions written in Python.  Are there any special
requirements or exclusions for Python scripts?
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
