From: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: Re: Creating attachments using git-format-patch
Date: Sun, 4 Mar 2007 20:56:41 +0100
Message-ID: <20070304195641.GA16274@issaris.org>
References: <loom.20070303T215950-974@post.gmane.org> <7vhct27xk2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703032356050.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vslcl7jxo.fsf@assigned-by-dhcp.cox.net> <7vmz2t7i1x.fsf@assigned-by-dhcp.cox.net> <45EB2294.9040702@issaris.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: takis@issaris.org
X-From: git-owner@vger.kernel.org Sun Mar 04 20:56:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNwot-0001kc-Me
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 20:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbXCDT4c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 14:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752456AbXCDT4c
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 14:56:32 -0500
Received: from outmx003.isp.belgacom.be ([195.238.4.100]:51156 "EHLO
	outmx003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbXCDT4c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 14:56:32 -0500
Received: from outmx003.isp.belgacom.be (localhost.localdomain [127.0.0.1])
        by outmx003.isp.belgacom.be (8.13.4/8.12.11/Skynet-OUT-2.22) with ESMTP id l24JuQDQ030123
        for <git@vger.kernel.org>; Sun, 4 Mar 2007 20:56:27 +0100
        (envelope-from <takis.issaris@uhasselt.be>)
Received: from adsl-dyn.isp.belgacom.be (78.129-64-87.adsl-dyn.isp.belgacom.be [87.64.129.78])
        by outmx003.isp.belgacom.be (8.13.4/8.13.4/Skynet-OUT-2.22) with SMTP id l24JuMKo030093;
	Sun, 4 Mar 2007 20:56:23 +0100
        (envelope-from <takis.issaris@uhasselt.be>)
Received: by adsl-dyn.isp.belgacom.be (sSMTP sendmail emulation); Sun, 04 Mar 2007 20:56:41 +0100
Content-Disposition: inline
In-Reply-To: <45EB2294.9040702@issaris.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41368>

Hi,

On Sun, Mar 04, 2007 at 08:48:36PM +0100, Panagiotis Issaris wrote:
> Junio C Hamano schreef:
> >The existing --attach option did not create a true "attachment"
> >but multipart/mixed with Content-Disposition: inline.  It should
> >have been with Content-Disposition: attachment.
> >
> >Introduce --inline to add multipart/mixed that is inlined, and
> >make --attach to create an attachement.
> >
> >[...]
> Thanks for the quick response and help! :-)

Sorry for the attachment in the previous email...

With friendly regards,

Takis


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
index 6ce239d..8797aa1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -186,7 +186,7 @@ void show_log(struct rev_info *opt, const char *sep)
 			snprintf(subject_buffer, sizeof(subject_buffer) - 1,
 				 "%s"
 				 "MIME-Version: 1.0\n"
-				 "Content-Type: multipart/mixed;\n"
+				 "Content-Type: multipart/mixed;"
 				 " boundary=\"%s%s\"\n"
 				 "\n"
 				 "This is a multi-part message in MIME "
@@ -202,13 +202,15 @@ void show_log(struct rev_info *opt, const char *sep)
 
 			snprintf(buffer, sizeof(buffer) - 1,
 				 "--%s%s\n"
-				 "Content-Type: text/x-patch;\n"
+				 "Content-Type: text/x-patch;"
 				 " name=\"%s.diff\"\n"
 				 "Content-Transfer-Encoding: 8bit\n"
-				 "Content-Disposition: inline;\n"
+				 "Content-Disposition: %s;"
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
