From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 06/11] revert: Implement parsing --continue, --abort and --skip
Date: Sun, 10 Apr 2011 20:41:52 +0530
Message-ID: <1302448317-32387-7-git-send-email-artagnon@gmail.com>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 10 17:13:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8wKc-0008Ks-Je
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 17:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371Ab1DJPNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 11:13:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49368 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755090Ab1DJPNh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 11:13:37 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so4855877iyb.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=rEI0hbc/fPnbW+gEFCqSpbNIG/oQoq1Ez7SgvQl0QVc=;
        b=jXMO6yiGTjbRdYcb5K0NUFUQJkpGEIAFrOccBCFvxfxbU3BtwMo0kmkRdgycy8d1U1
         a6yPoWs3481h5ixPzAY71Fh36TYIrFzu4Xrqy+7Fl68hUucxzNNLdn6QGIsMzUxhoaAD
         1HGSJzC15swYZ+zY92/p/Cjq330XMk0kOkDFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xe9sRImmpZ7p2GirNYmA5xD+GeaeZWpo3e/95FL2g7N8cmV13YAg82Ni90oVmzf4Nz
         fHOXU+GDpAsjZIU6PuQllDDiDtucQ4KBUBUS79U192IZN2VGFOUsthPO3kD8SYZ/ku9T
         JWib5mdIorxTsRh61bC2JPk6/uytXC+NkpDzA=
Received: by 10.231.140.34 with SMTP id g34mr1392501ibu.195.1302448415928;
        Sun, 10 Apr 2011 08:13:35 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id f28sm3367928ibh.67.2011.04.10.08.13.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 08:13:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171260>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index facae24..b90f3d0 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -39,6 +39,11 @@ static const char * const cherry_pick_usage[] = {
 static struct {
 	enum { REVERT, CHERRY_PICK } action;
 
+	/* --abort, --skip, and --continue */
+	int abort_oper;
+	int skip_oper;
+	int continue_oper;
+
 	/* Boolean options */
 	int edit;
 	int no_replay;
@@ -98,8 +103,12 @@ static void die_opt_incompatible(const char *me, const char *base_opt,
 static void parse_args(int argc, const char **argv)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage();
+	const char *me;
 	int noop;
 	struct option options[] = {
+		OPT_BOOLEAN(0, "abort", &cmd_opts.abort_oper, "abort the current operation"),
+		OPT_BOOLEAN(0, "skip", &cmd_opts.skip_oper, "skip the current commit"),
+		OPT_BOOLEAN(0, "continue", &cmd_opts.continue_oper, "continue the current operation"),
 		OPT_BOOLEAN('n', "no-commit", &cmd_opts.no_commit, "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &cmd_opts.edit, "edit the commit message"),
 		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
@@ -127,7 +136,42 @@ static void parse_args(int argc, const char **argv)
 	cmd_opts.commit_argc = parse_options(argc, argv, NULL, options, usage_str,
 				    PARSE_OPT_KEEP_ARGV0 |
 				    PARSE_OPT_KEEP_UNKNOWN);
-	if (cmd_opts.commit_argc < 2)
+
+	me = (cmd_opts.action == REVERT ? "revert" : "cherry-pick");
+
+	/* Check for incompatible command line arguments */
+	if (cmd_opts.abort_oper || cmd_opts.skip_oper || cmd_opts.continue_oper) {
+		char *this_oper;
+		int opt_bitarray[] = {cmd_opts.no_commit, cmd_opts.edit, noop,
+				      cmd_opts.signoff, cmd_opts.mainline,
+				      (cmd_opts.strategy ? 1 : 0),
+				      (cmd_opts.xopts ? 1 : 0),
+				      cmd_opts.no_replay, cmd_opts.allow_ff};
+		if (cmd_opts.abort_oper) {
+			this_oper = "--abort";
+			die_opt_incompatible(me, this_oper, 1,
+					&cmd_opts.skip_oper, "--skip");
+			die_opt_incompatible(me, this_oper, 1,
+					&cmd_opts.continue_oper, "--continue");
+		} else if (cmd_opts.skip_oper) {
+			this_oper = "--skip";
+			die_opt_incompatible(me, this_oper, 1,
+					&cmd_opts.abort_oper, "--abort");
+			die_opt_incompatible(me, this_oper, 1,
+					&cmd_opts.continue_oper, "--continue");
+		} else {
+			this_oper = "--continue";
+			die_opt_incompatible(me, this_oper, 1,
+					&cmd_opts.abort_oper, "--abort");
+			die_opt_incompatible(me, this_oper, 1,
+					&cmd_opts.skip_oper, "--skip");
+		}
+		die_opt_incompatible(me, this_oper, 9, opt_bitarray, "--no-commit",
+				"--edit", "-r",	"--signoff", "--mainline",
+				"--strategy", "--strategy-option", "-x", "--ff");
+	}
+
+	else if (cmd_opts.commit_argc < 2)
 		usage_with_options(usage_str, options);
 
 	if (cmd_opts.allow_ff) {
-- 
1.7.4.rc1.7.g2cf08.dirty
