From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP 7/8] am: apply patch with git-apply
Date: Wed, 27 May 2015 21:33:37 +0800
Message-ID: <1432733618-25629-8-git-send-email-pyokagan@gmail.com>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 15:35:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxbUN-0006UN-S4
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 15:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbbE0Nep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 09:34:45 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34595 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbbE0Nen (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 09:34:43 -0400
Received: by pdbki1 with SMTP id ki1so15470185pdb.1
        for <git@vger.kernel.org>; Wed, 27 May 2015 06:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j5BrWriuiMAsbseH5PO0yOuA7M/+auZ/ZqDeldDXagg=;
        b=NNmBuLekFMVEe/zbHtliS7cFm2ULV172Zxm8MLJ0wSxKrNxm/Q1NEk+Ms8sdTdw/Ar
         l9Z1JaApA5ARSPWVSH0tHCLKVNrp3am6vgqiudFHCPuzcztvsxWfhULfnYMMpYQ1aDkj
         CKP9DCWZ7YJVSiZ1JUdjDYQb3zwNJyWngNMo2dQM/+CM7khF8wQTmAMxfrqbgtAaX7ux
         ASU/49ZIK52Z7w8PrGBSYq3LSyCfVfgDX9aceQ7wvEKHnn9fZ1MMJNzVSvyiNhKFxuL5
         UZe+/2SmUK+eva+hbXusjbJ/CTPrSD81dSFUI3J1WWVYv6ZpWBIZtWnTsNu6WOBTLlP0
         edRw==
X-Received: by 10.68.202.135 with SMTP id ki7mr58511968pbc.122.1432733682640;
        Wed, 27 May 2015 06:34:42 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id e5sm16301395pdc.94.2015.05.27.06.34.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 May 2015 06:34:41 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270053>

Implement applying the patch to the index using git-apply.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 0b8a42d..7126df3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -25,6 +25,18 @@ static int is_empty_file(const char *filename)
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
@@ -503,6 +515,29 @@ static int parse_patch(struct am_state *state, const char *patch)
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
@@ -520,7 +555,20 @@ static void am_run(struct am_state *state)
 		write_file(am_path(state, "final-commit"), 1, "%s", state->msg.buf);
 		write_author_script(state);
 
-		/* patch application not implemented yet */
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
 
 next:
 		am_next(state);
-- 
2.1.4
