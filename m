From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 22/44] ruby: add Commit class
Date: Sat, 28 Sep 2013 17:03:47 -0500
Message-ID: <1380405849-13000-23-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2jJ-0003XH-C6
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab3I1WLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:09 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:38150 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174Ab3I1WLF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:05 -0400
Received: by mail-oa0-f46.google.com with SMTP id k14so3039226oag.33
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GiuusZwRZYe2ECUhJ5M2Zqp7zjeAdj4kx/qht9X0KTg=;
        b=ZXe9SmGFGm+jvx92io4HJIkwOgsaYMYY04yxgj6mJnIvSsbEf//VcaXQRlesJRcb4w
         8+EnKE9UwCmGAHgYWRUgb72O/NHSxZaarUTzwTPzyRQBTnYWxwHw5K3QzOZs8iVlJICf
         JuTpjbYynvZZB4hHR8bJyW4xsdCvwvgFqfh1WSGKffeAHVuSwVJsLrG57f1K28HIkA5i
         smBRKTIhfINGpuVYwrwwZCCXKR60oZ2pzTBi8782EIXhOF+dS7gk4ZM/ZyhdvlZFh7oY
         00Wjp7KfN5mOF1shCFVQAKCW4J/i3AcOfDsCxCtgJvbXwNZEZAgW9ZF2z44IMKGtMVKh
         49Ew==
X-Received: by 10.182.16.201 with SMTP id i9mr12411864obd.21.1380406264246;
        Sat, 28 Sep 2013 15:11:04 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm25445115oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235541>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    The Commit class inherits from the Object class, so commit.sha1() just works,
    even though it's an Object method.
    
    For now we don't define initializers or allocators, so Git::Commit.new() cannot
    really be used, but it's not needed at this point. These would be demonstrated
    later in the series.

 ruby.c           | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t10000-ruby.sh | 21 ++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/ruby.c b/ruby.c
index 45111e6..53afa32 100644
--- a/ruby.c
+++ b/ruby.c
@@ -1,12 +1,17 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "refs.h"
+#include "object.h"
+#include "commit.h"
 
 #undef NORETURN
 #undef PATH_SEP
 
 #include <ruby.h>
 
+static VALUE git_rb_object;
+static VALUE git_rb_commit;
+
 static inline VALUE sha1_to_str(const unsigned char *sha1)
 {
 	return rb_str_new((const char *)sha1, 20);
@@ -19,6 +24,18 @@ static inline VALUE cstr_to_str(const char *str)
 	return rb_str_new2(str);
 }
 
+static inline char *str_to_cstr(VALUE str)
+{
+	if (str == Qnil)
+		return NULL;
+	return RSTRING_PTR(str);
+}
+
+static inline unsigned char *str_to_sha1(VALUE str)
+{
+	return (unsigned char *)str_to_cstr(str);
+}
+
 static VALUE git_rb_setup_git_directory(VALUE self)
 {
 	int nongit_ok;
@@ -91,8 +108,67 @@ static VALUE git_rb_get_sha1(VALUE self, VALUE name)
 	return sha1_to_str(buf);
 }
 
