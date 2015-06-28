From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 14/44] builtin-am: reject patches when there's a session in progress
Date: Sun, 28 Jun 2015 22:05:36 +0800
Message-ID: <1435500366-31700-15-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:08:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DFZ-0002Cq-5x
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbbF1OH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:07:56 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34170 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbbF1OHd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:07:33 -0400
Received: by pdbep18 with SMTP id ep18so79680892pdb.1
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YHAc5owXkPtqHrSoay1lj6L4kJ3JLpvDKJ7lL8NnqR0=;
        b=rvgujI+NjhyOVsKu5W5g8r1pPdOmwLHJqpG7RVwAAs8NWy1aOtefninmyu7/BH0uPg
         tRahdaLLyzvcOWLhfykMWY1J9d/0Z1q4m5aziPJ9cGnhpNdmkG8J/p7Cs3kQu3mF+cee
         cPqOfhC7WSYSOoTJEt2FoFqZxT2vI99G1lDiaF4k1EoSx4mXDKJWpUl7sJFXctQtS24/
         9CRXTI9fI/hVC2u3Esl6nwEzeHUnPbgFENl8yx/tEM+mzHmr641uPOfmjfROqBR0S8AX
         zRIeAVr2ptS8hpep32iZV4AF0ckD+B+4euNXYKL5q40NlYrU7r67Se0tTnNPqC+jrf51
         8RJg==
X-Received: by 10.70.96.139 with SMTP id ds11mr22405394pdb.98.1435500452502;
        Sun, 28 Jun 2015 07:07:32 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.07.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:07:31 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272890>

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
index 1db95f2..e066a97 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1147,9 +1147,24 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
+		if (argc || (resume == RESUME_FALSE && !isatty(0)))
+			die(_("previous rebase directory %s still exists but mbox given."),
+				state.dir);
+
 		am_load(&state);
-	else {
+	} else {
 		struct argv_array paths = ARGV_ARRAY_INIT;
 		int i;
 
-- 
2.5.0.rc0.76.gb2c6e93
