X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC/PATCH] git-show: also handle blobs
Date: Sun, 3 Dec 2006 19:54:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612031952050.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 3 Dec 2006 18:55:14 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33128>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqwUX-0003tj-8r for gcvg-git@gmane.org; Sun, 03 Dec
 2006 19:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759986AbWLCSyz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 13:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759987AbWLCSyz
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 13:54:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:38289 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1759986AbWLCSyy (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 13:54:54 -0500
Received: (qmail invoked by alias); 03 Dec 2006 18:54:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp040) with SMTP; 03 Dec 2006 19:54:53 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Now you can say "git show v1.4.4.1:Makefile" and it pipes the requested 
contents into your favourite pager.

While at it, the manpage for -show is updated; it no longer pipes 
anything, but rather uses the internal revision walking machinery. Better 
not mention it at all.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	This combines the "wouldn't it be nice to have git-cat or
	git-less" wishes with "we do not want to clutter up the
	namespace any more.

	If people like this approach, we could easily enhance this patch 
	to be a synonym for "-p cat-file -p" for _every_ non-commit on the 
	command line.

 Documentation/git-show.txt |   11 +++++------
 builtin-log.c              |   12 ++++++++++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 4c880a8..9d4e93e 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -3,7 +3,7 @@ git-show(1)
 
 NAME
 ----
-git-show - Show one commit with difference it introduces
+git-show - Show one blob or one commit with difference it introduces
 
 
 SYNOPSIS
@@ -12,11 +12,10 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Shows commit log and textual diff for a single commit.  The
-command internally invokes 'git-rev-list' piped to
-'git-diff-tree', and takes command line options for both of
-these commands. It also presents the merge commit in a special
-format as produced by 'git-diff-tree --cc'.
+Shows a commit or blob. In case of a commit it shows the
+log message and textual diff for a single commit. It also
+presents the merge commit in a special format as produced by
+'git-diff-tree --cc'.
 
 This manual page describes only the most frequently used options.
 
diff --git a/builtin-log.c b/builtin-log.c
index 7acf5d3..c252c40 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -85,6 +85,18 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	rev.ignore_merges = 0;
 	rev.no_walk = 1;
 	cmd_log_init(argc, argv, prefix, &rev);
+	if (rev.pending.nr == 1
+			&& rev.pending.objects[0].item->type == OBJ_BLOB) {
+		unsigned long size;
+		char type[20];
+		void *buf = read_sha1_file(rev.pending.objects[0].item->sha1,
+				type, &size);
+		if (!buf)
+			return error("Could not read blob?");
+		fwrite(buf, size, 1, stdout);
+		free(buf);
+		return 0;
+	}
 	return cmd_log_walk(&rev);
 }
 
-- 
1.4.4.1.g317bd
