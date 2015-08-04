From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 35/45] builtin-am: invoke applypatch-msg hook
Date: Tue,  4 Aug 2015 21:51:56 +0800
Message-ID: <1438696326-19590-36-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:54:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcfx-0002r5-N1
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbbHDNya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:54:30 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34567 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964949AbbHDNy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:29 -0400
Received: by pawu10 with SMTP id u10so9258140paw.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kPMEBkazoMw4ZXeQs2xFF9MmoMGqrHerbfEwfjGHrKM=;
        b=ZzB8H5JKDhbk8/b+d4xchLQ/R915CMhxRwGjjoToitPaNJyFrjwk6ym122lpVuuPEm
         TYCdmsRiJjkB9OfjlbaYpj416LCTrWMNC8BSTBpnOZNzS0KMiddPTQtsYPYq6e7oMXt6
         Ugs+6FsGGxnv7mNfjNMcc0wcILrU5S9YKBTN2vK1TPJ8VEnL5St6CQY8Hd0yshGoRLO5
         k7zButU27GvRlE78EwjvfayYYY+263It9Fb3NY1p+vi+7RfP7grHN4ksW+r4cOUB6zNe
         bOvekLB2tGxED5C0i5QjZWqEi7IBiiiROcZbHZzVjruy+10fd4Jm80ORdJ03rxDOJbox
         ZTDQ==
X-Received: by 10.69.17.202 with SMTP id gg10mr7995022pbd.15.1438696468680;
        Tue, 04 Aug 2015 06:54:28 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.54.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:54:26 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275305>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sh will invoke the applypatch-msg hooks just after extracting the
patch message. If the applypatch-msg hook exits with a non-zero status,
git-am.sh abort before even applying the patch to the index.

Re-implement this in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 7d7f91d..f0e3aab 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -456,6 +456,27 @@ static void am_destroy(const struct am_state *state)
 }
 
 /**
+ * Runs applypatch-msg hook. Returns its exit code.
+ */
+static int run_applypatch_msg_hook(struct am_state *state)
+{
+	int ret;
+
+	assert(state->msg);
+	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
+
+	if (!ret) {
+		free(state->msg);
+		state->msg = NULL;
+		if (read_commit_msg(state) < 0)
+			die(_("'%s' was deleted by the applypatch-msg hook"),
+				am_path(state, "final-commit"));
+	}
+
+	return ret;
+}
+
+/**
  * Runs post-rewrite hook. Returns it exit code.
  */
 static int run_post_rewrite_hook(const struct am_state *state)
@@ -1420,6 +1441,9 @@ static void am_run(struct am_state *state, int resume)
 			write_commit_msg(state);
 		}
 
+		if (run_applypatch_msg_hook(state))
+			exit(1);
+
 		say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
 		apply_status = run_apply(state, NULL);
-- 
2.5.0.280.gd88bd6e
