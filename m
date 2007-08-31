From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] autodetect core.symlinks in git-init
Date: Fri, 31 Aug 2007 00:22:25 -0700
Message-ID: <7vodgo2moe.fsf_-_@gitster.siamese.dyndns.org>
References: <316a20a40708301835hc4236d4tdb289b6f705ab86@mail.gmail.com>
	<200708310645.l7V6jKJk009287@mi0.bluebottle.com>
	<7vveaw2na9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen Cuppett" <cuppett@gmail.com>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 31 09:22:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR0q2-0004h6-9H
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 09:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbXHaHWi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 03:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbXHaHWi
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 03:22:38 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:60827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbXHaHWh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 03:22:37 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7420112A248;
	Fri, 31 Aug 2007 03:22:54 -0400 (EDT)
Cc: Nanako Shiraishi <nanako3@bluebottle.com>
In-Reply-To: <7vveaw2na9.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 31 Aug 2007 00:09:18 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57124>

We already autodetect if filemode is reliable on the filesystem
to deal with VFAT and friends.  Do the same for symbolic link
support.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The earlier one left the test symlink behind after testing is
   complete.  Embarrassing...

 builtin-init-db.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index af15cb2..763fa55 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -264,6 +264,21 @@ static int create_default_files(const char *git_dir, const char *template_path)
 		if (work_tree != git_work_tree_cfg)
 			git_config_set("core.worktree", work_tree);
 	}
+
+	/* Check if symlink is supported in the work tree */
+	if (!reinit) {
+		path[len] = 0;
+		strcpy(path + len, "tXXXXXX");
+		if (!close(xmkstemp(path)) &&
+		    !unlink(path) &&
+		    !symlink("testing", path) &&
+		    !lstat(path, &st1) &&
+		    S_ISLNK(st1.st_mode))
+			unlink(path); /* good */
+		else
+			git_config_set("core.symlinks", "false");
+	}
+
 	return reinit;
 }
 
