From: Michael Witten <mfwitten@gmail.com>
Subject: [RFC 1/2] Portability: Convert strictly between function pointers
Date: Tue, 29 Mar 2011 15:02:30 +0000
Message-ID: <3c6b883f-8860-4da2-b328-d912019a4145-mfwitten@gmail.com>
References: <522d5a8a-a674-40bd-91bf-b5b8f88e0f78-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 21:06:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4eFV-0000aV-Ma
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 21:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931Ab1C2TGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 15:06:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33137 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962Ab1C2TGf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 15:06:35 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so420839wya.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 12:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:message-id:references;
        bh=mQPojmi6+Mqf2lz1nmTv7DON+lxOk8fhadm+OT8hwiw=;
        b=i5uMmhuHH1mhEf0i6+Km2F+vAgniGG+EqVs5mVbLHzY1BjQx5jlKs/V2NCYOBwV13o
         HJ1ChCQRsD26E/cI5N9m9vP6Qt6jpMWr1wuAGTqoaznQ1YAMU/72zKbQDP5VtbmB4pIU
         czKPxvqECoD51iCGwfQ3CjrhM91nA6QXgEveg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:message-id:references;
        b=Z0gpX+5Ls3wtM3Hb58yzwN1WtDhZva8HQtgxoDmbU51xUSs7zaIwZtmCIY4NfgX5uQ
         YLWuGvh/Z7Hlug3hu+Yv4q6dABaHOUhgk9xcamnpwguSQdN6j1DQj8gCfvClOVwuC9vp
         7508t6njAB46uKIby7pU4Hdvy4FfcJHTAXOSU=
Received: by 10.216.144.166 with SMTP id n38mr96961wej.75.1301425533936;
        Tue, 29 Mar 2011 12:05:33 -0700 (PDT)
Received: from gmail.com ([109.123.119.163])
        by mx.google.com with ESMTPS id z50sm2116491weq.47.2011.03.29.12.05.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 12:05:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170311>

Currently, building git with:

  CFLAGS="-std=c99 -pedantic -Wall -Werror -g -02"

causes gcc 4.5.2 to fail with:

  ISO C forbids initialization between function pointer and 'void *'

The C99 standard isn't very explicit about this fact, but the
following paragraphs seem relevant:

  6.3.2.3.1:
  A pointer to void may be converted to or from a pointer to
  any incomplete or object type. A pointer to any incomplete
  or object type may be converted to a pointer to void and
  back again; the result shall compare equal to the original
  pointer.

  6.3.2.3.8:
  A pointer to a function of one type may be converted to a
  pointer to a function of another type and back again; the
  result shall compare equal to the original pointer. If a
  converted pointer is used to call a function whose type is
  not compatible with the pointed-to type, the behavior is
  undefined.

  6.5.4.3:
  Conversions that involve pointers, other than where
  permitted by the constraints of 6.5.16.1, shall be
  specified by means of an explicit cast.

Also, this website:

  http://www.safercode.com/blog/2008/11/25/generic-function-pointers-in-c-and-void.html

provides some inspiring comments:

  Why can't we use void* for a Generic Function Pointer?
  ------------------------------------------------------

  This is because a void* is a pointer to a generic
  "data" type. A void * is used to denote pointers to
  objects and in some systems, pointers to functions can
  be larger than pointers to objects. So, if you convert
  amongst them, you'll lose information and hence, the
  situation would be undefined and implementation dependent.
  ...

However, that seems like a hypothetical justification for the
implicitly undefined behavior of using a variable of type
pointer to void to carry around a value of type
pointer to function.

In any case, the solution is clear: Rather than converting
to and from a pointer to void, one can instead convert to
and from a pointer to any other function type, say:

  void (*)(void)

Is this silly? Probably, but at least it's standards conforming.

