From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 23/45] builtin-am: handle stray state directory
Date: Tue,  4 Aug 2015 21:51:44 +0800
Message-ID: <1438696326-19590-24-git-send-email-pyokagan@gmail.com>
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
	id 1ZMcff-0002iy-JS
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbbHDNyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:54:03 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36129 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964892AbbHDNyA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:00 -0400
Received: by pdco4 with SMTP id o4so4780638pdc.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cepxc4if8YQXEOj1NZ2O+o3XnA/cEi7APTpmPOoljgw=;
        b=prCXX+wn9WOlRDPl8jLw/E9zITHrz0K7rWPCJZ4EKujlOSfDGsNtVY6ECYhtOi4ENh
         LGtlKzvg2SgiteZ0vG1i4iL1YEAYkQHNOL+XPNQGmze5WIubjubRDXZhBNGUMp/e937L
         5tj04sI0JwLUHYN23wi/VdgihxmXQPpYomcqIZLX5BNJy3gCsGulAvBqEXbNWd7iVvH1
         3xeED/oSmTtlMdpOYceMrTh/Fy/pENNvdIrLNeS3T8ih86MLIpvV9jXJsxl3grIEkYm5
         Kee3tf7dHQ4HD9jsFyl6EmSPWhuRGcp+RzqNW04LKicaSYX9eI1oT+9Lv76Cbexza5a6
         zhcQ==
X-Received: by 10.70.123.226 with SMTP id md2mr8131104pdb.29.1438696439632;
        Tue, 04 Aug 2015 06:53:59 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.53.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:53:52 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275299>

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
index a02c84e..47dd4c7 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1530,6 +1530,23 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.5.0.280.gd88bd6e
