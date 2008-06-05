From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] git-blame: refactor code to emit "porcelain format"
 output
Date: Wed, 04 Jun 2008 23:09:06 -0700
Message-ID: <7v8wxk4dml.fsf_-_@gitster.siamese.dyndns.org>
References: <940824.46903.qm@web31808.mail.mud.yahoo.com>
 <200806032331.44514.jnareb@gmail.com>
 <7v3ant213k.fsf@gitster.siamese.dyndns.org>
 <200806041603.49555.jnareb@gmail.com>
 <7vd4mw4dpp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 08:10:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K48fw-00078A-Pb
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 08:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbYFEGJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 02:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbYFEGJY
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 02:09:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbYFEGJY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 02:09:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AF55A3DE6;
	Thu,  5 Jun 2008 02:09:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0EAAF3DE5; Thu,  5 Jun 2008 02:09:13 -0400 (EDT)
In-Reply-To: <7vd4mw4dpp.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 04 Jun 2008 23:07:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F12B2244-32C5-11DD-9007-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83862>

Both the --porcelain and --incremental format shared the same output
format but implemented with two identical codepaths.  This merges them
into one shared function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This is just a preparatory clean-up patch (on jc/blame topic)

 builtin-blame.c |   65 ++++++++++++++++++++++++++----------------------------
 1 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 5c7546d..4b9c601 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1479,6 +1479,34 @@ static void write_filename_info(const char *path)
 }
 
 /*
+ * Porcelain/Incremental format wants to show a lot of details per
+ * commit.  Instead of repeating this every line, emit it only once,
+ * the first time each commit appears in the output.
+ */
+static int emit_one_suspect_detail(struct origin *suspect)
+{
+	struct commit_info ci;
+
+	if (suspect->commit->object.flags & METAINFO_SHOWN)
+		return 0;
+
+	suspect->commit->object.flags |= METAINFO_SHOWN;
+	get_commit_info(suspect->commit, &ci, 1);
+	printf("author %s\n", ci.author);
+	printf("author-mail %s\n", ci.author_mail);
+	printf("author-time %lu\n", ci.author_time);
+	printf("author-tz %s\n", ci.author_tz);
+	printf("committer %s\n", ci.committer);
+	printf("committer-mail %s\n", ci.committer_mail);
+	printf("committer-time %lu\n", ci.committer_time);
+	printf("committer-tz %s\n", ci.committer_tz);
+	printf("summary %s\n", ci.summary);
+	if (suspect->commit->object.flags & UNINTERESTING)
+		printf("boundary\n");
+	return 1;
+}
+
+/*
  * The blame_entry is found to be guilty for the range.  Mark it
  * as such, and show it in incremental output.
  */
@@ -1493,22 +1521,7 @@ static void found_guilty_entry(struct blame_entry *ent)
 		printf("%s %d %d %d\n",
 		       sha1_to_hex(suspect->commit->object.sha1),
 		       ent->s_lno + 1, ent->lno + 1, ent->num_lines);
-		if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
-			struct commit_info ci;
-			suspect->commit->object.flags |= METAINFO_SHOWN;
-			get_commit_info(suspect->commit, &ci, 1);
-			printf("author %s\n", ci.author);
-			printf("author-mail %s\n", ci.author_mail);
-			printf("author-time %lu\n", ci.author_time);
-			printf("author-tz %s\n", ci.author_tz);
-			printf("committer %s\n", ci.committer);
-			printf("committer-mail %s\n", ci.committer_mail);
-			printf("committer-time %lu\n", ci.committer_time);
-			printf("committer-tz %s\n", ci.committer_tz);
-			printf("summary %s\n", ci.summary);
-			if (suspect->commit->object.flags & UNINTERESTING)
-				printf("boundary\n");
-		}
+		emit_one_suspect_detail(suspect);
 		write_filename_info(suspect->path);
 		maybe_flush_or_die(stdout, "stdout");
 	}
@@ -1615,24 +1628,8 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent)
 	       ent->s_lno + 1,
 	       ent->lno + 1,
 	       ent->num_lines);
-	if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
-		struct commit_info ci;
-		suspect->commit->object.flags |= METAINFO_SHOWN;
-		get_commit_info(suspect->commit, &ci, 1);
-		printf("author %s\n", ci.author);
-		printf("author-mail %s\n", ci.author_mail);
-		printf("author-time %lu\n", ci.author_time);
-		printf("author-tz %s\n", ci.author_tz);
-		printf("committer %s\n", ci.committer);
-		printf("committer-mail %s\n", ci.committer_mail);
-		printf("committer-time %lu\n", ci.committer_time);
-		printf("committer-tz %s\n", ci.committer_tz);
-		write_filename_info(suspect->path);
-		printf("summary %s\n", ci.summary);
-		if (suspect->commit->object.flags & UNINTERESTING)
-			printf("boundary\n");
-	}
-	else if (suspect->commit->object.flags & MORE_THAN_ONE_PATH)
+	if (emit_one_suspect_detail(suspect) ||
+	    (suspect->commit->object.flags & MORE_THAN_ONE_PATH))
 		write_filename_info(suspect->path);
 
 	cp = nth_line(sb, ent->lno);
-- 
1.5.6.rc1.12.g7f718
