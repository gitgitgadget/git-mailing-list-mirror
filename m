From: newren@gmail.com
Subject: [PATCH] fast-export: Add a --full-tree option
Date: Mon, 28 Jun 2010 19:22:05 -0600
Message-ID: <1277774525-12530-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 29 03:20:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTPVH-0001IR-G3
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 03:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546Ab0F2BUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 21:20:42 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:41637 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab0F2BUl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 21:20:41 -0400
Received: by pxi8 with SMTP id 8so2063157pxi.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 18:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=jYeADPMfOPAf69VMvaKYtLUf0njp3QH6XmbweO3Th2A=;
        b=NLviUXcENPxzJ0kppGbWynVHWTgtnSUXSSZC/nkqdZj9L3S+gth8p4+X8NkD+aEojk
         F1pkc2KPUmN0lomIXrEvKD10fa0PFO/C2dL06BGlVtZ5IWn6pzkbV2LHWnHK40+dRz8w
         gL1QR0NRKLLNktiaYvTisjNwTptSJzk1Qf8k4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=djgT7pQ0syBZlZ/aUGsDrmmJyKjofWANKml5rVFDkvizNIfN+NGv4vaEsm+i1eG7l9
         ZQLZvKk3QVNOOA7PqxPKNKaZiEYNnLzJkLI7D9xb4ZoKg/kE0IBRfVlJFzjUXLNbcB8E
         rCyNCgBfc6pI+IiF8ij+M0T6YDEehw9jZ2JEc=
Received: by 10.142.8.21 with SMTP id 21mr4777058wfh.175.1277774440975;
        Mon, 28 Jun 2010 18:20:40 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id n2sm4241846wfl.13.2010.06.28.18.20.39
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 18:20:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.207.ga9fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149879>

From: Elijah Newren <newren@gmail.com>

This option makes fast-export issue a 'deleteall' directive and then the
full set of files that make up each commit, rather than just showing the
list of files that have changed since the (first) parent commit.

This is useful in at least two cases:

(1) When rewriting history for large repositories (i.e. where
git-filter-branch is much too slow to be functional), it is useful to use
fast-export + some filter + fast-import.  Sometimes it is easier to write
the necessary filter in terms of all the files in a commit rather than
just the differences from the first parent.

(2) When rewriting history and trying to remove early versions of some
subtrees, one can almost do so with the following recipe:
  Run fast-export once with a strict subset of paths up to a certain
  point in history, and then rerun fast-export on a more complete set of
  paths for the remainder of history.
Unfortunately, this results in files missing between the special history
point and their first modification after that time (and any unchanged
files in that span of history just missing altogether).  Running the
second fast-export with this new --full-tree option will fix this.

(git-filter-branch should be sufficient to handle the second usecase if
one is facing a situation that exactly matches that wording, but
variations of that usecase may result in fast-export being a better
choice for large repositories, and it would be nice to provide the
capability for it to handle such situations.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
This is a resend of an earlier patch that didn't get reviewed or make it
to pu.  I tried to make the commit message and documentation clearer and
explain in more detail the reasons for this change.

Also, note that this patch has a trivial dependence on my D/F conflict
fixes patch series that I just sent out, and will not apply cleanly (due
to a context region conflict) unless that patch series is applied first.
If wanted, I can change this by moving the t9350-fast-export.sh changes
to elsewhere in that file, or by rerolling this patch directly on top of
next.

 Documentation/git-fast-export.txt |    6 ++++++
 builtin/fast-export.c             |    8 +++++++-
 t/t9350-fast-export.sh            |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 98ec6b5..8a6a3cb 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -90,6 +90,12 @@ marks the same across runs.
 	resulting stream can only be used by a repository which
 	already contains the necessary objects.
 
+--full-tree::
+	This option will cause fast-export to issue a "deleteall"
+	directive for each commit followed by a full list of all files
+	in the commit (as opposed to just listing the files which are
+	different from the commit's first parent).
+
 [git-rev-list-args...]::
        A list of arguments, acceptable to 'git rev-parse' and
        'git rev-list', that specifies the specific objects and references
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9fe25ff..fe7a61b 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -26,6 +26,7 @@ static int progress;
 static enum { ABORT, VERBATIM, WARN, STRIP } signed_tag_mode = ABORT;
 static enum { ERROR, DROP, REWRITE } tag_of_filtered_mode = ABORT;
 static int fake_missing_tagger;
+static int full_tree;
 static int no_data;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
@@ -241,7 +242,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 		message += 2;
 
 	if (commit->parents &&
-	    get_object_mark(&commit->parents->item->object) != 0) {
+	    get_object_mark(&commit->parents->item->object) != 0 &&
+	    !full_tree) {
 		parse_commit(commit->parents->item);
 		diff_tree_sha1(commit->parents->item->tree->object.sha1,
 			       commit->tree->object.sha1, "", &rev->diffopt);
@@ -281,6 +283,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 		i++;
 	}
 
+	if (full_tree)
+		printf("deleteall\n");
 	log_tree_diff_flush(rev);
 	rev->diffopt.output_format = saved_output_format;
 
@@ -584,6 +588,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 			     "Import marks from this file"),
 		OPT_BOOLEAN(0, "fake-missing-tagger", &fake_missing_tagger,
 			     "Fake a tagger when tags lack one"),
+		OPT_BOOLEAN(0, "full-tree", &full_tree,
+			     "Output full tree for each commit"),
 		{ OPTION_NEGBIT, 0, "data", &no_data, NULL,
 			"Skip output of blob data",
 			PARSE_OPT_NOARG | PARSE_OPT_NEGHELP, NULL, 1 },
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 1ee1461..05c79ea 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -400,4 +400,39 @@ test_expect_success 'directory becomes symlink'        '
 	(cd result && git show master:foo)
 '
 
+cat >> dirtosymlink/expected << EOF
+blob
+mark :5
+data 6
+hello
+
+blob
+mark :6
+data 7
+badlink
+commit refs/heads/master
+mark :7
+author A U Thor <author@example.com> 1112912713 -0700
+committer C O Mitter <committer@example.com> 1112912713 -0700
+data 6
+three
+from :4
+deleteall
+M 100644 :5 bar/world
+M 120000 :6 foo
+
+EOF
+
+test_expect_success 'full-tree'        '
+	(
+		cd dirtosymlink &&
+		git fast-export --export-marks=marks master -- foo > output1 &&
+		rm foo &&
+		ln -s badlink foo &&
+		git commit -mthree foo &&
+		git fast-export --import-marks=marks --full-tree master -- foo bar > output &&
+		test_cmp output expected
+	)
+'
+
 test_done
-- 
1.7.2.rc0.212.g0c601
