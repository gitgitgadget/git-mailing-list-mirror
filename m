From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 13/44] ruby: bind setup_git_directory()
Date: Sat, 28 Sep 2013 17:03:38 -0500
Message-ID: <1380405849-13000-14-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:10:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2it-0003D3-Fc
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260Ab3I1WKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:10:43 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:48379 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755245Ab3I1WKj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:39 -0400
Received: by mail-oa0-f54.google.com with SMTP id n5so3060632oag.27
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=417vLVpgoKegQMbk4nZFEB+fkmZa/BIXj2NuNVEtk10=;
        b=sI0LunEV4XG/Mfh1KOU9PbZ2b5tlGop8hMH+BxACj+ETXrj8pPy66cm1CVXa5XCkBl
         XUPj2oBk+z1XbGD6wPBPzOuGrv9REwJ4GuCcbdh/4/qci/0ygtIXRegG96tlzg7bNYjq
         gR0bcGvP+69HPPyafRiipiV17wzFbGDip4zFhtT+munaFtaSfSISXyZHfMMcbSVLRdE9
         1CajG5em7yFrUqflc42ja9SgT+mXVt4oearhRqsYJnuCZEYuWXfkAqTCAQk0UM/7Uc4D
         gxPcCnz6gMmRKfQWvQ9oCs6jPubx40uGrhnGirFaHOk1RGwaUB2dif8GySXmxFdMv12X
         IMnQ==
X-Received: by 10.60.63.116 with SMTP id f20mr12420521oes.29.1380406239041;
        Sat, 28 Sep 2013 15:10:39 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u8sm19503984obd.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235533>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 ruby.c           | 16 ++++++++++++++++
 t/t10000-ruby.sh | 13 +++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/ruby.c b/ruby.c
index 339e376..c2ef72e 100644
--- a/ruby.c
+++ b/ruby.c
@@ -12,6 +12,21 @@ static inline VALUE sha1_to_str(const unsigned char *sha1)
 	return rb_str_new((const char *)sha1, 20);
 }
 
+static inline VALUE cstr_to_str(const char *str)
+{
+	if (str == NULL)
+		return Qnil;
+	return rb_str_new2(str);
+}
+
+static VALUE git_rb_setup_git_directory(VALUE self)
+{
+	int nongit_ok;
+	const char *prefix;
+	prefix = setup_git_directory_gently(&nongit_ok);
+	return rb_ary_new3(2, cstr_to_str(prefix), INT2FIX(nongit_ok));
+}
+
 static int for_each_ref_fn(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
 	VALUE r;
@@ -28,6 +43,7 @@ static VALUE git_rb_for_each_ref(void)
 
 static void git_ruby_init(void)
 {
+	rb_define_global_function("setup_git_directory", git_rb_setup_git_directory, 0);
 	rb_define_global_function("for_each_ref", git_rb_for_each_ref, 0);
 }
 
diff --git a/t/t10000-ruby.sh b/t/t10000-ruby.sh
index eb03706..2098e29 100755
--- a/t/t10000-ruby.sh
+++ b/t/t10000-ruby.sh
@@ -39,4 +39,17 @@ test_expect_success 'test for_each_ref()' '
 	test_cmp expected actual
 '
 
+test_expect_success 'test setup_git_directory()' '
+	mkdir t &&
+	(
+	cd t &&
+	git ruby > ../actual <<-EOF
+	prefix, nongit_ok = setup_git_directory()
+	puts prefix
+	EOF
+	) &&
+	echo "t/" > expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.4-fc
