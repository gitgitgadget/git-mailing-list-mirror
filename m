From: Michael Witten <mfwitten@gmail.com>
Subject: [RFC 2/2] Future Proofing: Pass around pointers to either functions or data
Date: Tue, 29 Mar 2011 15:28:30 +0000
Message-ID: <522d5a8a-a674-40bd-91bf-b5b8f88e0f78-mfwitten@gmail.com>
References: <3c6b883f-8860-4da2-b328-d912019a4145-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 21:06:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4eFL-0000Wz-2g
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 21:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab1C2TG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 15:06:26 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33137 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab1C2TGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 15:06:25 -0400
Received: by wya21 with SMTP id 21so420839wya.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:message-id:references;
        bh=1an73mVNGdapVS9O8/HYTn8N/wKFJDQilJgTlSuNzqg=;
        b=ma8CaMKNCSFxIjeEeWXRfOyRkC6753cxn3tPkxVblJyY0H6ZF7tyqXd/jVMdl/mr++
         df3aAPE2BJkB6xuhutTT3i5dxyd4y95rPYrurn+DP4Rck3jE1GdWsHO247zaib42CNMe
         BRZTW9yxwvg3YkuVgWhOBJdAKI0rjHTKG2S38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:message-id:references;
        b=xBaV89pd0Mf/kBTYo74NRTRqpXb6ir5Qqz8aqgY5TmnAxCiW86PiJq0pE5IDAhm0Px
         2LG1rMI6lx5wya6MkZPrRl4dlVDfi+qNvtiOn8VaH0jkBQmTTnk1H77uZpGZt1yKjtG1
         Sa4ogwCSV7/DMzqlopLLUaubgpAGdbL9fyR+A=
Received: by 10.216.254.82 with SMTP id g60mr2206769wes.36.1301425583946;
        Tue, 29 Mar 2011 12:06:23 -0700 (PDT)
Received: from gmail.com ([109.123.119.163])
        by mx.google.com with ESMTPS id x1sm2587870wbh.53.2011.03.29.12.06.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 12:06:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170310>

The seemingly unnecessary generality of the alternate object
database callback infrastructure suggests that there are plans
for passing around not only callbacks to callbacks, but also
arbitrary data to callbacks. Unfortunately, as discussed in the
previous commit's message, C[99] does not allow for values of type
pointer to function to be stored in variables of type pointer to
void.

The only unified solution, then, is to pass around a value of
type union of both pointer to function and pointer to void; this
solution is voiced here as well:

  http://www.safercode.com/blog/2008/11/25/generic-function-pointers-in-c-and-void.html

That article states:

  How can I use the same variable for object / data
  -------------------------------------------------
  and function pointers inter-changeably?
  ---------------------------------------

  Simple, use a union of a void * and the function pointer
  (like we described above) and you need not worry about
  the size because the compiler will automatically choose
  the largest size for this union which can hold a function
  pointer.

This commit introduces such a union and a couple of macros
for using it effectively.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 builtin/fetch-pack.c   |    3 ++-
 builtin/receive-pack.c |    3 ++-
 cache.h                |   16 ++++++++++++++--
 sha1_file.c            |    4 ++--
 transport.c            |    4 ++--
 transport.h            |    2 +-
 6 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index ded1784..737b382 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -225,7 +225,8 @@ static void insert_one_alternate_ref(const struct ref *ref, void *unused)
 
 static void insert_alternate_refs(void)
 {
+	ALT_ODB_FN_INFO_FUNC(info,insert_one_alternate_ref);
-	foreach_alt_odb(refs_from_alternate_cb, (alt_odb_fn_cb)insert_one_alternate_ref);
+	foreach_alt_odb(refs_from_alternate_cb, info);
 }
 
 #define INITIAL_FLUSH 16
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4ce9241..51e66d2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -738,7 +738,8 @@ static void add_one_alternate_ref(const struct ref *ref, void *unused)
 
 static void add_alternate_refs(void)
 {
+	ALT_ODB_FN_INFO_FUNC(info,add_one_alternate_ref);
-	foreach_alt_odb(refs_from_alternate_cb, (alt_odb_fn_cb)add_one_alternate_ref);
+	foreach_alt_odb(refs_from_alternate_cb, info);
 }
 
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
diff --git a/cache.h b/cache.h
index ab3407a..ca8574a 100644
--- a/cache.h
+++ b/cache.h
@@ -893,8 +893,20 @@ extern struct alternate_object_database {
 extern void prepare_alt_odb(void);
 extern void add_to_alternates_file(const char *reference);
 typedef void (*alt_odb_fn_cb)(void);
+union alt_odb_fn_info {
+	alt_odb_fn_cb func;
+	void *data;
+};
+#define ALT_ODB_FN_INFO_FUNC(variable, function) \
+	union alt_odb_fn_info variable = { \
+		.func = (alt_odb_fn_cb)function \
+	}
+#define ALT_ODB_FN_INFO_DATA(variable, data_) \
+	union alt_odb_fn_info variable = { \
+		.data = data_ \
+	}
-typedef int (*alt_odb_fn)(struct alternate_object_database *, alt_odb_fn_cb);
+typedef int (*alt_odb_fn)(struct alternate_object_database *, union alt_odb_fn_info);
-extern void foreach_alt_odb(alt_odb_fn, alt_odb_fn_cb);
+extern void foreach_alt_odb(alt_odb_fn, union alt_odb_fn_info);
 
 struct pack_window {
 	struct pack_window *next;
diff --git a/sha1_file.c b/sha1_file.c
index 8555dbe..2709fea 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -388,13 +388,13 @@ void add_to_alternates_file(const char *reference)
 		link_alt_odb_entries(alt, alt + strlen(alt), '\n', NULL, 0);
 }
 
-void foreach_alt_odb(alt_odb_fn fn, alt_odb_fn_cb cb)
+void foreach_alt_odb(alt_odb_fn fn, union alt_odb_fn_info info)
 {
 	struct alternate_object_database *ent;
 
 	prepare_alt_odb();
 	for (ent = alt_odb_list; ent; ent = ent->next)
-		if (fn(ent, cb))
+		if (fn(ent, info))
 			return;
 }
 
diff --git a/transport.c b/transport.c
index f572fa8..3b44b27 100644
--- a/transport.c
+++ b/transport.c
@@ -1190,14 +1190,14 @@ literal_copy:
 	return xstrdup(url);
 }
 
-int refs_from_alternate_cb(struct alternate_object_database *e, alt_odb_fn_cb cb)
+int refs_from_alternate_cb(struct alternate_object_database *e, union alt_odb_fn_info info)
 {
 	char *other;
 	size_t len;
 	struct remote *remote;
 	struct transport *transport;
 	const struct ref *extra;
-	alternate_ref_fn ref_fn = (alternate_ref_fn)cb;
+	alternate_ref_fn ref_fn = (alternate_ref_fn)info.func;
 
 	e->name[-1] = '\0';
 	other = xstrdup(real_path(e->base));
diff --git a/transport.h b/transport.h
index 47ea41a..d00e547 100644
--- a/transport.h
+++ b/transport.h
@@ -167,6 +167,6 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 		  int verbose, int porcelain, int *nonfastforward);
 
 typedef void (*alternate_ref_fn)(const struct ref *, void *);
-extern int refs_from_alternate_cb(struct alternate_object_database *e, alt_odb_fn_cb cb);
+extern int refs_from_alternate_cb(struct alternate_object_database *e, union alt_odb_fn_info info);
 
 #endif
-- 
1.7.4.2.417.g32d76d
