From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Tue, 14 May 2013 19:42:39 +0530
Message-ID: <1368540759-25598-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 14 16:11:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcFwZ-00084Z-92
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 16:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757446Ab3ENOLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 10:11:01 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:47626 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624Ab3ENOLA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 10:11:00 -0400
Received: by mail-pd0-f170.google.com with SMTP id 10so464914pdi.15
        for <git@vger.kernel.org>; Tue, 14 May 2013 07:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=l09evsnhSwpC1GL4jzjQGk2AeDFlS3pjcQYwFtG9aW0=;
        b=DRjlD8GDp8ku+PD7aCbK5K0KLfAuVX5mC/ReXrZCiL82L1ZMQcVQQndmhxVXwSdPXW
         QO/IBsC6Pobu8qhiXFmC/tvFfQuQvV75SICNrpQ2aU7v/BUQJ4IpVO7RqrDrMf7Kg/4J
         XYaUJYNr/vjBnnOtpCRXc5hCO9k0wt3IP6/EfoZ8xO7TAumFoJQxDwCU+W4olHVKVfQu
         UllLoePeNHScz7zSSGMhybLLPniEP2hquAuDAErf/+utPZMvAoF1k9MJZS4N1xEGxW2E
         CjhL6+qbtsEDipXYRzav45knlei4e1xKl/bVM+XXFZDodK9+l0suHDqugePjRBrzMkAG
         Pz+g==
X-Received: by 10.68.200.162 with SMTP id jt2mr34092299pbc.138.1368540660247;
        Tue, 14 May 2013 07:11:00 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id gh9sm18398472pbc.37.2013.05.14.07.10.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 14 May 2013 07:10:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.61.g2cacfff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224299>

The documentation of -S and -G is very sketchy.  Completely rewrite the
sections in Documentation/diff-options.txt and
Documentation/gitdiffcore.txt.

References:
52e9578 ([PATCH] Introducing software archaeologist's tool "pickaxe".)
f506b8e (git log/diff: add -G<regexp> that greps in the patch text)

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 I spent some time reading the code and history to figure out what -S
 and -G really do.  I hope I've done justice.

 Documentation/diff-options.txt | 35 +++++++++++++++++++++++++++-------
 Documentation/gitdiffcore.txt  | 43 +++++++++++++++++++++++-------------------
 2 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 104579d..765abc5 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -383,14 +383,35 @@ ifndef::git-format-patch[]
 	that matches other criteria, nothing is selected.
 
 -S<string>::
-	Look for differences that introduce or remove an instance of
-	<string>. Note that this is different than the string simply
-	appearing in diff output; see the 'pickaxe' entry in
-	linkgit:gitdiffcore[7] for more details.
+	Look for commits where the specified string was added or
+	removed.  More precisely, find commits that change the number
+	of occurrences of the specified string.
++
+It is often useful when you're looking for an exact string (like a
+function prototype), and want to know the history of that string since
+it first came into being.
 
 -G<regex>::
-	Look for differences whose added or removed line matches
-	the given <regex>.
+	Grep through the patch text of commits for added/removed lines
+	that match <regex>.  `--pickaxe-regex` is implied in this
+	mode.
++
+To illustrate the difference between `-S<regex> --pickaxe-regex` and
+`-G<regex>`, consider a commit with the following diff in the same
+file:
++
+----
++    return !regexec(regexp, two->ptr, 1, &regmatch, 0);
+...
+-    hit = !regexec(regexp, mf2.ptr, 1, &regmatch, 0);
+----
++
+While `git log -G"regexec\(regexp"` will show this commit, `git log
+-S"regexec\(regexp" --pickaxe-regex` will not (because the number of
+occurrences of that string didn't change).
++
+See the 'pickaxe' entry in linkgit:gitdiffcore[7] for more
+information.
 
 --pickaxe-all::
 	When `-S` or `-G` finds a change, show all the changes in that
@@ -399,7 +420,7 @@ ifndef::git-format-patch[]
 
 --pickaxe-regex::
 	Make the <string> not a plain string but an extended POSIX
-	regex to match.
+	regex to match.  Implied when using `-G`.
 endif::git-format-patch[]
 
 -O<orderfile>::
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 568d757..39b9c51 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -222,25 +222,30 @@ version prefixed with '+'.
 diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
 ---------------------------------------------------------------------
 
-This transformation is used to find filepairs that represent
-changes that touch a specified string, and is controlled by the
--S option and the `--pickaxe-all` option to the 'git diff-*'
-commands.
-
-When diffcore-pickaxe is in use, it checks if there are
-filepairs whose "result" side and whose "origin" side have
-different number of specified string.  Such a filepair represents
-"the string appeared in this changeset".  It also checks for the
-opposite case that loses the specified string.
-
-When `--pickaxe-all` is not in effect, diffcore-pickaxe leaves
-only such filepairs that touch the specified string in its
-output.  When `--pickaxe-all` is used, diffcore-pickaxe leaves all
-filepairs intact if there is such a filepair, or makes the
-output empty otherwise.  The latter behaviour is designed to
-make reviewing of the changes in the context of the whole
-changeset easier.
-
+There are two kinds of pickaxe: the S kind (corresponding to 'git log
+-S') and the G kind (corresponding to 'git log -G').
+
+The S kind detects filepairs whose "result" side and "origin" side
+have different number of occurrences of specified string.  While
+rename detection works as usual, 'git log -S' cannot omit commits
+where a the small string being looked for is moved verbatim from one
+file to another (since the number of occurrences of that string
+changed in each of those two filepairs). The implementation
+essentially runs a count, and is significantly cheaper than the G
+kind.
+
+The G kind detects filepairs whose patch text has an added or a
+deleted line that matches the given regexp.  This means that it can
+detect in-file (or what rename-detection considers the same file)
+moves.  The implementation of 'git log -G' runs diff twice and greps,
+and this can be quite expensive.
+
+A diffcore-pickaxe option worth mentioning: `--pickaxe-all`.  When not
+in effect, diffcore-pickaxe leaves only such filepairs that touch the
+specified string in its output.  When in effect, diffcore-pickaxe
+leaves all filepairs intact if there is such a filepair, or makes the
+output empty otherwise.  The latter behavior is designed to make
+reviewing of the changes in the context of the whole changeset easier.
 
 diffcore-order: For Sorting the Output Based on Filenames
 ---------------------------------------------------------
-- 
1.8.3.rc1.61.g2cacfff
