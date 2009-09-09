From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] status: make "how to stage" messages optional
Date: Wed, 9 Sep 2009 07:43:03 -0400
Message-ID: <20090909114303.GB31051@coredump.intra.peff.net>
References: <20090909112623.GA30765@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 13:43:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlLa2-000420-1J
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 13:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbZIILnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 07:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbZIILnH
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 07:43:07 -0400
Received: from peff.net ([208.65.91.99]:47242 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229AbZIILnG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 07:43:06 -0400
Received: (qmail 28000 invoked by uid 107); 9 Sep 2009 11:43:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 09 Sep 2009 07:43:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Sep 2009 07:43:03 -0400
Content-Disposition: inline
In-Reply-To: <20090909112623.GA30765@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128062>

These messages are nice for new users, but experienced git
users know how to manipulate the index, and these messages
waste a lot of screen real estate.

Signed-off-by: Jeff King <peff@peff.net>
---
Most changes are just from rebasing on the prior patch.

Since advice.statusAdvice was a bit redundant, I switched it to
advice.statusHints. Just advice.status was a bit too vague for my taste,
especially as we might want something like advice.statusCurrentBranch or
something later. statusHints is a little vague, too, so I'm open to
suggestions.

This version retains the "compact" output of the last version. I.e., no
newline between header and files, as there would be with the hints.
Like:

  # Changed but not updated:
          modified: foo

I tried looking at it both with and without the newline, and didn't feel
strongly. My reasoning was that people turning off the hints are
probably interested in compactness. Suggestions welcome.

 Documentation/config.txt |    4 ++++
 advice.c                 |    2 ++
 advice.h                 |    1 +
 wt-status.c              |    8 ++++++++
 4 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a35b918..8cbabe8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -122,6 +122,10 @@ advice.*::
 	pushNonFastForward::
 		Advice shown when linkgit:git-push[1] refuses
 		non-fast-forward refs. Default: true.
+	statusHints::
+		Directions on how to stage/unstage/add shown in the
+		output of linkgit:git-status[1] and the template shown
+		when writing commit messages. Default: true.
 --
 
 core.fileMode::
diff --git a/advice.c b/advice.c
index b5216a2..ae4b1e8 100644
--- a/advice.c
+++ b/advice.c
@@ -1,12 +1,14 @@
 #include "cache.h"
 
 int advice_push_nonfastforward = 1;
+int advice_status_hints = 1;
 
 static struct {
 	const char *name;
 	int *preference;
 } advice_config[] = {
 	{ "pushnonfastforward", &advice_push_nonfastforward },
+	{ "statushints", &advice_status_hints },
 };
 
 int git_default_advice_config(const char *var, const char *value)
diff --git a/advice.h b/advice.h
index 862bae3..e9df8e0 100644
--- a/advice.h
+++ b/advice.h
@@ -2,6 +2,7 @@
 #define ADVICE_H
 
 extern int advice_push_nonfastforward;
+extern int advice_status_hints;
 
 int git_default_advice_config(const char *var, const char *value);
 
diff --git a/wt-status.c b/wt-status.c
index 85f3fcb..38eb245 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -48,6 +48,8 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 	color_fprintf_ln(s->fp, c, "# Unmerged paths:");
+	if (!advice_status_hints)
+		return;
 	if (!s->is_initial)
 		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);
 	else
@@ -60,6 +62,8 @@ static void wt_status_print_cached_header(struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 	color_fprintf_ln(s->fp, c, "# Changes to be committed:");
+	if (!advice_status_hints)
+		return;
 	if (!s->is_initial) {
 		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);
 	} else {
@@ -73,6 +77,8 @@ static void wt_status_print_dirty_header(struct wt_status *s,
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 	color_fprintf_ln(s->fp, c, "# Changed but not updated:");
+	if (!advice_status_hints)
+		return;
 	if (!has_deleted)
 		color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to update what will be committed)");
 	else
@@ -85,6 +91,8 @@ static void wt_status_print_untracked_header(struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 	color_fprintf_ln(s->fp, c, "# Untracked files:");
+	if (!advice_status_hints)
+		return;
 	color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to include in what will be committed)");
 	color_fprintf_ln(s->fp, c, "#");
 }
-- 
1.6.5.rc0.173.g0bfef
