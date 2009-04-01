From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2] Add configuration variable for sign-off to format-patch
Date: Wed, 1 Apr 2009 19:51:54 +0200
Message-ID: <20090401175153.GA90421@macbook.lan>
References: <20090331185018.GD72569@macbook.lan> <20090331200457.GA23879@coredump.intra.peff.net> <20090331204338.GA88381@macbook.lan> <20090401102610.GC26181@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 01 19:53:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp4dK-00015d-OJ
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 19:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764875AbZDARwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 13:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932896AbZDARwB
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 13:52:01 -0400
Received: from darksea.de ([83.133.111.250]:43094 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932872AbZDARwA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 13:52:00 -0400
Received: (qmail 16618 invoked from network); 1 Apr 2009 19:51:43 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 1 Apr 2009 19:51:43 +0200
Content-Disposition: inline
In-Reply-To: <20090401102610.GC26181@coredump.intra.peff.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115404>

If you regularly create patches which require a Signed-off: line you may
want to make it your default to add that line. It also helps you not to forget
to add the -s/--signoff switch.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
This adds a note about the purpose of the Signed-off-by: line to the
Documentation this is the interdiff:

 diff --git a/Documentation/config.txt b/Documentation/config.txt
 index 9ccc28c..27cb7f1 100644
 --- a/Documentation/config.txt
 +++ b/Documentation/config.txt
 @@ -717,7 +717,10 @@ format.thread::
  
  format.signoff::
      A boolean value which lets you enable the `-s/--signoff` option of
 -    format-patch by default.
 +    format-patch by default. *Note:* Adding the Signed-off-by: line to a
 +    patch should be a conscious act and means that you certify you have
 +    the rights to submit this work under the same open source license.
 +    Please see the 'SubmittingPatches' document for further discussion.
  
  gc.aggressiveWindow::
  	The window size parameter used in the delta compression

 Documentation/config.txt           |    7 +++++++
 Documentation/git-format-patch.txt |    1 +
 builtin-log.c                      |   23 ++++++++++++++++-------
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ad22cb8..27cb7f1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -715,6 +715,13 @@ format.thread::
 	A true boolean value is the same as `shallow`, and a false
 	value disables threading.
 
+format.signoff::
+    A boolean value which lets you enable the `-s/--signoff` option of
+    format-patch by default. *Note:* Adding the Signed-off-by: line to a
+    patch should be a conscious act and means that you certify you have
+    the rights to submit this work under the same open source license.
+    Please see the 'SubmittingPatches' document for further discussion.
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
