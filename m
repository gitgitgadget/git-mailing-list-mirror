From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH/RFC 3/7] ruby: add simple wrappers
Date: Sat, 21 Sep 2013 13:48:11 -0500
Message-ID: <1379789295-18519-4-git-send-email-felipe.contreras@gmail.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 20:54:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNSJf-0000ZE-0Z
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 20:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482Ab3IUSx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 14:53:58 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:40700 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab3IUSx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 14:53:57 -0400
Received: by mail-ob0-f178.google.com with SMTP id uy5so2099962obc.37
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DBeDwXHt9rzAGv8+0kfiULP3mZxuVcWTD2EFPPyfNNg=;
        b=Q89FezDsfc6c50S+rtjXoqbrPpyo5EysV+h8QRgq64At04SLT4e26/eLbKOtuCmimx
         J8Nrjz8TTSnXSqZT++Z/wWiCPEAeslxgRggZtI5RjXzFkGROuj3C10IKM06Q7FYxL5Pq
         lYxOUuq2Dvh731PcTWHI8ntI0G5gZJTXDi/sajemTPFWzJEhS4bI4JwEbpOQgwHYmhSY
         W77gPincwSv+kPLGGXZVQllbSNcjRq1kcEpFc+01uC9b8EwL5zdEgIpq7lD/HlaMtybU
         UD0tuMeYTdTQaJ3GGXdk9Y9cHTi9MotfEXXKllzoe8ANrmvrQHtUs8cnhFPs2eLCiuw3
         WyXw==
X-Received: by 10.60.174.75 with SMTP id bq11mr11639309oec.17.1379789636864;
        Sat, 21 Sep 2013 11:53:56 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id b5sm8620510obj.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 11:53:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235137>

So that we can use for_each_ref() inside Ruby, and provide an example
script.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile    |  1 +
 git-refs.rb |  7 +++++++
 ruby.c      | 27 +++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 git-refs.rb

diff --git a/Makefile b/Makefile
index 138f9bf..8a4e48f 100644
--- a/Makefile
+++ b/Makefile
@@ -492,6 +492,7 @@ SCRIPT_PYTHON += git-remote-testpy.py
 SCRIPT_PYTHON += git-p4.py
 
 SCRIPT_RUBY += git-rb-setup.rb
+SCRIPT_RUBY += git-refs.rb
 
 NO_INSTALL += git-remote-testgit
 NO_INSTALL += git-remote-testpy
diff --git a/git-refs.rb b/git-refs.rb
new file mode 100644
index 0000000..b048714
--- /dev/null
+++ b/git-refs.rb
@@ -0,0 +1,7 @@
+#!/usr/bin/env ruby
+
+require_relative 'git-rb-setup'
+
+for_each_ref() do |name, sha1, flags|
+  puts '%s: %s' % [name, sha1_to_hex(sha1)]
+end
diff --git a/ruby.c b/ruby.c
index 5701753..7f0cc9d 100644
--- a/ruby.c
+++ b/ruby.c
@@ -1,12 +1,38 @@
 #include "cache.h"
 #include "exec_cmd.h"
+#include "refs.h"
 
 #undef NORETURN
 #undef PATH_SEP
 
 #include <ruby.h>
 
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
+static void git_init(void)
+{
+	rb_define_global_function("for_each_ref", git_rb_for_each_ref, 0);
+}
+
 static const char *commands[] = {
+	"refs",
 };
 
 static void run_ruby_command(int argc, const char **argv)
@@ -23,6 +49,7 @@ static void run_ruby_command(int argc, const char **argv)
 	snprintf(buf, PATH_MAX, "%s/git-%s.rb", dir, cmd);
 
 	ruby_init();
+	git_init();
 
 	prefix = Qnil;
 	rb_define_variable("$prefix", &prefix);
-- 
1.8.4-fc
