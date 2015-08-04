From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 43/45] builtin-am: implement legacy -b/--binary option
Date: Tue,  4 Aug 2015 21:52:04 +0800
Message-ID: <1438696326-19590-44-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:58:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcjN-0004cR-0J
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbbHDNyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:54:55 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36499 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934273AbbHDNyx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:53 -0400
Received: by pdco4 with SMTP id o4so4789106pdc.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CSBFoc1+lavnZSuXW+gYxvABhN3BWPFdGeG6AwOh3Ls=;
        b=Xb8rZBjsrWuds8uSQ3McAZkknukB1wcMxZxq67kaj+NT5LwDypxzzNu6S/kH635wY2
         nQeMDZgZQU+7f/WRNOfDNhPIl4v6cHOUnBnUGvry9MUqu1NxRK2fholhd78qaCigPzcH
         J28VKc8dLBEniVar73cEbet3Rr6BAKIhLrwPnwkv8jID1s9WT7n5HwwDHViZM4kcYc9e
         dqO1LiDbdOFAe8huoarKvWO8lBI0I2Q2tT09sGoTEOMVeib2Ws/BIujBIo29vGh/rm+l
         tngludVdYqQ0C+aK7uETVa3shcU3N9uaO+QOsKWE1pBmglMfkc5gHjXuS7dkM+2ia+gf
         HoWg==
X-Received: by 10.70.94.98 with SMTP id db2mr8208005pdb.130.1438696492523;
        Tue, 04 Aug 2015 06:54:52 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.54.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:54:50 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275311>

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
index 589199f..3c50392 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2126,6 +2126,7 @@ enum resume_mode {
 int cmd_am(int argc, const char **argv, const char *prefix)
 {
 	struct am_state state;
+	int binary = -1;
 	int keep_cr = -1;
 	int patch_format = PATCH_FORMAT_UNKNOWN;
 	enum resume_mode resume = RESUME_FALSE;
@@ -2139,6 +2140,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL('i', "interactive", &state.interactive,
 			N_("run interactively")),
+		OPT_HIDDEN_BOOL('b', "binary", &binary,
+			N_("(historical option -- no-op")),
 		OPT_BOOL('3', "3way", &state.threeway,
 			N_("allow fall back on 3way merging if needed")),
 		OPT__QUIET(&state.quiet, N_("be quiet")),
@@ -2239,6 +2242,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
+	if (binary >= 0)
+		fprintf_ln(stderr, _("The -b/--binary option has been a no-op for long time, and\n"
+				"it will be removed. Please do not use it anymore."));
+
 	if (read_index_preload(&the_index, NULL) < 0)
 		die(_("failed to read the index"));
 
-- 
2.5.0.280.gd88bd6e
