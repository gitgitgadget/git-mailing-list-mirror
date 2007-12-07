From: Jeff King <peff@peff.net>
Subject: [PATCH] add status.relativePaths config variable
Date: Fri, 7 Dec 2007 16:26:07 -0500
Message-ID: <20071207212607.GA11504@coredump.intra.peff.net>
References: <20071207165703.GA8889@sigill.intra.peff.net> <Pine.LNX.4.64.0712071853500.27959@racer.site> <4759996B.2000300@gmail.com> <20071207204937.GA20111@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Harning <harningt@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:26:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0kiQ-0006fz-SA
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 22:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444AbXLGV0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 16:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754435AbXLGV0L
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 16:26:11 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3251 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754356AbXLGV0K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 16:26:10 -0500
Received: (qmail 13276 invoked by uid 111); 7 Dec 2007 21:26:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 07 Dec 2007 16:26:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Dec 2007 16:26:07 -0500
Content-Disposition: inline
In-Reply-To: <20071207204937.GA20111@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67462>

The output of git-status was recently changed to output
relative paths. Setting this variable to false restores the
old behavior for any old-timers that prefer it.

Signed-off-by: Jeff King <peff@peff.net>
---
On Fri, Dec 07, 2007 at 03:49:37PM -0500, Jeff King wrote:

> Personally, I don't like either the "../" or the "./", but I actually
> think the relative paths are less readable than the full paths in
> general.

So here is a config option to turn it off; I don't think there should be
any consistency problems, since git-status output is meant to be
human-readable (and after all, we just changed it :) ).

This patch also contains a small buglet fix in the neighboring code
where we didn't stop trying to match "color.status.*" even after we used
it to set the status color.

 Documentation/config.txt |    6 ++++++
 builtin-commit.c         |    3 +--
 builtin-revert.c         |    2 +-
 t/t7502-status.sh        |   31 +++++++++++++++++++++++++++++++
 wt-status.c              |   10 +++++++++-
 wt-status.h              |    2 +-
 6 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f0ffb9d..fabe7f8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -776,6 +776,12 @@ showbranch.default::
 	The default set of branches for gitlink:git-show-branch[1].
 	See gitlink:git-show-branch[1].
 
+status.relativePaths::
+	By default, gitlink:git-status[1] shows paths relative to the
+	current directory. Setting this variable to `false` shows paths
+	relative to the repository root (this was the default for git
+	prior to v1.5.4).
+
 tar.umask::
 	This variable can be used to restrict the permission bits of
 	tar archive entries.  The default is 0002, which turns off the
diff --git a/builtin-commit.c b/builtin-commit.c
index 18c6323..04b3bf1 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -284,8 +284,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix)
 {
 	struct wt_status s;
 
-	wt_status_prepare(&s);
-	s.prefix = prefix;
+	wt_status_prepare(&s, prefix);
 
 	if (amend) {
 		s.amend = 1;
diff --git a/builtin-revert.c b/builtin-revert.c
index 4bf8eb2..c285f8e 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -277,7 +277,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 		if (get_sha1("HEAD", head))
 			die ("You do not have a valid HEAD");
-		wt_status_prepare(&s);
+		wt_status_prepare(&s, NULL);
 		if (s.commitable)
 			die ("Dirty index: cannot %s", me);
 		discard_cache();
diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index d6ae69d..9ce50ca 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -88,4 +88,35 @@ test_expect_success 'status with relative paths' '
 
 '
 
+cat > expect << \EOF
+# On branch master
+# Changes to be committed:
+#   (use "git reset HEAD <file>..." to unstage)
+#
+#	new file:   dir2/added
+#
+# Changed but not updated:
+#   (use "git add <file>..." to update what will be committed)
+#
+#	modified:   dir1/modified
+#
+# Untracked files:
+#   (use "git add <file>..." to include in what will be committed)
+#
+#	dir1/untracked
+#	dir2/modified
+#	dir2/untracked
+#	expect
+#	output
+#	untracked
+EOF
+
+test_expect_success 'status without relative paths' '
+
+	git config status.relativePaths false
+	(cd dir1 && git status) > output &&
+	git diff expect output
+
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 02dbb75..b21b2c4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -8,6 +8,7 @@
 #include "revision.h"
 #include "diffcore.h"
 
+int wt_status_relative_paths = 1;
 int wt_status_use_color = 0;
 static char wt_status_colors[][COLOR_MAXLEN] = {
 	"",         /* WT_STATUS_HEADER: normal */
@@ -42,7 +43,7 @@ static const char* color(int slot)
 	return wt_status_use_color ? wt_status_colors[slot] : "";
 }
 
-void wt_status_prepare(struct wt_status *s)
+void wt_status_prepare(struct wt_status *s, const char *prefix)
 {
 	unsigned char sha1[20];
 	const char *head;
@@ -53,6 +54,8 @@ void wt_status_prepare(struct wt_status *s)
 	s->reference = "HEAD";
 	s->fp = stdout;
 	s->index_file = get_index_file();
+	if (wt_status_relative_paths)
+		s->prefix = prefix;
 }
 
 static void wt_status_print_cached_header(struct wt_status *s)
@@ -397,6 +400,11 @@ int git_status_config(const char *k, const char *v)
 	if (!prefixcmp(k, "status.color.") || !prefixcmp(k, "color.status.")) {
 		int slot = parse_status_slot(k, 13);
 		color_parse(v, k, wt_status_colors[slot]);
+		return 0;
+	}
+	if (!strcmp(k, "status.relativepaths")) {
+		wt_status_relative_paths = git_config_bool(k, v);
+		return 0;
 	}
 	return git_default_config(k, v);
 }
diff --git a/wt-status.h b/wt-status.h
index 225fb4d..0ed94f3 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -28,7 +28,7 @@ struct wt_status {
 
 int git_status_config(const char *var, const char *value);
 int wt_status_use_color;
-void wt_status_prepare(struct wt_status *s);
+void wt_status_prepare(struct wt_status *s, const char *prefix);
 void wt_status_print(struct wt_status *s);
 
 #endif /* STATUS_H */
-- 
1.5.3.7.2159.gde63a-dirty
