From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 06/10] dir: add remove_untracked_cache()
Date: Tue, 15 Dec 2015 17:28:23 +0100
Message-ID: <1450196907-17805-7-git-send-email-chriscool@tuxfamily.org>
References: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 17:29:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8sTe-0004RO-Cu
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 17:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128AbbLOQ3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 11:29:14 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33369 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115AbbLOQ3L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 11:29:11 -0500
Received: by mail-wm0-f48.google.com with SMTP id n186so103098312wmn.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 08:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1nhbTW+ytcTYn+2UPv3niE2yW03HFBoPIdlYyivuR+c=;
        b=NtJ72tAgQcrlYNzZfBxcb5biJyDabW28lzF2U5aG8HIlWPZE25T/DM1LT5/oiWq/5T
         UzERBXOK3v5fw/+JWY4yY7EIYeT/Yg3HtwLtmS14gWikgvMlipDkQ/Tbn6WgHKMbL8p0
         lgL2mxp5vzrmHHTMMMPM2Pp5+vmMcPkrUpSVo8zQNjb/8Cl1dcTvf8mvRODkfoB/xzKf
         rnn0jjrGWPg/05a/IFtZhehcLRIADBYMsEs/w+/dmhxKlTuJE2CrCyMj1KXfQHCoVYhg
         sLQ17Ak8X3sFbInly1OQ/TFBUfjIn95AmScvL3/fdh10gL9E1EoBSeb+nZ/uS3tzL8vu
         0DMg==
X-Received: by 10.194.85.229 with SMTP id k5mr24226520wjz.100.1450196950385;
        Tue, 15 Dec 2015 08:29:10 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s11sm3513817wmb.14.2015.12.15.08.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 08:29:09 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.479.g8eb29d4
In-Reply-To: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282488>

Factor out code into remove_untracked_cache(), which will be used
in a later commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 3 +--
 dir.c                  | 6 ++++++
 dir.h                  | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5f009cf..4ca6d94 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1127,8 +1127,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		if (verbose)
 			printf(_("Untracked cache enabled\n"));
 	} else if (untracked_cache == UC_DISABLE && the_index.untracked) {
-		the_index.untracked = NULL;
-		the_index.cache_changed |= UNTRACKED_CHANGED;
+		remove_untracked_cache();
 		if (verbose)
 			printf(_("Untracked cache disabled\n"));
 	}
diff --git a/dir.c b/dir.c
index 0f7e293..ffc0286 100644
--- a/dir.c
+++ b/dir.c
@@ -1952,6 +1952,12 @@ void add_untracked_cache(void)
 	the_index.cache_changed |= UNTRACKED_CHANGED;
 }
 
+void remove_untracked_cache(void)
+{
+	the_index.untracked = NULL;
+	the_index.cache_changed |= UNTRACKED_CHANGED;
+}
+
 static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
 						      int base_len,
 						      const struct pathspec *pathspec)
diff --git a/dir.h b/dir.h
index ee94c76..3e5114d 100644
--- a/dir.h
+++ b/dir.h
@@ -309,4 +309,5 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_ident(struct untracked_cache *);
 void add_untracked_cache(void);
+void remove_untracked_cache(void);
 #endif
-- 
2.6.3.479.g8eb29d4
