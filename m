From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 06/10] clone: support multiple levels of verbosity
Date: Wed, 24 Feb 2010 20:50:25 +0800
Message-ID: <1267015829-5344-7-git-send-email-rctay89@gmail.com>
References: <1267015829-5344-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@googlemail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 13:51:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkGi4-0005M5-NJ
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 13:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756894Ab0BXMvC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 07:51:02 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:64550 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756844Ab0BXMvA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 07:51:00 -0500
Received: by mail-qy0-f179.google.com with SMTP id 9so338835qyk.5
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 04:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=txhFU9ZRG3rY2yfDJPwaLZfDa7tuYHmaSF75YxEa9k4=;
        b=AKr7jmChUv2Eeg6timbjzsNh5IZPoiaNI0lXYEqLTATSI4YXOmcWWxoReh/joqTt6v
         fkDrSi37iHjyMY51+wqi2euBE49YBQR3L2tQoWcS1Tw4psLqjuWbDY0O1zFqDZ5UJsQa
         CSQLfl7DuugGfuMH2SJEWxQ/kumkZZxBBPUfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TBQxDrJFxuzowE6L6O+cd+urIRO5T8WGZjJYiEwNAafu9H3CVWwa6rYGkl5kwV2k+j
         UuIbRuL5tAuX6cVjW0EGcKzAKhS4bRgMVmdjCZlAXdUwOlrMTdn61gxH49zBHTSWT6/0
         HSRBr3o2S1TgfUQnuMEEOg3jPrQgjAh2ozhdk=
Received: by 10.229.217.141 with SMTP id hm13mr278314qcb.48.1267015860261;
        Wed, 24 Feb 2010 04:51:00 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 23sm253680qyk.15.2010.02.24.04.50.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 04:50:59 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1267015829-5344-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140940>

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
1.7.0.20.gcb44ed
