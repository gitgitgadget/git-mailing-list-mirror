From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] format-patch: add --no-inline option
Date: Sun, 4 Mar 2007 00:12:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703040010100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <loom.20070303T215950-974@post.gmane.org> <7vhct27xk2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703032356050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Panagiotis Issaris <takis.issaris@uhasselt.be>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 04 00:12:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNdOx-0002l2-KP
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 00:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbXCCXML (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 18:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbXCCXMK
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 18:12:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:49473 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750712AbXCCXMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 18:12:09 -0500
Received: (qmail invoked by alias); 03 Mar 2007 23:12:07 -0000
X-Provags-ID: V01U2FsdGVkX18z85Qcktgzz5vxR1DBnqckwhj1UZoPCjeD9z1sPC
	6yoH0zN6wfTQTT
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0703032356050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41338>


Some projects have a "patches are not to be inlined" policy. Support
these by adding an option to turn off inlined attachments.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Sat, 3 Mar 2007, Johannes Schindelin wrote:

	> ... so we should introduce an option "--no-inline"!

	I.e. something like this. If you want this, I leave it to you to 
	add a config variable to set the default (but then, you have to 
	add an option "--inline", too!).

 builtin-log.c |    2 ++
 log-tree.c    |    6 ++++--
 revision.h    |    1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 1c9f7d0..3b73feb 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -486,6 +486,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			rev.mime_boundary = git_version_string;
 		else if (!prefixcmp(argv[i], "--attach="))
 			rev.mime_boundary = argv[i] + 9;
+		else if (!strcmp(argv[i], "--no-inline"))
+			rev.no_inline = 1;
 		else if (!strcmp(argv[i], "--ignore-if-in-upstream"))
 			ignore_if_in_upstream = 1;
 		else if (!strcmp(argv[i], "--thread"))
diff --git a/log-tree.c b/log-tree.c
index 6ce239d..7b3ad7d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -205,10 +205,12 @@ void show_log(struct rev_info *opt, const char *sep)
 				 "Content-Type: text/x-patch;\n"
 				 " name=\"%s.diff\"\n"
 				 "Content-Transfer-Encoding: 8bit\n"
-				 "Content-Disposition: inline;\n"
+				 "Content-Disposition: %s;\n"
 				 " filename=\"%s.diff\"\n\n",
 				 mime_boundary_leader, opt->mime_boundary,
-				 sha1, sha1);
+				 sha1,
+				 opt->no_inline ? "attachment" : "inline",
+				 sha1);
 			opt->diffopt.stat_sep = buffer;
 		}
 	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
diff --git a/revision.h b/revision.h
index 5fec184..cf33713 100644
--- a/revision.h
+++ b/revision.h
@@ -74,6 +74,7 @@ struct rev_info {
 	const char	*add_signoff;
 	const char	*extra_headers;
 	const char	*log_reencode;
+	int		no_inline;
 
 	/* Filter by commit log message */
 	struct grep_opt	*grep_filter;
