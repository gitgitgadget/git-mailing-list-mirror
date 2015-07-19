From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 15/45] builtin-am: reject patches when there's a session in progress
Date: Mon, 20 Jul 2015 00:10:07 +0800
Message-ID: <1437322237-29863-16-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:11:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrBi-0006Gi-Pt
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936AbbGSQLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:11:33 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35456 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887AbbGSQL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:11:27 -0400
Received: by pabkd10 with SMTP id kd10so17161032pab.2
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7KQab1RolFtOGwBJ/2Cseujx6XQ9OFf7AV0FoPR0I6g=;
        b=PUUm3M6O8Tzp6DCNX/c/RBvsJd4mQ4SKF5yWYjaqx1S6ke3M72hIBVc0ExpmMYqLCY
         0PaX0CIt2Xc08IuUS81fuvotMyGgCYeXm6Zub5iaXMnTqajoS+yntu+aMXdkBd07ptOn
         dCG/LKnDk/BDvcpKOR6BvMtXxYpZ1TmYOCNxNqeK6kRS4yVkT6UYBAH2OeUVumppVZW6
         EeFXftINpXmLwg37eF2kDGtim0AHpJz+MTTm0ohmzJsm9LzvPjV0YjzL3zAgRFqe8KlT
         3cyFQYah6oM0fy6e+Dq8IxXtl3zZa6ZefYIaWdD2HYOW3utpWtiG2nlWfQWFir2kaS2c
         uB9g==
X-Received: by 10.70.30.161 with SMTP id t1mr50202200pdh.138.1437322286794;
        Sun, 19 Jul 2015 09:11:26 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.11.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:11:26 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274241>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
would error out if the user gave it mbox(s) on the command-line, but
there was a session in progress.

Since c95b138 (Fix git-am safety checks, 2006-09-15), git-am would
detect if the user attempted to feed it a mbox via stdin, by checking if
stdin is not a tty and there is no resume command given.

Re-implement the above two safety checks.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 8a054ee..fa522f5 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1147,6 +1147,21 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		die(_("failed to read the index"));
 
 	if (am_in_progress(&state)) {
+		/*
+		 * Catch user error to feed us patches when there is a session
+		 * in progress:
+		 *
+		 * 1. mbox path(s) are provided on the command-line.
+		 * 2. stdin is not a tty: the user is trying to feed us a patch
+		 *    from standard input. This is somewhat unreliable -- stdin
+		 *    could be /dev/null for example and the caller did not
+		 *    intend to feed us a patch but wanted to continue
+		 *    unattended.
+		 */
+		if (argc || (resume == RESUME_FALSE && !isatty(0)))
+			die(_("previous rebase directory %s still exists but mbox given."),
+				state.dir);
+
 		if (resume == RESUME_FALSE)
 			resume = RESUME_APPLY;
 
-- 
2.5.0.rc2.110.gb39b692
