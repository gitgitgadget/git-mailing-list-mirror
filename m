From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 04/10] update-index: add untracked cache notifications
Date: Tue, 29 Dec 2015 08:09:28 +0100
Message-ID: <1451372974-16266-5-git-send-email-chriscool@tuxfamily.org>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:12:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDoSk-0008Us-IU
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbbL2HMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:12:46 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36501 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbbL2HMK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:12:10 -0500
Received: by mail-wm0-f49.google.com with SMTP id l65so24572041wmf.1
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 23:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6BN3fmbs2zL02pPd5iaKILT6UZZcvImf8KCXWBOwqVY=;
        b=EtrKZpAkSvnMmKXuMznKhpHSeIr3QswnGt3oeU2ImSrV0xwDe7T3erDCGruPToP8bC
         3HzQoemQQRxETc94hS8t6rElu67s1O0yRpauLAQzVtOHkTtVUcVQ6gYoNRIt6ciNokuU
         sgntcsjDJYG9lvVI6VvyXrHRA2u/JMir4XpWS1MfTBS5mwoVoZw2KFUFh8fScRbjJJSj
         BeLtOmbERlZUEWkEa6aGr/LrX/aHVvmpREOKCMM+tW5XiotCke2GKm7wWp7+IKTNp5f0
         BRkJL2K4tkn53LyHVQ8TyLSHAgzOJL5JqU3SlGfFOr6zU/T+l2Ffv7WPibihxpkRa2V+
         /oMA==
X-Received: by 10.194.110.5 with SMTP id hw5mr73453960wjb.154.1451373129678;
        Mon, 28 Dec 2015 23:12:09 -0800 (PST)
Received: from localhost.localdomain (243.40.126.78.rev.sfr.net. [78.126.40.243])
        by smtp.gmail.com with ESMTPSA id uw6sm59795661wjc.42.2015.12.28.23.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Dec 2015 23:12:08 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.10.g544ad6b
In-Reply-To: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283084>

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
 builtin/update-index.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 62222dd..369c207 100644
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
@@ -1135,10 +1135,14 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		}
 		add_untracked_ident(the_index.untracked);
 		the_index.cache_changed |= UNTRACKED_CHANGED;
-	} else if (untracked_cache == UC_DISABLE && the_index.untracked) {
-		free_untracked_cache(the_index.untracked);
-		the_index.untracked = NULL;
-		the_index.cache_changed |= UNTRACKED_CHANGED;
+		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
+	} else if (untracked_cache == UC_DISABLE) {
+		if (the_index.untracked) {
+			free_untracked_cache(the_index.untracked);
+			the_index.untracked = NULL;
+			the_index.cache_changed |= UNTRACKED_CHANGED;
+		}
+		report(_("Untracked cache disabled"));
 	}
 
 	if (active_cache_changed) {
-- 
2.7.0.rc2.10.g544ad6b
