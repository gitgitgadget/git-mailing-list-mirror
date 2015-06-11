From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v2 08/19] am: apply patch with git-apply
Date: Thu, 11 Jun 2015 18:21:54 +0800
Message-ID: <1434018125-31804-9-git-send-email-pyokagan@gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:22:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zdF-0007ox-Vc
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbbFKKWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 06:22:43 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35487 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbbFKKWl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:22:41 -0400
Received: by pacyx8 with SMTP id yx8so1835430pac.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 03:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sbNrVODHG5w5DI9bLZCYf1j4Bd1H/u9zolnKH8CtT+g=;
        b=FiK1hmyFs+TDOvlf1pYDi8fPo4Mp35+yziY4JjK9ZrOQvUiUtLlaJq4ZdX3F83sx18
         AuoaVwajsqpllqpeDWq9/pJExqCOCb1Vcwi0lnnm/1yShZi1usZFPk6VvFNy53aWyUOj
         ZnJBFW0gRXbCb9wBuE+zdLMk/pTe5hzl4+5oG2SERO3KVKjNskbrHQD6wyJ7LwdmBJIl
         Yvw+NZpKtS3sSvtftWx8eUPNMY6uC+xfOSy5i+ReZIoog+JLcZfrNxxIqy0+Fg+ECNl3
         gugzAlOK3svFRRw5ctCjlAWhcRW3GVo2zevZQdyWT9fr9r2QDp7aMptca2BsfQ8rW6it
         Dxgw==
X-Received: by 10.68.221.6 with SMTP id qa6mr13786151pbc.62.1434018160376;
        Thu, 11 Jun 2015 03:22:40 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id q4sm300488pdo.42.2015.06.11.03.22.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 03:22:38 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271388>

Implement applying the patch to the index using git-apply.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index a1db474..b725a74 100644
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
@@ -512,6 +524,29 @@ static int parse_patch(struct am_state *state, const char *patch)
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
+	argv_array_push(&cp.args, "--index");
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
@@ -529,7 +564,25 @@ static void am_run(struct am_state *state)
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
