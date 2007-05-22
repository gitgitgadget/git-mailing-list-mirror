From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-status: respect core.excludesFile
Date: Tue, 22 May 2007 01:12:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705220110401.6410@racer.site>
References: <Pine.LNX.4.64.0705212251300.6410@racer.site>
 <7v3b1pdbjf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 22 02:13:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqHzu-0003B8-28
	for gcvg-git@gmane.org; Tue, 22 May 2007 02:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbXEVANB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 20:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754732AbXEVANB
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 20:13:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:39566 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752449AbXEVANA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 20:13:00 -0400
Received: (qmail invoked by alias); 22 May 2007 00:12:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 22 May 2007 02:12:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XdtQAcVrX4sH3e1y1J+Me4mwfGRgo6BWvBKgA0v
	KAm9KgoNqrMCYE
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3b1pdbjf.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48064>


git-add reads this variable, and honours the contents of that file if that
exists. Match this behaviour in git-status, too.

Noticed by Evan Carroll on IRC.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 21 May 2007, Junio C Hamano wrote:
	
	> Sounds good, and probably is a 'maint' material.
	> 
	> Don't we need a documentation update and additional test for it,
	> though?

	Here you are.

 Documentation/config.txt           |    5 +++++
 Documentation/git-status.txt       |    5 +++++
 t/t3001-ls-files-others-exclude.sh |   20 ++++++++++++++++++++
 wt-status.c                        |    9 +++++++++
 4 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ee1c35e..179cb17 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -256,6 +256,11 @@ You probably do not need to adjust this value.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
+core.excludeFile::
+	In addition to '.gitignore' (per-directory) and
+	'.git/info/exclude', git looks into this file for patterns
+	of files which are not meant to be tracked.
+
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index e9e193f..d701538 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -42,6 +42,11 @@ mean the same thing and the latter is kept for backward
 compatibility) and `color.status.<slot>` configuration variables
 to colorize its output.
 
+As for gitlink:git-add[1], the configuration variable
+'core.excludesfile' can indicate a path to a file containing patterns
+of file names to exclude, in addition to patterns given in
+'info/exclude' and '.gitignore'.
+
 
 Author
 ------
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index db7a847..fcfcfbb 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -79,4 +79,24 @@ test_expect_success \
        >output &&
      git diff expect output'
 
+cat > excludes-file << EOF
+*.[1-8]
+e*
+EOF
+
+git-config core.excludesFile excludes-file
+
+git-runstatus | grep "^#	" > output
+
+cat > expect << EOF
+#	.gitignore
+#	a.6
+#	one/
+#	output
+#	three/
+EOF
+
+test_expect_success 'git-status honours core.excludesfile' \
+	'diff -u expect output'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index a055990..4bfe8f1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -22,6 +22,7 @@ static const char use_add_rm_msg[] =
 "use \"git add/rm <file>...\" to update what will be committed";
 static const char use_add_to_include_msg[] =
 "use \"git add <file>...\" to include in what will be committed";
+static const char *excludes_file;
 
 static int parse_status_slot(const char *var, int offset)
 {
@@ -259,6 +260,8 @@ static void wt_status_print_untracked(struct wt_status *s)
 	x = git_path("info/exclude");
 	if (file_exists(x))
 		add_excludes_from_file(&dir, x);
+	if (excludes_file && file_exists(excludes_file))
+		add_excludes_from_file(&dir, excludes_file);
 
 	read_directory(&dir, ".", "", 0, NULL);
 	for(i = 0; i < dir.nr; i++) {
@@ -356,5 +359,11 @@ int git_status_config(const char *k, const char *v)
 		int slot = parse_status_slot(k, 13);
 		color_parse(v, k, wt_status_colors[slot]);
 	}
+	if (!strcmp(k, "core.excludesfile")) {
+		if (!v)
+			die("core.excludesfile without value");
+		excludes_file = xstrdup(v);
+		return 0;
+	}
 	return git_default_config(k, v);
 }
-- 
1.5.2.746.g222b
