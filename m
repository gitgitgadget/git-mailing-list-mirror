From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 17/44] builtin-am: implement -s/--signoff
Date: Sun, 28 Jun 2015 22:05:39 +0800
Message-ID: <1435500366-31700-18-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:08:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DFl-0002LQ-Rm
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbbF1OIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:08:09 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35221 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbbF1OHl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:07:41 -0400
Received: by pdbci14 with SMTP id ci14so101356429pdb.2
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IJOzG/8ET+1jgVkTh4p4WgdxpRkh5Khuw7Qz7nO1qRs=;
        b=FrNh1q77VL7l4NeZ1rWUGYr8iFRnq+GdFUe8ZikvHmvMpM6HS5bTXD6WD42KeXQ9WM
         3XkgGEIyv7posIU/opR8vbDzK2Eqv5iaWspN/h6wiUM8L+CewoeTKK/gVKOvAV9izKzH
         Q6A2LApFJ+VzaTxXNUBOLMvwwiyCQcecy7rRjU8o1qezo70OjtCMqVkRKki0Emdgsf/U
         VH366Pfd9SK5WO73wgYInEBC8bhZ//PySlINBfBOAiHC6NA6qhdh5MTxGv+LJG5sT9IP
         GJvvpJ0mnXy/YBxuwBkx4ijDk8hQ3KiXXcsa1WWWrHeGJnJ9ayyccxifBcdygn+Qqalq
         szsA==
X-Received: by 10.68.243.9 with SMTP id wu9mr22588855pbc.28.1435500460922;
        Sun, 28 Jun 2015 07:07:40 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.07.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:07:40 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272894>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
supported the --signoff option which will append a signoff at the end of
the commit messsage. Re-implement this feature in parse_mail() by
calling append_signoff() if the option is set.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 7832ecf..1ffbba1 100644
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
@@ -377,6 +380,9 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, state, "quiet", 1);
 	state->quiet = !strcmp(sb.buf, "t");
 
+	read_state_file(&sb, state, "sign", 1);
+	state->append_signoff = !strcmp(sb.buf, "t");
+
 	strbuf_release(&sb);
 }
 
@@ -557,6 +563,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "quiet"), 1, state->quiet ? "t" : "f");
 
+	write_file(am_path(state, "sign"), 1, state->append_signoff ? "t" : "f");
+
 	if (!get_sha1("HEAD", curr_head)) {
 		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(curr_head));
 		update_ref("am", "ORIG_HEAD", curr_head, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
@@ -763,6 +771,9 @@ static int parse_mail(struct am_state *state, const char *mail)
 		die_errno(_("could not read '%s'"), am_path(state, "msg"));
 	stripspace(&msg, 0);
 
+	if (state->append_signoff)
+		append_signoff(&msg, 0, 0);
+
 	assert(!state->author_name);
 	state->author_name = strbuf_detach(&author_name, NULL);
 
@@ -1157,6 +1168,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	struct option options[] = {
 		OPT__QUIET(&state.quiet, N_("be quiet")),
+		OPT_BOOL('s', "signoff", &state.append_signoff,
+			N_("add a Signed-off-by line to the commit message")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.rc0.76.gb2c6e93
