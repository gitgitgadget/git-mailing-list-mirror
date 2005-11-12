From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: git-merge-recursive: documentation and implementation notes
Date: Sat, 12 Nov 2005 21:34:57 +0100
Message-ID: <20051112203457.GA5234@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat Nov 12 21:35:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb25e-000350-5e
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 21:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVKLUfG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 15:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVKLUfG
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 15:35:06 -0500
Received: from [85.8.31.11] ([85.8.31.11]:50837 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S964786AbVKLUfE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 15:35:04 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 40D644102; Sat, 12 Nov 2005 21:43:35 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1Eb25R-0001XK-00; Sat, 12 Nov 2005 21:34:57 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11705>

Hi,

This mail contains the promised documentation for the recursive merge
strategy. I don't really know where or even if this belongs in the Git
repository, so I am not posting it as a patch. If it is understandable
it might be appropriate for Documentaion/technical.



This note is supposed to describe how the recursive merge strategy
works. As I am not a native English speaker comments regarding
spelling and grammar are more than welcome. Comments on the content
is, of course, even more welcome :)

The fundamental merge problem that the recursive strategy tries to
solve is when there are more than one common ancestor of the branches
we want to merge. This happens, for example, in the "criss-cross"
merge case:

A
|\
| \
|  \
|   \
|    \
|     \
|      \
B8      C3
|\     /|
| \   / |
|  \ /  |
|   X   |
|  / \  |
| /   \ |
|/     \|
D8      E3
 \      |
  \     |
   \    |
    \   |
     \  |
      \ |
       \|
        M

(This example and the ASCII graphic are from Bram Cohen's excellent
description of the criss-cross case in
http://marc.theaimsgroup.com/?l=git&m=111463358500362&w=2)

We have a common base A, at commit B and D line 8 was changed and at
commit C and E line 3 was changed. There is only one file, so the same
file is modified in B, C, D and E. The result of the merge is called
M.

If we do a classical three-way merge of D and E with either A, B or C
as the common ancestor we will get conflicts. Theoretically this
shouldn't happen as both the D branch and the E branch knows about the
changes made at both B and C, the theoretical clean merge should
therefore contain line number 3 from E and line number 8 from D.

The recursive merge strategy solves this problem by recursively
merging any common ancestors. Hence, in the criss-cross scenario above
the code will detect that D and E has both B and C as their common
ancestor. It will then recursively merge B with C. The common ancestor
of B and C is A. When there is only one common ancestor an ordinary
three-way merge is done (modulo renames, will talk about those
below). So in this case we will merge B and C with A as the common
ancestor to create a temporary tree. This new tree will then be used
as the common ancestor for a merge of D and E.

In some cases there are more than two common ancestor, for example
44583d380d189095fa959ec8ba87f0cb6deb15f5 in Thomas Gleixner's
historical Linux kernel repository has no less than six common
ancestors.

The recursive strategy also has some support for renamed objects.
Consider the following ancestry graph:

   O
  / \
 /   \
A     B

Let the file 'foo' be renamed to 'bar' in A. In the B branch 'foo' is
modified. The result of a merge of A and B will contain a file 'bar'
with whatever contents merge(1) produced given A/bar and B/foo as the
files to be merged and O/foo as the ancestor. Renames are detected by
executing 'git-diff-tree -M --diff-filter=R <branch> <ancestor>' for
both branches. The rename processing may be seen as a pre-processing
step to the three-way merge procedure in the sense that renames are
processed first and then the ordinary file-level merging is done.

There are, essentially, only two merge scenarios which involves
renames that are cleanly merged. The first one is the case described
above when a file is renamed (and possibly modified) in one branch and
modified in the other branch. The other scenario is when the same file
is renamed to the same new name in both branches. However, there are
several scenarios which causes conflicts, if for example we are going
to merge the branches A and B then the following table contain a few
of the conflict cases:

In A                  In B
-------------------------------------
rename a -> b         rename a -> c
rename a -> b         rename c -> b
add a                 rename b -> a
delete a              rename a -> b

(Each line should be interpreted as an individual scenario, file names
on different lines do not have anything in common.)


There is currently no support for directory renames. If a directory is
renamed it will be processed as if every file in the directory was
renamed. This will cause clean merges of certain cases which probably
should be conflicts. (Such as: directory 'foo' is renamed to 'bar' in
one branch, in the other branch a new file 'foo/baz' is added. With
the current code we will end up with both a 'foo' directory,
containing 'foo/baz', and a 'bar' directory containing whatever 'foo'
contained in the common ancestor. A better outcome would probably be
to flag this as a conflict.)

The code tries, as far as possible, to let the user know what happens
in the conflict cases. The idea is that the user shouldn't have to
guess what the algorithm has done when she stumbles upon some strange
corner case. For example, if a file 'foo/bar' is added in the branch
'testing' and 'baz' is renamed to 'foo' in the branch 'release' then
the user will be given the message:

    CONFLICT (rename/directory): Rename baz => foo in branch release directory foo added in testing
    Renaming baz to foo~release instead

(The file name 'foo~release' is carefully constructed to not overwrite
any existing files.)


What follows is pseudo code which describes the algorithm from a
high-level point of view. Text within [brackets] is either a name of a
Python function where the real code can be found or a short
description of where the code can be found. Currently, the code is
contained in two files, git-merge-recursive.py and gitMergeCommon.py.

[merge]
merge(A, B)
{
    [getCommonAncestors]
    commonAncestors = getCommonAncestors(A, B)

    mergeCommonAncestor = commonAncestors[0]
    for(i = 1; i < length(commonAncestors); i++) {
        mergedCommonAncestor = merge(mergedCommonAncestor, commonAncestors[i])
    }

    [in mergeTrees]
    git-read-tree -m mergeCommonAncestor A B

    [loop in mergeTrees, git-diff-tree execution in getRenames]
    for each file in either
        'git-diff-tree -M --diff-filter=R -r mergeCommonAncestor A' or
        'git-diff-tree -M --diff-filter=R -r mergeCommonAncestor B':
        
	[processRenames]
        All rename processing is done here. This includes detection of
        various conflict cases and merge the 'rename in one branch and
        modified in the other'-case 
        
        [processRenames]
        For every file which is merged cleanly update the index


    [loop in mergeTrees]
    for each file which is still 'unmerged' in the index:

        [processEntry]
        Do a file-level merge. This is more or less the same thing as
        git-merge-one-file does, but it is implemented in Python.

    Return the new merged tree. 
}

Please note that the pseudo code above just is a sketch of the real
code. One important difference is that in the real code a resulting
tree is always returned from the 'merge'-function as soon as the
'merge'-function has been called recursively.

Lets assume there is a merge conflict when we merge B and C in the
criss-cross case above. Then both D and E must resolve this
conflict. If they have done it in the same way we wont get a merge
conflict at M, if they have resolved it differently we will get a
merge conflict. In the first case there is no merge conflict at M, in
the second case the user has to pick which one of the two different
resolutions she wants.

Note that the algorithm will happily write non-clean merge results to
the object database during the "merge common ancestors" stage. Hence,
when we are merging B and C "internally" we will _not_ ask the user to
resolve any eventual merge conflicts.

The temporary trees and non-cleanly merged files which are written to
the object database are not removed when the merge is finished. Hence,
in some cases, there will be unreachable objects in the database after
a merge.

- Fredrik
