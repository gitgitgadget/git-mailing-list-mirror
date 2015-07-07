From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 22/44] builtin-am: handle stray state directory
Date: Tue,  7 Jul 2015 22:20:40 +0800
Message-ID: <1436278862-2638-23-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:23:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTlu-0004qP-LL
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757726AbbGGOWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:22:39 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34485 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757678AbbGGOWT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:22:19 -0400
Received: by pabvl15 with SMTP id vl15so114111395pab.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bjR1oonFWxRxNdGHGBKiQkC39zLKGFqro3Y36QIjn6U=;
        b=evKVLh02dx1hbPsx2lY4qCl1O3HLOOGHT92R2wZ+h7fS1jZ64r3cQauZm+LZWzyMCp
         Oh8pGurOLjSpWzafs7+fz4fEZZnDfn4HSrr0VjKZb0mxJQIANSMF4ZuijvrlRDv3C93c
         2BYTx3nCT1g1CPqBMEryyVXlsSIzyqSOa4Mm/nWYUWCElQDPxJM3JmuVT5oUippsW1Ge
         H/6cGS3ZVF6mWj0S8cMbeWlDtn/jLa6LU9wX3dJGOWO18jQc3HqFdmFaBui3J11KZz6N
         Kb3e1Gndr2VpKcaq0qVDCLNKbUs9lrV/qEEUGVCaOLap6FSO7f1N2Um0S+icn7FGX2b6
         qyxQ==
X-Received: by 10.68.69.47 with SMTP id b15mr9675305pbu.38.1436278939440;
        Tue, 07 Jul 2015 07:22:19 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.22.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:22:18 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273536>

Should git-am terminate unexpectedly between the point where the state
directory is created, but the "next" and "last" files are not written
yet, a stray state directory will be left behind.

As such, since b141f3c (am: handle stray $dotest directory, 2013-06-15),
git-am.sh explicitly recognizes such a stray directory, and allows the
user to remove it with am --abort.

Re-implement this feature in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 06ded5d..c92bff4 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1531,6 +1531,23 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		struct argv_array paths = ARGV_ARRAY_INIT;
 		int i;
 
+		/*
+		 * Handle stray state directory in the independent-run case. In
+		 * the --rebasing case, it is up to the caller to take care of
+		 * stray directories.
+		 */
+		if (file_exists(state.dir) && !state.rebasing) {
+			if (resume == RESUME_ABORT) {
+				am_destroy(&state);
+				am_state_release(&state);
+				return 0;
+			}
+
+			die(_("Stray %s directory found.\n"
+				"Use \"git am --abort\" to remove it."),
+				state.dir);
+		}
+
 		if (resume)
 			die(_("Resolve operation not in progress, we are not resuming."));
 
-- 
2.5.0.rc1.76.gf60a929