+static VALUE git_rb_object_get(VALUE class, VALUE id)
+{
+	struct object *object;
+	object = parse_object(str_to_sha1(id));
+	return Data_Wrap_Struct(git_rb_object, NULL, NULL, object);
+}
+
+static VALUE git_rb_commit_get(VALUE class, VALUE id)
+{
+	struct object *object;
+	object = parse_object(str_to_sha1(id));
+	if (!object || object->type != OBJ_COMMIT)
+		return Qnil;
+	return Data_Wrap_Struct(git_rb_commit, NULL, NULL, object);
+}
+
+static VALUE git_rb_object_sha1(VALUE self)
+{
+	struct object *object;
+	Data_Get_Struct(self, struct object, object);
+	return sha1_to_str(object->sha1);
+}
+
+static VALUE git_rb_object_type(VALUE self)
+{
+	struct object *object;
+	Data_Get_Struct(self, struct object, object);
+	return INT2FIX(object->type);
+}
+
+static VALUE git_rb_object_to_s(VALUE self)
+{
+	struct object *object;
+	Data_Get_Struct(self, struct object, object);
+	return rb_str_new2(sha1_to_hex(object->sha1));
+}
+
+static VALUE git_rb_commit_buffer(VALUE self)
+{
+	struct commit *commit;
+	Data_Get_Struct(self, struct commit, commit);
+	return cstr_to_str(commit->buffer);
+}
+
 static void git_ruby_init(void)
 {
+	VALUE mod;
+
+	mod = rb_define_module("Git");
+
+	rb_define_global_const("OBJ_BAD", INT2FIX(OBJ_BAD));
+	rb_define_global_const("OBJ_NONE", INT2FIX(OBJ_NONE));
+	rb_define_global_const("OBJ_COMMIT", INT2FIX(OBJ_COMMIT));
+	rb_define_global_const("OBJ_TREE", INT2FIX(OBJ_TREE));
+	rb_define_global_const("OBJ_BLOB", INT2FIX(OBJ_BLOB));
+	rb_define_global_const("OBJ_TAG", INT2FIX(OBJ_TAG));
+	rb_define_global_const("OBJ_OFS_DELTA", INT2FIX(OBJ_OFS_DELTA));
+	rb_define_global_const("OBJ_REF_DELTA", INT2FIX(OBJ_REF_DELTA));
+	rb_define_global_const("OBJ_ANY", INT2FIX(OBJ_ANY));
+	rb_define_global_const("OBJ_MAX", INT2FIX(OBJ_MAX));
+
 	rb_define_global_function("setup_git_directory", git_rb_setup_git_directory, 0);
 	rb_define_global_function("for_each_ref", git_rb_for_each_ref, 0);
 	rb_define_global_function("dwim_ref", git_rb_dwim_ref, 1);
@@ -100,6 +176,16 @@ static void git_ruby_init(void)
 	rb_define_global_function("read_ref", git_rb_read_ref, 1);
 	rb_define_global_function("peel_ref", git_rb_peel_ref, 1);
 	rb_define_global_function("get_sha1", git_rb_get_sha1, 1);
+
+	git_rb_object = rb_define_class_under(mod, "Object", rb_cData);
+	rb_define_singleton_method(git_rb_object, "get", git_rb_object_get, 1);
+	rb_define_method(git_rb_object, "sha1", git_rb_object_sha1, 0);
+	rb_define_method(git_rb_object, "type", git_rb_object_type, 0);
+	rb_define_method(git_rb_object, "to_s", git_rb_object_to_s, 0);
+
+	git_rb_commit = rb_define_class_under(mod, "Commit", git_rb_object);
+	rb_define_singleton_method(git_rb_commit, "get", git_rb_commit_get, 1);
+	rb_define_method(git_rb_commit, "buffer", git_rb_commit_buffer, 0);
 }
 
 static int run_ruby_command(const char *cmd, int argc, const char **argv)
diff --git a/t/t10000-ruby.sh b/t/t10000-ruby.sh
index 849a615..e5a397c 100755
--- a/t/t10000-ruby.sh
+++ b/t/t10000-ruby.sh
@@ -81,4 +81,25 @@ test_expect_success 'test get_sha1()' '
 	test_cmp expected actual
 '
 
+test_expect_success 'test Object' '
+	git ruby > actual <<-EOF &&
+	object = Git::Object.get(get_sha1("HEAD"))
+	puts object, object.type == OBJ_COMMIT, sha1_to_hex(object.sha1)
+	EOF
+	git rev-parse -q --verify HEAD > expected &&
+	echo "true" >> expected &&
+	git rev-parse -q --verify HEAD >> expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'test Commit' '
+	git ruby > actual <<-EOF &&
+	commit = Git::Commit.get(get_sha1("HEAD"))
+	puts commit, commit.buffer
+	EOF
+	git rev-parse -q --verify HEAD > expected &&
+	git cat-file commit HEAD >> expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.4-fc
