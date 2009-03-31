From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] Add configuration variable for sign-off to format-patch
Date: Tue, 31 Mar 2009 20:50:19 +0200
Message-ID: <20090331185018.GD72569@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 20:57:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loj7z-0006G7-2X
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 20:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758982AbZCaSu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 14:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755292AbZCaSuZ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 14:50:25 -0400
Received: from darksea.de ([83.133.111.250]:59181 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763798AbZCaSuW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 14:50:22 -0400
Received: (qmail 14427 invoked from network); 31 Mar 2009 20:50:07 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 31 Mar 2009 20:50:07 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115299>

If you regularly create patches which require a Signed-off: line you may
want to make it your default to add that line. It also helps you not to forget
to add the -s/--signoff switch.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

Because it happened to me twice already that I forgot to add the switch.

 Documentation/config.txt           |    4 ++++
 Documentation/git-format-patch.txt |    1 +
 builtin-log.c                      |   23 ++++++++++++++++-------
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ad22cb8..ed85536 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -715,6 +715,10 @@ format.thread::
 	A true boolean value is the same as `shallow`, and a false
 	value disables threading.
 
+format.signoff::
+	This lets you enable the -s/--signoff option of format-patch by
+	default. It takes a boolean value.
+
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
 	algorithm used by 'git-gc --aggressive'.  This defaults
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index c2eb5fa..c25ea10 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -197,6 +197,7 @@ more than one.
 	numbered = auto
 	cc = <email>
 	attach [ = mime-boundary-string ]
+	signoff = true
 ------------
 
 
diff --git a/builtin-log.c b/builtin-log.c
index c7a5772..d77b7fb 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -465,6 +465,7 @@ static void add_header(const char *value)
 #define THREAD_SHALLOW 1
 #define THREAD_DEEP 2
 static int thread = 0;
+static int do_signoff = 0;
 
 static int git_format_config(const char *var, const char *value, void *cb)
 {
@@ -514,6 +515,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		thread = git_config_bool(var, value) && THREAD_SHALLOW;
 		return 0;
 	}
+	if (!strcmp(var, "format.signoff")) {
+		do_signoff = git_config_bool(var, value);
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -865,13 +870,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		}
 		else if (!strcmp(argv[i], "--signoff") ||
 			 !strcmp(argv[i], "-s")) {
-			const char *committer;
-			const char *endpos;
-			committer = git_committer_info(IDENT_ERROR_ON_NO_NAME);
-			endpos = strchr(committer, '>');
-			if (!endpos)
-				die("bogus committer info %s", committer);
-			add_signoff = xmemdupz(committer, endpos - committer + 1);
+			do_signoff = 1;
 		}
 		else if (!strcmp(argv[i], "--attach")) {
 			rev.mime_boundary = git_version_string;
@@ -923,6 +922,16 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}
 	argc = j;
 
+	if(do_signoff) {
+		const char *committer;
+		const char *endpos;
+		committer = git_committer_info(IDENT_ERROR_ON_NO_NAME);
+		endpos = strchr(committer, '>');
+		if (!endpos)
+			die("bogus committer info %s", committer);
+		add_signoff = xmemdupz(committer, endpos - committer + 1);
+	}
+
 	for (i = 0; i < extra_hdr_nr; i++) {
 		strbuf_addstr(&buf, extra_hdr[i]);
 		strbuf_addch(&buf, '\n');
-- 
1.6.2.1.424.g0b27.dirty
