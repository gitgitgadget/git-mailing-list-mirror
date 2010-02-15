From: Mark Lodato <lodatom@gmail.com>
Subject: git-grep ignores untracked files
Date: Sun, 14 Feb 2010 19:35:37 -0500
Message-ID: <1266194137-25653-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 01:33:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgouJ-0003J8-61
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 01:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768Ab0BOAdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 19:33:41 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:24628 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365Ab0BOAdj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 19:33:39 -0500
Received: by qw-out-2122.google.com with SMTP id 5so359731qwi.37
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 16:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=MhZmZsPIWuT0eYNs/O/i4nyxNtcKJ+kjQBmL4D3jH+U=;
        b=ChQ2yJ5IAoANlBo/kVCkKJ7sQ7cq9J1EIyn1lLF6g0Q++oIBy52s8YhwARQYBqcvzC
         kuEr/EEeclURHIW+5hFtU0C/2o+CxxsiahbU14hKBIz9GqR++3hxThK9rPV7iInEba2d
         8uIa0rzHvTb1c+so8lwjwuvkvtRSVNXGzSx2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=aOoK8fZAb49XS3t93MIw0o8wIvlQ2Sr20zucDRw9LH/jjiBD9UB6V4LIur6naWnRV1
         YOMLObt4IfBnjOJMAIVtjJwXqsLvFVZipvyizfnk1Uq8c3Dt/SootUxGG4T2t1iVLs8k
         6Q7/GfM2izX0Obe4Hj1BMgVzuEPpIO/+LgVdw=
Received: by 10.224.115.74 with SMTP id h10mr2044406qaq.372.1266194019137;
        Sun, 14 Feb 2010 16:33:39 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 20sm3897042qyk.13.2010.02.14.16.33.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 16:33:38 -0800 (PST)
X-Mailer: git-send-email 1.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139951>

Currently, git-grep ignores untracked files in the working directory.
For example:

    $ pattern=qazxswedc
    $ echo $pattern > foo
    $ git grep $pattern || echo not found
    not found

This is annoying and counter-intuitive, since it *does* search modified
files with unstaged changes.  More importantly, this is undocumented.

The situation is much worse when untracked files are given on the
command line.  For example, the following command warns me that a file
does not exist, as expected.

    $ git grep $pattern does_not_exist
    fatal: ambiguous argument 'does_not_exist': unknown revision or path not in the working tree.
    Use '--' to separate paths from revisions

However, if I give it an untracked file, it just tells me there's no match.

    $ git grep $pattern foo || echo not found
    not found

In this case, I would expect the program to either search that file
(would be nice!) or die with an error message (I'll take this for now).
Furthermore, when '--' is given, even the non-existent case fails
silently.

    $ git grep $pattern -- does_not_exist || echo not found
    not found

So, what I would I like to see?  Ideally, something like the following
series of patches:

1. Document the current behavior in the man page.

2. Issue a warning if any paths (pattern or non-pattern) fail to match
any files.  Ideally, this would work in all cases (work tree, --cached,
and trees).  If an untracked file matches a pattern that also matches
a tracked file, there would be no warning - not sure what's best in this
case.  This warning should probably be disable-able with a flag, say
--no-warn-if-unmatched.

3. If neither --cached nor trees are given, and a non-pattern filename
is given that does not not exist in the cache, search this file as well.
(That is, instead of issuing a warning, just search it.)  If the
filename is a directory, issue a warning.

4. Add an --untracked flag that causes grep to search *all* files in the
working directory, not just tracked ones.  (This includes searches with
and without a pathspec.)  The option would be incompatible with --cached
or given trees.


I post this wish list for several reasons.  First, to see if anyone
agrees with me.  Second, to see if this patch series has a chance of
ever being accepted.  Third, to implant this idea into someones head so
they write it for me :).  I may try to do it myself, but it will take me
a while.

To get started, here's a shot at #1.

Mark

---- 8< ----
From 697d97ca45b5c7abe8c84c3caae28cf839c668ac Mon Sep 17 00:00:00 2001
From: Mark Lodato <lodatom@gmail.com>
Date: Sun, 14 Feb 2010 19:28:55 -0500
Subject: [PATCH] Documentation: clarify untracked files and <path>

Note that only tracked files are searched, that non-matching paths are
silently ignored, and that <path> is a glob(7) pattern.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-grep.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index e019e76..fdc05ec 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -27,7 +27,9 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Look for specified patterns in the working tree files, blobs
-registered in the index file, or given tree objects.
+registered in the index file, or given tree objects.  Only tracked files in
+the working tree are searched.  Paths that do not match are silently ignored,
+including paths to untracked files.
 
 
 OPTIONS
@@ -170,6 +172,10 @@ OPTIONS
 	Signals the end of options; the rest of the parameters
 	are <path> limiters.
 
+<path>...::
+	Only search files matching these wildcard patterns; see glob(7) for
+	the format.  If not given, all tracked files in the tree are searched.
+
 
 Example
 -------
-- 
1.7.0
