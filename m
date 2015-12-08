From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 1/8] update-index: add untracked cache notifications
Date: Tue,  8 Dec 2015 18:15:09 +0100
Message-ID: <1449594916-21167-2-git-send-email-chriscool@tuxfamily.org>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 18:15:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6Lre-00061D-AW
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 18:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbbLHRPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 12:15:40 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33469 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbbLHRPi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 12:15:38 -0500
Received: by wmec201 with SMTP id c201so222255531wme.0
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 09:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5yOGnPyz90IFhMfo8XYBP19lq2KQgajtJoHGo5WW0JQ=;
        b=IUDfFPUn1pq14SDcO95927jbD/ww44RLd8Ss5kkMd6hZHeFvSHWILEN5wxHW1IKQB+
         EcTt+jmUBxTwLvPk+w0YD3b8JJmb2plk+Kaki24gR+B16dl3vTpE97Ix9lU+pvUXmJIc
         +eGbrIPEsS0PcpKrAu9XFzHanOCmmCFo7OwNn2JnXmv9if5XMWUIJP/cgIbP3wVse/J4
         QcTUgm0/A/We/Z4xhWVQTA539Ckivkq58BvKF/SLxKWbNjQTTkaRGo26dnvBNOlcfq/l
         4Hg4BkaPjRN7Iwon2m/A2ysXxtg6yjRnvSQl54bl4AltU99azbUbPFe3zALYiFFvWzys
         r+Qw==
X-Received: by 10.194.88.130 with SMTP id bg2mr711418wjb.162.1449594937775;
        Tue, 08 Dec 2015 09:15:37 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 200sm4332517wmn.11.2015.12.08.09.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Dec 2015 09:15:36 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.478.g9f95483.dirty
In-Reply-To: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282160>

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
index 7431938..6f6b289 100644
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
+		fprintf(stderr, _("Untracked cache disabled\n"));
 	}
 
 	if (active_cache_changed) {
-- 
2.6.3.478.g9f95483.dirty
