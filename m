From: Chris Parsons <chris@edendevelopment.co.uk>
Subject: [PATCH v2] Updated status to show 'Not currently on any branch' in red
Date: Thu, 22 May 2008 11:19:18 +0100
Message-ID: <056F10DF-524A-48F3-9D53-A8676335B6C3@edendevelopment.co.uk>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 12:20:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jz7uB-0005IW-9i
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 12:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933048AbYEVKTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 06:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761981AbYEVKTW
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 06:19:22 -0400
Received: from dedi38.dedi.blackcatnetworks.co.uk ([217.147.94.39]:44157 "HELO
	host1.edendevelopment.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1757934AbYEVKTW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 May 2008 06:19:22 -0400
Received: (qmail 5992 invoked by uid 0); 22 May 2008 10:19:19 -0000
Received: from unknown (HELO joseph.internal.edendevelopment.co.uk) (chris@edendevelopment.co.uk@82.69.83.105)
  by pa.rsons.org with ESMTPA; 22 May 2008 10:19:19 -0000
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82610>

This provides additional warning to users when attempting to
commit to a detached HEAD. It is configurable in color.status.nobranch.

Signed-off-by: Chris Parsons <chris@edendevelopment.co.uk>
---
Updated to incorporate changes suggested by Jeff King.

  Documentation/config.txt |    6 ++++--
  wt-status.c              |   11 ++++++++---
  wt-status.h              |    1 +
  3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 217980f..a073dc1 100644
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
index a44c543..78bc769 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -18,6 +18,7 @@ static char wt_status_colors[][COLOR_MAXLEN] = {
  	"\033[32m", /* WT_STATUS_UPDATED: green */
  	"\033[31m", /* WT_STATUS_CHANGED: red */
  	"\033[31m", /* WT_STATUS_UNTRACKED: red */
+	"\033[31m", /* WT_STATUS_NOBRANCH: red */
  };

  static const char use_add_msg[] =
@@ -38,6 +39,8 @@ static int parse_status_slot(const char *var, int  
offset)
  		return WT_STATUS_CHANGED;
  	if (!strcasecmp(var+offset, "untracked"))
  		return WT_STATUS_UNTRACKED;
+	if (!strcasecmp(var+offset, "nobranch"))
+		return WT_STATUS_NOBRANCH;
  	die("bad config variable '%s'", var);
  }

@@ -315,7 +318,8 @@ void wt_status_print(struct wt_status *s)
  {
  	unsigned char sha1[20];
  	s->is_initial = get_sha1(s->reference, sha1) ? 1 : 0;
-
+	const char* branch_color = color(WT_STATUS_HEADER);
+
  	if (s->branch) {
  		const char *on_what = "On branch ";
  		const char *branch_name = s->branch;
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
1.5.5.1.249.g3fdb.dirty
