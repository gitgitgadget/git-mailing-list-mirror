From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 30/45] builtin-am: implement --ignore-date
Date: Tue,  4 Aug 2015 21:51:51 +0800
Message-ID: <1438696326-19590-31-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:54:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcfj-0002iy-0j
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbbHDNyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:54:18 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36845 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964928AbbHDNyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:16 -0400
Received: by pacgq8 with SMTP id gq8so9182812pac.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H/bWVaS35uoftIobpjF9sAx2tTE27S1qOfHbsnbQ6vE=;
        b=mqqvlCFYnrZQzQ5LjGltxVBdeJiBjDLeNUH5sJE42mOB+ekDgbdp55jIfOJnKImmco
         ihhbwnqhpNwQGLCYkaS4okFSrg9HENQ65Eyd1hU5TgPKLkhofpZzkFkyV7nKSraucf2A
         KuyyWC4ihaAjFXlVcAL26/unpf7I7t380a/58GEM4W04rXamLjjlAqdCEVdncmsyZ96k
         9jWHhyMnDX6rzfx7P0EIaZt6N4HoyLWPtANDPD0d33ynGCVPTd2d6Zy/jtvZ2t0uQatW
         3hA25+WLFzfwkdWSZG96hnYqmUI4LUGia/G0iTAUwKvd25qdRH0UtgcXykP5igq1epER
         tsUQ==
X-Received: by 10.66.159.68 with SMTP id xa4mr8174562pab.105.1438696455820;
        Tue, 04 Aug 2015 06:54:15 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.54.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:54:14 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275300>

Since a79ec62 (git-am: Add --ignore-date option, 2009-01-24), git-am.sh
supported the --ignore-date option, and would use the current timestamp
instead of the one provided in the patch if the option was set.

Re-implement this option in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index f842f69..84d3e05 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -108,6 +108,7 @@ struct am_state {
 	int scissors; /* enum scissors_type */
 	struct argv_array git_apply_opts;
 	const char *resolvemsg;
+	int ignore_date;
 	int rebasing;
 };
 
@@ -1217,7 +1218,8 @@ static void do_commit(const struct am_state *state)
 	}
 
 	author = fmt_ident(state->author_name, state->author_email,
-			state->author_date, IDENT_STRICT);
+			state->ignore_date ? NULL : state->author_date,
+			IDENT_STRICT);
 
 	if (commit_tree(state->msg, state->msg_len, tree, parents, commit,
 				author, NULL))
@@ -1661,6 +1663,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "abort", &resume,
 			N_("restore the original branch and abort the patching operation."),
 			RESUME_ABORT),
+		OPT_BOOL(0, "ignore-date", &state.ignore_date,
+			N_("use current timestamp for author date")),
 		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
 			N_("(internal use for git-rebase)")),
 		OPT_END()
-- 
2.5.0.280.gd88bd6e
