From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 15/45] builtin-am: reject patches when there's a session in progress
Date: Tue,  4 Aug 2015 21:51:36 +0800
Message-ID: <1438696326-19590-16-git-send-email-pyokagan@gmail.com>
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
	id 1ZMcfK-0002W9-KG
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756569AbbHDNxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:53:43 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35665 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964858AbbHDNxf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:53:35 -0400
Received: by pasy3 with SMTP id y3so9194000pas.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iBHI4AMW9WAWcLa6EQl2XNidGS1TJk7jXkmRvUL6n+0=;
        b=ebRlIVha0xTqKLbWVBJu2kMLAPnu3Hu1RQ/gLfEU7TJskUaWivDXa+lWDWxc91BeiD
         Z9iFzuh39NcTSWMeLwBYmUguJI3lOYqjrXxrG6t0pc+jz5VRKKU0Q4XgQwxMsRDs6hri
         luSELPAezHrz+Z5MlJAG/WIFz6im5c7nrIX4oFJcziL72EnG1fwrUmmpjZP4njeY8Riv
         MUGlsHw4UPIGgzBY0qzPRIbsJICQQ9AtRECewK+N4YmG9+LnwlMLA876O+yuRAPwi1nG
         GKherTYOYSa/PdZJj8oPyfWCNL8YLjCd1WDaISMqtiFgQ6zZo+AynR5ppQ8ZIqdDkD5f
         qWtg==
X-Received: by 10.68.254.69 with SMTP id ag5mr8189531pbd.130.1438696415392;
        Tue, 04 Aug 2015 06:53:35 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.53.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:53:34 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275290>

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
index 6c24d07..d4b4b86 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1148,6 +1148,21 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.5.0.280.gd88bd6e
