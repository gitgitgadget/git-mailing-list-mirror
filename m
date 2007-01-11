From: Junio C Hamano <junkio@cox.net>
Subject: Re: Removing files
Date: Thu, 11 Jan 2007 15:36:18 -0800
Message-ID: <7vzm8p16h9.fsf@assigned-by-dhcp.cox.net>
References: <87bql5cok3.fsf@morpheus.local>
	<7vejq12nlu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 00:36:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H59TL-0008W5-GV
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 00:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbXAKXgf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 18:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932813AbXAKXgf
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 18:36:35 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:53611 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932670AbXAKXgf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 18:36:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070111233634.EPEL19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jan 2007 18:36:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9zbj1W0031kojtg0000000; Thu, 11 Jan 2007 18:35:43 -0500
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <7vejq12nlu.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 11 Jan 2007 14:41:01 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36632>

Junio C Hamano <junkio@cox.net> writes:

> I think the right fix is to suggest "git add/rm" in status
> output and make "git rm" not barf if the user has already
> removed the file from the working tree.

This does the latter.  A separate patch will do the former.

-- >8 --

[PATCH] git-rm: do not fail on already removed file.

Often the user would do "/bin/rm foo" before telling git, but
then want to tell git about it.  "git rm foo" however would fail
because it cannot unlink(2) foo.

Treat ENOENT error return from unlink(2) as if a successful
removal happened.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-rm.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index 5b078c4..d81f289 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -32,6 +32,10 @@ static int remove_file(const char *name)
 	char *slash;
 
 	ret = unlink(name);
+	if (ret && errno == ENOENT)
+		/* The user has removed it from the filesystem by hand */
+		ret = errno = 0;
+
 	if (!ret && (slash = strrchr(name, '/'))) {
 		char *n = xstrdup(name);
 		do {
@@ -204,7 +208,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		return 0;
 
 	/*
-	 * Then, unless we used "--cache", remove the filenames from
+	 * Then, unless we used "--cached", remove the filenames from
 	 * the workspace. If we fail to remove the first one, we
 	 * abort the "git rm" (but once we've successfully removed
 	 * any file at all, we'll go ahead and commit to it all:
-- 
1.4.4.4.gb8a1
