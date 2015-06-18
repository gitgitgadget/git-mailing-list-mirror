From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 15/31] am: don't accept patches when there's a session in progress
Date: Thu, 18 Jun 2015 19:25:27 +0800
Message-ID: <1434626743-8552-16-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:27:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XyR-00055J-1W
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbbFRL1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:27:06 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35399 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505AbbFRL0x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:26:53 -0400
Received: by pdbci14 with SMTP id ci14so6233824pdb.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A3qipsvaVMgyFwLn3BvOl8py6wml13NzI6WRkhtwa2Y=;
        b=opDCDLJsMF1/4lBitdeeQcLq7Id3L/WLvbgioarycfHo3RwbfsISeeXmBQM2JuZglo
         ksAdTk8ns9XKCUmwPzLgLTEb2ViC0WnouLsBP5gzN/gS073ma88aTSNdlpP8xhOsuGxc
         QjICA2NJi/s0LBFnVHOyD7DU6un44OIQ5nIqnECTC3Pm8HR2FKpWUbwpGqtcABc0sOKj
         +WnHRtWgi9vUhBdByVJ0WUFT4GCesdqEYbFNg7dpeaXL4m8Jv6g0RlXmF5OuDeYV+9jw
         Cmo6QDkH5M4SNZGWOlzH5IwjrR4PO9P+ShIzK2Vzt/5k6cBvFgzVy7wi6uEe7vT5upT6
         KmXg==
X-Received: by 10.68.244.73 with SMTP id xe9mr20261249pbc.98.1434626812830;
        Thu, 18 Jun 2015 04:26:52 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.26.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:26:51 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271979>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
would error out if the user gave it mbox(s) on the command-line, but
there was a session in progress.

Since c95b138 (Fix git-am safety checks, 2006-09-15), git-am would
detect if the user attempted to feed it a mbox via stdin, by checking if
stdin is not a tty and there is no resume command given.

Re-implement the above two safety checks.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    NOTE: there's no test for this

 builtin/am.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 7053b8f..4adc487 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1003,9 +1003,24 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	if (read_index_preload(&the_index, NULL) < 0)
 		die(_("failed to read the index"));
 
-	if (am_in_progress(&state))
+	if (am_in_progress(&state)) {
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
+		if (argc || (!opt_resume && !isatty(0)))
+			die(_("previous rebase directory %s still exists but mbox given."),
+				state.dir.buf);
+
 		am_load(&state);
-	else {
+	} else {
 		struct string_list paths = STRING_LIST_INIT_DUP;
 		int i;
 
-- 
2.1.4
