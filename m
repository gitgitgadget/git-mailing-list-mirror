From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 16/44] ruby: bind git_config()
Date: Sat, 28 Sep 2013 17:03:41 -0500
Message-ID: <1380405849-13000-17-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:10:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2j3-0003LP-Ew
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269Ab3I1WKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:10:50 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:58503 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099Ab3I1WKr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:47 -0400
Received: by mail-ob0-f175.google.com with SMTP id uz6so4170960obc.20
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RBPTX+XCfhFrqHOFRFUixOa/QYcTVZubEN52guvua7k=;
        b=k+0TI4V2+TctIRbEACMcUrveu3JIutNVaRE/tbvinERiBiQzSleU/jEqzrQekQYZoh
         2Y0tnhsj1ADqEa0GQ7V/Om0IkO3TcQKxJgSM1LdIgQl47r6qYymhYm9iMlLhpNSo3qg2
         d+jETQF+hmbSigd9W4W94wLwl42lAxmUqqvyLBOovrJqE7C3P9Xdu4xEzfcz5iI9TCwt
         AWTbjpSkiMIfz+JEHqtbtHuuBHuQsLHgThm0njQrrer19YAOrjCBkBZR+Hlczl4vt4DF
         sJAo4Wer2m5/1iZJ01NaOcMGcyql4MRZC7ygWzQxApVGVJSWQAXIexBxBUSxtlr7ZQOB
         yYug==
X-Received: by 10.60.142.8 with SMTP id rs8mr12557128oeb.34.1380406247244;
        Sat, 28 Sep 2013 15:10:47 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm19476011obg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235537>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    Our first usage of Ruby blocks.
    
    Notice how the code inside the block is in the same scope as the code outside.
    
      cb_data = "config"
      git_config() do |key, value|
        puts "%s: %s=%s" % [cb_data, key, value]
      end
    
    This invalidates the need for callback data, because the block has access to
    those variables already.

 ruby.c           | 15 +++++++++++++++
 t/t10000-ruby.sh | 10 ++++++++++
 2 files changed, 25 insertions(+)

diff --git a/ruby.c b/ruby.c
index 0ab56de..36de943 100644
--- a/ruby.c
+++ b/ruby.c
@@ -51,11 +51,26 @@ static VALUE git_rb_dwim_ref(VALUE self, VALUE name)
 	return rb_ary_new3(3, sha1_to_str(buf), INT2NUM(r), cstr_to_str(ref));
 }
 
+static int git_config_fn(const char *var, const char *value, void *cb_data)
+{
+	VALUE r;
+	r = rb_yield_values(2, rb_str_new2(var), rb_str_new2(value));
+	return r == Qfalse;
+}
+
+static VALUE git_rb_git_config(VALUE self)
+{
+	int r;
+	r = git_config(git_config_fn, NULL);
+	return INT2FIX(r);
+}
+
 static void git_ruby_init(void)
 {
 	rb_define_global_function("setup_git_directory", git_rb_setup_git_directory, 0);
 	rb_define_global_function("for_each_ref", git_rb_for_each_ref, 0);
 	rb_define_global_function("dwim_ref", git_rb_dwim_ref, 1);
+	rb_define_global_function("git_config", git_rb_git_config, 0);
 }
 
 static int run_ruby_command(const char *cmd, int argc, const char **argv)
diff --git a/t/t10000-ruby.sh b/t/t10000-ruby.sh
index d719b30..cdbf5d8 100755
--- a/t/t10000-ruby.sh
+++ b/t/t10000-ruby.sh
@@ -63,4 +63,14 @@ test_expect_success 'test dwim_ref()' '
 	test_cmp expected actual
 '
 
+test_expect_success 'test git_config()' '
+	git ruby > actual <<-EOF &&
+	git_config() do |key, value|
+	  puts "%s=%s" % [key, value]
+	end
+	EOF
+	git config --list > expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.4-fc
