From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 22/44] builtin-am: handle stray state directory
Date: Sun, 28 Jun 2015 22:05:44 +0800
Message-ID: <1435500366-31700-23-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:08:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DG9-0002cL-40
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbbF1OIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:08:31 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34276 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbbF1OH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:07:57 -0400
Received: by pdbep18 with SMTP id ep18so79683862pdb.1
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sn6yFoX3o3Ke7Av4WEzsyA0O5NTRAvJuohErNK5nm98=;
        b=PyokD917MCqglae9GGAE5qieIL/xy8gOU82sjBc8ylIcPRx0+PqZTw7cdLSpfjMUl8
         +Gv/81zZ9YEYOyT9+Oaep3uHKKEhuuCXmD8Hlz3ruOLnkT54fb5UiK3QoynEBNN6xH2K
         MOfjS4ufULBduXNY8xfmrqg68tZmTgPknM4fjaTOCYkD7KkPbIF9RPI1dPQj+HZqC5ak
         G7tU0nHafoF4HzLZiX+zR4USFuUzyhtvHwhz4KOKVEo24Kv5giCHdY8Oq8PBu8/CZdeK
         KwiRU8mHvvGY5M7u/ndJxPu6Q/tjz7DwsUfpKWNk8gXlNazc/EgsoglhN+H28QvnD/hs
         orWg==
X-Received: by 10.68.65.7 with SMTP id t7mr22417425pbs.133.1435500477390;
        Sun, 28 Jun 2015 07:07:57 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.07.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:07:53 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272900>

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
index 9af8ad2..49a6840 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1537,6 +1537,23 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.5.0.rc0.76.gb2c6e93
