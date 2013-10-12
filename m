From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 12/14] reset: add --stage and --work options
Date: Sat, 12 Oct 2013 02:04:45 -0500
Message-ID: <1381561488-20294-12-git-send-email-felipe.contreras@gmail.com>
References: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:11:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtMY-0004MJ-MN
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754Ab3JLHLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:11:23 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:56152 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab3JLHLW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:11:22 -0400
Received: by mail-ob0-f171.google.com with SMTP id uy5so3480859obc.30
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+lXiVyITv1Ykepo/V5q2/3y8i11cDJR6ngZpzw3jsD4=;
        b=bZ4KE5MUwEvQFryG1s1j85BlwhBEk90QPQhcp4E0nsADJdYzue+TGqJOXGT7jPgcsu
         ST5kmPGrnM07eagQch+wRXZTAQIhBiy2EkEQTtpZmaUBSSdpywXTRsg5up68prRt1bbw
         DUOTbJu4+/pEH0wlW6xVtiOQkFbjs9nm2JuQy39p/xlMQR03zBDqnmpVVbdsqMOSI3xk
         O9tD0A9eWY/GZK0d1flaekEWdRMQqaBzu4G/tUdCtstxCF4FY4KoNqPcbzJ6qWKRF2I5
         laubNvGBDPjEXEa+6ffcU4hwDvqCPbCwRTihCX7mzLe9SM8ikc+9geWRvjKOnGQZZxag
         Rzyw==
X-Received: by 10.60.117.225 with SMTP id kh1mr17726333oeb.15.1381561882163;
        Sat, 12 Oct 2013 00:11:22 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u8sm28638436obd.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235969>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-reset.txt |  8 ++++++++
 builtin/reset.c             | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index f445cb3..5cd75a8 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 'git reset' [-q] [<tree-ish>] [--] <paths>...
 'git reset' (--patch | -p) [<tree-ish>] [--] [<paths>...]
 'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<commit>]
+'git reset' [--stage | --work] [-q] [<commit>]
 
 DESCRIPTION
 -----------
@@ -81,6 +82,13 @@ but carries forward unmerged index entries.
 	different between <commit> and HEAD.
 	If a file that is different between <commit> and HEAD has local changes,
 	reset is aborted.
+
+--stage::
+	Reset the index, basically `--mixed`. `--no-stage` is the equivalent of
+	`--soft`.
+
+--work::
+	Resets the working tree, basically `--hard`.
 --
 
 If you want to undo a commit other than the latest on a branch,
diff --git a/builtin/reset.c b/builtin/reset.c
index afa6e02..fbc1abc 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -23,6 +23,7 @@
 
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
+	N_("git reset [--stage | --work] [-q] [<commit>]"),
 	N_("git reset [-q] <tree-ish> [--] <paths>..."),
 	N_("git reset --patch [<tree-ish>] [--] [<paths>...]"),
 	NULL
@@ -243,6 +244,7 @@ static int update_refs(const char *rev, const unsigned char *sha1)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
+	int stage = -1, working_tree = -1;
 	int patch_mode = 0, unborn;
 	const char *rev;
 	unsigned char sha1[20];
@@ -258,6 +260,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				N_("reset HEAD, index and working tree"), MERGE),
 		OPT_SET_INT(0, "keep", &reset_type,
 				N_("reset HEAD but keep local changes"), KEEP),
+		OPT_BOOL(0, "stage", &stage, N_("reset index")),
+		OPT_BOOL(0, "work", &working_tree, N_("reset working tree")),
 		OPT_BOOLEAN('p', "patch", &patch_mode, N_("select hunks interactively")),
 		OPT_END()
 	};
@@ -290,6 +294,22 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		hashcpy(sha1, tree->object.sha1);
 	}
 
+	if (stage >= 0 || working_tree >= 0) {
+		if (reset_type != NONE)
+			die(_("--{stage,work} are incompatible with --{hard,mixed,soft,merge}"));
+
+		if (working_tree == 1) {
+			if (stage == 0)
+				die(_("--no-stage doesn't make sense with --work"));
+			reset_type = HARD;
+		} else {
+			if (stage == 1)
+				reset_type = NONE;
+			else
+				reset_type = SOFT;
+		}
+	}
+
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
-- 
1.8.4-fc
