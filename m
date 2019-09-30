Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EED251F463
	for <e@80x24.org>; Mon, 30 Sep 2019 01:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfI3Bv1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 21:51:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43399 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbfI3Bv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 21:51:26 -0400
Received: by mail-qk1-f195.google.com with SMTP id h126so6394544qke.10
        for <git@vger.kernel.org>; Sun, 29 Sep 2019 18:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XjgY7U/fvsDJln7bP14c0fp0bf0y0uP4VAMF2X8hlH4=;
        b=J5bdIGRIoAdsHb4iIZBVofV8+gz9Pp89U1SUCfR1+6MEZrF/Ca6sYy9tnxQyomPYpV
         AlOYYFJJ+zmWTd3xyquUrIhJtYW/iPtYAadCScBhRmPEU1nK8lx5jlC30bPQqF20dluw
         sXSBDrM9VlUO0+k03zB/RPu04miZeaJk9GLhLdBPUcvUadH99Gy5S86kYxRw9n2TsvRX
         oc/tbM3PaBeSDoGg29JVaveBxh+8y+WTxeblKFJ4Wl3enT83mLULAKkvYOcgU54yoJgR
         dN11kqbPu/L0kq4bHjAtsE7y0GxhBnvU2HDVf4gM/9z9aQXBORki7PMC67Yu4h+Ilntu
         yZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XjgY7U/fvsDJln7bP14c0fp0bf0y0uP4VAMF2X8hlH4=;
        b=k25ThJfZT8e94FY3IlluDImyik3U/gJCn0eVakUY4VoqaJDY+kBA6NAXR5nuim16aE
         FfZqpLTq+tEIeVPPmvUFlwv/VNbTw2RCE2Ei7JBcOhXSfzz5EDszIkhTJcqakXT6h8ku
         K0hgSGF0LRJyT3/8IW1zY+FqCsgDX6nWCLgMOR1pjkXxcr45a+IglOSwbT275UZa4HAu
         CdmdbDqjLrRMZgdoqqgGLRbX99FxBsiR1Xov0m4y9uiAwLm2ITqmv7BqR6LWq6QgbML0
         eiAdz7W3G4QBIivtTjTtvBO8Q8NGbmYBbNGmR6NVt3yMOj9ow5tHO8XdP/5UyLqixv5f
         cAyQ==
X-Gm-Message-State: APjAAAWWB7GME6NImWrztgmWlRzpNDflMNLBpUiWdo4Avw5fhEv/2QQX
        WOrGduMaNvA3cP7WHMM05oX4WOXjfzI=
X-Google-Smtp-Source: APXvYqzIE6TafNEQyekya/UwhGp+csMJvh8myje4UFybMwt0txPuaI7iuLSKIfh9LuEKYMkfxz+ykg==
X-Received: by 2002:a37:bd5:: with SMTP id 204mr15002726qkl.330.1569808284813;
        Sun, 29 Sep 2019 18:51:24 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id f11sm4706954qkk.76.2019.09.29.18.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 18:51:24 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, olyatelezhnaya@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH v2 04/11] replace-object: make replace operations thread-safe
Date:   Sun, 29 Sep 2019 22:50:50 -0300
Message-Id: <5deee3cf11e6f67c696617a9264395fb1ab04f73.1569808052.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569808052.git.matheus.bernardino@usp.br>
References: <cover.1569808052.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

replace-object functions are very close to being thread-safe: the only
current racy section is the lazy initialization at
prepare_replace_object(). The following patches will protect some object
reading operations to be called threaded, but before that, replace
functions must be protected. To do so, add a mutex to struct
raw_object_store and acquire it before lazy initializing the
replace_map. This won't cause any noticeable performance drop as the
mutex will no longer be used after the replace_map is initialized.

Later, when the replace functions are called in parallel, thread
debuggers might point our use of the added replace_map_initialized flag
as a data race. However, as this boolean variable is initialized as
false and it's only updated once, there's no real harm. It's perfectly
fine if the value is updated right after a thread read it in
replace-map.h:lookup_replace_object() (there'll only be a performance
penalty for the affected threads at that moment). We could cease the
debugger warning protecting the variable reading at the said function.
However, this would negatively affect performance for all threads
calling it, at any time, so it's not really worthy since the warning
doesn't represent a real problem. Instead, to make sure we don't get
false positives (at ThreadSanitizer, at least) an entry for the
respective function is added to .tsan-suppressions.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 .tsan-suppressions |  6 ++++++
 object-store.h     |  2 ++
 object.c           |  2 ++
 replace-object.c   | 11 ++++++++++-
 replace-object.h   |  7 ++++++-
 5 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/.tsan-suppressions b/.tsan-suppressions
