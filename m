From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 35/44] ruby: add RevInfo and DiffOptions
Date: Sat, 28 Sep 2013 17:04:00 -0500
Message-ID: <1380405849-13000-36-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2jw-000423-46
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370Ab3I1WLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:47 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:47268 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355Ab3I1WLo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:44 -0400
Received: by mail-ob0-f181.google.com with SMTP id gq1so4112868obb.40
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z7zcA1SwDcaWtBMJnsYz+g6jmBOUUncajZU+u/+rnHI=;
        b=x564mLHKWl9uWCoauUp6krduA44TmhBY2uR8NyQCMoN88xKHMURdqFix7jt3Kso9e4
         p+bpT4Dyk2rDhEDFV5vD+OFmwoo34hp9JGorjhyMb1xeW4+/OYsywbzxcYCEMWOeWBVg
         h9U8mWTknDsQwq8YuFRz3Ufa+Axk8zZSy+OvCpKXbNC4r7ksQ3P1J2ZFRJmNW687OR29
         K0U9PDXVjBgNbn53I2kagBPnXTpF8JvPZe62ZwzVi2ATtV9fW76k6h76W2uFi8B/NuUt
         aVfVIVmQdyVhnT7u+hVL4g2Jmclhablq5MLOjoNcaPeAJqRo0nK7GKXjAoL6jeD+1smT
         Hxmg==
X-Received: by 10.60.117.225 with SMTP id kh1mr12301937oeb.15.1380406304290;
        Sat, 28 Sep 2013 15:11:44 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xx9sm19517230obc.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235555>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    This time we use an initializer and alloc function, so we could do:
    
     ri = Git::RevInfo.new()
     ri.setup(args)
    
    Or:
    
     ri = Git::RevInfo.setup(args)
    
    The effect is the same.
    
    Also, we use the extremely useful 'method_missing' method, which allows us to
    do the binding at run-time, saving us precious finger typing time and code,
    with price of a bit of performance loss, which is not that important in a
    script like this.
    
    We could do something fancier like saving the Ruby internal identifiers in an
    array to map them to a C enum, or we could even generate the missing methods at
    run-time, but for now let's stick to the simpler option and just make it work
    with the less possible code.

 ruby.c | 165 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/ruby.c b/ruby.c
index 360515f..d9ee985 100644
--- a/ruby.c
+++ b/ruby.c
@@ -5,6 +5,8 @@
 #include "commit.h"
 #include "remote.h"
 #include "transport.h"
+#include "revision.h"
+#include "diff.h"
 
 #undef NORETURN
 #undef PATH_SEP
@@ -17,6 +19,8 @@ static VALUE git_rb_commit_list;
 static VALUE git_rb_remote;
 static VALUE git_rb_transport;
 static VALUE git_rb_ref;
+static VALUE git_rb_rev_info;
+static VALUE git_rb_diff_opt;
 
 static inline VALUE sha1_to_str(const unsigned char *sha1)
 {
@@ -277,6 +281,107 @@ static VALUE git_rb_read_sha1_file(VALUE self, VALUE sha1, VALUE type)
 	return rb_ary_new3(2, rb_str_new(buffer, size), INT2FIX(g_type));
 }
 
