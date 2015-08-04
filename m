From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 18/45] builtin-am: implement -s/--signoff
Date: Tue,  4 Aug 2015 21:51:39 +0800
Message-ID: <1438696326-19590-19-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:54:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcfL-0002W9-F3
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbbHDNxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:53:47 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33095 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756372AbbHDNxm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:53:42 -0400
Received: by padck2 with SMTP id ck2so9385634pad.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LlTLR71Q2Uc1oGi3JKNZk6edaKC6bnBtWerB38oWE9A=;
        b=IJcx8UQvSZQ4JC9O3478MU+iSh9tr8ZV/q21pDRVsEw7lOQTqIl1xh8MdHYfmj0O7c
         epMUWCabggCXUPSvRVEYthzQHdgUaEd5osGUCax5+4yMbP0XVfuNj5lHWgekz+4qrLzj
         oBlkre+CDCnA3iTd/46xvY9O9PSd19m6BJuQgs2k9MZ8nR47aKGDuvtFUfcFYazKI18U
         usmpkSPn/AM55Bca7r5hYTkXcyIk/mPnDPSC6M2/x8pzlQpc+BK5vy1UVFBwwwO368Qa
         0laWg17iB7e+z7LTWQtOkrskf6VEXwOzeu2H4kYlPM+qhNba8nYiQsEuQXd83w99JfRV
         gMfQ==
X-Received: by 10.68.105.33 with SMTP id gj1mr4518434pbb.100.1438696422346;
        Tue, 04 Aug 2015 06:53:42 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.53.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:53:41 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275284>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
supported the --signoff option which will append a signoff at the end of
the commit messsage. Re-implement this feature in parse_mail() by
calling append_signoff() if the option is set.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v7
    
    * Having a field named "append_signoff" takes up a lot of horizontal
      space when referring to it. Shorten the name to just "signoff".

 builtin/am.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 8b8f2da..12952cf 100644
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
+	int signoff;
 	const char *resolvemsg;
 };
 
@@ -353,6 +355,9 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, state, "quiet", 1);
 	state->quiet = !strcmp(sb.buf, "t");
 
+	read_state_file(&sb, state, "sign", 1);
+	state->signoff = !strcmp(sb.buf, "t");
+
 	strbuf_release(&sb);
 }
 
@@ -533,6 +538,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "quiet"), 1, state->quiet ? "t" : "f");
 
+	write_file(am_path(state, "sign"), 1, state->signoff ? "t" : "f");
+
 	if (!get_sha1("HEAD", curr_head)) {
 		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(curr_head));
 		update_ref("am", "ORIG_HEAD", curr_head, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
@@ -734,6 +741,9 @@ static int parse_mail(struct am_state *state, const char *mail)
 		die_errno(_("could not read '%s'"), am_path(state, "msg"));
 	stripspace(&msg, 0);
 
+	if (state->signoff)
+		append_signoff(&msg, 0, 0);
+
 	assert(!state->author_name);
 	state->author_name = strbuf_detach(&author_name, NULL);
 
@@ -1150,6 +1160,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	struct option options[] = {
 		OPT__QUIET(&state.quiet, N_("be quiet")),
+		OPT_BOOL('s', "signoff", &state.signoff,
+			N_("add a Signed-off-by line to the commit message")),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
2.5.0.280.gd88bd6e
