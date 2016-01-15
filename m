From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 04/11] update-index: add untracked cache notifications
Date: Fri, 15 Jan 2016 07:59:45 +0100
Message-ID: <1452841192-620-5-git-send-email-chriscool@tuxfamily.org>
References: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 08:00:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJyNH-0004wf-RC
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 08:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031AbcAOHAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 02:00:37 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35988 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbcAOHAe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 02:00:34 -0500
Received: by mail-wm0-f45.google.com with SMTP id l65so8277320wmf.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 23:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ekr9mV65s2IepJNkKgbisheWsjMQBG375oHf83kuKAs=;
        b=JlK32YH9HlIa6dfJfLsGOKmDQI67xTgUpAm1y7LjDrqmksmeD9oa3E2evjvsq1JQMw
         pBzG/GEG5pWMOEmSvgoUeXKctEjBmukqtojMKAmjT1FTcYPMS65Whf6uKnr+5vdnYxVc
         IM48NxlGMCEWGaz0y/qsHb3T975LjvM4xWYIWIfKxUPtO43LKTUC3B42zqvHpIE2lgdR
         9DQwy6EW9bZ4H2Nf9Jf3i+3pWvpPofeYN0kzy4Om1k1n1eUPcm+UNIpzHjHucx9vIOOM
         KU8RGbgABi++ePa/9CV0TDRBZiGLawEoR4g19sH0K2rQAv1mZ+0Ll+zWPxpccDSjfvpZ
         pkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ekr9mV65s2IepJNkKgbisheWsjMQBG375oHf83kuKAs=;
        b=MMhWEqowgzRd8/JVpNLw8wPfpadNhqGDY4HVdXKflMn4ZO0cKAaviyv0m0F84sHJ0K
         7jTbP+NjlHEGew0QZLP0nU5fZ6PqV0Lt7bgz+7BUZ++8Pf5p5HnF4oKSBQw2/rWXIN5M
         tZiaw3pQC0cZP7P4nCQtnlkdoU+OuYnOh56mUqRoYhBxD5DY0iQo9GVJ3bgLNgwlsptt
         qbxY0QpMbIgZ6Z2PXKG4CMgfQo+Vf11fH8JHklHW4QhTtpKtP9A4AB5dziZGPPLEDBx7
         7tnJxvQ2JoBf1g+gXfcAJbGFbWcgl2eW57qC7k1DE4Qs5n+mPjSjZuwkEC7ucNsjJdWG
         89ng==
X-Gm-Message-State: ALoCoQnwz6BudC1WJnBmdIUveq4T2teGsWFx0KKmbXcLOqkZUYJdorcmeeA36SBCXnVitiOqGJd9o7qe2IpK5K88A2oHVB71ww==
X-Received: by 10.195.12.75 with SMTP id eo11mr8007729wjd.50.1452841232937;
        Thu, 14 Jan 2016 23:00:32 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id f205sm1169733wme.4.2016.01.14.23.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jan 2016 23:00:32 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g20612a7
In-Reply-To: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284143>

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
2.7.0.36.g20612a7
