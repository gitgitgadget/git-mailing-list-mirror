From: linux@horizon.com
Subject: Re: More merge questions (why doesn't this work?)
Date: 2 Dec 2005 06:37:13 -0500
Message-ID: <20051202113713.11618.qmail@science.horizon.com>
References: <20051202091946.1631.qmail@science.horizon.com>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Dec 02 12:39:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ei9EW-00064K-Gq
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 12:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732AbVLBLhQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 06:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932733AbVLBLhQ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 06:37:16 -0500
Received: from science.horizon.com ([192.35.100.1]:17463 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932732AbVLBLhP
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 06:37:15 -0500
Received: (qmail 11619 invoked by uid 1000); 2 Dec 2005 06:37:13 -0500
To: junkio@cox.net
In-Reply-To: <20051202091946.1631.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13114>

> Yes.  The reason is git-read-tree's behaviour was changed
> underneath while octopus was looking elsewhere ;-).  See
> Documentation/technical/trivial-merge.txt, last couple of
> lines.

> There are two schools of thoughts about "both sides remove"
> (case #10) case.

Um, I'm looking at the one-side remove case, which t/t1000 calls

     O       A       B         result      index requirements
-------------------------------------------------------------------
 10  exists  O==A    missing   remove      ditto
 ------------------------------------------------------------------

while trivial-merge.txt says is:

case  ancest    head    remote    result
----------------------------------------
10    ancest^   ancest  (empty)   no merge

I assumed the test case was probably more accurate, given that it's coupled
to code which actually verifies the behaviour.

> Some people argued that "the branches might
> have renamed that path to different paths and might indicate a
> rename/rename conflict" (meaning read-tree should not consider
> it trivial, and leave that to upper level "policy layer" to
> decide).  merge-one-file policy simply says "no, they both
> wanted to remove them".  If I recall correctly, read-tree itself
> merged this case before multi-base rewrite happened (if you are
> curious, run 'git whatchanged -p read-tree.c' and look for
> "Rewrite read-tree").

Aren't you talking about case #6?

     O       A       B         result      index requirements
-------------------------------------------------------------------
  6  exists  missing missing   remove      must not exist.
 ------------------------------------------------------------------

case  ancest    head    remote    result
----------------------------------------
6     ancest+   (empty) (empty)   no merge

>> 1) The MAJOR difference between "git checkout" and "git reset --hard"

> True.  "git reset --hard" should be used without <rev> by
> novices and with <rev> after they understand what they are
> doing (it is used for rewinding/warping heads).

For the longest time I had been under the delusion that
"git-checkout <branch> *" and "git-reset --hard <branch>"
were very similar operations (modulo your comments about
deleting files): overwrite the index and working directory
files with the versions from that branch.

It's hard to say how much I managed to confuse myself by
damaging test repositories while I didn't understand what was
going on.

>> 2) Don't use "git branch" to create branches, unless you really
>>    *don't* want to switch to them.  Use "git checkout -b".

> Because...?  "git branch foo && git checkout foo" may be
> suboptimal to type, but it is not _wrong_; it does not do
> anything bad or incorrect.

Yes, I know it works.  I suggest avoiding it because there's a much
more convenient alternative and I kept forgetting the second half and
checking my changes in to the wrong branch.

>> 3) Dumb question: why does "git-commit-tree" need "-p" before the
>>    parent commit arguments?  Isn't just argv[2]..argv[argc-1]
>>    good enough?

> 1. Why not?
> 3. It does not matter; nobody types that command by hand.

Because it's a real pain to get it properly quoted and set up
in a shell script.  "$@" is a lot simpler and easier, and
old /bin/sh only has the one array which provides that magic
quoting behaviour.

(Admittedly, you usually pass the arguments through git-rev-parse
first, and are then guaranteed no embedded whitespace.)

> 4. It allows us to later add some other flags to commit-tree
>    (none planned currently).

Making it disappear wouldn't preclude having more options, either,
any more than the variable number of arguments to cp(1) or mv(1)...

>> 4) If the "git-read-tree" docs for "--reset", does "ignored" mean
>>    "not overwritten" or "overwritten"?

> That sentence is very poorly written; a better paraphrasing is
> appreciated.

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 8b91847..47e2f93 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -31,8 +31,8 @@ OPTIONS
 	Perform a merge, not just a read.
 
 --reset::
-
-        Same as -m except that unmerged entries will be silently ignored.
+        Same as -m except that unmerged entries will be silently overwritten
+	(instead of failing).
 
 -u::
 	After a successful merge, update the files in the work
@@ -47,7 +47,6 @@ OPTIONS
 	trees that are not directly related to the current
 	working tree status into a temporary index file.
 
-
 <tree-ish#>::
 	The id of the tree object(s) to be read/merged.
 

>> 5) The final "error" message on "git-merge --no-commit" is a bit
>>    alarming for a newbie who uses it...

> First of all, --no-commit is not meant to be used by newbies,
> but you are right.

Well, I can tell you that it's very very attractive to newbies.
The first 5 or 10 times I tried git-merge, I used --no-commit.
(My surprise was mostly that there wasn't a one-letter -x form.)
"Do something really complicated and then commit it to the repository"
is a frightening concept.  "Do something really complicated and
then stop and wait for you to see if it was what you expected" is
a lot more comforting.

>> 6) The "pickaxe" options are being a bit confusing, and the fact they're
>>    only documented in cvs-migration.txt doesn't help.

> Docs of git-diff-* family have OPTIONS section, at the end of
> which refers you to the diffcore documentation.  Suggestions to
> a better organization and a patch is appropriate here.

That's a bigger job; I'll work on it when I've finished the docs I'm
writing right. :-)

>> 7) The git-tag man page could use a little better description of -a.

> Please.  It should have the same "OPTIONS" section as others do.

I know NOTHING about asciidoc, and really wish I could fix its
lack-of-line-break problem:

GIT-BISECT(1)                                                    GIT-BISECT(1)

NAME
       git-bisect - Find the change that introduced a bug

SYNOPSIS
       git  bisect start git bisect bad <rev> git bisect good <rev> git bisect
       reset [<branch>] git bisect visualize git bisect replay  <logfile>  git
       bisect log

but emulating what I saw elsewhere...

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 95de436..7635b1e 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -10,6 +10,26 @@ SYNOPSIS
 --------
 'git-tag' [-a | -s | -u <key-id>] [-f | -d] [-m <msg>] <name> [<head>]
 
+OPTIONS
+-------
+-a::
+	Make an unsigned (anotation) tag object
+
+-s::
+	Make a GPG-signed tag, using the default e-mail address's key
+
+-u <key-id>::
+	Make a GPG-signed tag, using the given key
+
+-f::
+	Replace an existing tag with the given name (instead of failing)
+
+-d::
+	Delete an existing tag with the given name
+
+-m <msg>::
+	Use the given tag message (instead of prompting)
+
 DESCRIPTION
 -----------
 Adds a 'tag' reference in .git/refs/tags/
@@ -23,7 +43,7 @@ creates a 'tag' object, and requires the
 in the tag message.
 
 Otherwise just the SHA1 object name of the commit object is
-written (i.e. an lightweight tag).
+written (i.e. a lightweight tag).
 
 A GnuPG signed tag object will be created when `-s` or `-u
 <key-id>` is used.  When `-u <key-id>` is not used, the
