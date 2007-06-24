From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] diff: round down similarity index
Date: Mon, 25 Jun 2007 00:23:34 +0200
Message-ID: <467EEEE6.3090100@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jun 25 00:23:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2aUq-0003gD-RB
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 00:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbXFXWXs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 18:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbXFXWXs
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 18:23:48 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:40546
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751692AbXFXWXq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2007 18:23:46 -0400
Received: from [10.0.1.201] (p508E4382.dip.t-dialin.net [80.142.67.130])
	by neapel230.server4you.de (Postfix) with ESMTP id 9C87A7049;
	Mon, 25 Jun 2007 00:23:45 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50835>

Rounding down the printed (dis)similarity index allows us to use
"100%" as a special value that indicates complete rewrites and
fully equal file contents, respectively.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

The added documentation is only correct if you apply the
diffcore-rename patch, too.

 Documentation/diff-format.txt |    7 +++++++
 diff.c                        |   30 +++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 18d49d2..0015032 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -126,6 +126,13 @@ the file that rename/copy produces, respectively.
     If there is need for such substitution then the whole
     pathname is put in double quotes.
 
+The similarity index is the percentage of unchanged lines, and
+the dissimilarity index is the percentage of changed lines.  It
+is a rounded down integer, followed by a percent sign.  The
+similarity index value of 100% is thus reserved for two equal
+files, while 100% dissimilarity means that no line from the old
+file made it into the new one.
+
 
 combined diff format
 --------------------
diff --git a/diff.c b/diff.c
index 4aa9bbc..f1db55d 100644
--- a/diff.c
+++ b/diff.c
@@ -1813,6 +1813,19 @@ static void diff_fill_sha1_info(struct diff_filespec *one)
 		hashclr(one->sha1);
 }
 
+static int similarity_index(struct diff_filepair *p)
+{
+	int result = p->score * 100.0 / MAX_SCORE;
+
+	/* Paranoia: guard against floating point rounding errors. */
+	if (p->score == MAX_SCORE)
+		result = 100;
+	else if (result == 100)
+		result = 99;
+
+	return result;
+}
+
 static void run_diff(struct diff_filepair *p, struct diff_options *o)
 {
 	const char *pgm = external_diff();
@@ -1847,23 +1860,20 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 				"similarity index %d%%\n"
 				"copy from %s\n"
 				"copy to %s\n",
-				(int)(0.5 + p->score * 100.0/MAX_SCORE),
-				name_munged, other_munged);
+				similarity_index(p), name_munged, other_munged);
 		break;
 	case DIFF_STATUS_RENAMED:
 		len += snprintf(msg + len, sizeof(msg) - len,
 				"similarity index %d%%\n"
 				"rename from %s\n"
 				"rename to %s\n",
-				(int)(0.5 + p->score * 100.0/MAX_SCORE),
-				name_munged, other_munged);
+				similarity_index(p), name_munged, other_munged);
 		break;
 	case DIFF_STATUS_MODIFIED:
 		if (p->score) {
 			len += snprintf(msg + len, sizeof(msg) - len,
 					"dissimilarity index %d%%\n",
-					(int)(0.5 + p->score *
-					      100.0/MAX_SCORE));
+					similarity_index(p));
 			complete_rewrite = 1;
 			break;
 		}
@@ -2385,8 +2395,7 @@ static void diff_flush_raw(struct diff_filepair *p,
 	}
 
 	if (p->score)
-		sprintf(status, "%c%03d", p->status,
-			(int)(0.5 + p->score * 100.0/MAX_SCORE));
+		sprintf(status, "%c%03d", p->status, similarity_index(p));
 	else {
 		status[0] = p->status;
 		status[1] = 0;
@@ -2668,8 +2677,7 @@ static void show_rename_copy(const char *renamecopy, struct diff_filepair *p)
 {
 	char *names = pprint_rename(p->one->path, p->two->path);
 
-	printf(" %s %s (%d%%)\n", renamecopy, names,
-	       (int)(0.5 + p->score * 100.0/MAX_SCORE));
+	printf(" %s %s (%d%%)\n", renamecopy, names, similarity_index(p));
 	free(names);
 	show_mode_change(p, 0);
 }
@@ -2693,7 +2701,7 @@ static void diff_summary(struct diff_filepair *p)
 		if (p->score) {
 			char *name = quote_one(p->two->path);
 			printf(" rewrite %s (%d%%)\n", name,
-				(int)(0.5 + p->score * 100.0/MAX_SCORE));
+			       similarity_index(p));
 			free(name);
 			show_mode_change(p, 0);
 		} else	show_mode_change(p, 1);
