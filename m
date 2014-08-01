From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v7 3/8] add line number and file name info to `config_set`
Date: Fri,  1 Aug 2014 10:05:51 -0700
Message-ID: <1406912756-15517-4-git-send-email-tanayabh@gmail.com>
References: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 19:06:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDGIE-0001qE-N3
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 19:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbaHARGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 13:06:52 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:59780 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbaHARGv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 13:06:51 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so5917815pde.9
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 10:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9HdyQ7lNmnPMhzmkzwtD/GfDdKK30QmaBa5yXv5lo0c=;
        b=mEOrwpqknIBk20SEKEwWVVtGi6PWe+pW3LjhzvYGhOHxIO8joxtYKpyVhUgZjGO+wd
         PL8Jo4EDnruNYBCQfDY8CTbpLKPV1adPNS1zbzKC/XPcJiZQ6REhfXQslKpDhEgwJsuV
         ff638FDcMsMNb4QBxndFGGQciU3v+Ts46Zm4a5diYO3mOf0sLOXacPlDX1BK3svpyDpO
         F2tleJ1r97P25jweq5jyOiS91ZpLqFTocfWFoNd8fXJDllidATSboREkJhrV2OY7tWEz
         FpPZrf9a8dqv+mvZSMFsPSaZStBQMMQTCUQQPdSZET87ZQS8waPj9+6cDggkVtSSViiY
         eJQw==
X-Received: by 10.70.136.194 with SMTP id qc2mr7816804pdb.109.1406912811107;
        Fri, 01 Aug 2014 10:06:51 -0700 (PDT)
Received: from localhost.localdomain ([110.225.111.156])
        by mx.google.com with ESMTPSA id pz10sm9241121pbb.33.2014.08.01.10.06.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 01 Aug 2014 10:06:49 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254636>

Store file name and line number for each key-value pair in the cache
during parsing of the configuration files.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 config.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index bb4629e..e685b66 100644
--- a/config.c
+++ b/config.c
@@ -1230,6 +1230,11 @@ int git_config_with_options(config_fn_t fn, void *data,
 	return ret;
 }
 
+struct key_value_info {
+	const char *filename;
+	int linenr;
+};
+
 int git_config(config_fn_t fn, void *data)
 {
 	return git_config_with_options(fn, data, NULL, 1);
@@ -1260,6 +1265,9 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 static int configset_add_value(struct config_set *cs, const char *key, const char *value)
 {
 	struct config_set_element *e;
+	struct string_list_item *si;
+	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
+
 	e = configset_find_element(cs, key);
 	/*
 	 * Since the keys are being fed by git_config*() callback mechanism, they
@@ -1272,7 +1280,16 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
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
+		kv_info->filename = strintern("parameter");
+		kv_info->linenr = 0;
+	}
+	si->util = kv_info;
 
 	return 0;
 }
@@ -1299,7 +1316,7 @@ void git_configset_clear(struct config_set *cs)
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
