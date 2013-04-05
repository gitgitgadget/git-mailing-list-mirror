From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2] submodule: print graph output next to submodule log
Date: Fri, 5 Apr 2013 17:12:08 +0100
Message-ID: <20130405161207.GQ2222@serenity.lan>
References: <a6f8377623599ef8f31cc63f7e038b5e8d04aa01.1365177990.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:03:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWJx-0002u6-I4
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161947Ab3DEQMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 12:12:19 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:60483 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161930Ab3DEQMS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 12:12:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 3FFFC6064D3;
	Fri,  5 Apr 2013 17:12:18 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8cko5mdY0seb; Fri,  5 Apr 2013 17:12:17 +0100 (BST)
Received: from hyena.aluminati.org (hyena.aluminati.org [10.0.49.221])
	by coyote.aluminati.org (Postfix) with ESMTP id 602B66064AA;
	Fri,  5 Apr 2013 17:12:17 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 529212307F;
	Fri,  5 Apr 2013 17:12:17 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qGP+btS5KjqD; Fri,  5 Apr 2013 17:12:16 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id A850D21445;
	Fri,  5 Apr 2013 17:12:10 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <a6f8377623599ef8f31cc63f7e038b5e8d04aa01.1365177990.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220182>

When running "git log -p --submodule=log", the submodule log is not
indented by the graph output, although all other lines are.  Fix this by
prepending the current line prefix to each line of the submodule log.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Fri, Apr 05, 2013 at 05:06:30PM +0100, John Keeping wrote:
> From: John Keeping <john@metanate.com>

That shouldn't have escaped here :-(  The email in the S-O-B is the
right one.

No other change from v1.

 diff.c      |  1 +
 submodule.c | 13 +++++++++----
 submodule.h |  1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index db952a5..28a742c 100644
--- a/diff.c
+++ b/diff.c
@@ -2255,6 +2255,7 @@ static void builtin_diff(const char *name_a,
 		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
 		show_submodule_summary(o->file, one ? one->path : two->path,
+				line_prefix,
 				one->sha1, two->sha1, two->dirty_submodule,
 				meta, del, add, reset);
 		return;
diff --git a/submodule.c b/submodule.c
index 975bc87..e728025 100644
--- a/submodule.c
+++ b/submodule.c
@@ -216,6 +216,7 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 }
 
 static void print_submodule_summary(struct rev_info *rev, FILE *f,
+		const char *line_prefix,
 		const char *del, const char *add, const char *reset)
 {
 	static const char format[] = "  %m %s";
@@ -226,6 +227,7 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 		struct pretty_print_context ctx = {0};
 		ctx.date_mode = rev->date_mode;
 		strbuf_setlen(&sb, 0);
+		strbuf_addstr(&sb, line_prefix);
 		if (commit->object.flags & SYMMETRIC_LEFT) {
 			if (del)
 				strbuf_addstr(&sb, del);
@@ -256,6 +258,7 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
 }
 
 void show_submodule_summary(FILE *f, const char *path,
+		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset)
@@ -280,16 +283,18 @@ void show_submodule_summary(FILE *f, const char *path,
 		message = "(revision walker failed)";
 
 	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
-		fprintf(f, "Submodule %s contains untracked content\n", path);
+		fprintf(f, "%sSubmodule %s contains untracked content\n",
+			line_prefix, path);
 	if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-		fprintf(f, "Submodule %s contains modified content\n", path);
+		fprintf(f, "%sSubmodule %s contains modified content\n",
+			line_prefix, path);
 
 	if (!hashcmp(one, two)) {
 		strbuf_release(&sb);
 		return;
 	}
 
-	strbuf_addf(&sb, "%sSubmodule %s %s..", meta, path,
+	strbuf_addf(&sb, "%s%sSubmodule %s %s..", line_prefix, meta, path,
 			find_unique_abbrev(one, DEFAULT_ABBREV));
 	if (!fast_backward && !fast_forward)
 		strbuf_addch(&sb, '.');
@@ -301,7 +306,7 @@ void show_submodule_summary(FILE *f, const char *path,
 	fwrite(sb.buf, sb.len, 1, f);
 
 	if (!message) /* only NULL if we succeeded in setting up the walk */
-		print_submodule_summary(&rev, f, del, add, reset);
+		print_submodule_summary(&rev, f, line_prefix, del, add, reset);
 	if (left)
 		clear_commit_marks(left, ~0);
 	if (right)
diff --git a/submodule.h b/submodule.h
index 3dc1b3f..c7ffc7c 100644
--- a/submodule.h
+++ b/submodule.h
@@ -19,6 +19,7 @@ int parse_submodule_config_option(const char *var, const char *value);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 void show_submodule_summary(FILE *f, const char *path,
+		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset);
-- 
1.8.2.452.gb520e27
