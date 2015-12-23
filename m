From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 04/11] update-index: add untracked cache notifications
Date: Wed, 23 Dec 2015 22:03:52 +0100
Message-ID: <1450904639-25592-5-git-send-email-chriscool@tuxfamily.org>
References: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 22:04:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBqaQ-0008O8-8y
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 22:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965436AbbLWVEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 16:04:37 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36974 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965335AbbLWVEc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 16:04:32 -0500
Received: by mail-wm0-f51.google.com with SMTP id p187so162729409wmp.0
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 13:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ATEHMqw3IEx7AHOQJo4WgCwuLKybKSTKM20umiwuhlU=;
        b=uewav5R5WgBJA6cI2eUn9ba4C+3FzMuC9cJBiMt7qQ1I2CCJsSg/mAeNt/63s7NsN3
         2iVF4d5ONENQi85ZQXAOMvrPPANdIOb/ZCJ3dLUEuskjEU9E06TCBbZMEY265kwo41t/
         cI1RoKr+CWirS6ue5cg87xWeyDDFQOFu4XdtIDAzFJLVCuhxiadJx+tRliicsfl49yDL
         JKUUG3RKjhPbr4B/10Vpguf0PvSwwNYgGANfgNkxNTByoy4EYro4v7sr1Q2UtIAivF46
         NRTddBXRrzT/B0bcPxbX5H1KQ3Th4FM3w3zgByaxltRbECAVnFhQVneWLdh5pzU73cgT
         M3tg==
X-Received: by 10.194.104.130 with SMTP id ge2mr36056707wjb.111.1450904671038;
        Wed, 23 Dec 2015 13:04:31 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id w80sm9434692wme.17.2015.12.23.13.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Dec 2015 13:04:29 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.11.g68ccdd4
In-Reply-To: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282959>

Attempting to flip the untracked-cache feature on for a random index
file with

    cd /random/unrelated/place
    git --git-dir=/somewhere/else/.git update-index --untracked-cache

would not work as you might expect. Because flipping the feature on
in the index also records the location of the corresponding working
tree (/random/unrelated/place in the above example), when the index
is subsequently used to keep track of files in the working tree in
/somewhere/else, the feature is disabled.

With this patch "git update-index --[test-]untracked-cache" tells the
user in which directory tests are performed. This makes it easy to
spot any problem.

Also in verbose mode, let's tell the user when the cache is enabled
or disabled.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 62222dd..c91e695 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -130,7 +130,7 @@ static int test_if_untracked_cache_is_supported(void)
 	if (!mkdtemp(mtime_dir.buf))
 		die_errno("Could not make temporary directory");
 
-	fprintf(stderr, _("Testing "));
+	fprintf(stderr, _("Testing mtime in '%s' "), xgetcwd());
 	atexit(remove_test_directory);
 	xstat_mtime_dir(&st);
 	fill_stat_data(&base, &st);
@@ -1135,10 +1135,16 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		}
 		add_untracked_ident(the_index.untracked);
 		the_index.cache_changed |= UNTRACKED_CHANGED;
-	} else if (untracked_cache == UC_DISABLE && the_index.untracked) {
-		free_untracked_cache(the_index.untracked);
-		the_index.untracked = NULL;
-		the_index.cache_changed |= UNTRACKED_CHANGED;
+		if (verbose)
+			printf(_("Untracked cache enabled for '%s'\n"), get_git_work_tree());
+	} else if (untracked_cache == UC_DISABLE) {
+		if (the_index.untracked) {
+			free_untracked_cache(the_index.untracked);
+			the_index.untracked = NULL;
+			the_index.cache_changed |= UNTRACKED_CHANGED;
+		}
+		if (verbose)
+			printf(_("Untracked cache disabled\n"));
 	}
 
 	if (active_cache_changed) {
-- 
2.7.0.rc2.11.g68ccdd4
