From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 05/10] clone: support multiple levels of verbosity
Date: Thu, 18 Feb 2010 20:37:06 +0800
Message-ID: <1266496631-3980-6-git-send-email-rctay89@gmail.com>
References: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Cc: "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 13:38:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni5e4-0004Ez-If
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 13:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758169Ab0BRMhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 07:37:50 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:60410 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758149Ab0BRMht (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 07:37:49 -0500
Received: by mail-yx0-f200.google.com with SMTP id 38so6323162yxe.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 04:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4kYIwXSTWCxMihSe1n4vfam3vd6PNlXq3SfReDu4U0A=;
        b=f89uvDqfjYQyWqkuYKcFpepqHP3YKxlyE032JGm+ivdwOfBd3AVKHL5QLG7UI5+Zoj
         UmZArqecKJK7lrOdqoBptKCDmk0wmnU4EcmR4fYz/YkWRk2DRhvwjuglUtm7Nt1RBuzz
         oZ5yu65iUQnIze4nw5Kz6AVcgWhUCfQJk6Ca8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LcUPtpcw7wuavbeSlKfae/JlwMKzA2A9HCOBvCBixU7Io+aZrg1FTiKY1WpBWIQWSp
         ot91CMzGTLhnSJ0s2mc2zrp8ztc/lzZaKOtU9CRjZIlMc3Q8cddmSWDI38JWUzzh4gtY
         bPAnBmhi8Tgok5RkxHc2rk1xoS0LJnH3ksZnA=
Received: by 10.150.47.19 with SMTP id u19mr16787904ybu.160.1266496667909;
        Thu, 18 Feb 2010 04:37:47 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 21sm381013ywh.17.2010.02.18.04.37.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 04:37:47 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140332>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin-clone.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 58bacbd..959fe4b 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -37,18 +37,17 @@ static const char * const builtin_clone_usage[] = {
 	NULL
 };
 
-static int option_quiet, option_no_checkout, option_bare, option_mirror;
+static int option_no_checkout, option_bare, option_mirror;
 static int option_local, option_no_hardlinks, option_shared, option_recursive;
 static char *option_template, *option_reference, *option_depth;
 static char *option_origin = NULL;
 static char *option_branch = NULL;
 static char *option_upload_pack = "git-upload-pack";
-static int option_verbose;
+static int option_verbosity;
 static int option_progress;
 
 static struct option builtin_clone_options[] = {
-	OPT__QUIET(&option_quiet),
-	OPT__VERBOSE(&option_verbose),
+	OPT__VERBOSITY(&option_verbosity),
 	OPT_BOOLEAN(0, "progress", &option_progress,
 			"force progress reporting"),
 	OPT_BOOLEAN('n', "no-checkout", &option_no_checkout,
@@ -462,7 +461,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		die("could not create leading directories of '%s'", git_dir);
 	set_git_dir(make_absolute_path(git_dir));
 
-	init_db(option_template, option_quiet ? INIT_DB_QUIET : 0);
+	init_db(option_template, (option_verbosity < 0) ? INIT_DB_QUIET : 0);
 
 	/*
 	 * At this point, the config exists, so we do not need the
@@ -526,10 +525,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			transport_set_option(transport, TRANS_OPT_DEPTH,
 					     option_depth);
 
-		if (option_quiet)
-			transport->verbose = -1;
-		else if (option_verbose)
-			transport->verbose = 1;
+		transport_set_verbosity(transport, option_verbosity);
 
 		if (option_progress)
 			transport->progress = 1;
@@ -641,7 +637,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		opts.update = 1;
 		opts.merge = 1;
 		opts.fn = oneway_merge;
-		opts.verbose_update = !option_quiet;
+		opts.verbose_update = (option_verbosity > 0);
 		opts.src_index = &the_index;
 		opts.dst_index = &the_index;
 
-- 
1.7.0.27.g5d71b
