From: Jeff King <peff@peff.net>
Subject: [PATCH] improve reflog date/number heuristic
Date: Sun, 27 Sep 2009 03:50:33 -0400
Message-ID: <20090927075033.GC15393@coredump.intra.peff.net>
References: <49578b170909150756k3c19912dv28615053a6bd0f7d@mail.gmail.com>
 <20090924070121.GD24486@coredump.intra.peff.net>
 <20090925222920.GZ14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alf Kristian St??yle <alf.kristian@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 27 09:50:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MroWo-0007om-9n
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 09:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbZI0Hud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 03:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753376AbZI0Huc
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 03:50:32 -0400
Received: from peff.net ([208.65.91.99]:44735 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753340AbZI0Huc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 03:50:32 -0400
Received: (qmail 18693 invoked by uid 107); 27 Sep 2009 07:53:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 27 Sep 2009 03:53:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Sep 2009 03:50:33 -0400
Content-Disposition: inline
In-Reply-To: <20090925222920.GZ14660@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129197>

When we show a reflog, we have two ways of naming the entry:
by sequence number (e.g., HEAD@{0}) or by date (e.g.,
HEAD@{10 minutes ago}). There is no explicit option to set
one or the other, but we guess based on whether or not the
user has provided us with a date format, showing them the
date version if they have done so, and the sequence number
otherwise.

This usually made sense if the use did something like "git
log -g --date=relative". However, it didn't make much sense
if the user set the date format using the log.date config
variable; in that case, all of their reflogs would end up as
dates.

This patch records the source of the date format and only
triggers the date-based view if --date= was given on the
command line.

Signed-off-by: Jeff King <peff@peff.net>
---
On Fri, Sep 25, 2009 at 03:29:20PM -0700, Shawn O. Pearce wrote:

> I agree.  I doubt anyone is relying on log.date to reformat the
> output of `git reflog show` or `git stash list`, so this is probably
> a reasonable change to make.  Even if they were trying to use that,
> its a bug.
> 
> Care to wrap this up in a patch?

Here it is.

 log-tree.c |    4 +++-
 revision.c |    2 ++
 revision.h |    3 ++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 1c9eefe..1618f3c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -390,7 +390,9 @@ void show_log(struct rev_info *opt)
 			 */
 			show_reflog_message(opt->reflog_info,
 				    opt->commit_format == CMIT_FMT_ONELINE,
-				    opt->date_mode);
+				    opt->date_mode_explicit ?
+					opt->date_mode :
+					DATE_NORMAL);
 			if (opt->commit_format == CMIT_FMT_ONELINE)
 				return;
 		}
diff --git a/revision.c b/revision.c
index 35eca4a..9fc4e8d 100644
--- a/revision.c
+++ b/revision.c
@@ -1159,8 +1159,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->simplify_history = 0;
 	} else if (!strcmp(arg, "--relative-date")) {
 		revs->date_mode = DATE_RELATIVE;
+		revs->date_mode_explicit = 1;
 	} else if (!strncmp(arg, "--date=", 7)) {
 		revs->date_mode = parse_date_format(arg + 7);
+		revs->date_mode_explicit = 1;
 	} else if (!strcmp(arg, "--log-size")) {
 		revs->show_log_size = 1;
 	}
diff --git a/revision.h b/revision.h
index 9d0dddb..b6421a6 100644
--- a/revision.h
+++ b/revision.h
@@ -81,7 +81,8 @@ struct rev_info {
 			show_merge:1,
 			abbrev_commit:1,
 			use_terminator:1,
-			missing_newline:1;
+			missing_newline:1,
+			date_mode_explicit:1;
 	enum date_mode date_mode;
 
 	unsigned int	abbrev;
-- 
1.6.5.rc2.197.g25cf3
