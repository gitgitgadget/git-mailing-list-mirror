From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 1/8] update-index: add untracked cache notifications
Date: Tue,  1 Dec 2015 21:31:32 +0100
Message-ID: <1449001899-18956-2-git-send-email-chriscool@tuxfamily.org>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 21:32:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3rbK-00081a-Gc
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 21:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755779AbbLAUcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 15:32:32 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36106 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356AbbLAUca (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 15:32:30 -0500
Received: by wmec201 with SMTP id c201so5027496wme.3
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 12:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4i/xyk7KnweD0CjoAJqVny/Pc004d3fZim+1Cdchnog=;
        b=I/wqAn+H/2KMYN+VUmmh1mDUiHlMR4m7bk/pM9OVdQhB2cjxySJNPcQcYbcDj6pOPa
         1zlYVJ1Fc+vtKK2AtFwLlIge3iCUwW0PaSy8S9RXs6ocEVSvmHYgDaZK9YSUDTbJ4rZa
         32Hc4qY9/HVt9aTyaT942J9UpijZ3rCrwAO9eWsoL0cwVNBHm6D3nV4djGMYx7ENrZt5
         ZU0wfT9mgEAhQRJHNFsbL05+1HCapOpyXw9CXKbAYSC5PIgGEAfenHlup+KC/5q29BAA
         iUmZJpYCOcPOacke1ejqkytc3QRucc3ObdB+kQps9Cc53zfvvJUaLctQ05MkBZTFi4dl
         iIYw==
X-Received: by 10.28.127.200 with SMTP id a191mr93236wmd.27.1449001949611;
        Tue, 01 Dec 2015 12:32:29 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id uw6sm1978310wjc.42.2015.12.01.12.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Dec 2015 12:32:28 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.391.g95a3a5c
In-Reply-To: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281846>

Doing:

  cd /tmp
  git --git-dir=/git/somewhere/else/.git update-index --untracked-cache

doesn't work how one would expect. It hardcodes "/tmp" as the directory
that "works" into the index, so if you use the working tree, you'll
never use the untracked cache.

With this patch "git update-index --untracked-cache" tells the user in
which directory tests are performed and in which working directory the
untracked cache is allowed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7431938..e568acc 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -121,7 +121,7 @@ static int test_if_untracked_cache_is_supported(void)
 	if (!mkdtemp(mtime_dir.buf))
 		die_errno("Could not make temporary directory");
 
-	fprintf(stderr, _("Testing "));
+	fprintf(stderr, _("Testing mtime in '%s' "), xgetcwd());
 	atexit(remove_test_directory);
 	xstat_mtime_dir(&st);
 	fill_stat_data(&base, &st);
@@ -1122,9 +1122,11 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		}
 		add_untracked_ident(the_index.untracked);
 		the_index.cache_changed |= UNTRACKED_CHANGED;
+		fprintf(stderr, _("Untracked cache enabled for '%s'\n"), get_git_work_tree());
 	} else if (!untracked_cache && the_index.untracked) {
 		the_index.untracked = NULL;
 		the_index.cache_changed |= UNTRACKED_CHANGED;
+		fprintf(stderr, _("Untracked disabled\n"));
 	}
 
 	if (active_cache_changed) {
-- 
2.6.3.391.g95a3a5c
