From: Karl Chen <quarl@cs.berkeley.edu>
Subject: [PATCH v2] Support "core.excludesfile = ~/.gitignore"
Date: Mon, 25 Aug 2008 12:07:15 -0700
Message-ID: <quack.20080825T1207.lthk5e46hi4_-_@roar.cs.berkeley.edu>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu>
	<7vsksw92nh.fsf@gitster.siamese.dyndns.org>
	<quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu>
	<7vprnyqo59.fsf@gitster.siamese.dyndns.org>
	<20080824220854.GA27299@coredump.intra.peff.net>
	<7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
	<20080824231343.GC27619@coredump.intra.peff.net>
	<7vhc9aj82i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 21:08:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXhQO-0001zM-PY
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 21:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbYHYTHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 15:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753562AbYHYTHR
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 15:07:17 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:55816 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbYHYTHP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 15:07:15 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 7474C34452; Mon, 25 Aug 2008 12:07:15 -0700 (PDT)
X-Quack-Archive: 1
In-Reply-To: <7vhc9aj82i.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 24 Aug 2008 16\:40\:21 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93657>


The config variable core.excludesfile is parsed to substitute ~ and ~user with
getpw entries.

Signed-off-by: Karl Chen <quarl@quarl.org>
---
 config.c |   41 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 39 insertions(+), 2 deletions(-)


Based on the discussion it sounds like there are complications to
supporting relative paths (due to worktree config), and "$HOME"
(when generalized, due to bootstrapping issues with $GIT_*).

Since ~ and ~user are orthogonal to these, can I suggest going
forward with this, without blocking on those two?

I have reworked the patch to use getpw to support ~user.  $HOME
can eventually be supported via $ENVVARs.


diff --git a/config.c b/config.c
index 53f04a0..6a83c64 100644
--- a/config.c
+++ b/config.c
@@ -334,6 +334,42 @@ int git_config_string(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
+/*
+ * Expand ~ and ~user.  Returns a newly malloced string.  (If input does not
+ * start with "~", equivalent to xstrdup.)
+ */
+static char *expand_userdir(const char *value) {
+	if (value[0] == '~') {
+		struct passwd *pw;
+		char *expanded_dir;
+		const char *slash = strchr(value+1, '/');
+		const char *after_username = slash ? slash : value+strlen(value);
+		if (after_username == value+1) {
+			pw = getpwuid(getuid());
+			if (!pw) die("You don't exist!");
+		} else {
+			char save = *after_username;
+			*(char*)after_username = '\0';
+			pw = getpwnam(value+1);
+			if (!pw) die("No such user: '%s'", value+1);
+			*(char*)after_username = save;
+		}
+		expanded_dir = xmalloc(strlen(pw->pw_dir) + strlen(after_username) + 1);
+		strcpy(expanded_dir, pw->pw_dir);
+		strcat(expanded_dir, after_username);
+		return expanded_dir;
+	} else {
+		return xstrdup(value);
+	}
+}
+
+int git_config_userdir(const char **dest, const char *var, const char *value) {
+	if (!value)
+		return config_error_nonbool(var);
+	*dest = expand_userdir(value);
+	return 0;
+}
+
 static int git_default_core_config(const char *var, const char *value)
 {
 	/* This needs a better name */
@@ -456,8 +492,9 @@ static int git_default_core_config(const char *var, const char *value)
 	if (!strcmp(var, "core.editor"))
 		return git_config_string(&editor_program, var, value);
 
-	if (!strcmp(var, "core.excludesfile"))
-		return git_config_string(&excludes_file, var, value);
+	if (!strcmp(var, "core.excludesfile")) {
+		return git_config_userdir(&excludes_file, var, value);
+	}
 
 	if (!strcmp(var, "core.whitespace")) {
 		if (!value)
-- 
1.5.6.2
