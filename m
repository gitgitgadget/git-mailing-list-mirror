From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 11/11] revert: Implement --abort processing
Date: Sun, 10 Apr 2011 20:41:57 +0530
Message-ID: <1302448317-32387-12-git-send-email-artagnon@gmail.com>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 10 17:14:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8wL8-0000B0-3u
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 17:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256Ab1DJPOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 11:14:08 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49368 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045Ab1DJPOH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 11:14:07 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so4855877iyb.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=J5aNotz/FWXd8OLXbcQZZu728dwuHxJvPFJpnslcSRU=;
        b=j+QG0pCvAmp3Bv1TbMfnZiv6Z5iruk1e9nljHT/KJKC/9GGusdXQSP4Vof0xDx5vx6
         CuSxcpNKniDwoLOFzXl7iuU1adhl4S4gqRAQRlz54/cd9smoWTakad0gsqYW2bpfD6nI
         e+TkUA9TsfFynj5HWIO8aevkRP+LSzI3bkdVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=N3VRKyYBfdQn7S2N6Y6lfeWD/QK0uDfCQMGx5jDwYG9fgaRuy4ZF/fMifUqazJtqkF
         sgbAS1pIHxpspMa47iONy5gSPwLa/r21OTw8iv1j2JIhAHmZQRAKPZttXrsyaTSzFnNG
         gtL7oHqJHSV+Lp77xwooKUDD8f0WSVIS15Qc0=
Received: by 10.42.74.131 with SMTP id w3mr3374362icj.455.1302448446830;
        Sun, 10 Apr 2011 08:14:06 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id f28sm3367928ibh.67.2011.04.10.08.14.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 08:14:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171265>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 0720721..c050d4f 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -743,6 +743,51 @@ static int pick_commits(void)
 	return persist_todo_done(res, revs.commits, done_list);
 }
 
+static int process_args(int argc, const char **argv)
+{
+	const char *me;
+	int fd;
+
+	parse_args(argc, argv);
+	me = (cmd_opts.action == REVERT ? "revert" : "cherry-pick");
+	if (cmd_opts.abort_oper) {
+		const char *args[3] = {NULL, NULL, NULL};
+		char head[DEFAULT_ABBREV];
+
+		args[0] = "rerere";
+		args[1] = "clear";
+		cmd_rerere(2, args, NULL);
+
+		if (!file_exists(HEAD_FILE))
+			goto error;
+
+		if ((fd = open(HEAD_FILE, O_RDONLY, 0666)) < 0)
+			return error_errno(_("Could not open '%s' for reading"), HEAD_FILE);
+		if (xread(fd, head, DEFAULT_ABBREV) < DEFAULT_ABBREV)
+			return error_errno(_("Corrupt '%s'"), HEAD_FILE);
+		close(fd);
+
+		args[0] = "reset";
+		args[1] = "--hard";
+		args[2] = head;
+		return cmd_reset(3, args, NULL);
+	}
+	else if (cmd_opts.skip_oper) {
+		if (!file_exists(TODO_FILE))
+			goto error;
+		return 0;
+	}
+	else if (cmd_opts.continue_oper) {
+		if (!file_exists(TODO_FILE))
+			goto error;
+		return 0;
+	}
+
+	return pick_commits();
+error:
+	return error(_("No %s in progress"), me);
+}
+
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	if (isatty(0))
@@ -752,9 +797,8 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	memset(&cmd_opts, 0, sizeof(cmd_opts));
 	cmd_opts.action = REVERT;
 	setenv(GIT_REFLOG_ACTION, "revert", 0);
-	parse_args(argc, argv);
 
-	return pick_commits();
+	return process_args(argc, argv);
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
@@ -763,7 +807,6 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	memset(&cmd_opts, 0, sizeof(cmd_opts));
 	cmd_opts.action = CHERRY_PICK;
 	setenv(GIT_REFLOG_ACTION, "cherry-pick", 0);
-	parse_args(argc, argv);
 
-	return pick_commits();
+	return process_args(argc, argv);
 }
-- 
1.7.4.rc1.7.g2cf08.dirty
