From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 36/45] builtin-am: invoke pre-applypatch hook
Date: Tue,  4 Aug 2015 21:51:57 +0800
Message-ID: <1438696326-19590-37-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:54:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcfy-0002r5-AR
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbbHDNyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:54:35 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33743 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964949AbbHDNyd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:33 -0400
Received: by padck2 with SMTP id ck2so9401693pad.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D+nUt9dTYdhfD1VfL/XWBA+13Ym9E+EHalLKqCcZP/Y=;
        b=PoNmureiFZM5UgrpMQJu7r2wZG/83oLom7rY7meDngb/ZBiR9bp12dy0Vr1UB0sm14
         lCdFt16Idcw93SjUKr/+jZ5nuqQdprLIbvbUkRoWAa21yGDa+g+kVzeQHXOp7kxHX9Kw
         JTRstlzWg9P6YOT8aLSf4Suwu0xqsev0q8EqiNN45C857WPH8VuTYSwMP5Y+aEDMW4b3
         Fr0jBlFNC6ELNX/a99BeR/1QK2niAZ7G/niQMJ9X/QlTuhbLAA4bl1joURQYP2gmzu39
         q0czbolgwWSVtRCYrGnAe7p0EXlsCmBZSDwWXz4/j6wESS64unLh6RwtLu+1XZRvjJJB
         27vw==
X-Received: by 10.68.164.97 with SMTP id yp1mr8047556pbb.133.1438696472705;
        Tue, 04 Aug 2015 06:54:32 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.54.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:54:30 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275303>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sg will invoke the pre-applypatch hook after applying the patch
to the index, but before a commit is made. Should the hook exit with a
non-zero status, git am will exit.

Re-implement this in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index f0e3aab..7a7da94 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1334,6 +1334,9 @@ static void do_commit(const struct am_state *state)
 	const char *reflog_msg, *author;
 	struct strbuf sb = STRBUF_INIT;
 
+	if (run_hook_le(NULL, "pre-applypatch", NULL))
+		exit(1);
+
 	if (write_cache_as_tree(tree, 0, NULL))
 		die(_("git write-tree failed to write a tree"));
 
-- 
2.5.0.280.gd88bd6e
