From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 18/31] am: implement am --signoff
Date: Thu, 18 Jun 2015 19:25:30 +0800
Message-ID: <1434626743-8552-19-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:27:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xym-0005MN-PH
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbbFRL1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:27:19 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36623 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbbFRL1B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:27:01 -0400
Received: by paceq1 with SMTP id eq1so35058177pac.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BHAoejTD6AIAd+N5nMHb/0U96zPoeSj6iNaBl16Eymo=;
        b=qcGSuPMRT4kDjVygHhZ4PK9waTkO6IYVfjpwEbU73uH8KXt9QIl3gvycoVDtE93IXb
         DzV33ZQ3nx0tpUy5CWXrsCI23wvr6TSe/BYJbYRb1XBOETyA95abbqLyb0gw218lMywq
         6iAW2OAQlWNpRCxvUa925zvkcaDaECPt+zsYqEkHE5YqRwvDrMjatbeUEshuc+C4pg/G
         DVw8+AESknv2sNkknjw99zTxGPTko/ZfKNTH+SnCI5xX/g5i4nhXvYTtCpfgWyqsIU1v
         jeuFhF+zmv0J/sYAo3JuYFyKJDKXCUEa4eDYnOp+i7DkxHtkqHBGyfeErEyoKQ48J6dU
         UDfg==
X-Received: by 10.70.96.65 with SMTP id dq1mr20526916pdb.79.1434626819628;
        Thu, 18 Jun 2015 04:26:59 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.26.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:26:58 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271984>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
supported the --signoff option which will append a signoff at the end of
the commit messsage. Re-implement this feature by calling
append_signoff() if the option is set.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 1807d12..d45dd41 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -18,6 +18,7 @@
 #include "diffcore.h"
 #include "unpack-trees.h"
 #include "branch.h"
+#include "sequencer.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -71,6 +72,8 @@ struct am_state {
 
 	int quiet;
 
+	int sign;
+
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 };
@@ -292,6 +295,9 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, am_path(state, "quiet"), 2, 1);
 	state->quiet = !strcmp(sb.buf, "t");
 
+	read_state_file(&sb, am_path(state, "sign"), 2, 1);
+	state->sign = !strcmp(sb.buf, "t");
+
 	strbuf_release(&sb);
 }
 
@@ -477,6 +483,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "quiet"), 1, state->quiet ? "t" : "f");
 
+	write_file(am_path(state, "sign"), 1, state->sign ? "t" : "f");
+
 	if (!get_sha1("HEAD", curr_head)) {
 		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(curr_head));
 		update_ref("am", "ORIG_HEAD", curr_head, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
@@ -636,6 +644,9 @@ static int parse_patch(struct am_state *state, const char *patch)
 		die_errno(_("could not read '%s'"), am_path(state, "msg"));
 	stripspace(&state->msg, 0);
 
+	if (state->sign)
+		append_signoff(&state->msg, 0, 0);
+
 	return 0;
 }
 
@@ -1007,6 +1018,8 @@ static const char * const am_usage[] = {
 
 static struct option am_options[] = {
 	OPT__QUIET(&state.quiet, N_("be quiet")),
+	OPT_BOOL('s', "signoff", &state.sign,
+		N_("add a Signed-off-by line to the commit message")),
 	OPT_CALLBACK(0, "patch-format", &opt_patch_format, N_("format"),
 		N_("format the patch(es) are in"), parse_opt_patchformat),
 	OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
-- 
2.1.4
