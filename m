From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 18/45] builtin-am: implement -s/--signoff
Date: Mon, 20 Jul 2015 00:10:10 +0800
Message-ID: <1437322237-29863-19-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:11:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrBo-0006JF-1b
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbbGSQLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:11:37 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35505 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbbGSQLe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:11:34 -0400
Received: by pabkd10 with SMTP id kd10so17162136pab.2
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gaYCT6KbMjKY/OLY1LGCvgUB4NvZJvZnIwiW54MfjLg=;
        b=lld7CDGZK+C/pfNa8Mwj6/4XqfmY5fBBjXb4kAhtofHCo7lc/sUKlmbN9gasJqEG+b
         b72Hewwm6oWj9Qz6ueySjxiYdo0Z7J/EFwsn6iKdtEJCzOBW4mfLziE4/n4uZsJSnF/p
         cCLJWaCB0jqSN2IrpvDryS1OVsO8+agrfqDHEd3KDn9969q0eHeTo+nabAyR0mAo8IFd
         jPbKtXWD93tPzUiARkCBihfSqTAwmHHN9M63tbW2rlVYtBUNN5iuQtUFHJCu5lGEzeJq
         9JL0OFk3wDvpdTg0Ye37t7MGbAC3kRvp6UcLTwx6j94juFkPk29JfSL6vCKQJFVNk5od
         qi2g==
X-Received: by 10.68.78.36 with SMTP id y4mr49244628pbw.106.1437322294257;
        Sun, 19 Jul 2015 09:11:34 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.11.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:11:33 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274242>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
supported the --signoff option which will append a signoff at the end of
the commit messsage. Re-implement this feature in parse_mail() by
calling append_signoff() if the option is set.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index fb428f9..7c0f604 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -18,6 +18,7 @@
 #include "diffcore.h"
 #include "unpack-trees.h"
 #include "branch.h"
+#include "sequencer.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -83,6 +84,7 @@ struct am_state {
 
 	/* various operating modes and command line options */
 	int quiet;
+	int append_signoff;
 	const char *resolvemsg;
 };
 
@@ -353,6 +355,9 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, state, "quiet", 1);
 	state->quiet = !strcmp(sb.buf, "t");
 
+	read_state_file(&sb, state, "sign", 1);
+	state->append_signoff = !strcmp(sb.buf, "t");
+
 	strbuf_release(&sb);
 }
 
@@ -533,6 +538,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "quiet"), 1, state->quiet ? "t" : "f");
 
+	write_file(am_path(state, "sign"), 1, state->append_signoff ? "t" : "f");
+
 	if (!get_sha1("HEAD", curr_head)) {
 		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(curr_head));
 		update_ref("am", "ORIG_HEAD", curr_head, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
@@ -734,6 +741,9 @@ static int parse_mail(struct am_state *state, const char *mail)
 		die_errno(_("could not read '%s'"), am_path(state, "msg"));
 	stripspace(&msg, 0);
 
+	if (state->append_signoff)
+		append_signoff(&msg, 0, 0);
+
 	assert(!state->author_name);
 	state->author_name = strbuf_detach(&author_name, NULL);
 
@@ -1149,6 +1159,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	struct option options[] = {
 		OPT__QUIET(&state.quiet, N_("be quiet")),
+		OPT_BOOL('s', "signoff", &state.append_signoff,
+			N_("add a Signed-off-by line to the commit message")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.rc2.110.gb39b692