Unfortunately (or fortunately?), this requires more
explicit casting, as per 6.5.4.3.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 builtin/fetch-pack.c   |    2 +-
 builtin/receive-pack.c |    2 +-
 cache.h                |    5 +++--
 sha1_file.c            |    2 +-
 transport.c            |    4 ++--
 transport.h            |    4 ++--
 6 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 1724b76..ded1784 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -225,7 +225,7 @@ static void insert_one_alternate_ref(const struct ref *ref, void *unused)
 
 static void insert_alternate_refs(void)
 {
-	foreach_alt_odb(refs_from_alternate_cb, insert_one_alternate_ref);
+	foreach_alt_odb(refs_from_alternate_cb, (alt_odb_fn_cb)insert_one_alternate_ref);
 }
 
 #define INITIAL_FLUSH 16
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 27050e7..4ce9241 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -738,7 +738,7 @@ static void add_one_alternate_ref(const struct ref *ref, void *unused)
 
 static void add_alternate_refs(void)
 {
-	foreach_alt_odb(refs_from_alternate_cb, add_one_alternate_ref);
+	foreach_alt_odb(refs_from_alternate_cb, (alt_odb_fn_cb)add_one_alternate_ref);
 }
 
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
diff --git a/cache.h b/cache.h
index 9f06d21..ab3407a 100644
--- a/cache.h
+++ b/cache.h
@@ -892,8 +892,9 @@ extern struct alternate_object_database {
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
 extern void add_to_alternates_file(const char *reference);
+typedef void (*alt_odb_fn_cb)(void);
-typedef int alt_odb_fn(struct alternate_object_database *, void *);
+typedef int (*alt_odb_fn)(struct alternate_object_database *, alt_odb_fn_cb);
-extern void foreach_alt_odb(alt_odb_fn, void*);
+extern void foreach_alt_odb(alt_odb_fn, alt_odb_fn_cb);
 
 struct pack_window {
 	struct pack_window *next;
diff --git a/sha1_file.c b/sha1_file.c
index df0edba..8555dbe 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -388,7 +388,7 @@ void add_to_alternates_file(const char *reference)
 		link_alt_odb_entries(alt, alt + strlen(alt), '\n', NULL, 0);
 }
 
-void foreach_alt_odb(alt_odb_fn fn, void *cb)
+void foreach_alt_odb(alt_odb_fn fn, alt_odb_fn_cb cb)
 {
 	struct alternate_object_database *ent;
 
diff --git a/transport.c b/transport.c
index a02f79a..f572fa8 100644
--- a/transport.c
+++ b/transport.c
@@ -1190,14 +1190,14 @@ literal_copy:
 	return xstrdup(url);
 }
 
-int refs_from_alternate_cb(struct alternate_object_database *e, void *cb)
+int refs_from_alternate_cb(struct alternate_object_database *e, alt_odb_fn_cb cb)
 {
 	char *other;
 	size_t len;
 	struct remote *remote;
 	struct transport *transport;
 	const struct ref *extra;
-	alternate_ref_fn *ref_fn = cb;
+	alternate_ref_fn ref_fn = (alternate_ref_fn)cb;
 
 	e->name[-1] = '\0';
 	other = xstrdup(real_path(e->base));
diff --git a/transport.h b/transport.h
index efb1968..47ea41a 100644
--- a/transport.h
+++ b/transport.h
@@ -166,7 +166,7 @@ int transport_refs_pushed(struct ref *ref);
 void transport_print_push_status(const char *dest, struct ref *refs,
 		  int verbose, int porcelain, int *nonfastforward);
 
-typedef void alternate_ref_fn(const struct ref *, void *);
+typedef void (*alternate_ref_fn)(const struct ref *, void *);
-extern int refs_from_alternate_cb(struct alternate_object_database *e, void *cb);
+extern int refs_from_alternate_cb(struct alternate_object_database *e, alt_odb_fn_cb cb);
 
 #endif
-- 
1.7.4.2.417.g32d76d
