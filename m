From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Change handling of RelNotes
Date: Fri, 31 Aug 2007 00:09:18 -0700
Message-ID: <7vveaw2na9.fsf@gitster.siamese.dyndns.org>
References: <316a20a40708301835hc4236d4tdb289b6f705ab86@mail.gmail.com>
	<200708310645.l7V6jKJk009287@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen Cuppett" <cuppett@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 09:09:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR0dK-00015R-VR
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 09:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbXHaHJ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 03:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758666AbXHaHJ3
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 03:09:29 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:60704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758788AbXHaHJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 03:09:28 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 5173712B86B;
	Fri, 31 Aug 2007 03:09:47 -0400 (EDT)
In-Reply-To: <200708310645.l7V6jKJk009287@mi0.bluebottle.com> (Nanako
	Shiraishi's message of "Fri, 31 Aug 2007 15:44:58 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57123>

Nanako Shiraishi <nanako3@bluebottle.com> writes:

> I sometimes have a checkout on a filesystem that does not support
> symbolic links, but I set core.symlink configuration variable to false
> in such a case.  Would it make sense to update "git init" to autodetect
> lack of symbolic link support in the filesystem?

Hmph.  Something along this line, perhaps?

 builtin-init-db.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index af15cb2..c411008 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -264,6 +264,22 @@ static int create_default_files(const char *git_dir, const char *template_path)
 		if (work_tree != git_work_tree_cfg)
 			git_config_set("core.worktree", work_tree);
 	}
+
+	/* Check if symlink is supported in the work tree */
+	if (!reinit) {
+		path[len] = 0;
+		strcpy(path + len, "tXXXXXX");
+		
+		if (!close(xmkstemp(path)) &&
+		    !unlink(path) &&
+		    !symlink("testing", path) &&
+		    !lstat(path, &st1) &&
+		    S_ISLNK(st1.st_mode))
+			; /* good */
+		else
+			git_config_set("core.symlinks", "false");
+	}
+
 	return reinit;
 }
 
