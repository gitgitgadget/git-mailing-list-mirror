From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] diffcore-pickaxe doc: document -S and -G properly
Date: Fri, 24 May 2013 16:03:55 +0530
Message-ID: <1369391635-13056-3-git-send-email-artagnon@gmail.com>
References: <1369391635-13056-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 24 12:32:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfpIT-0007LH-58
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 12:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760401Ab3EXKcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 06:32:22 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:34819 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760386Ab3EXKcT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 06:32:19 -0400
Received: by mail-pb0-f41.google.com with SMTP id xb12so4069473pbc.0
        for <git@vger.kernel.org>; Fri, 24 May 2013 03:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=v1fW5VvyomOf4mITUwY4tleWiWDbIcHyUcIXQDFWCWg=;
        b=cHM1SCuvmwhryWcfl9kP+TXVEywF8IkFicDX86XjSnF47I4vYn7yTfE7Co0FnSyPq4
         ngQQrW/tFSxl8BqC02fWfBeM06MErL+pIGN4nm+bVvM9G57quhchL22TstkjPzogDgmt
         Sk29siQssGmUiIFRM2sQIJRjlCd+XeySj/SkipuoS3B6SOChFEby6z1K30PiSoS3BokT
         mQVyWw5M9IQelOa1yYPm5D2RCT2NKC01KONRsroJr5UpZoh01lzGgbj560HUgQmJd4yI
         kOoHqs7KwcOIBVju/qh2sqq7bPjW3UovXpzOY+YD0n5E03phQ1LPmt6llAQIyJbc9U7k
         Bo8g==
X-Received: by 10.66.120.164 with SMTP id ld4mr17652313pab.187.1369391539299;
        Fri, 24 May 2013 03:32:19 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id v7sm15680718pbq.32.2013.05.24.03.32.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 May 2013 03:32:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.17.gd95ec6c.dirty
In-Reply-To: <1369391635-13056-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225343>

The documentation of -S and -G is very sketchy.  Completely rewrite the
sections in Documentation/diff-options.txt and
Documentation/gitdiffcore.txt.

References:
52e9578 ([PATCH] Introducing software archaeologist's tool "pickaxe".)
f506b8e (git log/diff: add -G<regexp> that greps in the patch text)

Inputs-from: Phil Hord <phil.hord@gmail.com>
Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/diff-options.txt | 38 +++++++++++++++++++++++++++++--------
 Documentation/gitdiffcore.txt  | 43 ++++++++++++++++++++++++------------------
 2 files changed, 55 insertions(+), 26 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 104579d..2835eef 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -383,14 +383,36 @@ ifndef::git-format-patch[]
 	that matches other criteria, nothing is selected.
 
 -S<string>::
-	Look for differences that introduce or remove an instance of
-	<string>. Note that this is different than the string simply
-	appearing in diff output; see the 'pickaxe' entry in
-	linkgit:gitdiffcore[7] for more details.
+	Look for differences that change the number of occurrences of
+	the specified string (i.e. addition/deletion) in a file.
+	Intended for the scripter's use.
++
+It is especially useful when you're looking for an exact block of code
+(like a struct), and want to know the history of that block since it
+first came into being: use the feature iteratively to feed the
+interesting block in the preimage back into `-S`, and keep going until
+you get the very first version of the block.
 
 -G<regex>::
-	Look for differences whose added or removed line matches
-	the given <regex>.
+	Look for differences whose patch text contains added/removed
+	lines that match <regex>.
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
+occurrences of that string did not change).
++
+See the 'pickaxe' entry in linkgit:gitdiffcore[7] for more
+information.
 
 --pickaxe-all::
 	When `-S` or `-G` finds a change, show all the changes in that
@@ -398,8 +420,8 @@ ifndef::git-format-patch[]
 	in <string>.
 
 --pickaxe-regex::
-	Make the <string> not a plain string but an extended POSIX
-	regex to match.
+	Treat the <string> given to `-S` as an extended POSIX regular
+	expression to match.
 endif::git-format-patch[]
 
 -O<orderfile>::
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 568d757..ef4c04a 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -222,26 +222,33 @@ version prefixed with '+'.
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
+There are two kinds of pickaxe: the S kind (corresponding to 'git log
+-S') and the G kind (mnemonic: grep; corresponding to 'git log -G').
+
+"-S<block of text>" detects filepairs whose preimage and postimage
+have different number of occurrences of the specified block of text.
+By definition, it will not detect in-file moves.  Also, when a
+changeset moves a file wholesale without affecting the interesting
+string, rename detection kicks in as usual, and `-S` omits the
+filepair (since the number of occurrences of that string didn't change
+in that rename-detected filepair).  The implementation essentially
+runs a count, and is significantly cheaper than the G kind.  When used
+with `--pickaxe-regex`, treat the <block of text> as an extended POSIX
+regular expression to match, instead of a literal string.
+
+"-G<regular expression>" detects filepairs whose textual diff has an
+added or a deleted line that matches the given regular expression.
+This means that it can detect in-file (or what rename-detection
+considers the same file) moves.  The implementation runs diff twice
+and greps, and this can be quite expensive.
+
+When `-S` or `-G` are used without `--pickaxe-all`, only filepairs
+that match their respective criterion are kept in the output.  When
+`--pickaxe-all` is used, if even one filepair matches their respective
+criterion in a changeset, the entire changeset is kept.  This behavior
+is designed to make reviewing changes in the context of the whole
 changeset easier.
 
-
 diffcore-order: For Sorting the Output Based on Filenames
 ---------------------------------------------------------
 
-- 
1.8.3.rc3.17.gd95ec6c.dirty
