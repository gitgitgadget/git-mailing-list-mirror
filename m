From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff/diff-files: do not use --cc too aggressively
Date: Thu, 18 Sep 2008 02:08:54 -0700
Message-ID: <7v7i99zuqh.fsf_-_@gitster.siamese.dyndns.org>
References: <48D0B907.7040903@viscovery.net>
 <7vwsha6761.fsf@gitster.siamese.dyndns.org> <48D1EDB7.5070107@viscovery.net>
 <7vy71qyo9d.fsf@gitster.siamese.dyndns.org> <48D1F426.4040208@viscovery.net>
 <7vskryym24.fsf@gitster.siamese.dyndns.org> <48D203B3.90807@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 11:10:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgFWi-00075h-Vf
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 11:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbYIRJJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 05:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbYIRJJA
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 05:09:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333AbYIRJI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 05:08:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 905A862EC0;
	Thu, 18 Sep 2008 05:08:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D8BC562EBD; Thu, 18 Sep 2008 05:08:55 -0400 (EDT)
In-Reply-To: <48D203B3.90807@viscovery.net> (Johannes Sixt's message of "Thu,
 18 Sep 2008 09:30:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6D75E1CA-8561-11DD-A178-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96186>

Textual diff output for unmerged paths was too eager to give condensed
combined diff.  This has two problems:

 (1) "diff --base/--ours/--theirs" (and "diff-files -p" with the same) is
     a request to compare with the named stage.  We showed "-c -p" output
     instead;

 (2) "diff -c" (and "diff-files -c -p") is a request to view combined diff
     without condensing (otherwise the user would have explicitly asked
     for --cc, not -c).  We showed "--cc" output anyway.

0fe7c1d (built-in diff: assorted updates, 2006-04-29) claimed to be
careful about doing this, but its breakage was hidden because back then
"git diff" was still a shell script that did not use the codepath it
introduced fully.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-diff-files.c |    7 ++++++-
 builtin-diff.c       |    8 +++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 9bf10bb..2b578c7 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -50,7 +50,12 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	    3 < rev.max_count)
 		usage(diff_files_usage);
 
-	if (rev.max_count == -1 &&
+	/*
+	 * "diff-files --base -p" should not combine merges because it
+	 * was not asked to.  "diff-files -c -p" should not densify
+	 * (the user should ask with "diff-files --cc" explicitly).
+	 */
+	if (rev.max_count == -1 && !rev.combine_merges &&
 	    (rev.diffopt.output_format & DIFF_FORMAT_PATCH))
 		rev.combine_merges = rev.dense_combined_merges = 1;
 
diff --git a/builtin-diff.c b/builtin-diff.c
index 037c303..d5fe775 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -223,7 +223,13 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 		argv++; argc--;
 	}
 
-	if (revs->max_count == -1 &&
+	/*
+	 * "diff --base" should not combine merges because it was not
+	 * asked to.  "diff -c" should not densify (if the user wants
+	 * dense one, --cc can be explicitly asked for, or just rely
+	 * on the default).
+	 */
+	if (revs->max_count == -1 && !revs->combine_merges &&
 	    (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
 		revs->combine_merges = revs->dense_combined_merges = 1;
 
-- 
1.6.0.2.412.g0bc80
