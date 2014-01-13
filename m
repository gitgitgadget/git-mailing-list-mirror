From: "Bernhard R. Link" <brlink@debian.org>
Subject: [RFC v2] blame: new option --prefer-first to better handle merged
 cherry-picks
Date: Mon, 13 Jan 2014 07:30:25 +0100
Message-ID: <20140113063008.GA3072@client.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 13 07:32:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2b4c-0004i5-Fv
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 07:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbaAMGcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 01:32:31 -0500
Received: from server.brlink.eu ([78.46.187.186]:46469 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbaAMGca (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 01:32:30 -0500
Received: from workstation.brlink.eu 
	by server.brlink.eu with esmtpsa (tls-peer-hash VPEZql)
	id 1W2b4V-0004d3-Bp; Mon, 13 Jan 2014 07:32:27 +0100
Received: with local; Mon, 13 Jan 2014 07:30:25 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240356>

Allows to disable the git blame optimization of assuming that if there is a
parent of a merge commit that has the exactly same file content, then
only this parent is to be looked at.

This optimization, while being faster in the usual case, means that in
the case of cherry-picks the blamed commit depends on which other commits
touched a file.

If for example one commit A modified both files b and c. And there are
commits B and C, B only modifies file b and C only modifies file c
(so that no conflicts happen), and assume A is cherry-picked as A'
and the two branches then merged:

--o-----B---A
   \         \
    ---C---A'--M---

Then without this new option git blame blames the A|A' changes of
file b to A while blaming the changes of c to A'.
With the new option --prefer-first it blames both changes to the
same commit and to the one more on the "left" side of the graph.

Signed-off-by: Bernhard R. Link <brlink@debian.org>
---
 Documentation/blame-options.txt | 6 ++++++
 builtin/blame.c                 | 7 +++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

 Differences to first round: rename option and describe the effect
 instead of the implementation in documentation.

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 0cebc4f..b2e7fb8 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -48,6 +48,12 @@ include::line-range-format.txt[]
 	Show the result incrementally in a format designed for
 	machine consumption.
 
+--prefer-first::
+	If a line was introduced by two commits (for example via
+	a merged cherry-pick), prefer the commit that was
+	first merged in the history of always following the
+	first parent.
+
 --encoding=<encoding>::
 	Specifies the encoding used to output author names
 	and commit summaries. Setting it to `none` makes blame
diff --git a/builtin/blame.c b/builtin/blame.c
index 4916eb2..8ea34cf 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -45,6 +45,7 @@ static int incremental;
 static int xdl_opts;
 static int abbrev = -1;
 static int no_whole_file_rename;
+static int prefer_first;
 
 static enum date_mode blame_date_mode = DATE_ISO8601;
 static size_t blame_date_width;
@@ -1248,7 +1249,8 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 			porigin = find(sb, p, origin);
 			if (!porigin)
 				continue;
-			if (!hashcmp(porigin->blob_sha1, origin->blob_sha1)) {
+			if (!prefer_first &&
+			    !hashcmp(porigin->blob_sha1, origin->blob_sha1)) {
 				pass_whole_blame(sb, origin, porigin);
 				origin_decref(porigin);
 				goto finish;
@@ -2247,7 +2249,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	static const char *contents_from = NULL;
 	static const struct option options[] = {
 		OPT_BOOL(0, "incremental", &incremental, N_("Show blame entries as we find them, incrementally")),
-		OPT_BOOL('b', NULL, &blank_boundary, N_("Show blank SHA-1 for boundary commits (Default: off)")),
+		OPT_BOOL(0, "prefer-first", &prefer_first, N_("Prefer blaming commits merged earlier")),
+		OPT_BOOL('b', NULL, &blank_boundary, N_("Show blank SHA-1 for boundary commits (Default: ff)")),
 		OPT_BOOL(0, "root", &show_root, N_("Do not treat root commits as boundaries (Default: off)")),
 		OPT_BOOL(0, "show-stats", &show_stats, N_("Show work cost statistics")),
 		OPT_BIT(0, "score-debug", &output_option, N_("Show output score for blame entries"), OUTPUT_SHOW_SCORE),
-- 
1.8.5.1

	Bernhard R. Link
-- 
F8AC 04D5 0B9B 064B 3383  C3DA AFFC 96D1 151D FFDC
