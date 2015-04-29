From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 2/5] cat-file: make the options mutually exclusive
Date: Wed, 29 Apr 2015 18:22:33 +0530
Message-ID: <1430311953-23240-1-git-send-email-karthik.188@gmail.com>
References: <5540D397.8020104@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 14:52:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnRTu-00044O-B4
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 14:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422954AbbD2Mwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 08:52:46 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34229 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422953AbbD2Mwp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 08:52:45 -0400
Received: by pacyx8 with SMTP id yx8so27215500pac.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=My8ixB/tbDNDvnqXztLR1Hw1C0NIJtO3mmkCSzBgcIU=;
        b=Ua9Vyj5S7+JyMz1uWpPibGPsG8gwJBvIKXOG8j2aY4lR2l2DuHckYWX+TzzKCHczUs
         cSXjNiLzO1oQV9udFlYP69mXtzytylfoJhqKPkzGByCPCASZ0s0MH+wPYv02HTmv2fpS
         lQHiVscuA6PB1GXlbpRrdjTGTRdTvo18iZSuXkdrrO2Kd3Kak7Wz0GL1o+miARypy9vV
         0Oioibl5CyHcwR2sDSPOMY2fD2qMW7ULHwB6RwpnSPUzUV+E1n6P1Ywmw1VuOsiTuSsa
         Oo1ApkRqYVswxdzpbvFzRkl8fTWHMepLepszCbsRqDkOQjMYBh4hNSu4B3eAdRZ3t/zq
         ufDQ==
X-Received: by 10.68.194.6 with SMTP id hs6mr41741318pbc.58.1430311965260;
        Wed, 29 Apr 2015 05:52:45 -0700 (PDT)
Received: from ashley.localdomain ([182.48.234.2])
        by mx.google.com with ESMTPSA id ef15sm25596602pad.38.2015.04.29.05.52.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Apr 2015 05:52:44 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc1.250.g565e85b
In-Reply-To: <5540D397.8020104@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267962>

Currently we only parse the options if 2 or 3 arguments are specified.
Update 'struct option options[]' to use OPT_CMDMODE rather than
OPT_SET_INT to allow only one mutually exclusive option and avoid the
need for checking number of arguments. This was written by Junio C Hamano,
tested by me.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/cat-file.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index df99df4..53b5376 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -362,12 +362,12 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 
 	const struct option options[] = {
 		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
-		OPT_SET_INT('t', NULL, &opt, N_("show object type"), 't'),
-		OPT_SET_INT('s', NULL, &opt, N_("show object size"), 's'),
-		OPT_SET_INT('e', NULL, &opt,
+		OPT_CMDMODE('t', NULL, &opt, N_("show object type"), 't'),
+		OPT_CMDMODE('s', NULL, &opt, N_("show object size"), 's'),
+		OPT_CMDMODE('e', NULL, &opt,
 			    N_("exit with zero when there's no error"), 'e'),
-		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
-		OPT_SET_INT(0, "textconv", &opt,
+		OPT_CMDMODE('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
+		OPT_CMDMODE(0, "textconv", &opt,
 			    N_("for blob objects, run textconv on object's content"), 'c'),
 		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
@@ -380,9 +380,6 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 
 	git_config(git_cat_file_config, NULL);
 
-	if (argc != 3 && argc != 2)
-		usage_with_options(cat_file_usage, options);
-
 	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
 
 	if (opt) {
-- 
2.4.0.rc1.250.g565e85b
