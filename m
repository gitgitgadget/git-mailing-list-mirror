From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 08/31] am: apply patch with git-apply
Date: Thu, 18 Jun 2015 19:25:20 +0800
Message-ID: <1434626743-8552-9-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:26:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xy3-0004ot-3J
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506AbbFRL0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:26:42 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33660 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604AbbFRL0e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:26:34 -0400
Received: by padev16 with SMTP id ev16so59554577pad.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m+4tigT7a2797kApc+2jKADJkR2JLmRWZBAhtNiLwbo=;
        b=JhQgzgxU96wylP3zbSfFvrQhgNnSko15eYt4R/u1QazdLCZDa8pNzqn1YZabtZGsuK
         9YaozKnVOZCKktFlAE94kSHdI1gNfZCN6bHmclpSnl9SLyzJc6D/XfXaSch5DEuTGXbf
         RxcqtRohwlnuRZDQohiMVijA2NQyxbz5kGqw/811wWDOUB18leGVltuk/79shcY91TCm
         rrQC/wqv3UgnXEjNGcob8oWFwbSQXgHb7lJq6p9AZazX5Phy5g6udA8YFovcY8w+tGiR
         ArZwZqUOrutOz+DKda+7rP2EDbw67r5VsVzILgwA2aHYhAJI1v7qH6b//4wqBQr+I0gS
         TTWg==
X-Received: by 10.70.43.10 with SMTP id s10mr20396182pdl.57.1434626794002;
        Thu, 18 Jun 2015 04:26:34 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.26.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:26:32 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271971>

Implement applying the patch to the index using git-apply.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index d6434e4..296a5fc 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -27,6 +27,18 @@ static int is_empty_file(const char *filename)
 	return !st.st_size;
 }
 
+/**
+ * Returns the first line of msg
+ */
+static const char *firstline(const char *msg)
+{
+	static struct strbuf sb = STRBUF_INIT;
+
+	strbuf_reset(&sb);
+	strbuf_add(&sb, msg, strchrnul(msg, '\n') - msg);
+	return sb.buf;
+}
+
 enum patch_format {
 	PATCH_FORMAT_UNKNOWN = 0,
 	PATCH_FORMAT_MBOX
@@ -519,6 +531,31 @@ static int parse_patch(struct am_state *state, const char *patch)
 	return 0;
 }
 
+/*
+ * Applies current patch with git-apply. Returns 0 on success, -1 otherwise.
+ */
+static int run_apply(const struct am_state *state)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	cp.git_cmd = 1;
+
+	argv_array_push(&cp.args, "apply");
+
+	argv_array_push(&cp.args, "--index");
+
+	argv_array_push(&cp.args, am_path(state, "patch"));
+
+	if (run_command(&cp))
+		return -1;
+
+	/* Reload index as git-apply will have modified it. */
+	discard_cache();
+	read_cache();
+
+	return 0;
+}
+
 /**
  * Applies all queued patches.
  */
@@ -536,7 +573,25 @@ static void am_run(struct am_state *state)
 		write_author_script(state);
 		write_file(am_path(state, "final-commit"), 1, "%s", state->msg.buf);
 
-		/* TODO: Patch application not implemented yet */
+		printf_ln(_("Applying: %s"), firstline(state->msg.buf));
+
+		if (run_apply(state) < 0) {
+			int value;
+
+			printf_ln(_("Patch failed at %s %s"), msgnum(state),
+					firstline(state->msg.buf));
+
+			if (!git_config_get_bool("advice.amworkdir", &value) && !value)
+				printf_ln(_("The copy of the patch that failed is found in: %s"),
+						am_path(state, "patch"));
+
+			exit(128);
+		}
+
+		/*
+		 * TODO: After the patch has been applied to the index with
+		 * git-apply, we need to make commit as well.
+		 */
 
 next:
 		am_next(state);
-- 
2.1.4
