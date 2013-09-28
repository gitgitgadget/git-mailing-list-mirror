From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 01/44] Add support for ruby commands
Date: Sat, 28 Sep 2013 17:03:26 -0500
Message-ID: <1380405849-13000-2-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:10:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2iG-0002jN-TW
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168Ab3I1WKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:10:02 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:40077 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092Ab3I1WKA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:00 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo20so4129104obc.41
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UKCdxyhpuYaPu4w03cZxC3aEZq5+4tkTcvzpNmHIaoQ=;
        b=t3vQwhRzqGhabIMyGoReUkBk+GgnfOP0Csns+1wpyPZ7BHjqLickI7ztc+ZKx5Gfud
         wU2HT39jpPzuxRQw+oXVuME5UgA/eI49aI2EmKGMa2Z46gU9Tmc62RRLMo3qQ6wOjxxb
         xZKecmZIKlaieztSXxc2o2PNpmxfiLTq6NTTb/UuEsAP2ulIgEJubk8Y8i8sG0w5oeOm
         YZNFP/50l5/oaIWzxg+x7k8oYeIK3zTDLt5gYbzgh3fkXUGhPSoSqmJoFZ5H6E43uKAX
         nIyLy76j/ISOvjlF1cMS+xPKqQRpjHg4RlYUTiyE/0Pszu27c9VunqAEY+nuPdu3zPe/
         xBkg==
X-Received: by 10.182.121.137 with SMTP id lk9mr12542445obb.32.1380406199481;
        Sat, 28 Sep 2013 15:09:59 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rl1sm25415331oeb.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:09:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235521>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    With this support, third parties would be able to write scripts more easily and
    access libgit facilities.
    
    Also, it could help developers by allowing easier prototyping
    
      git ruby > actual <<EOF &&
      for_each_ref() do |name, sha1, flags|
        puts "%s: %s" % [name, sha1_to_hex(sha1)]
      end

 .gitignore       |  1 +
 Makefile         | 19 ++++++++++++++++++-
 git-rb-setup.rb  | 11 +++++++++++
 ruby.c           | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t10000-ruby.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 git-rb-setup.rb
 create mode 100644 ruby.c
 create mode 100755 t/t10000-ruby.sh

diff --git a/.gitignore b/.gitignore
index 6b1fd1b..51b04be 100644
--- a/.gitignore
+++ b/.gitignore
@@ -139,6 +139,7 @@
 /git-rev-parse
 /git-revert
 /git-rm
+/git-ruby
 /git-send-email
 /git-send-pack
 /git-sh-i18n
diff --git a/Makefile b/Makefile
index 3588ca1..2fdee15 100644
--- a/Makefile
+++ b/Makefile
@@ -491,6 +491,8 @@ SCRIPT_PERL += git-svn.perl
 SCRIPT_PYTHON += git-remote-testpy.py
 SCRIPT_PYTHON += git-p4.py
 
+SCRIPT_RUBY += git-rb-setup.rb
+
 NO_INSTALL += git-remote-testgit
 NO_INSTALL += git-remote-testpy
 
@@ -502,6 +504,7 @@ SCRIPT_PYTHON_GEN = $(patsubst %.py,%,$(SCRIPT_PYTHON))
 SCRIPT_SH_INS = $(filter-out $(NO_INSTALL),$(SCRIPT_SH_GEN))
 SCRIPT_PERL_INS = $(filter-out $(NO_INSTALL),$(SCRIPT_PERL_GEN))
 SCRIPT_PYTHON_INS = $(filter-out $(NO_INSTALL),$(SCRIPT_PYTHON_GEN))
+SCRIPT_RUBY_INS = $(filter-out $(NO_INSTALL),$(SCRIPT_RUBY))
 
 # Individual rules to allow e.g.
 # "make -C ../.. SCRIPT_PERL=contrib/foo/bar.perl build-perl-script"
@@ -511,13 +514,15 @@ build-perl-script: $(SCRIPT_PERL_GEN)
 build-sh-script: $(SCRIPT_SH_GEN)
 build-python-script: $(SCRIPT_PYTHON_GEN)
 
-.PHONY: install-perl-script install-sh-script install-python-script
+.PHONY: install-perl-script install-sh-script install-python-script install-ruby-script
 install-sh-script: $(SCRIPT_SH_INS)
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 install-perl-script: $(SCRIPT_PERL_INS)
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 install-python-script: $(SCRIPT_PYTHON_INS)
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+install-ruby-script: $(SCRIPT_RUBY_INS)
+	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 
 .PHONY: clean-perl-script clean-sh-script clean-python-script
 clean-sh-script:
