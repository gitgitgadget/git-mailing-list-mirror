From: Michael Witten <mfwitten@gmail.com>
Subject: [RFC 1/3] Alternates API: Untangle the interface
Date: Wed, 30 Mar 2011 20:43:18 +0000
Message-ID: <5ed7886ec5e12c8e3a5f45d19625a4f5d2cdd38a.1301521243.git.mfwitten@gmail.com>
References: <7vlizwmm4o.fsf@alter.siamese.dyndns.org>
            <3c6b883f-8860-4da2-b328-d912019a4145-mfwitten@gmail.com>
            <522d5a8a-a674-40bd-91bf-b5b8f88e0f78-mfwitten@gmail.com>
            <cover.1301521243.git.mfwitten@gmail.com>
            <a0e5204fe8c03b3b6af2150198bad51f86b126c4.1301521243.git.mfwitten@gmail.com>
            <3c357acd119aa836f6cd3298d62cc5098f4c053c.1301521244.git.mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 00:20:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q53kZ-0007je-8s
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 00:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933088Ab1C3WUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 18:20:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60904 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933018Ab1C3WUR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 18:20:17 -0400
Received: by iwn34 with SMTP id 34so1724586iwn.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 15:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:message-id:in-reply-to
         :references;
        bh=KvFvADKHhZVUJ7TFF6ubk2Mbks2e6B5hkFb/q/3g66A=;
        b=KTTUR5F4ZxQbS+tFDYwx6jviCn4M/GRuHcOyN96PYltD8dRfJcSektvSeCkHbHqHLy
         XiPB7g3HU3pQ/PKbv+do7ONIK/LcvRD7/vHwOd1jCPRvPwv7GAdX65jN84a7lSTPG0L7
         wVuu6m+RI0ZJEkc/DC3jXR7W4x71UDDypj7uM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:message-id:in-reply-to:references;
        b=LXWpiGvsB3+iBNrM0enLwkbPe6t/GHxjDuj0mPhlDLnJywkNHWppqnQ5eEPuahvS3q
         zefhZjsJqwtJaPiDpoie08qe55FORsZc9K0TPaG9iacwaHRrdYT8dUWbXhe6H/HAxqbo
         J9g/VK28pAHLGOwMPRn7s7kUa0fkeHHyUbDLQ=
Received: by 10.42.134.2 with SMTP id j2mr1705717ict.191.1301523616827;
        Wed, 30 Mar 2011 15:20:16 -0700 (PDT)
Received: from gmail.com (raskin.torservers.net [74.120.15.150])
        by mx.google.com with ESMTPS id 8sm294223iba.4.2011.03.30.15.20.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 15:20:16 -0700 (PDT)
In-Reply-To: <cover.1301521243.git.mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170428>

These 2 functions:

      cache.h:896:    foreach_alt_odb
  transport.h:170:    refs_from_alternate_cb

were unnecessarily coupled; the callback used by:

  refs_from_alternate_cb

was being passed to the higher-level:

  foreach_alt_odb

which necessitated some casting ugliness that has
actually been invoking undefined behavior[0].

This commit decouples this relationship, resulting
in a simpler (albeit slightly more verbose) usage.
As a bonus, the undefined behavior is automatically
resolved.

References
----------

[0] Variables of type pointer to void were being used
to pass around values of type pointer to function; see:

  [RFC 1/2] Portability: Convert strictly between function pointers
  Message-ID: <3c6b883f-8860-4da2-b328-d912019a4145-mfwitten@gmail.com>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 builtin/fetch-pack.c   |    7 ++++++-
 builtin/receive-pack.c |    7 ++++++-
 cache.h                |    4 ++--
 sha1_file.c            |    4 ++--
 transport.c            |    3 +--
 transport.h            |    4 ++--
 6 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index 9f06d21..71cfcef 100644
--- a/cache.h
+++ b/cache.h
@@ -892,8 +892,8 @@ extern struct alternate_object_database {
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
 extern void add_to_alternates_file(const char *reference);
-typedef int alt_odb_fn(struct alternate_object_database *, void *);
+typedef int (*alt_odb_fn)(struct alternate_object_database *);
-extern void foreach_alt_odb(alt_odb_fn, void*);
+extern void foreach_alt_odb(alt_odb_fn);
 
 struct pack_window {
 	struct pack_window *next;
diff --git a/sha1_file.c b/sha1_file.c
index df0edba..e55a496 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -388,13 +388,13 @@ void add_to_alternates_file(const char *reference)
 		link_alt_odb_entries(alt, alt + strlen(alt), '\n', NULL, 0);
 }
 
-void foreach_alt_odb(alt_odb_fn fn, void *cb)
+void foreach_alt_odb(alt_odb_fn fn)
 {
 	struct alternate_object_database *ent;
 
 	prepare_alt_odb();
 	for (ent = alt_odb_list; ent; ent = ent->next)
-		if (fn(ent, cb))
+		if (fn(ent))
 			return;
 }
 
diff --git a/transport.h b/transport.h
index efb1968..72a692f 100644
--- a/transport.h
+++ b/transport.h
@@ -166,7 +166,7 @@ int transport_refs_pushed(struct ref *ref);
 void transport_print_push_status(const char *dest, struct ref *refs,
 		  int verbose, int porcelain, int *nonfastforward);
 
-typedef void alternate_ref_fn(const struct ref *, void *);
+typedef void (*alternate_ref_fn)(const struct ref *, void *);
-extern int refs_from_alternate_cb(struct alternate_object_database *e, void *cb);
+extern int refs_from_alternate_cb(struct alternate_object_database *, alternate_ref_fn);
 
 #endif
diff --git a/transport.c b/transport.c
index a02f79a..c61723f 100644
--- a/transport.c
+++ b/transport.c
@@ -1190,14 +1190,13 @@ literal_copy:
 	return xstrdup(url);
 }
 
-int refs_from_alternate_cb(struct alternate_object_database *e, void *cb)
+int refs_from_alternate_cb(struct alternate_object_database *e, alternate_ref_fn ref_fn)
 {
 	char *other;
 	size_t len;
 	struct remote *remote;
 	struct transport *transport;
 	const struct ref *extra;
-	alternate_ref_fn *ref_fn = cb;
 
 	e->name[-1] = '\0';
 	other = xstrdup(real_path(e->base));
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 85aff02..62ebdb4 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -224,9 +224,14 @@ static void insert_one_alternate_ref(const struct ref *ref, void *unused)
 	rev_list_insert_ref(NULL, ref->old_sha1, 0, NULL);
 }
 
+static int alt_odb_callback(struct alternate_object_database *d)
+{
+	return refs_from_alternate_cb(d,insert_one_alternate_ref);
+}
+
 static void insert_alternate_refs(void)
 {
-	foreach_alt_odb(refs_from_alternate_cb, insert_one_alternate_ref);
+	foreach_alt_odb(alt_odb_callback);
 }
 
 #define INITIAL_FLUSH 16
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 27050e7..8ef6301 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -736,9 +736,14 @@ static void add_one_alternate_ref(const struct ref *ref, void *unused)
 	add_extra_ref(".have", ref->old_sha1, 0);
 }
 
+static int alt_odb_callback(struct alternate_object_database *d)
+{
+	return refs_from_alternate_cb(d,add_one_alternate_ref);
+}
+
 static void add_alternate_refs(void)
 {
-	foreach_alt_odb(refs_from_alternate_cb, add_one_alternate_ref);
+	foreach_alt_odb(alt_odb_callback);
 }
 
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
-- 
1.7.4.18.g68fe8
