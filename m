From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 29/44] builtin-am: implement --ignore-date
Date: Tue,  7 Jul 2015 22:20:47 +0800
Message-ID: <1436278862-2638-30-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:23:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTmE-00051M-AV
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757768AbbGGOXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:23:09 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36721 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757719AbbGGOWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:22:36 -0400
Received: by pacgz10 with SMTP id gz10so40448475pac.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=69rZM/vxJTCKRS9YyNyZ26HMZnBCkhamBpDDJ9+zgSY=;
        b=YGho0oyM/dncUbTmB4I5MtPgblMqoFmGajz4zaaT2SvQ0GN5JU1CV5evAz0Gq8skOR
         1lH892DcBZgU6bw0cMTX96P00hkR1TEER4djKzDNmmZYE0N5/3Ij85zYMszYALuzG2ad
         j+qdWt6E/jQDGFOvetvH1CGHV/Fi15CPbyCwEh3N3iAThTEXrcv2JnDhSlTns68muJd4
         o10SVWYQDGUvNcbx6ECmebe5dP/ASrNaq9INCExE+WlGa/MXkmXVXqIfZhoHdi6MzFPb
         HmmRFJdMyJxfD1VU4QoGiNfwAgk3OudCTayN/CXHcni8aPggKur7MqOQ38IfxFVovfB4
         r/5A==
X-Received: by 10.66.229.65 with SMTP id so1mr9541093pac.92.1436278956022;
        Tue, 07 Jul 2015 07:22:36 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.22.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:22:35 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273543>

Since a79ec62 (git-am: Add --ignore-date option, 2009-01-24), git-am.sh
supported the --ignore-date option, and would use the current timestamp
instead of the one provided in the patch if the option was set.

Re-implement this option in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 6006010..e9eacf0 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -120,6 +120,8 @@ struct am_state {
 	/* override error message when patch failure occurs */
 	const char *resolvemsg;
 
+	int ignore_date;
+
 	int rebasing;
 };
 
@@ -1254,7 +1256,8 @@ static void do_commit(const struct am_state *state)
 	}
 
 	author = fmt_ident(state->author_name, state->author_email,
-			state->author_date, IDENT_STRICT);
+			state->ignore_date ? NULL : state->author_date,
+			IDENT_STRICT);
 
 	if (commit_tree(state->msg, state->msg_len, tree, parents, commit,
 				author, NULL))
@@ -1674,6 +1677,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "abort", &resume,
 			N_("restore the original branch and abort the patching operation."),
 			RESUME_ABORT),
+		OPT_BOOL(0, "ignore-date", &state.ignore_date,
+			N_("use current timestamp for author date")),
 		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
 			N_("(internal use for git-rebase)")),
 		OPT_END()
-- 
2.5.0.rc1.76.gf60a929
