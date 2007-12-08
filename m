From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add status.relativePaths config variable
Date: Fri, 07 Dec 2007 23:47:56 -0800
Message-ID: <7vaboly6dv.fsf@gitster.siamese.dyndns.org>
References: <20071207165703.GA8889@sigill.intra.peff.net>
	<Pine.LNX.4.64.0712071853500.27959@racer.site>
	<4759996B.2000300@gmail.com>
	<20071207204937.GA20111@coredump.intra.peff.net>
	<20071207212607.GA11504@coredump.intra.peff.net>
	<7vejdxy70p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Harning <harningt@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 08 08:48:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0uQW-0002z6-Vx
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 08:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbXLHHsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 02:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752729AbXLHHsX
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 02:48:23 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:60024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbXLHHsW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 02:48:22 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DECD4099;
	Sat,  8 Dec 2007 02:48:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B3F6B4098;
	Sat,  8 Dec 2007 02:48:05 -0500 (EST)
In-Reply-To: <7vejdxy70p.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 07 Dec 2007 23:34:14 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67521>

Junio C Hamano <gitster@pobox.com> writes:

> I have been wondering ever since receiving this patch if this is a good
> interface change.  Was there a problem if instead:
>
> 	- The implementation of wt_status_prepare(&s) stays as before;
>
> 	- run_status(), after calling wt_status_prepare(&s), notices the
>           configuration variable, and sets s.prefix conditionally;

Which would make the rewritten patch like this...

-- >8 --
From: Jeff King <peff@peff.net>
Date: Fri, 7 Dec 2007 16:26:07 -0500
Subject: [PATCH] add status.relativePaths config variable

The output of git-status was recently changed to output relative
paths. Setting this variable to false restores the old behavior for
any old-timers that prefer it.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt     |    6 ++++++
 Documentation/git-status.txt |    5 ++++-
 builtin-commit.c             |    3 ++-
 t/t7502-status.sh            |   31 +++++++++++++++++++++++++++++++
 wt-status.c                  |    6 ++++++
 wt-status.h                  |    1 +
 6 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 736fcd7..79d51f2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -762,6 +762,12 @@ showbranch.default::
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
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index b0cb6bc..bd4d787 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -42,7 +42,10 @@ template comments, and all the output lines are prefixed with '#'.
 
 The paths mentioned in the output, unlike many other git commands, are
 made relative to the current directory, if you are working in a
-subdirectory (this is on purpose, to help cutting and pasting).
+subdirectory (this is on purpose, to help cutting and pasting).  You can
+restore the older behaviour of showing the paths as relative to the top
+of the work tree by setting `status.relativepaths` configuration
+variable to `false`.
 
 
 CONFIGURATION
diff --git a/builtin-commit.c b/builtin-commit.c
index 2ec8223..19297ac 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -285,7 +285,8 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix)
 	struct wt_status s;
 
 	wt_status_prepare(&s);
-	s.prefix = prefix;
+	if (wt_status_relative_paths)
+		s.prefix = prefix;
 
 	if (amend) {
 		s.amend = 1;
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
index 05414bb..51c1879 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -8,6 +8,7 @@
 #include "revision.h"
 #include "diffcore.h"
 
+int wt_status_relative_paths = 1;
 int wt_status_use_color = 0;
 static char wt_status_colors[][COLOR_MAXLEN] = {
 	"",         /* WT_STATUS_HEADER: normal */
@@ -400,6 +401,11 @@ int git_status_config(const char *k, const char *v)
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
index 225fb4d..63d50f2 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -28,6 +28,7 @@ struct wt_status {
 
 int git_status_config(const char *var, const char *value);
 int wt_status_use_color;
+int wt_status_relative_paths;
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 
-- 
1.5.3.7-2182-g108b
