From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] diffcore-pickaxe doc: document -S and -G properly
Date: Fri, 17 May 2013 17:53:23 +0530
Message-ID: <1368793403-4642-3-git-send-email-artagnon@gmail.com>
References: <1368793403-4642-1-git-send-email-artagnon@gmail.com>
Cc: Phil Hord <phil.hord@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 17 14:21:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdJfb-000113-6p
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 14:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851Ab3EQMVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 08:21:52 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:41578 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755803Ab3EQMVv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 08:21:51 -0400
Received: by mail-pd0-f176.google.com with SMTP id x10so3282360pdj.35
        for <git@vger.kernel.org>; Fri, 17 May 2013 05:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=45avrber1NBYkuXK9zYf1Y73NQ+v5IUwyf0GIyde1eg=;
        b=lhX9UVlMUJ3nQqqUAJx2uAPpx2FlM1TRWEiya5QyV9beGd+zDpr72wlB7R7PNC6Bpw
         bgR06GsYuCJMZ0HK5zjXqeqMxzHa8sGLOtpVB/FzLW7BqZrIs2Op4N96mupUjQm1qf+D
         wk6ahLNUDAQaK0LY/Z13hETCyOaUhK7kFJ7k/h92MkKzcO1laqBPlkrXoTtd7/XT/LRe
         V1KexBYChtfypTQgQg9pRUGQhKZBAGkxOLaM1BIB8xEf3Uzob+asuJ7OzP4B1UJRQHDM
         4YX81Hr9MP06czKzuI53tr/WwBzpCO5DX2U9UUGRPTzmH0EX00pZxgWZASODYn9NObEX
         0i2w==
X-Received: by 10.66.150.168 with SMTP id uj8mr47656295pab.34.1368793310747;
        Fri, 17 May 2013 05:21:50 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id rn7sm11064643pbc.12.2013.05.17.05.21.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 May 2013 05:21:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.2.432.g070c57d
In-Reply-To: <1368793403-4642-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224686>

The documentation of -S and -G is very sketchy.  Completely rewrite the
sections in Documentation/diff-options.txt and
Documentation/gitdiffcore.txt.

References:
52e9578 ([PATCH] Introducing software archaeologist's tool "pickaxe".)
f506b8e (git log/diff: add -G<regexp> that greps in the patch text)

Inputs-from: Phil Hord <phil.hord@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/diff-options.txt | 37 ++++++++++++++++++++++++++-------
 Documentation/gitdiffcore.txt  | 47 +++++++++++++++++++++++++-----------------
 2 files changed, 57 insertions(+), 27 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 104579d..b61a666 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -383,14 +383,35 @@ ifndef::git-format-patch[]
 	that matches other criteria, nothing is selected.
 
 -S<string>::
-	Look for differences that introduce or remove an instance of
-	<string>. Note that this is different than the string simply
-	appearing in diff output; see the 'pickaxe' entry in
-	linkgit:gitdiffcore[7] for more details.
+	Look for commits that change the number of occurrences of the
+	specified string (i.e. addition/ deletion) in a file.
+	Intended for the scripter's use.
++
+It is especially useful when you're looking for an exact block of code
+(like a struct), and want to know the history of that block since it
+first came into being.
 
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
@@ -398,8 +419,8 @@ ifndef::git-format-patch[]
 	in <string>.
 
 --pickaxe-regex::
-	Make the <string> not a plain string but an extended POSIX
-	regex to match.
+	Treat the <string> not as a plain string, but an extended
+	POSIX regex to match.  It is implied when `-G` is used.
 endif::git-format-patch[]
 
 -O<orderfile>::
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 568d757..d0f2b91 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -222,25 +222,34 @@ version prefixed with '+'.
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
+-S') and the G kind (mnemonic: grep; corresponding to 'git log -G').
+
+The S kind detects filepairs whose "result" side and "origin" side
+have different number of occurrences of specified string.  By
+definition, it will not detect in-file moves.  Also, when a commit
+moves a file wholesale without affecting the string being looked at,
+rename detection kicks in as usual, and 'git log -S' omits the commit
+(since the number of occurrences of that string didn't change in that
+rename-detected filepair).  The implementation essentially runs a
+count, and is significantly cheaper than the G kind.
+
+The G kind detects filepairs whose patch text has an added or a
+deleted line that matches the given regexp.  This means that it can
+detect in-file (or what rename-detection considers the same file)
+moves.  The implementation of 'git log -G' runs diff twice and greps,
+and this can be quite expensive.
+
+When `--pickaxe-regex` is used with `-S`, treat the <string> not as a
+plain string, but an extended POSIX regex to match.  It is implied
+when `-G` is used.
+
+When `--pickaxe-all` is not in effect, diffcore-pickaxe leaves only
+the filepairs that touch the specified string in its output.  When in
+effect, diffcore-pickaxe leaves all filepairs intact if there is such
+a filepair, or makes the output empty otherwise.  The latter behavior
+is designed to make reviewing of the changes in the context of the
+whole changeset easier.
 
 diffcore-order: For Sorting the Output Based on Filenames
 ---------------------------------------------------------
-- 
1.8.1.2.432.g070c57d
