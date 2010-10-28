From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v8 2/5] Raw diff output format for bulk moves.
Date: Fri, 29 Oct 2010 00:08:29 +0200
Message-ID: <1288303712-14662-3-git-send-email-ydirson@altern.org>
References: <1288303712-14662-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>, Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 29 00:09:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBaf1-0002AX-LL
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 00:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760282Ab0J1WJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 18:09:08 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:60553 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759734Ab0J1WI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 18:08:58 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 89E56D48049;
	Fri, 29 Oct 2010 00:08:52 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PBaeJ-0003p9-Cl; Fri, 29 Oct 2010 00:08:43 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1288303712-14662-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160239>

To distinguish the general bulk-move case (where the destination
directory was pre-existing) from the directory-rename case (where it
was not), the output of raw diff is displayed as "Rnnn a/* b/".  Those
cannot be confused with renames of files named "whatever/*" with a
literal star character, from the full-zero SHA1's.

Signed-off-by: Yann Dirson <ydirson@free.fr>
---
 Documentation/gitdiffcore.txt |    2 +-
 diff.c                        |    9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 93111ac..2538dc0 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -181,7 +181,7 @@ additional pass on top of the results of per-file rename detection.
 They are reported with NULL SHA1 id, in addition to the file renames:
 
 ------------------------------------------------
-:040000 040000 0000000... 0000000... R100 foo/ bar/
+:040000 040000 0000000... 0000000... R100 foo/* bar/
 :100644 100644 0123456... 1234567... R090 foo/file0 bar/file3
 :100644 100644 2345678... 2345678... R100 foo/file1 bar/file1
 :100644 100644 3456789... 3456789... R100 foo/file2 bar/file2
diff --git a/diff.c b/diff.c
index 2eba335..948eb76 100644
--- a/diff.c
+++ b/diff.c
@@ -3490,7 +3490,14 @@ static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)
 	if (p->status == DIFF_STATUS_COPIED ||
 	    p->status == DIFF_STATUS_RENAMED) {
 		const char *name_a, *name_b;
-		name_a = p->one->path;
+		if (p->is_bulkmove) {
+			/* append "*" to the first dirname */
+			char buf[PATH_MAX];
+			char *next = memccpy(buf, p->one->path, '\0', PATH_MAX);
+			next[-1] = '*'; *next = '\0';
+			name_a = buf;
+		} else
+			name_a = p->one->path;
 		name_b = p->two->path;
 		strip_prefix(opt->prefix_length, &name_a, &name_b);
 		write_name_quoted(name_a, opt->file, inter_name_termination);
-- 
1.7.2.3
