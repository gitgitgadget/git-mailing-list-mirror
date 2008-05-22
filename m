From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Updated status to show 'Not currently on any
	branch' in red
Date: Thu, 22 May 2008 08:50:02 -0400
Message-ID: <20080522125002.GA23889@sigill.intra.peff.net>
References: <056F10DF-524A-48F3-9D53-A8676335B6C3@edendevelopment.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Chris Parsons <chris@edendevelopment.co.uk>
X-From: git-owner@vger.kernel.org Thu May 22 14:51:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzAG5-0005er-AS
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 14:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762349AbYEVMuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 08:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762117AbYEVMuH
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 08:50:07 -0400
Received: from peff.net ([208.65.91.99]:4530 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762308AbYEVMuF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 08:50:05 -0400
Received: (qmail 22736 invoked by uid 111); 22 May 2008 12:50:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 May 2008 08:50:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2008 08:50:02 -0400
Content-Disposition: inline
In-Reply-To: <056F10DF-524A-48F3-9D53-A8676335B6C3@edendevelopment.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82622>

From: Chris Parsons <chris@edendevelopment.co.uk>

This provides additional warning to users when attempting to
commit to a detached HEAD. It is configurable in color.status.nobranch.

Signed-off-by: Chris Parsons <chris@edendevelopment.co.uk>
Acked-by: Jeff King <peff@peff.net>
---
On Thu, May 22, 2008 at 11:19:18AM +0100, Chris Parsons wrote:

> Updated to incorporate changes suggested by Jeff King.

The improvements look good to me.

This patch was severely whitespaced damaged, probably due to:

  Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes

in the original, so I am resending an unmangled version for Junio's
convenience. Chris, please make sure to turn off flowed text when
sending future patches.

 Documentation/config.txt |    6 ++++--
 wt-status.c              |    9 +++++++--
 wt-status.h              |    1 +
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 217980f..554977b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -523,8 +523,10 @@ color.status.<slot>::
 	one of `header` (the header text of the status message),
 	`added` or `updated` (files which are added but not committed),
 	`changed` (files which are changed but not added in the index),
-	or `untracked` (files which are not tracked by git). The values of
-	these variables may be specified as in color.branch.<slot>.
+	`untracked` (files which are not tracked by git), or
+	`nobranch` (the color the 'no branch' warning is shown in, defaulting
+	to red). The values of these variables may be specified as in
+	color.branch.<slot>.
 
 commit.template::
 	Specify a file to use as the template for new commit messages.
diff --git a/wt-status.c b/wt-status.c
index a44c543..7a3223e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -18,6 +18,7 @@ static char wt_status_colors[][COLOR_MAXLEN] = {
 	"\033[32m", /* WT_STATUS_UPDATED: green */
 	"\033[31m", /* WT_STATUS_CHANGED: red */
 	"\033[31m", /* WT_STATUS_UNTRACKED: red */
+	"\033[31m", /* WT_STATUS_NOBRANCH: red */
 };
 
 static const char use_add_msg[] =
@@ -38,6 +39,8 @@ static int parse_status_slot(const char *var, int offset)
 		return WT_STATUS_CHANGED;
 	if (!strcasecmp(var+offset, "untracked"))
 		return WT_STATUS_UNTRACKED;
+	if (!strcasecmp(var+offset, "nobranch"))
+		return WT_STATUS_NOBRANCH;
 	die("bad config variable '%s'", var);
 }
 
@@ -315,6 +318,7 @@ void wt_status_print(struct wt_status *s)
 {
 	unsigned char sha1[20];
 	s->is_initial = get_sha1(s->reference, sha1) ? 1 : 0;
+	const char* branch_color = color(WT_STATUS_HEADER);
 
 	if (s->branch) {
 		const char *on_what = "On branch ";
@@ -323,10 +327,11 @@ void wt_status_print(struct wt_status *s)
 			branch_name += 11;
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_name = "";
+			branch_color = color(WT_STATUS_NOBRANCH);
 			on_what = "Not currently on any branch.";
 		}
-		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER),
-			"# %s%s", on_what, branch_name);
+		color_fprintf(s->fp, color(WT_STATUS_HEADER), "# ");
+		color_fprintf_ln(s->fp, branch_color, "%s%s", on_what, branch_name);
 	}
 
 	if (s->is_initial) {
diff --git a/wt-status.h b/wt-status.h
index 7d61410..f0675fd 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -8,6 +8,7 @@ enum color_wt_status {
 	WT_STATUS_UPDATED,
 	WT_STATUS_CHANGED,
 	WT_STATUS_UNTRACKED,
+	WT_STATUS_NOBRANCH,
 };
 
 struct wt_status {
-- 
1.5.5.1.450.gdbd2d
