From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 23/44] ruby: bind get_merge_bases()
Date: Sat, 28 Sep 2013 17:03:48 -0500
Message-ID: <1380405849-13000-24-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2jN-0003bT-Nc
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301Ab3I1WLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:11 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:58389 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279Ab3I1WLH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:07 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so3055251oag.14
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q9HNmavzWimNuHKVfvwxcMQgrGXJZLEKza9aX+kDB5M=;
        b=L5HATjVUemcJshh4fqJsGjsDMXglv0qiq1rpktR4A3QI7h57qxwOkJoq0jckelcJOD
         A5sVHrcPFm4dJqNeyQ1yS5ygJm/rJt8fYSughJhaBh1LCet8FCo1gDT9QlluLp3Ar92O
         urH4PJIzV+9p9WnIhAeHqCr1ESkWkuJHhQvp9nVxIfR3AHeIZOeHCMDWZdsZhEb5GcDe
         NoT/EDYIuVY5WKPcJcCBZ0EM40F6R0zh+9AAkyrk3R9sJyJNw41axJiql/980MKA2Y6O
         ZlWV1RHsgo/NfK3hT3eglZYzQVN40hEMnQtCdoZH/7RAQLN2sy2oGBiFh33qiCBCU3/+
         zH/g==
X-Received: by 10.60.63.116 with SMTP id f20mr12422280oes.29.1380406267172;
        Sat, 28 Sep 2013 15:11:07 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u8sm19508950obd.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235542>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    We could call it get_merge_bases_many(), but the fact that it's awkward to
    pass arrays in C is a limitation we don't have in Ruby. We can pass as many
    commits as we want easily.

 ruby.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/ruby.c b/ruby.c
index 53afa32..cc8fe0e 100644
--- a/ruby.c
+++ b/ruby.c
@@ -11,6 +11,7 @@
 
 static VALUE git_rb_object;
 static VALUE git_rb_commit;
+static VALUE git_rb_commit_list;
 
 static inline VALUE sha1_to_str(const unsigned char *sha1)
 {
@@ -152,6 +153,36 @@ static VALUE git_rb_commit_buffer(VALUE self)
 	return cstr_to_str(commit->buffer);
 }
 
+static VALUE git_rb_commit_list_each(VALUE self)
+{
+	struct commit_list *e, *list;
+	Data_Get_Struct(self, struct commit_list, list);
+
+	for (e = list; e; e = e->next) {
+		VALUE c;
+		c = Data_Wrap_Struct(git_rb_commit, NULL, NULL, e->item);
+		rb_yield(c);
+	}
+
+	return self;
+}
+
+static VALUE git_rb_get_merge_bases(VALUE self, VALUE commits, VALUE cleanup)
+{
+	struct commit *g_commits[RARRAY_LEN(commits)];
+	struct commit_list *result;
+	int i;
+
+	for (i = 0; i < RARRAY_LEN(commits); i++) {
+		VALUE commit = RARRAY_PTR(commits)[i];
+		Data_Get_Struct(commit, struct commit, g_commits[i]);
+	}
+	result = get_merge_bases_many(g_commits[0], RARRAY_LEN(commits) - 1, g_commits + 1, NUM2INT(cleanup));
+	if (!result)
+		return Qnil;
+	return Data_Wrap_Struct(git_rb_commit_list, NULL, NULL, result);
+}
+
 static void git_ruby_init(void)
 {
 	VALUE mod;
@@ -176,6 +207,7 @@ static void git_ruby_init(void)
 	rb_define_global_function("read_ref", git_rb_read_ref, 1);
 	rb_define_global_function("peel_ref", git_rb_peel_ref, 1);
 	rb_define_global_function("get_sha1", git_rb_get_sha1, 1);
+	rb_define_global_function("get_merge_bases", git_rb_get_merge_bases, 2);
 
 	git_rb_object = rb_define_class_under(mod, "Object", rb_cData);
 	rb_define_singleton_method(git_rb_object, "get", git_rb_object_get, 1);
@@ -186,6 +218,10 @@ static void git_ruby_init(void)
 	git_rb_commit = rb_define_class_under(mod, "Commit", git_rb_object);
 	rb_define_singleton_method(git_rb_commit, "get", git_rb_commit_get, 1);
 	rb_define_method(git_rb_commit, "buffer", git_rb_commit_buffer, 0);
+
+	git_rb_commit_list = rb_define_class_under(mod, "CommitList", rb_cData);
+	rb_include_module(git_rb_commit_list, rb_mEnumerable);
+	rb_define_method(git_rb_commit_list, "each", git_rb_commit_list_each, 0);
 }
 
 static int run_ruby_command(const char *cmd, int argc, const char **argv)
-- 
1.8.4-fc
