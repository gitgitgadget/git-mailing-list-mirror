From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 14/44] ruby: bind dwim_ref()
Date: Sat, 28 Sep 2013 17:03:39 -0500
Message-ID: <1380405849-13000-15-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:10:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2iw-0003F5-Sq
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263Ab3I1WKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:10:45 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:57117 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207Ab3I1WKm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:42 -0400
Received: by mail-oa0-f45.google.com with SMTP id o17so3002494oag.4
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tXjwHSliy4+nHHj1mbucsIWfEqCa51dNUHsE34//EEg=;
        b=jsOTjR6f6tIR5WSlNS040RyrVJ3sal/CSWDIrJ7Rf78n/6gng1ktNUovVGdvIoro2C
         scSUMrSIbIt+0wjpdK4rAxfgiXvaaiFxawTaXNeJwpmt2nAuXdSzo7HxdTIqqG9/Cu9T
         SSYCDm8+GY1ZPvXt0Tip+wmbMm6Ft/ZAnA6OARsNpRzpoR1H/2a0DhEbmV9yig+6TtMw
         u1RipKOhXaVAXFKwKGgtW8Q1eRmxyBDS1NqwlbIIp+i2zFRInG2dOJr0iqEdNO6CT5oU
         nxvEOP6OFwWfhGNXha8WZRZKeznHBWB3sofz5M8pweInv1cn/nQNQvLabXD8WMAcgT5L
         ZDSA==
X-Received: by 10.182.246.74 with SMTP id xu10mr12379130obc.23.1380406242004;
        Sat, 28 Sep 2013 15:10:42 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm19483409obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235535>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 ruby.c           | 11 +++++++++++
 t/t10000-ruby.sh | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/ruby.c b/ruby.c
index c2ef72e..0ab56de 100644
--- a/ruby.c
+++ b/ruby.c
@@ -41,10 +41,21 @@ static VALUE git_rb_for_each_ref(void)
 	return INT2FIX(r);
 }
 
+static VALUE git_rb_dwim_ref(VALUE self, VALUE name)
+{
+	unsigned char buf[20];
+	char *ref;
+	int r;
+
+	r = dwim_ref(RSTRING_PTR(name), RSTRING_LEN(name), buf, &ref);
+	return rb_ary_new3(3, sha1_to_str(buf), INT2NUM(r), cstr_to_str(ref));
+}
+
 static void git_ruby_init(void)
 {
 	rb_define_global_function("setup_git_directory", git_rb_setup_git_directory, 0);
 	rb_define_global_function("for_each_ref", git_rb_for_each_ref, 0);
+	rb_define_global_function("dwim_ref", git_rb_dwim_ref, 1);
 }
 
 static int run_ruby_command(const char *cmd, int argc, const char **argv)
diff --git a/t/t10000-ruby.sh b/t/t10000-ruby.sh
index 2098e29..d719b30 100755
--- a/t/t10000-ruby.sh
+++ b/t/t10000-ruby.sh
@@ -52,4 +52,15 @@ test_expect_success 'test setup_git_directory()' '
 	test_cmp expected actual
 '
 
+test_expect_success 'test dwim_ref()' '
+	git ruby > actual <<-EOF &&
+	sha1, num, ref = dwim_ref("HEAD")
+	puts sha1_to_hex(sha1), num, ref
+	EOF
+	git rev-parse -q --verify HEAD > expected &&
+	echo 1 >> expected &&
+	git rev-parse -q --verify --symbolic-full-name HEAD >> expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.4-fc
