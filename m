From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 36/44] ruby: bind shortlog()
Date: Sat, 28 Sep 2013 17:04:01 -0500
Message-ID: <1380405849-13000-37-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2jw-000423-Ks
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374Ab3I1WLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:49 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:35001 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365Ab3I1WLr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:47 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo20so4188973obc.13
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PSkX0VTRrqzN7/AUoUPMMf1cI53DBF5F9nPmaIzFrwM=;
        b=bMAWovlC7lTJwUuTSvt81HBk8QU1AAkAfVv9VK+MmBpwVifV1iZIqYUUMWcXn7uubK
         WPRHGrU1SStNZL62YCBF/MHgpD3692A15HJ/CjLFcoIcgO/miET0dBrSqv4ckMbUNgm5
         4ZORonBB1gXgu4nDS5rD7+XYEl3msEESfA+Ral5EfM4S2movAmFZ5y0G0KcbFdAWSYm0
         MkOg8GVyEI+PkZ8BQxxLxZ7m0pS5uVzWkYCbSyS9YR4bHzGkTZ3MVFpU+1VlN8mkOWDm
         usv3zLmbaUU3fZkk9VSCCoF2YNGxahPGh8y9XUF7b0iD5BJwE/tcIPO3Sf7rJxobCg2E
         Qctg==
X-Received: by 10.60.124.14 with SMTP id me14mr12330113oeb.4.1380406306715;
        Sat, 28 Sep 2013 15:11:46 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xx9sm19517552obc.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235554>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    There's no need to bind all the shortlog functions, we can easily pass all the
    commits we want in Ruby.

 ruby.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/ruby.c b/ruby.c
index d9ee985..d59aafd 100644
--- a/ruby.c
+++ b/ruby.c
@@ -7,6 +7,7 @@
 #include "transport.h"
 #include "revision.h"
 #include "diff.h"
+#include "shortlog.h"
 
 #undef NORETURN
 #undef PATH_SEP
@@ -344,6 +345,21 @@ static VALUE git_rb_rev_info_diffopt(VALUE self)
 	return Data_Wrap_Struct(git_rb_diff_opt, NULL, NULL, &revs->diffopt);
 }
 
+static VALUE git_rb_shortlog(VALUE self, VALUE commits)
+{
+	struct shortlog log;
+	int i;
+
+	shortlog_init(&log);
+	for (i = 0; i < RARRAY_LEN(commits); i++) {
+		struct commit *commit;
+		Data_Get_Struct(rb_ary_entry(commits, i), struct commit, commit);
+		shortlog_add_commit(&log, commit);
+	}
+	shortlog_output(&log);
+	return Qnil;
+}
+
 static VALUE git_rb_diff_opt_new(VALUE class)
 {
 	struct diff_options *opt;
@@ -460,6 +476,7 @@ static void git_ruby_init(void)
 	rb_define_global_function("transport_get", git_rb_transport_get, 2);
 	rb_define_global_function("find_unique_abbrev", git_rb_find_unique_abbrev, 2);
 	rb_define_global_function("read_sha1_file", git_rb_read_sha1_file, 1);
+	rb_define_global_function("shortlog", git_rb_shortlog, 1);
 
 	git_rb_object = rb_define_class_under(mod, "Object", rb_cData);
 	rb_define_singleton_method(git_rb_object, "get", git_rb_object_get, 1);
-- 
1.8.4-fc
