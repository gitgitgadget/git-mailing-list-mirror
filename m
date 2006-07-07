From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] diff.c: respect diff.renames config option
Date: Fri, 07 Jul 2006 03:10:44 -0700
Message-ID: <11522670473116-git-send-email-normalperson@yhbt.net>
References: <11522670452824-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jul 07 12:11:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FynIW-0002Au-8n
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 12:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWGGKKu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 06:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWGGKKu
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 06:10:50 -0400
Received: from hand.yhbt.net ([66.150.188.102]:11704 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932107AbWGGKKu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 06:10:50 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 2F38E7DC022;
	Fri,  7 Jul 2006 03:10:47 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri,  7 Jul 2006 03:10:47 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.1.g3dc65
In-Reply-To: <11522670452824-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23418>

diff.renames is mentioned several times in the documentation,
but to my surprise it didn't do anything before this patch.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/config.txt |    5 +++++
 diff.c                   |   12 ++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f075f19..5290a8f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -114,6 +114,11 @@ diff.renameLimit::
 	The number of files to consider when performing the copy/rename
 	detection; equivalent to the git diff option '-l'.
 
+diff.renames::
+	Tells git to detect renames.  If set to any boolean value, it
+	will enable basic rename detection.  If set to "copies" or
+	"copy", it will detect copies, as well.
+
 format.headers::
 	Additional email headers to include in a patch to be submitted
 	by mail.  See gitlink:git-format-patch[1].
diff --git a/diff.c b/diff.c
index 507e401..223622a 100644
--- a/diff.c
+++ b/diff.c
@@ -13,6 +13,7 @@ #include "xdiff-interface.h"
 
 static int use_size_cache;
 
+static int diff_detect_rename_default = 0;
 static int diff_rename_limit_default = -1;
 static int diff_use_color_default = 0;
 
@@ -120,6 +121,16 @@ int git_diff_config(const char *var, con
 			diff_use_color_default = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.renames")) {
+		if (!value)
+			diff_detect_rename_default = DIFF_DETECT_RENAME;
+		else if (!strcasecmp(value, "copies") ||
+			 !strcasecmp(value, "copy"))
+			diff_detect_rename_default = DIFF_DETECT_COPY;
+		else
+			diff_detect_rename_default = git_config_bool(var,value);
+		return 0;
+	}
 	if (!strncmp(var, "diff.color.", 11)) {
 		int slot = parse_diff_color_slot(var, 11);
 		diff_colors[slot] = parse_diff_color_value(value, var);
@@ -1429,6 +1440,7 @@ void diff_setup(struct diff_options *opt
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
 	options->color_diff = diff_use_color_default;
+	options->detect_rename = diff_detect_rename_default;
 }
 
 int diff_setup_done(struct diff_options *options)
-- 
1.4.1.g3dc65
