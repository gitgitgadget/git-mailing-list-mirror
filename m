From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-diff: allow  --no-index semantics a bit more
Date: Mon, 26 May 2008 22:36:39 -0700
Message-ID: <7vd4n82tqw.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 07:37:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0rsU-0006Co-IA
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 07:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbYE0Fgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 01:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbYE0Fgu
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 01:36:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48963 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbYE0Fgt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 01:36:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6BCDA2B56;
	Tue, 27 May 2008 01:36:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 689952B54; Tue, 27 May 2008 01:36:45 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E69C4FA6-2BAE-11DD-A577-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82983>

Even when inside a git work tree, if two paths are given and at least one
is clearly outside the work tree, it cannot be a request to diff a tracked
path anyway; allow such an invocation to use --no-index semantics.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 > * jc/diff-no-no-index (Fri May 23 22:28:56 2008 -0700) 3 commits
 >  + "git diff": do not ignore index without --no-index
 >  + diff-files: do not play --no-index games
 >  + tests: do not use implicit "git diff --no-index"
 >
 > This was done in response to recently discovered interaction with stgit;
 > we were too eater to invoke --no-index behaviour without being asked.
 > Currently it even drops the behaviour when you ask to compare two paths
 > that are outside of git work tree if your current directory is inside it,
 > which I think could safely resurrect, and then the whole thing will be
 > ready for 1.5.6.

 And this should hopefully be enough.

 diff-no-index.c |   39 ++++++++++++++++++++++++++++++++-------
 1 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 1b57fee..b1ae791 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -144,6 +144,25 @@ static int queue_diff(struct diff_options *o,
 	}
 }
 
+static int path_outside_repo(const char *path)
+{
+	/*
+	 * We have already done setup_git_directory_gently() so we
+	 * know we are inside a git work tree already.
+	 */
+	const char *work_tree;
+	size_t len;
+
+	if (!is_absolute_path(path))
+		return 0;
+	work_tree = get_git_work_tree();
+	len = strlen(work_tree);
+	if (strncmp(path, work_tree, len) ||
+	    (path[len] != '\0' && path[len] != '/'))
+		return 1;
+	return 0;
+}
+
 void diff_no_index(struct rev_info *revs,
 		   int argc, const char **argv,
 		   int nongit, const char *prefix)
@@ -162,13 +181,19 @@ void diff_no_index(struct rev_info *revs,
 			break;
 	}
 
-	/*
-	 * No explicit --no-index, but "git diff --opts A B" outside
-	 * a git repository is a cute hack to support.
-	 */
-	if (!no_index && !nongit)
-		return;
-
+	if (!no_index && !nongit) {
+		/*
+		 * Inside a git repository, without --no-index.  Only
+		 * when a path outside the repository is given,
+		 * e.g. "git diff /var/tmp/[12]", or "git diff
+		 * Makefile /var/tmp/Makefile", allow it to be used as
+		 * a colourful "diff" replacement.
+		 */
+		if ((argc != i + 2) ||
+		    (!path_outside_repo(argv[i]) &&
+		     !path_outside_repo(argv[i+1])))
+			return;
+	}
 	if (argc != i + 2)
 		die("git diff %s takes two paths",
 		    no_index ? "--no-index" : "[--no-index]");
-- 
1.5.6.rc0.13.g2d392
