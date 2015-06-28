From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 42/44] builtin-am: implement legacy -b/--binary option
Date: Sun, 28 Jun 2015 22:06:04 +0800
Message-ID: <1435500366-31700-43-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:09:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DHG-0003Ob-GT
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbbF1OJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:09:42 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32775 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbbF1OJh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:09:37 -0400
Received: by padev16 with SMTP id ev16so91899372pad.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iUFe+dNQUNLr0z5gkjDh1bayn3So35asiieKUcQDlUs=;
        b=z1Ab/T54D2JLCzdddQXisyhZcswrpl8DP3ATkvRZ41KTVqvc/2epzaQpGKxsiBsu5x
         OTTabIkFax1sud+2Cycl/BamFT0JDg9qEb4aR1Demn+HLmiONnqQ/fn0DftZgNB1GiET
         tID3j/EJEgjG8wYIQlZkwATaIE0ysP+S5l7BBBZqO4VBJK3VCRjXVxx58BYYxq4PdsEs
         84B83w9R5HBVyxFxxLXHTeE0EWFPkRAaJxtgoSqaJWGDqkdelMR7aTMaxIYAwBkT0XLy
         SMSYSzjhJh4NZychk2DsOdmF0P6dT/bcXiCTXoWNWwosEHiVOrl0I+w6VdSIbfpCOR0T
         9AEg==
X-Received: by 10.70.53.99 with SMTP id a3mr22376128pdp.169.1435500576195;
        Sun, 28 Jun 2015 07:09:36 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.09.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:09:34 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272919>

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
index f148f05..a46aa74 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2148,6 +2148,7 @@ enum resume_mode {
 int cmd_am(int argc, const char **argv, const char *prefix)
 {
 	struct am_state state;
+	int binary = -1;
 	int keep_cr = -1;
 	int patch_format = PATCH_FORMAT_UNKNOWN;
 	enum resume_mode resume = RESUME_FALSE;
@@ -2161,6 +2162,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL('i', "interactive", &state.interactive,
 			N_("run interactively")),
+		OPT_HIDDEN_BOOL('b', "binary", &binary,
+			N_("(historical option -- no-op")),
 		OPT_BOOL('3', "3way", &state.threeway,
 			N_("allow fall back on 3way merging if needed")),
 		OPT__QUIET(&state.quiet, N_("be quiet")),
@@ -2261,6 +2264,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
+	if (binary >= 0)
+		fprintf_ln(stderr, _("The -b/--binary option has been a no-op for long time, and\n"
+				"it will be removed. Please do not use it anymore."));
+
 	if (read_index_preload(&the_index, NULL) < 0)
 		die(_("failed to read the index"));
 
-- 
2.5.0.rc0.76.gb2c6e93
