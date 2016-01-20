From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 04/11] update-index: add untracked cache notifications
Date: Wed, 20 Jan 2016 10:59:37 +0100
Message-ID: <1453283984-8979-5-git-send-email-chriscool@tuxfamily.org>
References: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 11:06:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLpeu-0007wT-SZ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 11:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758229AbcATKGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 05:06:23 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35766 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758049AbcATKGL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 05:06:11 -0500
Received: by mail-wm0-f48.google.com with SMTP id r129so124169009wmr.0
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 02:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GPMYb81iaCL/M/k8dtD5hgoenMav/9MEH4zi7307FFM=;
        b=LBBjEBwh8QCHJ/4iTqPB3KY1moXv9P9YnZYsbCZP1L/mRDVzunw8Ys0BsdqcaCXuHI
         SqbOoEqMCK8ocSBkAkbsQOEdWrnWdg4zm9L9LYjJ6HKQTTKKYZRaKR5Ro+KIcCEGZb1q
         E9ws5zbpK49xn3IrgHNLeNnl8EeNOwJbTr4v6gDK0NcXELSZ3qmU9fiRWIlGcD2ucqRI
         bqVEVHkTyN8UDowiqQIlfvY2tg+BTfUVez7Og8nlVQDXg2ipheQ1D+0b81HF03znOa5G
         QsKzlEUOLcHeB1PqdFPBHhM7CQ+drkxiD90F/4jdSFTW3X8cJlo2deypve4dM0kLxXQs
         Jdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GPMYb81iaCL/M/k8dtD5hgoenMav/9MEH4zi7307FFM=;
        b=I/HR3JdTpN+5Y5VVkjCGZFpWOb9P8oOlaLS/MpdT3sWWLuxCI6UtekQpJ1p/VDJbT2
         KZ8DwuV4yAAQmplArWTlfBhtW8QvyF8BmD0K2Miy/w2L8M2YI941svVSVMoH6mupMUoB
         hWzYIpFLUQfxBHtbB6/kk7zfPLm2Zu1AzGfS8RyxhecrGC3gIObFVyj05jrfpZKTs9BH
         j64BBz6ZwXuVFaIUavunQZavf/qTyHFgL2EPHGX4EClfAhgK+33vFg55OSJIR1i41sHV
         rkWQ7Rw4uct1T5DAQQISwZ1qY8r1zvrAk9gKKGSQdepQOrBn6kX5/RPttmnGFB0QjNyn
         6iuA==
X-Gm-Message-State: AG10YOSJUKgZfLKRl0CscQuOok/cg6rsI/rUV+X84YpCguvbv3EPMF93Eq0mQnnE7pck6w==
X-Received: by 10.28.13.213 with SMTP id 204mr2883338wmn.16.1453284370401;
        Wed, 20 Jan 2016 02:06:10 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id x6sm32305613wje.38.2016.01.20.02.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 02:06:09 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g6be5eef
In-Reply-To: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284439>

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
Helped-by: Duy Nguyen <pclouds@gmail.com>
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
2.7.0.36.g6be5eef
