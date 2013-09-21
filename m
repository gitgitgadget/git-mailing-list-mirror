From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH/RFC 6/7] ruby: remove one fork
Date: Sat, 21 Sep 2013 13:48:14 -0500
Message-ID: <1379789295-18519-7-git-send-email-felipe.contreras@gmail.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 20:54:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNSJq-0000ez-E4
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 20:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596Ab3IUSyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 14:54:06 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34367 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab3IUSyE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 14:54:04 -0400
Received: by mail-ob0-f178.google.com with SMTP id uy5so2168385obc.9
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 11:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4+BmZK+MqPflsnQjdQoyDMzgQSclhC9p3fD28qqGGmI=;
        b=oNTuDgRTdeVYex+6rd957CrGwhZ7nGKOE7Igv0/F3sQAOwdOE+dVFxs3JigAebe0us
         u2sr5UOzQZtyNFVMc5fQd0FpOClNSGrp8ATEz64ofIkftWO0auhaHMYcYqkl54woFJU7
         /EwKrUSCUOyFd89sRGVOjaB8NWnBWPr9eSqkfrezqbYjs90KFusEkNknoJtaBIvb2Tob
         m1DkLSDua2cZjwsEbwiAAlE3AtpQqwAPjA0kOaNaktdIwd1lyaKfA/ECMvWHP75yV/2S
         CPFUuB1j0dOFMCCaWLOB2ddnMb1RU3tUpGJZNAU0QsJlaOE0iEerxGn/LnD8pBx1iX8d
         YJmQ==
X-Received: by 10.182.28.134 with SMTP id b6mr11825433obh.27.1379789644153;
        Sat, 21 Sep 2013 11:54:04 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id b5sm8621410obj.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 11:54:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235140>

This is an example of how to start moving out of Git commands, towards
using Git's internal library.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-request-pull.rb |  8 +++++++-
 ruby.c              | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/git-request-pull.rb b/git-request-pull.rb
index 6a96a98..fc3175c 100644
--- a/git-request-pull.rb
+++ b/git-request-pull.rb
@@ -37,7 +37,13 @@ head = ARGV[2] || 'HEAD'
 status = 0
 branch_name = nil
 
-headref = `git symbolic-ref -q "#{head}"`.chomp
+def get_symbolic_ref(refname)
+  refname, sha1, flags = resolve_ref_unsafe(refname, 0)
+  return nil if (flags & REF_ISSYMREF) == 0
+  return refname
+end
+
+headref = get_symbolic_ref(head)
 
 if system(%[git show-ref -q --verify "#{headref}"])
   branch_name = headref.gsub(/^refs\/heads\//, '')
diff --git a/ruby.c b/ruby.c
index 733215a..b4e874d 100644
--- a/ruby.c
+++ b/ruby.c
@@ -26,9 +26,30 @@ static VALUE git_rb_for_each_ref(void)
 	return INT2FIX(r);
 }
 
+static VALUE git_rb_resolve_ref_unsafe(VALUE self, VALUE refname, VALUE reading)
+{
+	VALUE a = rb_ary_new2(3);
+	unsigned char sha1[20];
+	int flag;
+	const char *r;
+
+	r = resolve_ref_unsafe(RSTRING_PTR(refname), sha1, FIX2INT(reading), &flag);
+	if (!r)
+		return Qnil;
+	rb_ary_store(a, 0, rb_str_new2(r));
+	rb_ary_store(a, 1, sha1_to_str(sha1));
+	rb_ary_store(a, 2, INT2FIX(flag));
+	return a;
+}
+
 static void git_init(void)
 {
+	rb_define_global_const("REF_ISSYMREF", INT2FIX(REF_ISSYMREF));
+	rb_define_global_const("REF_ISPACKED", INT2FIX(REF_ISPACKED));
+	rb_define_global_const("REF_ISBROKEN", INT2FIX(REF_ISBROKEN));
+
 	rb_define_global_function("for_each_ref", git_rb_for_each_ref, 0);
+	rb_define_global_function("resolve_ref_unsafe", git_rb_resolve_ref_unsafe, 2);
 }
 
 static const char *commands[] = {
-- 
1.8.4-fc
