From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 19/44] ruby: bind get_sha1()
Date: Sat, 28 Sep 2013 17:03:44 -0500
Message-ID: <1380405849-13000-20-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2jB-0003Qw-QK
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281Ab3I1WLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:00 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50446 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099Ab3I1WK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:56 -0400
Received: by mail-oa0-f46.google.com with SMTP id k14so2982707oag.5
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/sW4Gq1sivq7tTh6G2riQhgwL9gk7vf/CTYfU3b28LM=;
        b=fScf3Nx9ELvnF2ggVfVGd/utJVFyg/4HxOfSAIyaokTHIn9Q2D+qV+/8xCfa6p62zk
         Q/JYYUms6GESv25F/k6JGI6aOuHDo4B4NpQMEyHf38B129u0ttXEQM2flyLZrRebbREq
         DDXmIb9E/WT6EkJuXdHGuq3mxT5sP+wUYOmlg3VnscxJnZrkyVxjX0z0H1hlwPTcF4JT
         u/FpzdOds+OjAQ3W25VtWH5V4+BGM4W8ug37UgnHY0KaVLUMREbP4/l3eMXq33yIblkm
         QU/1GIbi04QT6Cgw6BUoCXE4m+I9bE8hbngRluNK+QtXtKaDfn4O720dmmWCdqYTrwyG
         +Qfw==
X-Received: by 10.60.96.169 with SMTP id dt9mr12228054oeb.27.1380406255477;
        Sat, 28 Sep 2013 15:10:55 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm19486621obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235539>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 ruby.c           | 11 +++++++++++
 t/t10000-ruby.sh |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/ruby.c b/ruby.c
index 92c636c..45111e6 100644
--- a/ruby.c
+++ b/ruby.c
@@ -81,6 +81,16 @@ static VALUE git_rb_peel_ref(VALUE self, VALUE refname)
 	return sha1_to_str(sha1);
 }
 
+static VALUE git_rb_get_sha1(VALUE self, VALUE name)
+{
+	unsigned char buf[20];
+	int r;
+	r = get_sha1(RSTRING_PTR(name), buf);
+	if (r)
+		return Qnil;
+	return sha1_to_str(buf);
+}
+
 static void git_ruby_init(void)
 {
 	rb_define_global_function("setup_git_directory", git_rb_setup_git_directory, 0);
@@ -89,6 +99,7 @@ static void git_ruby_init(void)
 	rb_define_global_function("git_config", git_rb_git_config, 0);
 	rb_define_global_function("read_ref", git_rb_read_ref, 1);
 	rb_define_global_function("peel_ref", git_rb_peel_ref, 1);
+	rb_define_global_function("get_sha1", git_rb_get_sha1, 1);
 }
 
 static int run_ruby_command(const char *cmd, int argc, const char **argv)
diff --git a/t/t10000-ruby.sh b/t/t10000-ruby.sh
index cdbf5d8..849a615 100755
--- a/t/t10000-ruby.sh
+++ b/t/t10000-ruby.sh
@@ -73,4 +73,12 @@ test_expect_success 'test git_config()' '
 	test_cmp expected actual
 '
 
+test_expect_success 'test get_sha1()' '
+	git ruby > actual <<-EOF &&
+	puts sha1_to_hex(get_sha1("HEAD"))
+	EOF
+	git rev-parse -q --verify HEAD > expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.4-fc
