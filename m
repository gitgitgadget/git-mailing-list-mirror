From: Junio C Hamano <junkio@cox.net>
Subject: Re: Creating attachments using git-format-patch
Date: Sat, 03 Mar 2007 20:23:54 -0800
Message-ID: <7vmz2t7i1x.fsf@assigned-by-dhcp.cox.net>
References: <loom.20070303T215950-974@post.gmane.org>
	<7vhct27xk2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703032356050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vslcl7jxo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Panagiotis Issaris <takis.issaris@uhasselt.be>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 04 05:24:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNiGZ-00061J-ES
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 05:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbXCDEX4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 23:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbXCDEX4
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 23:23:56 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:54534 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbXCDEXz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 23:23:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070304042355.SSSJ748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Mar 2007 23:23:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WUPu1W00h1kojtg0000000; Sat, 03 Mar 2007 23:23:55 -0500
In-Reply-To: <7vslcl7jxo.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 03 Mar 2007 19:43:15 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41346>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date: Sun, 4 Mar 2007 00:12:06 +0100
Subject: [PATCH] format-patch: add --inline option and make --attach a true attachment

The existing --attach option did not create a true "attachment"
but multipart/mixed with Content-Disposition: inline.  It should
have been with Content-Disposition: attachment.

Introduce --inline to add multipart/mixed that is inlined, and
make --attach to create an attachement.

Hopefully-Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Junio C Hamano <junkio@cox.net> writes:

 > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
 >
 >> ... so we should introduce an option "--no-inline"!
 >
 > Yes, but this time around I _think_ we should admit that the
 > current option is misnamed and make it right.

 * I do not think existing users care too deeply, as a patch as
   an attachment has always been frowned upon in kernel and git
   mailing list _anyway_, even if they were inlined.

 Documentation/git-format-patch.txt |   14 +++++++++++---
 builtin-log.c                      |   16 ++++++++++++++--
 log-tree.c                         |    6 ++++--
 revision.h                         |    1 +
 4 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 59f34b9..dfdb652 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -9,7 +9,8 @@ git-format-patch - Prepare patches for e-mail submission
 SYNOPSIS
 --------
 [verse]
-'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--attach] [--thread]
+'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--thread]
+	           [--attach[=<boundary>] | --inline[=<boundary>]]
 	           [-s | --signoff] [--diff-options] [--start-number <n>]
 		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
 		   [--ignore-if-in-upstream]
@@ -68,8 +69,15 @@ OPTIONS
 	Print all commits to the standard output in mbox format,
 	instead of creating a file for each one.
 
---attach::
-	Create attachments instead of inlining patches.
+--attach[=<boundary>]::
+	Create multipart/mixed attachment, the first part of
+	which is the commit message and the patch itself in the
+	second part, with "Content-Disposition: attachment".
+
+--inline[=<boundary>]::
+	Create multipart/mixed attachment, the first part of
+	which is the commit message and the patch itself in the
+	second part, with "Content-Disposition: inline".
 
 --thread::
 	Add In-Reply-To and References headers to make the second and
diff --git a/builtin-log.c b/builtin-log.c
index 1c9f7d0..865832c 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -482,10 +482,22 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			memcpy(add_signoff, committer, endpos - committer + 1);
 			add_signoff[endpos - committer + 1] = 0;
 		}
-		else if (!strcmp(argv[i], "--attach"))
+		else if (!strcmp(argv[i], "--attach")) {
 			rev.mime_boundary = git_version_string;
-		else if (!prefixcmp(argv[i], "--attach="))
+			rev.no_inline = 1;
+		}
+		else if (!prefixcmp(argv[i], "--attach=")) {
+			rev.mime_boundary = argv[i] + 9;
+			rev.no_inline = 1;
+		}
+		else if (!strcmp(argv[i], "--inline")) {
+			rev.mime_boundary = git_version_string;
+			rev.no_inline = 0;
+		}
+		else if (!prefixcmp(argv[i], "--inline=")) {
 			rev.mime_boundary = argv[i] + 9;
+			rev.no_inline = 0;
+		}
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
-- 
1.5.0.2.864.ge1aa