+static VALUE git_rb_rev_info_alloc(VALUE class)
+{
+	struct rev_info *revs;
+	return Data_Make_Struct(class, struct rev_info, NULL, free, revs);
+}
+
+static VALUE git_rb_rev_info_init(VALUE self, VALUE prefix)
+{
+	struct rev_info *revs;
+	Data_Get_Struct(self, struct rev_info, revs);
+	init_revisions(revs, str_to_cstr(prefix));
+	return self;
+}
+
+static VALUE git_rb_rev_info_setup(VALUE self, VALUE args, VALUE opts)
+{
+	struct rev_info *revs;
+	const char *argv[RARRAY_LEN(args) + 2];
+	int i, r;
+
+	argv[0] = "";
+	Data_Get_Struct(self, struct rev_info, revs);
+	for (i = 0; i < RARRAY_LEN(args); i++)
+		argv[i + 1] = RSTRING_PTR(RARRAY_PTR(args)[i]);
+	argv[i + 1] = NULL;
+	r = setup_revisions(RARRAY_LEN(args) + 1, argv, revs, NULL);
+	return INT2FIX(r - 1);
+}
+
+static VALUE git_rb_rev_info_single_setup(VALUE class, VALUE prefix, VALUE args, VALUE opts)
+{
+	struct rev_info *revs;
+	VALUE self;
+	self = Data_Make_Struct(class, struct rev_info, NULL, free, revs);
+	init_revisions(revs, str_to_cstr(prefix));
+	git_rb_rev_info_setup(self, args, opts);
+	return self;
+}
+
+static VALUE git_rb_rev_info_each_revision(VALUE self, VALUE args, VALUE opts)
+{
+	struct commit *commit;
+	struct rev_info *revs;
+
+	Data_Get_Struct(self, struct rev_info, revs);
+	if (prepare_revision_walk(revs))
+		return Qnil;
+	while ((commit = get_revision(revs))) {
+		VALUE c;
+		c = Data_Wrap_Struct(git_rb_commit, NULL, NULL, commit);
+		rb_yield(c);
+	}
+	return Qnil;
+}
+
+static VALUE git_rb_rev_info_diffopt(VALUE self)
+{
+	struct rev_info *revs;
+
+	Data_Get_Struct(self, struct rev_info, revs);
+	return Data_Wrap_Struct(git_rb_diff_opt, NULL, NULL, &revs->diffopt);
+}
+
+static VALUE git_rb_diff_opt_new(VALUE class)
+{
+	struct diff_options *opt;
+	VALUE self;
+	self = Data_Make_Struct(class, struct diff_options, NULL, free, opt);
+
+	diff_setup(opt);
+
+	return self;
+}
+
+static VALUE git_rb_diff_opt_method_missing(int argc, VALUE *argv, VALUE self)
+{
+	struct diff_options *opt;
+	ID id;
+
+	id = rb_to_id(argv[0]);
+	Data_Get_Struct(self, struct diff_options, opt);
+
+	if (id == rb_intern("stat_width="))
+		opt->stat_width = NUM2INT(argv[1]);
+	else if (id == rb_intern("stat_graph_width="))
+		opt->stat_graph_width = NUM2INT(argv[1]);
+	else if (id == rb_intern("output_format="))
+		opt->output_format = NUM2INT(argv[1]);
+	else if (id == rb_intern("detect_rename="))
+		opt->detect_rename = NUM2INT(argv[1]);
+	else if (id == rb_intern("flags="))
+		opt->flags = NUM2INT(argv[1]);
+	else if (id == rb_intern("output_format"))
+		return INT2FIX(opt->output_format);
+	else if (id == rb_intern("flags"))
+		return INT2FIX(opt->flags);
+	else
+		return rb_call_super(argc, argv);
+	return Qnil;
+}
+
 static void git_ruby_init(void)
 {
 	VALUE mod;
@@ -296,6 +401,53 @@ static void git_ruby_init(void)
 
 	rb_define_global_const("DEFAULT_ABBREV", INT2FIX(DEFAULT_ABBREV));
 
+	rb_define_global_const("DIFF_FORMAT_RAW", INT2FIX(DIFF_FORMAT_RAW));
+	rb_define_global_const("DIFF_FORMAT_DIFFSTAT", INT2FIX(DIFF_FORMAT_DIFFSTAT));
+	rb_define_global_const("DIFF_FORMAT_NUMSTAT", INT2FIX(DIFF_FORMAT_NUMSTAT));
+	rb_define_global_const("DIFF_FORMAT_SUMMARY", INT2FIX(DIFF_FORMAT_SUMMARY));
+	rb_define_global_const("DIFF_FORMAT_PATCH", INT2FIX(DIFF_FORMAT_PATCH));
+	rb_define_global_const("DIFF_FORMAT_SHORTSTAT", INT2FIX(DIFF_FORMAT_SHORTSTAT));
+	rb_define_global_const("DIFF_FORMAT_DIRSTAT", INT2FIX(DIFF_FORMAT_DIRSTAT));
+	rb_define_global_const("DIFF_FORMAT_NAME", INT2FIX(DIFF_FORMAT_NAME));
+	rb_define_global_const("DIFF_FORMAT_NAME_STATUS", INT2FIX(DIFF_FORMAT_NAME_STATUS));
+	rb_define_global_const("DIFF_FORMAT_CHECKDIFF", INT2FIX(DIFF_FORMAT_CHECKDIFF));
+	rb_define_global_const("DIFF_FORMAT_NO_OUTPUT", INT2FIX(DIFF_FORMAT_NO_OUTPUT));
+	rb_define_global_const("DIFF_FORMAT_CALLBACK", INT2FIX(DIFF_FORMAT_CALLBACK));
+
+	rb_define_global_const("DIFF_DETECT_RENAME", INT2FIX(DIFF_DETECT_RENAME));
+	rb_define_global_const("DIFF_DETECT_COPY", INT2FIX(DIFF_DETECT_COPY));
+
+	rb_define_global_const("DIFF_OPT_RECURSIVE", INT2FIX(DIFF_OPT_RECURSIVE));
+	rb_define_global_const("DIFF_OPT_TREE_IN_RECURSIVE", INT2FIX(DIFF_OPT_TREE_IN_RECURSIVE));
+	rb_define_global_const("DIFF_OPT_BINARY", INT2FIX(DIFF_OPT_BINARY));
+	rb_define_global_const("DIFF_OPT_TEXT", INT2FIX(DIFF_OPT_TEXT));
+	rb_define_global_const("DIFF_OPT_FULL_INDEX", INT2FIX(DIFF_OPT_FULL_INDEX));
+	rb_define_global_const("DIFF_OPT_SILENT_ON_REMOVE", INT2FIX(DIFF_OPT_SILENT_ON_REMOVE));
+	rb_define_global_const("DIFF_OPT_FIND_COPIES_HARDER", INT2FIX(DIFF_OPT_FIND_COPIES_HARDER));
+	rb_define_global_const("DIFF_OPT_FOLLOW_RENAMES", INT2FIX(DIFF_OPT_FOLLOW_RENAMES));
+	rb_define_global_const("DIFF_OPT_RENAME_EMPTY", INT2FIX(DIFF_OPT_RENAME_EMPTY));
+	rb_define_global_const("DIFF_OPT_HAS_CHANGES", INT2FIX(DIFF_OPT_HAS_CHANGES));
+	rb_define_global_const("DIFF_OPT_QUICK", INT2FIX(DIFF_OPT_QUICK));
+	rb_define_global_const("DIFF_OPT_NO_INDEX", INT2FIX(DIFF_OPT_NO_INDEX));
+	rb_define_global_const("DIFF_OPT_ALLOW_EXTERNAL", INT2FIX(DIFF_OPT_ALLOW_EXTERNAL));
+	rb_define_global_const("DIFF_OPT_EXIT_WITH_STATUS", INT2FIX(DIFF_OPT_EXIT_WITH_STATUS));
+	rb_define_global_const("DIFF_OPT_REVERSE_DIFF", INT2FIX(DIFF_OPT_REVERSE_DIFF));
+	rb_define_global_const("DIFF_OPT_CHECK_FAILED", INT2FIX(DIFF_OPT_CHECK_FAILED));
+	rb_define_global_const("DIFF_OPT_RELATIVE_NAME", INT2FIX(DIFF_OPT_RELATIVE_NAME));
+	rb_define_global_const("DIFF_OPT_IGNORE_SUBMODULES", INT2FIX(DIFF_OPT_IGNORE_SUBMODULES));
+	rb_define_global_const("DIFF_OPT_DIRSTAT_CUMULATIVE", INT2FIX(DIFF_OPT_DIRSTAT_CUMULATIVE));
+	rb_define_global_const("DIFF_OPT_DIRSTAT_BY_FILE", INT2FIX(DIFF_OPT_DIRSTAT_BY_FILE));
+	rb_define_global_const("DIFF_OPT_ALLOW_TEXTCONV", INT2FIX(DIFF_OPT_ALLOW_TEXTCONV));
+	rb_define_global_const("DIFF_OPT_DIFF_FROM_CONTENTS", INT2FIX(DIFF_OPT_DIFF_FROM_CONTENTS));
+	rb_define_global_const("DIFF_OPT_SUBMODULE_LOG", INT2FIX(DIFF_OPT_SUBMODULE_LOG));
+	rb_define_global_const("DIFF_OPT_DIRTY_SUBMODULES", INT2FIX(DIFF_OPT_DIRTY_SUBMODULES));
+	rb_define_global_const("DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES", INT2FIX(DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES));
+	rb_define_global_const("DIFF_OPT_IGNORE_DIRTY_SUBMODULES", INT2FIX(DIFF_OPT_IGNORE_DIRTY_SUBMODULES));
+	rb_define_global_const("DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG", INT2FIX(DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG));
+	rb_define_global_const("DIFF_OPT_DIRSTAT_BY_LINE", INT2FIX(DIFF_OPT_DIRSTAT_BY_LINE));
+	rb_define_global_const("DIFF_OPT_FUNCCONTEXT", INT2FIX(DIFF_OPT_FUNCCONTEXT));
+	rb_define_global_const("DIFF_OPT_PICKAXE_IGNORE_CASE", INT2FIX(DIFF_OPT_PICKAXE_IGNORE_CASE));
+
 	rb_define_global_function("setup_git_directory", git_rb_setup_git_directory, 0);
 	rb_define_global_function("for_each_ref", git_rb_for_each_ref, 0);
 	rb_define_global_function("dwim_ref", git_rb_dwim_ref, 1);
@@ -334,6 +486,19 @@ static void git_ruby_init(void)
 	rb_define_method(git_rb_ref, "each", git_rb_ref_each, 0);
 	rb_define_method(git_rb_ref, "name", git_rb_ref_name, 0);
 	rb_define_method(git_rb_ref, "old_sha1", git_rb_ref_old_sha1, 0);
+
+	git_rb_rev_info = rb_define_class_under(mod, "RevInfo", rb_cData);
+	rb_include_module(git_rb_rev_info, rb_mEnumerable);
+	rb_define_alloc_func(git_rb_rev_info, git_rb_rev_info_alloc);
+	rb_define_method(git_rb_rev_info, "initialize", git_rb_rev_info_init, 1);
+	rb_define_singleton_method(git_rb_rev_info, "setup", git_rb_rev_info_single_setup, 3);
+	rb_define_method(git_rb_rev_info, "setup", git_rb_rev_info_setup, 2);
+	rb_define_method(git_rb_rev_info, "each", git_rb_rev_info_each_revision, 0);
+	rb_define_method(git_rb_rev_info, "diffopt", git_rb_rev_info_diffopt, 0);
+
+	git_rb_diff_opt = rb_define_class_under(mod, "DiffOptions", rb_cData);
+	rb_define_singleton_method(git_rb_diff_opt, "new", git_rb_diff_opt_new, 0);
+	rb_define_method(git_rb_diff_opt, "method_missing", git_rb_diff_opt_method_missing, -1);
 }
 
 static int run_ruby_command(const char *cmd, int argc, const char **argv)
-- 
1.8.4-fc
