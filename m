From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 23/31] am: handle stray state directory
Date: Thu, 18 Jun 2015 19:25:35 +0800
Message-ID: <1434626743-8552-24-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:27:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xyr-0005X5-Dg
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbbFRL1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:27:33 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34494 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932173AbbFRL1O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:27:14 -0400
Received: by pdbki1 with SMTP id ki1so64757370pdb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XkxgJNVZN5CczcjJq7beFNoxmpJ0fxka8cjnFce/aDQ=;
        b=mGI5xoZj55JTamC1T5dCMSvdmpAqc1Vqy8+nFXXjDcBSHL5TJ9CBPdiGd4zpaE9VcD
         LIVlsKEwCkZ2bjEwYA+vmBYJKI2xzWNw1qJ9Eyzb49lW7B6vLxHpmCFghKOYNRV0jeMA
         cMsWT8mDNIY0/IHAy8qh8Ot4Zo+thvvLdBFnjgpN1i7j0Bvcce5aFD9eIA8+uEmMu3GZ
         aTUW8wg0wACeOSfClDIYaOKQ12nBTLIG/kjO9U2tXdhqchMfLb7f3CJ4vQKofBlHIwHI
         rk9NhnJ+mibDSF6RZtPU/GeCsthYDIzga0uYyui5RVP1YbyZHjKDWuPCagSZ4hA2Ri9f
         2Q7Q==
X-Received: by 10.66.197.134 with SMTP id iu6mr20748571pac.50.1434626833531;
        Thu, 18 Jun 2015 04:27:13 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.27.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:27:12 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271987>

Should git-am terminate unexpectedly between the point where the state
directory is created, but the "next" and "last" files are not written
yet, a stray state directory will be left behind.

As such, since b141f3c (am: handle stray $dotest directory, 2013-06-15),
git-am.sh explicitly recognizes such a stray directory, and allows the
user to remove it with am --abort.

Re-implement this feature in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 0d7e37c..bbef91f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1395,6 +1395,21 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		struct string_list paths = STRING_LIST_INIT_DUP;
 		int i;
 
+		/*
+		 * Possible stray dotest directory in the independent-run case.
+		 */
+		if (file_exists(state.dir.buf) && !state.rebasing) {
+			if (opt_resume == RESUME_ABORT) {
+				am_destroy(&state);
+				am_state_release(&state);
+				return 0;
+			}
+
+			die(_("Stray %s directory found.\n"
+				"Use \"git am --abort\" to remove it."),
+				state.dir.buf);
+		}
+
 		if (opt_resume)
 			die(_("Resolve operation not in progress, we are not resuming."));
 
-- 
2.1.4
