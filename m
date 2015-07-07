From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 42/44] builtin-am: implement legacy -b/--binary option
Date: Tue,  7 Jul 2015 22:21:00 +0800
Message-ID: <1436278862-2638-43-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:24:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTnY-0005pA-DF
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757785AbbGGOYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:24:16 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33056 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757787AbbGGOXO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:23:14 -0400
Received: by pacws9 with SMTP id ws9so115540976pac.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9gJwUok8k+opRKYL8KZZlaZVisfT96/zRjN2gJkc3xE=;
        b=ved6D3SVy3wM3WoIo5zRnISBDwlTeNoHS37VAiU/bBtesRK1aChHKwHY5YS+Gwdv/e
         EUPjAAXkYWKeRDkuVFYVT5kcBTgmQkdFRPWV/QKQTbpMQS9A06hpGHrkYCE8HEcajdlj
         AP+PE2Of+BTf45lIwwMbtdJsUWyVxFDjxfT9EkREpGgyjg2YAt9leNZASYYhYwZeoB9s
         Z9BJD6bi+4rpIVKlBSmTAuJdqiUy/qlXb2Jrl0S5G2baTopROYe64wgp/BXjkuCp6S+T
         +vlWJqa0fTMWLb8SqpXvFu8LPW66fAg6in9VRPs5Y3WW0Zndm9+azleE6p9CDyM4B0Md
         ykqw==
X-Received: by 10.70.130.161 with SMTP id of1mr9515882pdb.31.1436278994470;
        Tue, 07 Jul 2015 07:23:14 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.23.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:23:13 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273560>

The -b/--binary option was initially implemented in 087b674 (git-am:
--binary; document --resume and --binary., 2005-11-16). The option will
pass the --binary flag to git-apply to allow it to apply binary patches.

However, in 2b6eef9 (Make apply --binary a no-op., 2006-09-06), --binary
was been made a no-op in git-apply. Following that, since cb3a160
(git-am: ignore --binary option, 2008-08-09), the --binary option in
git-am is ignored as well.

In 6c15a1c (am: officially deprecate -b/--binary option, 2012-03-13),
the --binary option was tweaked to its present behavior: when set, the
message:

	The -b/--binary option has been a no-op for long time, and it
	will be removed. Please do not use it anymore.

will be printed.

Re-implement this in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 2866328..ad07ba4 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2144,6 +2144,7 @@ enum resume_mode {
 int cmd_am(int argc, const char **argv, const char *prefix)
 {
 	struct am_state state;
+	int binary = -1;
 	int keep_cr = -1;
 	int patch_format = PATCH_FORMAT_UNKNOWN;
 	enum resume_mode resume = RESUME_FALSE;
@@ -2157,6 +2158,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL('i', "interactive", &state.interactive,
 			N_("run interactively")),
+		OPT_HIDDEN_BOOL('b', "binary", &binary,
+			N_("(historical option -- no-op")),
 		OPT_BOOL('3', "3way", &state.threeway,
 			N_("allow fall back on 3way merging if needed")),
 		OPT__QUIET(&state.quiet, N_("be quiet")),
@@ -2257,6 +2260,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
+	if (binary >= 0)
+		fprintf_ln(stderr, _("The -b/--binary option has been a no-op for long time, and\n"
+				"it will be removed. Please do not use it anymore."));
+
 	if (read_index_preload(&the_index, NULL) < 0)
 		die(_("failed to read the index"));
 
-- 
2.5.0.rc1.76.gf60a929
