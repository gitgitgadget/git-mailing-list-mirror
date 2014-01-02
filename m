From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: [RFC] blame: new option to better handle merged cherry-picks
Date: Thu, 2 Jan 2014 18:55:37 +0100
Message-ID: <20140102175529.GA4669@client.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 02 18:57:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VymWZ-0002Ac-Mn
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 18:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbaABR5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 12:57:36 -0500
Received: from server.brlink.eu ([78.46.187.186]:37617 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbaABR5f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 12:57:35 -0500
Received: from workstation.brlink.eu 
	by server.brlink.eu with esmtpsa (tls-peer-hash VPEZql)
	id 1VymWS-00089B-N3; Thu, 02 Jan 2014 18:57:32 +0100
Received: with local; Thu, 02 Jan 2014 18:55:37 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239861>

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
With the new option --no-parent-shortcut it blames both changes to the
same commit.

Signed-off-by: Bernhard R. Link <brlink@debian.org>
---
 Documentation/blame-options.txt | 6 ++++++
 builtin/blame.c                 | 5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 0cebc4f..55dd12b 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -48,6 +48,12 @@ include::line-range-format.txt[]
 	Show the result incrementally in a format designed for
 	machine consumption.
 
+--no-parent-shortcut::
+	Always look at all parents of a merge and do not shortcut
+	to the first parent with no changes to the file looked at.
+	This takes more time but produces more reliable results
+	if branches with cherry-picked commits were merged.
+
 --encoding=<encoding>::
 	Specifies the encoding used to output author names
 	and commit summaries. Setting it to `none` makes blame
diff --git a/builtin/blame.c b/builtin/blame.c
index 4916eb2..dab2c36 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -45,6 +45,7 @@ static int incremental;
 static int xdl_opts;
 static int abbrev = -1;
 static int no_whole_file_rename;
+static int no_parent_shortcut;
 
 static enum date_mode blame_date_mode = DATE_ISO8601;
 static size_t blame_date_width;
@@ -1248,7 +1249,8 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 			porigin = find(sb, p, origin);
 			if (!porigin)
 				continue;
-			if (!hashcmp(porigin->blob_sha1, origin->blob_sha1)) {
+			if (!no_parent_shortcut &&
+			    !hashcmp(porigin->blob_sha1, origin->blob_sha1)) {
 				pass_whole_blame(sb, origin, porigin);
 				origin_decref(porigin);
 				goto finish;
@@ -2247,6 +2249,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	static const char *contents_from = NULL;
 	static const struct option options[] = {
 		OPT_BOOL(0, "incremental", &incremental, N_("Show blame entries as we find them, incrementally")),
+		OPT_BOOL(0, "no-parent-shortcut", &no_parent_shortcut, N_("Don't take shortcuts in some merges but handle cherry-picks better")),
 		OPT_BOOL('b', NULL, &blank_boundary, N_("Show blank SHA-1 for boundary commits (Default: off)")),
 		OPT_BOOL(0, "root", &show_root, N_("Do not treat root commits as boundaries (Default: off)")),
 		OPT_BOOL(0, "show-stats", &show_stats, N_("Show work cost statistics")),
-- 
1.8.5.1
