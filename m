From: Jeff King <peff@peff.net>
Subject: [PATCH] log: respect log.shownotes variable
Date: Wed, 7 Apr 2010 16:45:36 -0400
Message-ID: <20100407204536.GA32382@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Apr 07 22:46:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzc8e-0007N5-6a
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 22:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539Ab0DGUp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 16:45:57 -0400
Received: from peff.net ([208.65.91.99]:33331 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878Ab0DGUp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 16:45:56 -0400
Received: (qmail 10678 invoked by uid 107); 7 Apr 2010 20:45:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 07 Apr 2010 16:45:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Apr 2010 16:45:36 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144283>

Log shows notes by default if no --pretty format is given.
However, depending on what's in your default notes ref, that
may actually be quite distracting when reading a normal log.
Let's let the user decide whether they want to see notes by
default.

Signed-off-by: Jeff King <peff@peff.net>
---
My git repository has your mailing list reference notes in
refs/notes/commits. They're quite bulky, and being headers, they look
kind of like a new commit stanza, which always confuses me when reading
log output. I got tired of typing --no-notes.

I guess an alternate solution would be for me to store them in some
other ref, and then use --show-notes=email when I do want to see them
(instead of just --show-notes, as I would do with this patch). But I
still wonder if log.shownotes is a sensible addition, just for the sake
of completeness.

 builtin/log.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 046f3e4..3d93607 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -24,6 +24,7 @@
 static const char *default_date_mode = NULL;
 
 static int default_show_root = 1;
+static int default_show_notes = 1;
 static int decoration_style;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
@@ -77,7 +78,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	argc = setup_revisions(argc, argv, rev, opt);
 
 	if (!rev->show_notes_given && !rev->pretty_given)
-		rev->show_notes = 1;
+		rev->show_notes = default_show_notes;
 	if (rev->show_notes)
 		init_display_notes(&rev->notes_opt);
 
@@ -291,6 +292,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		default_show_root = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "log.shownotes")) {
+		default_show_notes = git_config_bool(var, value);
+		return 0;
+	}
 	return git_diff_ui_config(var, value, cb);
 }
 
-- 
1.7.1.rc0.220.g92be4.dirty
