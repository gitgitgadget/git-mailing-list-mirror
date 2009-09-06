From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] status: make "how to stage" messages optional
Date: Sun, 6 Sep 2009 02:50:44 -0400
Message-ID: <20090906065044.GD28941@coredump.intra.peff.net>
References: <20090906064454.GA1643@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 08:50:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkBaS-00076l-FT
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 08:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521AbZIFGur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 02:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754369AbZIFGuq
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 02:50:46 -0400
Received: from peff.net ([208.65.91.99]:38697 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbZIFGup (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 02:50:45 -0400
Received: (qmail 9471 invoked by uid 107); 6 Sep 2009 06:51:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Sep 2009 02:51:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Sep 2009 02:50:44 -0400
Content-Disposition: inline
In-Reply-To: <20090906064454.GA1643@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127839>

These messages are nice for new users, but experienced git
users know how to manipulate the index, and these messages
waste a lot of screen real estate.

Signed-off-by: Jeff King <peff@peff.net>
---
This also actually cuts out the blank line after the instructions, so:

  # Changed but not updated:
  #   (use "git add <file>..." to update what will be committed)
  #   (use "git checkout -- <file>..." to discard changes in working directory)
  #
  #       modified:   file
  #

becomes:

  # Changed but not updated:
  #       modified:   file
  #

Arguably the blank should be left in.

 Documentation/config.txt |    4 ++++
 messages.c               |    1 +
 messages.h               |    1 +
 wt-status.c              |    8 ++++++++
 4 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ec308a6..cadbfc9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1215,6 +1215,10 @@ message.*::
 	pushNonFastForward::
 		Help message shown when linkgit:git-push[1] refuses
 		non-fast-forward refs. Default: true.
+	statusAdvice::
+		Directions on how to stage/unstage/add shown in the
+		output of linkgit:git-status[1] and the template shown
+		when writing commit messages. Default: true.
 --
 
 pack.window::
diff --git a/messages.c b/messages.c
index 00fc196..d2785b2 100644
--- a/messages.c
+++ b/messages.c
@@ -3,6 +3,7 @@
 
 struct message_preference messages[] = {
 	{ "pushnonfastforward", 1 },
+	{ "statusadvice", 1 },
 };
 
 int git_default_message_config(const char *var, const char *value)
diff --git a/messages.h b/messages.h
index f175747..8edd08e 100644
--- a/messages.h
+++ b/messages.h
@@ -2,6 +2,7 @@
 #define MESSAGE_H
 
 #define MESSAGE_PUSH_NONFASTFORWARD 0
+#define MESSAGE_STATUS_ADVICE 1
 
 struct message_preference {
 	const char *name;
diff --git a/wt-status.c b/wt-status.c
index 85f3fcb..716d8cc 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -48,6 +48,8 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 	color_fprintf_ln(s->fp, c, "# Unmerged paths:");
+	if (!messages[MESSAGE_STATUS_ADVICE].preference)
+		return;
 	if (!s->is_initial)
 		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);
 	else
@@ -60,6 +62,8 @@ static void wt_status_print_cached_header(struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 	color_fprintf_ln(s->fp, c, "# Changes to be committed:");
+	if (!messages[MESSAGE_STATUS_ADVICE].preference)
+		return;
 	if (!s->is_initial) {
 		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);
 	} else {
@@ -73,6 +77,8 @@ static void wt_status_print_dirty_header(struct wt_status *s,
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 	color_fprintf_ln(s->fp, c, "# Changed but not updated:");
+	if (!messages[MESSAGE_STATUS_ADVICE].preference)
+		return;
 	if (!has_deleted)
 		color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to update what will be committed)");
 	else
@@ -85,6 +91,8 @@ static void wt_status_print_untracked_header(struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 	color_fprintf_ln(s->fp, c, "# Untracked files:");
+	if (!messages[MESSAGE_STATUS_ADVICE].preference)
+		return;
 	color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to include in what will be committed)");
 	color_fprintf_ln(s->fp, c, "#");
 }
-- 
1.6.4.2.266.g981efc.dirty
