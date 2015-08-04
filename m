From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 26/45] builtin-am: implement --[no-]message-id, am.messageid
Date: Tue,  4 Aug 2015 21:51:47 +0800
Message-ID: <1438696326-19590-27-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:54:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcfh-0002iy-8I
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbbHDNyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:54:09 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33421 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964921AbbHDNyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:07 -0400
Received: by padck2 with SMTP id ck2so9393704pad.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kNLerm5Sw85YjESZJ01/PNyqHcpTri6mgw6wHX4V+No=;
        b=P7tGCTutA2LnIQC+R75hzO5GbsSS9ZmbBAl03XBSitHrB49aN3hfiX7XICH/gJnjbW
         Zw+yFlrjZcns4qL2hT4zIN80xno2RTm2ZIIOXXk+hHEjMrRhIS9aaOdoEiMu5VBYROEj
         qs4GNW+QsOMwXkIjfZ+2u8i0g/aJJL4uqDlvJJFJlyRuGEQM32EaqA53Rm3BRTSUfD2r
         yh/Vq+Hr22+a4+AgSHNsuIj709qLkw/Klml7gpKM2Y59dryrQnE02wTDeFA3rZP4E4zU
         FZgzu6w5go4OhA1YB0uqtp50NpLMMsxJ/wbTA9OYRPRuffpiJJLyzhTASsm3vNavI+dn
         zR9Q==
X-Received: by 10.68.254.69 with SMTP id ag5mr8194105pbd.130.1438696446496;
        Tue, 04 Aug 2015 06:54:06 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.54.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:54:05 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275296>

Since a078f73 (git-am: add --message-id/--no-message-id, 2014-11-25),
git-am.sh supported the --[no-]message-id options, and the
"am.messageid" setting which specifies the default option.

--[no-]message-id tells git-am whether or not the -m option should be
passed to git-mailinfo.

Re-implement this option in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 68dca2e..8e97839 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -98,6 +98,7 @@ struct am_state {
 	int signoff;
 	int utf8;
 	int keep; /* enum keep_type */
+	int message_id;
 	const char *resolvemsg;
 	int rebasing;
 };
@@ -116,6 +117,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 	state->prec = 4;
 
 	state->utf8 = 1;
+
+	git_config_get_bool("am.messageid", &state->message_id);
 }
 
 /**
@@ -388,6 +391,9 @@ static void am_load(struct am_state *state)
 	else
 		state->keep = KEEP_FALSE;
 
+	read_state_file(&sb, state, "messageid", 1);
+	state->message_id = !strcmp(sb.buf, "t");
+
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
 	strbuf_release(&sb);
@@ -596,6 +602,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "keep"), 1, "%s", str);
 
+	write_file(am_path(state, "messageid"), 1, state->message_id ? "t" : "f");
+
 	if (state->rebasing)
 		write_file(am_path(state, "rebasing"), 1, "%s", "");
 	else
@@ -777,6 +785,9 @@ static int parse_mail(struct am_state *state, const char *mail)
 		die("BUG: invalid value for state->keep");
 	}
 
+	if (state->message_id)
+		argv_array_push(&cp.args, "-m");
+
 	argv_array_push(&cp.args, am_path(state, "msg"));
 	argv_array_push(&cp.args, am_path(state, "patch"));
 
@@ -1521,6 +1532,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("pass -k flag to git-mailinfo"), KEEP_TRUE),
 		OPT_SET_INT(0, "keep-non-patch", &state.keep,
 			N_("pass -b flag to git-mailinfo"), KEEP_NON_PATCH),
+		OPT_BOOL('m', "message-id", &state.message_id,
+			N_("pass -m flag to git-mailinfo")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.280.gd88bd6e
