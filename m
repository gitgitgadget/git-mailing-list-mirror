X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: [PATCH] add log.fulldiff config option
Date: Wed, 20 Dec 2006 01:01:02 -0500
Message-ID: <20061220060102.GA540@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 06:01:14 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34908>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwuVq-0006QE-T0 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 07:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964904AbWLTGBH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 01:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWLTGBH
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 01:01:07 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:35424
 "HELO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id
 S964905AbWLTGBG (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 01:01:06 -0500
Received: (qmail 9374 invoked from network); 20 Dec 2006 01:01:04 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 20 Dec 2006 01:01:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Dec
 2006 01:01:03 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This continues to default to 'off'.

Signed-off-by: Jeff King <peff@peff.net>
---
On Tue, Dec 19, 2006 at 05:17:17PM -0800, Junio C Hamano wrote:
> I typically do:
> 
>   git log --full-diff -p -SCOLLISION
> 
> The --full-diff option helps because it shows the diff for other
> files (that do not have different number of substring COLLISION
> in the pre and postimage) in the same commit as well.

I use --full-diff all the time, so this should save some typing. I can't
think of a time when I wouldn't want it on, but if there is, we probably
need a --no-full-diff.

Also, should this instead be diff.fulldiff?

Also also, I was going to submit a patch to document --full-diff,
but I had a few questions. Should it go in diff-options? That makes some
sense to me, but the parsing actually happens in setup_revisions.
Furthermore, it seems to do the same thing as --pickaxe-all. Should we
try to combine these?

 Documentation/config.txt |    6 ++++++
 builtin-log.c            |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 22482d6..8be1fa6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -248,6 +248,12 @@ i18n.commitEncoding::
 	browser (and possibly at other places in the future or in other
 	porcelains). See e.g. gitlink:git-mailinfo[1]. Defaults to 'utf-8'.
 
+log.fulldiff::
+	If true, log entries which have been selected through path-limiting
+	or pickaxe will show the diff for all files changed in that commit
+	instead of only the files matching the specified path or pickaxe
+	string.
+
 log.showroot::
 	If true, the initial commit will be shown as a big creation event.
 	This is equivalent to a diff against an empty tree.
diff --git a/builtin-log.c b/builtin-log.c
index 17014f7..57edd12 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -15,6 +15,7 @@
 #include <sys/time.h>
 
 static int default_show_root = 1;
+static int default_full_diff = 0;
 
 /* this is in builtin-diff.c */
 void add_head(struct rev_info *revs);
@@ -26,6 +27,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	rev->commit_format = CMIT_FMT_DEFAULT;
 	rev->verbose_header = 1;
 	rev->show_root_diff = default_show_root;
+	rev->full_diff = default_full_diff;
 	argc = setup_revisions(argc, argv, rev, "HEAD");
 	if (rev->diffopt.pickaxe || rev->diffopt.filter)
 		rev->always_show_header = 0;
@@ -54,6 +56,10 @@ static int git_log_config(const char *var, const char *value)
 		default_show_root = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "log.fulldiff")) {
+		default_full_diff = git_config_bool(var, value);
+		return 0;
+	}
 	return git_diff_ui_config(var, value);
 }
 
-- 
