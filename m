From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 17/44] builtin-am: implement -s/--signoff
Date: Tue,  7 Jul 2015 22:20:35 +0800
Message-ID: <1436278862-2638-18-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:24:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTn3-0005XB-MR
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757862AbbGGOYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:24:00 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34995 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757600AbbGGOWF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:22:05 -0400
Received: by pactm7 with SMTP id tm7so114126914pac.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kn7T/BPNqwtfYSQnbXyKhJDQLo7l5YOb8hf7PsYSXfs=;
        b=zv4Ym5tPR7yQ++0o5ll5wrImqqPnIf+PsWbeo1kNS0FBAWtFRxE8osVrDeWvkHkQEG
         +3yJ4ybTB0TLkG3AjzsTDGbGkmAtmvYKjlevcnxrYWKazNPbJCsP56/YYSOS8QGMBPFq
         Pgrd3lIFh2yV79cHr9GXTxBKdwPcaO2lgBonI8LK89X9Bq8+qEEoH3h1RGaio2G6lt9U
         857iEGHS2V+iAw58fBy6yosX9p1cPWNj7+ABRIzZtfqiM212yWor7vcFkyxnqZwX7+/6
         wMFJmKA5ydAQJ7dzRndL0TEtfO0yEpVwsnDWjDpKx0/kYLMDtvSzKqv52YPxtjrYcTKB
         SBLw==
X-Received: by 10.68.191.229 with SMTP id hb5mr9442966pbc.126.1436278924225;
        Tue, 07 Jul 2015 07:22:04 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.22.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:22:03 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273556>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
supported the --signoff option which will append a signoff at the end of
the commit messsage. Re-implement this feature in parse_mail() by
calling append_signoff() if the option is set.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 7eb23b9..511e4dd 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -18,6 +18,7 @@
 #include "diffcore.h"
 #include "unpack-trees.h"
 #include "branch.h"
+#include "sequencer.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -83,6 +84,8 @@ struct am_state {
 
 	int quiet;
 
+	int append_signoff;
+
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 };
@@ -371,6 +374,9 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, state, "quiet", 1);
 	state->quiet = !strcmp(sb.buf, "t");
 
+	read_state_file(&sb, state, "sign", 1);
+	state->append_signoff = !strcmp(sb.buf, "t");
+
 	strbuf_release(&sb);
 }
 
@@ -551,6 +557,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "quiet"), 1, state->quiet ? "t" : "f");
 
+	write_file(am_path(state, "sign"), 1, state->append_signoff ? "t" : "f");
+
 	if (!get_sha1("HEAD", curr_head)) {
 		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(curr_head));
 		update_ref("am", "ORIG_HEAD", curr_head, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
@@ -757,6 +765,9 @@ static int parse_mail(struct am_state *state, const char *mail)
 		die_errno(_("could not read '%s'"), am_path(state, "msg"));
 	stripspace(&msg, 0);
 
+	if (state->append_signoff)
+		append_signoff(&msg, 0, 0);
+
 	assert(!state->author_name);
 	state->author_name = strbuf_detach(&author_name, NULL);
 
@@ -1151,6 +1162,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	struct option options[] = {
 		OPT__QUIET(&state.quiet, N_("be quiet")),
+		OPT_BOOL('s', "signoff", &state.append_signoff,
+			N_("add a Signed-off-by line to the commit message")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.rc1.76.gf60a929
