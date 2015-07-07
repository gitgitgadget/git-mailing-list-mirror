From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 35/44] builtin-am: invoke pre-applypatch hook
Date: Tue,  7 Jul 2015 22:20:53 +0800
Message-ID: <1436278862-2638-36-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:23:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTmX-0005EC-9f
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757773AbbGGOX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:23:28 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36853 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757706AbbGGOWv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:22:51 -0400
Received: by pacgz10 with SMTP id gz10so40451625pac.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P4SQoSzH99/kryfgz7wNGO/jbbKsqejuZAc0irc2gmA=;
        b=qkHJO7A4nEXi3xDuejNaMUeIG97zOEAp4WP7UbIQ37TwpYPd2MHR78wuDOQveFQuqC
         mIobpJ/XDJHcrHI0x29oeuKcfm7+JBvDW0cTPNSjjHrtAoqajdalgHzMlrx9qJlmTkuW
         tdA9rrXSYICRZPodyoK8Zklt7+Hb/mUrPLjOHELm/Noi7tJBvo2moQzVQqMyZ2kOkxol
         Hy/ylVar54XoV3nSsCLpRgLnM/0TLkOTid1UoYXnVEWiEEhxA7FV6xQIFqbBZbvbr5JB
         jVVmF+1+mhBVItvHKLikERyBnF5lCzExam+7D9XqStc9tM8yG8DWmfh0QRO0cDrEAfwd
         CIPw==
X-Received: by 10.66.249.101 with SMTP id yt5mr9495804pac.116.1436278970505;
        Tue, 07 Jul 2015 07:22:50 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.22.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:22:49 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273550>

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
index f856d3b..407775c 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1374,6 +1374,9 @@ static void do_commit(const struct am_state *state)
 	const char *reflog_msg, *author;
 	struct strbuf sb = STRBUF_INIT;
 
+	if (run_hook_le(NULL, "pre-applypatch", NULL))
+		exit(1);
+
 	if (write_cache_as_tree(tree, 0, NULL))
 		die(_("git write-tree failed to write a tree"));
 
-- 
2.5.0.rc1.76.gf60a929
