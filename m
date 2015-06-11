From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v2 17/19] am: implement am --signoff
Date: Thu, 11 Jun 2015 18:22:03 +0800
Message-ID: <1434018125-31804-18-git-send-email-pyokagan@gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:23:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zdj-00088k-DV
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026AbbFKKXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 06:23:12 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36218 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbbFKKXE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:23:04 -0400
Received: by pabqy3 with SMTP id qy3so1794046pab.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 03:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8WMuwECclfqiQYH4ig2HrFZHgBUnX3aXljJza5GFPcE=;
        b=jzrx2fKG7bV7qKQbCQcxWnld15X4RpoUJjTZsouGLjsjLBx3OcqnhGnLKk9CSF2rnS
         JLIzIj8Ukz7qZg7rqiqhN9i5OFixQDQIK8n35uc1BlTyOFzamuCi1BFrxFhzQU1XmoB9
         kw/oO1V7b2u1DG9a3Pmpl94jl0fJZqt3UVEwxv4y8NTsgiG2fUyCpLTeMrebFC9WKiU7
         kCc2YqmUUYI8CPI9SIX6IB2U5m6tuauBhbkeXmcr8h/aw9sTQbXhtdo9xBHSP8oEk89R
         0bK/cOIjZy4Ef28h0PLtiq14om1NLnCXsojeJP0iMxgWHBXT7q2POXtW+oSLJrYbvEGb
         q4rQ==
X-Received: by 10.70.135.106 with SMTP id pr10mr13530888pdb.156.1434018184124;
        Thu, 11 Jun 2015 03:23:04 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id q4sm300488pdo.42.2015.06.11.03.23.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 03:23:03 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271398>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
supported the --signoff option which will append a signoff at the end of
the commit messsage. Re-implement this feature by calling
append_signoff() if the option is set.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 4cd21b8..71fda16 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -18,6 +18,7 @@
 #include "diffcore.h"
 #include "unpack-trees.h"
 #include "branch.h"
+#include "sequencer.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -73,6 +74,8 @@ struct am_state {
 
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
+
+	int sign;
 };
 
 /**
@@ -280,6 +283,9 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, am_path(state, "quiet"), 2, 1);
 	state->quiet = !strcmp(sb.buf, "t");
 
+	read_state_file(&sb, am_path(state, "sign"), 2, 1);
+	state->sign = !strcmp(sb.buf, "t");
+
 	strbuf_release(&sb);
 }
 
@@ -463,6 +469,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "quiet"), 1, state->quiet ? "t" : "f");
 
+	write_file(am_path(state, "sign"), 1, state->sign ? "t" : "f");
+
 	if (!get_sha1("HEAD", curr_head)) {
 		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(curr_head));
 		update_ref("am", "ORIG_HEAD", curr_head, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
@@ -629,6 +637,9 @@ static int parse_patch(struct am_state *state, const char *patch)
 		die_errno(_("could not read '%s'"), am_path(state, "msg"));
 	stripspace(&state->msg, 0);
 
+	if (state->sign)
+		append_signoff(&state->msg, 0, 0);
+
 	return 0;
 }
 
@@ -997,6 +1008,8 @@ static const char * const am_usage[] = {
 
 static struct option am_options[] = {
 	OPT__QUIET(&state.quiet, N_("be quiet")),
+	OPT_BOOL('s', "signoff", &state.sign,
+		N_("add a Signed-off-by line to the commit message")),
 	OPT_CALLBACK(0, "patch-format", &opt_patch_format, N_("format"),
 		N_("format the patch(es) are in"), parse_opt_patchformat),
 	OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
-- 
2.1.4
