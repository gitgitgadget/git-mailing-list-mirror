From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] diffcore-pickaxe doc: document -S and -G properly
Date: Fri, 31 May 2013 17:42:15 +0530
Message-ID: <1370002335-6596-3-git-send-email-artagnon@gmail.com>
References: <1370002335-6596-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 31 14:10:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiOAL-0001P9-KI
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 14:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423Ab3EaMKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 08:10:38 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:46610 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755018Ab3EaMKe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 08:10:34 -0400
Received: by mail-pb0-f41.google.com with SMTP id xb12so2118455pbc.14
        for <git@vger.kernel.org>; Fri, 31 May 2013 05:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KT7OxclGf3xLTvIzyCtZMKv4eia+rY6PBLvhbGBSyVo=;
        b=Oc6qtR49KzFyHcArVSJA69UzwtXbzmhhOMqTCFYSIghNNZFvacpqPgJy6YlgbDMSFI
         b+CmTVIYs8JVMAKi7XcFrpi5eUCxbBwUYCJEZwR7SNnj4M68ot+FrHLFO5JWS8j1uEcD
         D5/vXcHhsVDcdWfWYg7g8sqVRNANqc3keirKUnb/NWDqB/FxvcsCHTY++rrFoJ8nz5CJ
         +2LhJiMBGI3xRjQyAK63sDE+tHVdmIkeqUVCo+STV7EJxcoP3kGV7rQ56hv17ytVKq+T
         zWmvaha4Gn6rEt4YMhgACbVcrXKUeJkkXqbiM87B4on86hcdCwRCiZoEzn96b4IIy3En
         TMmw==
X-Received: by 10.66.74.226 with SMTP id x2mr13121625pav.190.1370002233976;
        Fri, 31 May 2013 05:10:33 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id cp1sm46430663pbc.42.2013.05.31.05.10.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 31 May 2013 05:10:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.114.gcd03571
In-Reply-To: <1370002335-6596-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226090>

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
 Documentation/diff-options.txt | 38 +++++++++++++++++++++++++++--------
 Documentation/gitdiffcore.txt  | 45 +++++++++++++++++++++++++-----------------
 2 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index b8a9b86..a85288f 100644
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
+It is useful when you're looking for an exact block of code (like a
+struct), and want to know the history of that block since it first
+came into being: use the feature iteratively to feed the interesting
+block in the preimage back into `-S`, and keep going until you get the
+very first version of the block.
 
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
index 568d757..c8b3e51 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -222,26 +222,35 @@ version prefixed with '+'.
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
+This transformation limits the set of filepairs to those that change
+specified strings between the preimage and the postimage in a certain
+way.  -S<block of text> and -G<regular expression> options are used to
+specify different ways these strings are sought.
+
+"-S<block of text>" detects filepairs whose preimage and postimage
+have different number of occurrences of the specified block of text.
+By definition, it will not detect in-file moves.  Also, when a
+changeset moves a file wholesale without affecting the interesting
+string, diffcore-rename kicks in as usual, and `-S` omits the filepair
+(since the number of occurrences of that string didn't change in that
+rename-detected filepair).  When used with `--pickaxe-regex`, treat
+the <block of text> as an extended POSIX regular expression to match,
+instead of a literal string.
+
+"-G<regular expression>" (mnemonic: grep) detects filepairs whose
+textual diff has an added or a deleted line that matches the given
+regular expression.  This means that it will detect in-file (or what
+rename-detection considers the same file) moves, which is noise.  The
+implementation runs diff twice and greps, and this can be quite
+expensive.
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
1.8.3.114.gcd03571