index 8c85014a0a..5ba86d6845 100644
--- a/.tsan-suppressions
+++ b/.tsan-suppressions
@@ -8,3 +8,9 @@
 # in practice it (hopefully!) doesn't matter.
 race:^want_color$
 race:^transfer_debug$
+
+# A boolean value, which tells whether the replace_map has been initialized or
+# not, is read racily with an update. As this variable is written to only once,
+# and it's OK if the value change right after reading it, this shouldn't be a
+# problem.
+race:^lookup_replace_object$
diff --git a/object-store.h b/object-store.h
index 7f7b3cdd80..b22e20ad7d 100644
--- a/object-store.h
+++ b/object-store.h
@@ -110,6 +110,8 @@ struct raw_object_store {
 	 * (see git-replace(1)).
 	 */
 	struct oidmap *replace_map;
+	unsigned replace_map_initialized : 1;
+	pthread_mutex_t replace_mutex; /* protect object replace functions */
 
 	struct commit_graph *commit_graph;
 	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
diff --git a/object.c b/object.c
index 07bdd5b26e..7ef5856f57 100644
--- a/object.c
+++ b/object.c
@@ -480,6 +480,7 @@ struct raw_object_store *raw_object_store_new(void)
 
 	memset(o, 0, sizeof(*o));
 	INIT_LIST_HEAD(&o->packed_git_mru);
+	pthread_mutex_init(&o->replace_mutex, NULL);
 	return o;
 }
 
@@ -507,6 +508,7 @@ void raw_object_store_clear(struct raw_object_store *o)
 
 	oidmap_free(o->replace_map, 1);
 	FREE_AND_NULL(o->replace_map);
+	pthread_mutex_destroy(&o->replace_mutex);
 
 	free_commit_graph(o->commit_graph);
 	o->commit_graph = NULL;
diff --git a/replace-object.c b/replace-object.c
index e295e87943..7bd9aba6ee 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -34,14 +34,23 @@ static int register_replace_ref(struct repository *r,
 
 void prepare_replace_object(struct repository *r)
 {
-	if (r->objects->replace_map)
+	if (r->objects->replace_map_initialized)
 		return;
 
+	pthread_mutex_lock(&r->objects->replace_mutex);
+	if (r->objects->replace_map_initialized) {
+		pthread_mutex_unlock(&r->objects->replace_mutex);
+		return;
+	}
+
 	r->objects->replace_map =
 		xmalloc(sizeof(*r->objects->replace_map));
 	oidmap_init(r->objects->replace_map, 0);
 
 	for_each_replace_ref(r, register_replace_ref, NULL);
+	r->objects->replace_map_initialized = 1;
+
+	pthread_mutex_unlock(&r->objects->replace_mutex);
 }
 
 /* We allow "recursive" replacement. Only within reason, though */
diff --git a/replace-object.h b/replace-object.h
index 04ed7a85a2..3fbc32eb7b 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -24,12 +24,17 @@ const struct object_id *do_lookup_replace_object(struct repository *r,
  * name (replaced recursively, if necessary).  The return value is
  * either sha1 or a pointer to a permanently-allocated value.  When
  * object replacement is suppressed, always return sha1.
+ *
+ * Note: some thread debuggers might point a data race on the
+ * replace_map_initialized reading in this function. However, we know there's no
+ * problem in the value being updated by one thread right after another one read
+ * it here (and it should be written to only once, anyway).
  */
 static inline const struct object_id *lookup_replace_object(struct repository *r,
 							    const struct object_id *oid)
 {
 	if (!read_replace_refs ||
-	    (r->objects->replace_map &&
+	    (r->objects->replace_map_initialized &&
 	     r->objects->replace_map->map.tablesize == 0))
 		return oid;
 	return do_lookup_replace_object(r, oid);
-- 
2.23.0

