From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v9 3/8] add line number and file name info to `config_set`
Date: Thu,  7 Aug 2014 04:59:14 -0700
Message-ID: <1407412759-13833-4-git-send-email-tanayabh@gmail.com>
References: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 14:00:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFMMu-0004x2-Db
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 14:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbaHGMAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 08:00:18 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34117 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbaHGMAP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 08:00:15 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so5321611pab.28
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 05:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vBMRh3pScM7VFOfEXb0sEm0ZjnQFr6NY+M/DQrht0H0=;
        b=jM3zcs6w3xq7kZZmAwG7DHwMDdMBzr6zdhcCl05hLazmzEOI1LZlO104Cm6YzOYtJo
         iBOboPSV4fFIoNS5dAdXBN7QNarYqcfPspD5d6CFGYcw+Yw6ZGgB/Oae6uHvy/osZ82K
         2X+IHFBuu5JbdDyO5bzPNMF/Exg0pqRzmmYa2t49xMvxpFwJK5Fq9qnrs4I7QB3ZYFJM
         p1KTY3Z0g3NTKT02A2kXPMtmn4Vr3pU8zfLq8iNERQ43G2+SFjpy9Ywl/qmShYE/KIp9
         WLNaQ4fMEdHWI+kmBERm/FHzVCV6C2gDQe4pEigv3wh7BOPtRCLjL7c1C6e539Uy3vmg
         PNvA==
X-Received: by 10.68.69.109 with SMTP id d13mr17074320pbu.111.1407412814997;
        Thu, 07 Aug 2014 05:00:14 -0700 (PDT)
Received: from localhost.localdomain ([223.176.226.83])
        by mx.google.com with ESMTPSA id cb8sm13997212pad.8.2014.08.07.05.00.11
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 05:00:14 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254953>

Store file name and line number for each key-value pair in the cache
during parsing of the configuration files.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 cache.h  |  5 +++++
 config.c | 16 ++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 7292aef..0b1bdfd 100644
--- a/cache.h
+++ b/cache.h
@@ -1383,6 +1383,11 @@ extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
 extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
 
+struct key_value_info {
+	const char *filename;
+	int linenr;
+};
+
 extern int committer_ident_sufficiently_given(void);
 extern int author_ident_sufficiently_given(void);
 
diff --git a/config.c b/config.c
index bb4629e..e4d745e 100644
--- a/config.c
+++ b/config.c
@@ -1260,6 +1260,9 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 static int configset_add_value(struct config_set *cs, const char *key, const char *value)
 {
 	struct config_set_element *e;
+	struct string_list_item *si;
+	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
+
 	e = configset_find_element(cs, key);
 	/*
 	 * Since the keys are being fed by git_config*() callback mechanism, they
@@ -1272,7 +1275,16 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 		string_list_init(&e->value_list, 1);
 		hashmap_add(&cs->config_hash, e);
 	}
-	string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
+	si = string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
+	if (cf) {
+		kv_info->filename = strintern(cf->name);
+		kv_info->linenr = cf->linenr;
+	} else {
+		/* for values read from `git_config_from_parameters()` */
+		kv_info->filename = NULL;
+		kv_info->linenr = -1;
+	}
+	si->util = kv_info;
 
 	return 0;
 }
@@ -1299,7 +1311,7 @@ void git_configset_clear(struct config_set *cs)
 	hashmap_iter_init(&cs->config_hash, &iter);
 	while ((entry = hashmap_iter_next(&iter))) {
 		free(entry->key);
-		string_list_clear(&entry->value_list, 0);
+		string_list_clear(&entry->value_list, 1);
 	}
 	hashmap_free(&cs->config_hash, 1);
 	cs->hash_initialized = 0;
-- 
1.9.0.GIT
