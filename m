From: Michael Witten <mfwitten@gmail.com>
Subject: [RFC 2/3] Alternates API: Improve naming
Date: Wed, 30 Mar 2011 21:24:24 +0000
Message-ID: <a0e5204fe8c03b3b6af2150198bad51f86b126c4.1301521243.git.mfwitten@gmail.com>
References: <cover.1301521243.git.mfwitten@gmail.com>
            <5ed7886ec5e12c8e3a5f45d19625a4f5d2cdd38a.1301521243.git.mfwitten@gmail.com>
            <3c357acd119aa836f6cd3298d62cc5098f4c053c.1301521244.git.mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 00:21:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q53lB-00081b-SO
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 00:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933237Ab1C3WUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 18:20:48 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42540 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933094Ab1C3WUh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 18:20:37 -0400
Received: by iyb14 with SMTP id 14so1705463iyb.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 15:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:message-id:in-reply-to
         :references;
        bh=1FXpEDs+Vz1HG3w+CMWRP1+vHfir+9JCw5wf7WUrrVc=;
        b=la4hCdtaS7nMCGq8w41cpR3aOChmSChy3wW8/3Ip+ThH8SIs/yTYFUa5Rza7H5I505
         HKZbBzJgSq4gudFJr/GOvpHxj4afaeRVdlXao4aFMyhzN0AC5kuoqe/epJ+FBGbLoA4b
         z8dY5NC6jdc1pL+D0eiumMbScYD4f8ry9wXbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:message-id:in-reply-to:references;
        b=XL+7rg2XU8HFN3qX4JA8Zdde2pwNzeUXWaIZRMSxzIkuIKAbNoQDL4aJY3r7HNCeXW
         cFMhfN5l7NI/6DEezIDva26uNciQJGmVlP7/PIp28TmL/CW2eWrVjYNUvhG9plI6QFgB
         dzGkYDz3F25V/lbNHpJosSirc586yPHGBU6sQ=
Received: by 10.231.142.32 with SMTP id o32mr1794091ibu.143.1301523636732;
        Wed, 30 Mar 2011 15:20:36 -0700 (PDT)
Received: from gmail.com (raskin.torservers.net [74.120.15.150])
        by mx.google.com with ESMTPS id g16sm289646ibb.37.2011.03.30.15.20.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 15:20:36 -0700 (PDT)
In-Reply-To: <cover.1301521243.git.mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170429>

This should make the API a bit more cohesive.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 builtin/fetch-pack.c   |    2 +-
 builtin/receive-pack.c |    2 +-
 sha1_file.c            |    6 +++---
 transport.c            |    8 ++++----
 transport.h            |    4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/transport.h b/transport.h
index 72a692f..88fa484 100644
--- a/transport.h
+++ b/transport.h
@@ -166,7 +166,7 @@ int transport_refs_pushed(struct ref *ref);
 void transport_print_push_status(const char *dest, struct ref *refs,
 		  int verbose, int porcelain, int *nonfastforward);
 
-typedef void (*alternate_ref_fn)(const struct ref *, void *);
+typedef void (*transport_alt_refs_fn)(const struct ref *, void *);
-extern int refs_from_alternate_cb(struct alternate_object_database *, alternate_ref_fn);
+extern int transport_alt_refs(struct alternate_object_database *, transport_alt_refs_fn);
 
 #endif
diff --git a/transport.c b/transport.c
index c61723f..53d37a9 100644
--- a/transport.c
+++ b/transport.c
@@ -1190,7 +1190,7 @@ literal_copy:
 	return xstrdup(url);
 }
 
-int refs_from_alternate_cb(struct alternate_object_database *e, alternate_ref_fn ref_fn)
+int transport_alt_refs(struct alternate_object_database *d, transport_alt_refs_fn ref_fn)
 {
 	char *other;
 	size_t len;
@@ -1198,9 +1198,9 @@ int refs_from_alternate_cb(struct alternate_object_database *e, alternate_ref_fn
 	struct transport *transport;
 	const struct ref *extra;
 
-	e->name[-1] = '\0';
+	d->name[-1] = '\0';
-	other = xstrdup(real_path(e->base));
+	other = xstrdup(real_path(d->base));
-	e->name[-1] = '/';
+	d->name[-1] = '/';
 	len = strlen(other);
 
 	while (other[len-1] == '/')
diff --git a/sha1_file.c b/sha1_file.c
index e55a496..a6c1f1f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -390,11 +390,11 @@ void add_to_alternates_file(const char *reference)
 
 void foreach_alt_odb(alt_odb_fn fn)
 {
-	struct alternate_object_database *ent;
+	struct alternate_object_database *d;
 
 	prepare_alt_odb();
-	for (ent = alt_odb_list; ent; ent = ent->next)
+	for (d = alt_odb_list; d; d = d->next)
-		if (fn(ent))
+		if (fn(d))
 			return;
 }
 
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 62ebdb4..b3a9f74 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -226,7 +226,7 @@ static void insert_one_alternate_ref(const struct ref *ref, void *unused)
 
 static int alt_odb_callback(struct alternate_object_database *d)
 {
-	return refs_from_alternate_cb(d,insert_one_alternate_ref);
+	return transport_alt_refs(d,insert_one_alternate_ref);
 }
 
 static void insert_alternate_refs(void)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 8ef6301..a761332 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -738,7 +738,7 @@ static void add_one_alternate_ref(const struct ref *ref, void *unused)
 
 static int alt_odb_callback(struct alternate_object_database *d)
 {
-	return refs_from_alternate_cb(d,add_one_alternate_ref);
+	return transport_alt_refs(d,add_one_alternate_ref);
 }
 
 static void add_alternate_refs(void)
-- 
1.7.4.18.g68fe8