@@ -530,6 +535,7 @@ clean-python-script:
 SCRIPTS = $(SCRIPT_SH_INS) \
 	  $(SCRIPT_PERL_INS) \
 	  $(SCRIPT_PYTHON_INS) \
+	  $(SCRIPT_RUBY_INS) \
 	  git-instaweb
 
 ETAGS_TARGET = TAGS
@@ -1502,6 +1508,12 @@ ifneq (,$(XDL_FAST_HASH))
 	BASIC_CFLAGS += -DXDL_FAST_HASH
 endif
 
+ifndef NO_RUBY
+	RUBY_LIBS = $(shell pkg-config --libs ruby-2.0)
+	RUBY_CFLAGS = $(shell pkg-config --cflags ruby-2.0)
+	PROGRAM_OBJS += ruby.o
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
@@ -2059,6 +2071,11 @@ git-http-push$X: revision.o http.o http-push.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
+git-ruby$X: BASIC_CFLAGS += $(RUBY_CFLAGS)
+git-ruby$X: ruby.o GIT-LDFLAGS $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) $(RUBY_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS) $(RUBY_LIBS)
+
 git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) $(VCSSVN_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
 	$(VCSSVN_LIB)
diff --git a/git-rb-setup.rb b/git-rb-setup.rb
new file mode 100644
index 0000000..969278a
--- /dev/null
+++ b/git-rb-setup.rb
@@ -0,0 +1,11 @@
+#!/usr/bin/env ruby
+
+def die(*args)
+  fmt = args.shift
+  $stderr.printf("fatal: %s\n" % fmt, *args)
+  exit 128
+end
+
+def sha1_to_hex(sha1)
+  sha1.unpack('H*').first
+end
diff --git a/ruby.c b/ruby.c
new file mode 100644
index 0000000..ee6a0e7
--- /dev/null
+++ b/ruby.c
@@ -0,0 +1,56 @@
+#include "cache.h"
+#include "exec_cmd.h"
+#include "refs.h"
+
+#undef NORETURN
+#undef PATH_SEP
+
+#include <ruby.h>
+
+static inline VALUE sha1_to_str(const unsigned char *sha1)
+{
+	return rb_str_new((const char *)sha1, 20);
+}
+
+static int for_each_ref_fn(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+{
+	VALUE r;
+	r = rb_yield_values(3, rb_str_new2(refname), sha1_to_str(sha1), INT2FIX(flags));
+	return r == Qfalse;
+}
+
+static VALUE git_rb_for_each_ref(void)
+{
+	int r;
+	r = for_each_ref(for_each_ref_fn, NULL);
+	return INT2FIX(r);
+}
+
+static void git_ruby_init(void)
+{
+	rb_define_global_function("for_each_ref", git_rb_for_each_ref, 0);
+}
+
+static int run_ruby_command(const char *cmd, int argc, const char **argv)
+{
+	static char buf[PATH_MAX + 1];
+	void *node;
+	struct stat st;
+
+	ruby_init();
+	git_ruby_init();
+
+	node = ruby_options(argc, (char **)argv);
+
+	ruby_script(cmd);
+	snprintf(buf, PATH_MAX, "%s/%s", git_exec_path(), "git-rb-setup.rb");
+	if (!stat(buf, &st))
+		rb_load(rb_str_new2(buf), 0);
+
+	return ruby_run_node(node);
+}
+
+int main(int argc, const char **argv)
+{
+	return run_ruby_command(argv[1], argc, argv);
+}
diff --git a/t/t10000-ruby.sh b/t/t10000-ruby.sh
new file mode 100755
index 0000000..eb03706
--- /dev/null
+++ b/t/t10000-ruby.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+#
+# Copyright (c) 2013 Felipe Contreras
+#
+
+test_description='test ruby support'
+
+. ./test-lib.sh
+
+test_expect_success 'basic support' '
+	git ruby > actual <<-EOF &&
+	puts "hello world"
+	EOF
+	echo "hello world" > expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'argument passing' '
+	cat > script <<-"EOF" &&
+	p($0)
+	p(ARGV)
+	EOF
+	git ruby script foo bar > actual &&
+	cat > expected <<-EOF &&
+	"script"
+	["foo", "bar"]
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'test for_each_ref()' '
+	test_commit foo &&
+	git ruby > actual <<-EOF &&
+	for_each_ref() do |name, sha1, flags|
+		puts "%s: %s" % [name, sha1_to_hex(sha1)]
+	end
+	EOF
+	git for-each-ref --format="%(refname): %(objectname)" > expected &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.8.4-fc
