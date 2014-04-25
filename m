From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 12/14] reset: add --stage and --work options
Date: Fri, 25 Apr 2014 13:12:45 -0500
Message-ID: <1398449567-16314-13-git-send-email-felipe.contreras@gmail.com>
References: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 20:24:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdknM-0007Rv-F8
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbaDYSYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:24:08 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:57778 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692AbaDYSYF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:24:05 -0400
Received: by mail-ob0-f178.google.com with SMTP id wn1so4704935obc.9
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 11:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=71N/8o7VGhIxe+Mv4RiXBSoQlsAx2JX5y59InoND06c=;
        b=SkB5XzVxzC3C6RCi4mEtTB9Wzuz/kgG7te5stMcnwG0Y1WmTzW5sw5pTwdqmpRqyly
         d+muXLXwcd+5KlzJVAXqi2L9oRrj8SfJVgkZO138htpUr5xmbeOWUEr1jz86sQ1ZgqW3
         5nQeQt0YTR9TKaO42blJcDlfLktMMhB/jnUVw8Q8H0Rl7FgJml30l1EjFSTCwbqVVv7U
         pPFeyodie75/GcxtSA7A2TTb6kOCpcTh+LKXSNTSYgHp/WaJwoYsy1M+HVPGO7Gx71WJ
         8P6Lc829coEnS/qCF79YBmT1d5H98SqyYIQ/NpKfXsnQMqDL7iiZwsYpHt/KjiUZoeTS
         O1cw==
X-Received: by 10.60.131.172 with SMTP id on12mr8261095oeb.18.1398450244912;
        Fri, 25 Apr 2014 11:24:04 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ut8sm17041589obc.22.2014.04.25.11.24.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 11:24:03 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247086>

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
index a991344..c40987e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -23,6 +23,7 @@
 
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
+	N_("git reset [--stage | --work] [-q] [<commit>]"),
 	N_("git reset [-q] <tree-ish> [--] <paths>..."),
 	N_("git reset --patch [<tree-ish>] [--] [<paths>...]"),
 	NULL
@@ -254,6 +255,7 @@ static int reset_refs(const char *rev, const unsigned char *sha1)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
+	int stage = -1, working_tree = -1;
 	int patch_mode = 0, unborn;
 	const char *rev;
 	unsigned char sha1[20];
@@ -269,6 +271,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				N_("reset HEAD, index and working tree"), MERGE),
 		OPT_SET_INT(0, "keep", &reset_type,
 				N_("reset HEAD but keep local changes"), KEEP),
+		OPT_BOOL(0, "stage", &stage, N_("reset index")),
+		OPT_BOOL(0, "work", &working_tree, N_("reset working tree")),
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
 		OPT_END()
 	};
@@ -301,6 +305,22 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
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
1.9.2+fc1.2.gfbaae8c
