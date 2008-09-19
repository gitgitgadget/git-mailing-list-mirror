From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v2] Bust the ghost of long-defunct diffcore-pathspec.
Date: Fri, 19 Sep 2008 22:12:53 +0200
Message-ID: <20080919201012.1705.10446.stgit@gandelf.nowhere.earth>
References: <7vbpz7tqsb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 22:12:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgmLQ-0000ex-4d
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 22:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbYISULg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 16:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbYISULg
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 16:11:36 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:55356 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754009AbYISULf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 16:11:35 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 5621A17B544
	for <git@vger.kernel.org>; Fri, 19 Sep 2008 22:11:33 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 239A417B5AC
	for <git@vger.kernel.org>; Fri, 19 Sep 2008 22:11:33 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 0AFAB1F00A
	for <git@vger.kernel.org>; Fri, 19 Sep 2008 22:12:54 +0200 (CEST)
In-Reply-To: <7vbpz7tqsb.fsf@gitster.siamese.dyndns.org>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96309>

This concept was retired by 77882f60d9df2fd410ba7d732b01738315643c05,
more than 2 years ago.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

This new version ought to address all points in the comments to my
original patch.

 Documentation/gitdiffcore.txt |   55 ++++++++++++++++-------------------------
 diffcore.h                    |    1 -
 2 files changed, 22 insertions(+), 34 deletions(-)

diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 2bdbc3d..e8041bc 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -36,11 +36,25 @@ files:
 
  - 'git-diff-tree' compares contents of two "tree" objects;
 
-In all of these cases, the commands themselves compare
-corresponding paths in the two sets of files.  The result of
-comparison is passed from these commands to what is internally
-called "diffcore", in a format similar to what is output when
-the -p option is not used.  E.g.
+In all of these cases, the commands themselves first optionally limit
+the two sets of files by any pathspecs given on their command-lines,
+and compare corresponding paths in the two resulting sets of files.
+
+The pathspecs are used to limit the world diff operates in.  They remove
+the filepairs outside the specified sets of pathnames.  E.g. If the
+input set of filepairs included:
+
+------------------------------------------------
+:100644 100644 bcd1234... 0123456... M junkfile
+------------------------------------------------
+
+but the command invocation was `git diff-files myfile`, then the
+junkfile entry would be removed from the list because only "myfile"
+is under consideration.
+
+The result of comparison is passed from these commands to what is
+internally called "diffcore", in a format similar to what is output
+when the -p option is not used.  E.g.
 
 ------------------------------------------------
 in-place edit  :100644 100644 bcd1234... 0123456... M file0
@@ -52,9 +66,8 @@ unmerged       :000000 000000 0000000... 0000000... U file6
 The diffcore mechanism is fed a list of such comparison results
 (each of which is called "filepair", although at this point each
 of them talks about a single file), and transforms such a list
-into another list.  There are currently 6 such transformations:
+into another list.  There are currently 5 such transformations:
 
-- diffcore-pathspec
 - diffcore-break
 - diffcore-rename
 - diffcore-merge-broken
@@ -62,38 +75,14 @@ into another list.  There are currently 6 such transformations:
 - diffcore-order
 
 These are applied in sequence.  The set of filepairs 'git-diff-{asterisk}'
-commands find are used as the input to diffcore-pathspec, and
-the output from diffcore-pathspec is used as the input to the
+commands find are used as the input to diffcore-break, and
+the output from diffcore-break is used as the input to the
 next transformation.  The final result is then passed to the
 output routine and generates either diff-raw format (see Output
 format sections of the manual for 'git-diff-{asterisk}' commands) or
 diff-patch format.
 
 
-diffcore-pathspec: For Ignoring Files Outside Our Consideration
----------------------------------------------------------------
-
-The first transformation in the chain is diffcore-pathspec, and
-is controlled by giving the pathname parameters to the
-'git-diff-{asterisk}' commands on the command line.  The pathspec is used
-to limit the world diff operates in.  It removes the filepairs
-outside the specified set of pathnames.  E.g. If the input set
-of filepairs included:
-
-------------------------------------------------
-:100644 100644 bcd1234... 0123456... M junkfile
-------------------------------------------------
-
-but the command invocation was `git diff-files myfile`, then the
-junkfile entry would be removed from the list because only "myfile"
-is under consideration.
-
-Implementation note.  For performance reasons, 'git-diff-tree'
-uses the pathname parameters on the command line to cull set of
-filepairs it feeds the diffcore mechanism itself, and does not
-use diffcore-pathspec, but the end result is the same.
-
-
 diffcore-break: For Splitting Up "Complete Rewrites"
 ----------------------------------------------------
 
diff --git a/diffcore.h b/diffcore.h
index cc96c20..8ae3578 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -92,7 +92,6 @@ extern struct diff_filepair *diff_queue(struct diff_queue_struct *,
 					struct diff_filespec *);
 extern void diff_q(struct diff_queue_struct *, struct diff_filepair *);
 
-extern void diffcore_pathspec(const char **pathspec);
 extern void diffcore_break(int);
 extern void diffcore_rename(struct diff_options *);
 extern void diffcore_merge_broken(void);
