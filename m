From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 26/44] ruby: bind remote and transport stuff
Date: Sat, 28 Sep 2013 17:03:51 -0500
Message-ID: <1380405849-13000-27-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2jX-0003iY-44
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324Ab3I1WLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:22 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:60503 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099Ab3I1WLP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:15 -0400
Received: by mail-oa0-f49.google.com with SMTP id i4so2956947oah.8
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rrb/HHFmSSySiXi9AjNaRyZWgbeUm1gx6HZsZOI6+nQ=;
        b=JHxgHr7JylyfGGv00Uqb68c7M8Dlcr/g4Yz5queiNX3g6M+ZbnbY2iuawFm2kTdclR
         KvGEGS1AAWkH5IAKYJOFkgnFNo6Y2+zAe4eHNIgD+uQ3bBQAK0MqPCA8loh3Vy0BOu11
         qGi8BfgQleSl0r6mzCo+AAd6E6Mcdg+CWhe3qrIEnGRYlgYb7c/AP8NqhBYevCMwrZXf
         6TMvI3Ii/+1f6aP7Taczuuo7bvXI9HxJwHxj4KSg/ApdjmD9OGrW2eB4rBP8cqBbLwyj
         m2Y6R/YQJ1ULG356BhuICUAdmLhFJt/q9i4mRwQS0ADmIHp5uzBZOeYxv2GhVPaxaHGJ
         fmwg==
X-Received: by 10.182.237.44 with SMTP id uz12mr12523632obc.11.1380406275117;
        Sat, 28 Sep 2013 15:11:15 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ru3sm19539648obc.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235546>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    Only the few fields that will be needed later on.

 ruby.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/ruby.c b/ruby.c
index cc8fe0e..ee548dc 100644
--- a/ruby.c
+++ b/ruby.c
@@ -3,6 +3,8 @@
 #include "refs.h"
 #include "object.h"
 #include "commit.h"
+#include "remote.h"
+#include "transport.h"
 
 #undef NORETURN
 #undef PATH_SEP
@@ -12,6 +14,9 @@
 static VALUE git_rb_object;
 static VALUE git_rb_commit;
 static VALUE git_rb_commit_list;
+static VALUE git_rb_remote;
+static VALUE git_rb_transport;
+static VALUE git_rb_ref;
 
 static inline VALUE sha1_to_str(const unsigned char *sha1)
 {
@@ -183,6 +188,76 @@ static VALUE git_rb_get_merge_bases(VALUE self, VALUE commits, VALUE cleanup)
 	return Data_Wrap_Struct(git_rb_commit_list, NULL, NULL, result);
 }
 
+static VALUE git_rb_remote_get(VALUE self, VALUE name)
+{
+	struct remote *remote;
+	remote = remote_get(RSTRING_PTR(name));
+	if (!remote)
+		return Qnil;
+	return Data_Wrap_Struct(git_rb_remote, NULL, NULL, remote);
+}
+
+static VALUE git_rb_remote_url(VALUE self)
+{
+	struct remote *remote;
+	VALUE url;
+	int i;
+
+	Data_Get_Struct(self, struct remote, remote);
+	url = rb_ary_new2(remote->url_nr);
+	for (i = 0; i < remote->url_nr; i++)
+		rb_ary_store(url, i, rb_str_new2(remote->url[i]));
+	return url;
+}
+
+static VALUE git_rb_transport_get(VALUE self, VALUE remote, VALUE url)
+{
+	struct transport *transport;
+	struct remote *g_remote;
+	Data_Get_Struct(remote, struct remote, g_remote);
+	transport = transport_get(g_remote, str_to_cstr(url));
+	if (!transport)
+		return Qnil;
+	return Data_Wrap_Struct(git_rb_transport, NULL, transport_disconnect, transport);
+}
+
+static VALUE git_rb_transport_get_remote_refs(VALUE self)
+{
+	struct transport *transport;
+	const struct ref *ref;
+	Data_Get_Struct(self, struct transport, transport);
+	ref = transport_get_remote_refs(transport);
+	return Data_Wrap_Struct(git_rb_ref, NULL, NULL, (void *)ref);
+}
+
+static VALUE git_rb_ref_each(VALUE self)
+{
+	struct ref *e, *ref;
+	Data_Get_Struct(self, struct ref, ref);
+
+	for (e = ref; e; e = e->next) {
+		VALUE c;
+		c = Data_Wrap_Struct(git_rb_ref, NULL, NULL, e);
+		rb_yield(c);
+	}
+
+	return self;
+}
+
+static VALUE git_rb_ref_name(VALUE self)
+{
+	struct ref *ref;
+	Data_Get_Struct(self, struct ref, ref);
+	return rb_str_new2(ref->name);
+}
+
+static VALUE git_rb_ref_old_sha1(VALUE self)
+{
+	struct ref *ref;
+	Data_Get_Struct(self, struct ref, ref);
+	return sha1_to_str(ref->old_sha1);
+}
+
 static void git_ruby_init(void)
 {
 	VALUE mod;
@@ -208,6 +283,8 @@ static void git_ruby_init(void)
 	rb_define_global_function("peel_ref", git_rb_peel_ref, 1);
 	rb_define_global_function("get_sha1", git_rb_get_sha1, 1);
 	rb_define_global_function("get_merge_bases", git_rb_get_merge_bases, 2);
+	rb_define_global_function("remote_get", git_rb_remote_get, 1);
+	rb_define_global_function("transport_get", git_rb_transport_get, 2);
 
 	git_rb_object = rb_define_class_under(mod, "Object", rb_cData);
 	rb_define_singleton_method(git_rb_object, "get", git_rb_object_get, 1);
@@ -222,6 +299,18 @@ static void git_ruby_init(void)
 	git_rb_commit_list = rb_define_class_under(mod, "CommitList", rb_cData);
 	rb_include_module(git_rb_commit_list, rb_mEnumerable);
 	rb_define_method(git_rb_commit_list, "each", git_rb_commit_list_each, 0);
+
+	git_rb_remote = rb_define_class_under(mod, "Remote", rb_cData);
+	rb_define_method(git_rb_remote, "url", git_rb_remote_url, 0);
+
+	git_rb_transport = rb_define_class_under(mod, "Transport", rb_cData);
+	rb_define_method(git_rb_transport, "get_remote_refs", git_rb_transport_get_remote_refs, 0);
+
+	git_rb_ref = rb_define_class_under(mod, "Ref", rb_cData);
+	rb_include_module(git_rb_ref, rb_mEnumerable);
+	rb_define_method(git_rb_ref, "each", git_rb_ref_each, 0);
+	rb_define_method(git_rb_ref, "name", git_rb_ref_name, 0);
+	rb_define_method(git_rb_ref, "old_sha1", git_rb_ref_old_sha1, 0);
 }
 
 static int run_ruby_command(const char *cmd, int argc, const char **argv)
-- 
1.8.4-fc
