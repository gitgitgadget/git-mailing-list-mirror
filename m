From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v10 08/15] contrib: related: show role count
Date: Sat, 12 Oct 2013 02:06:23 -0500
Message-ID: <1381561584-20529-15-git-send-email-felipe.contreras@gmail.com>
References: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtNz-0005PR-QV
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396Ab3JLHNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:04 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:57931 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab3JLHNB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:01 -0400
Received: by mail-ob0-f172.google.com with SMTP id vb8so3486286obc.3
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fMC45U/LOBnBHmK9ntSrz0TnHglTVMNc+AFrApJk1Vc=;
        b=WAIRAoFvUnM8/2+gXD7MhH7EkswOJSPN/j1XxA1qfilCZCZYNnowBX5eGxl0xWKiUr
         n0YrQDpwg17n7esq5ji3OQRKev5L2PbJLp7/ZkdbWcSDm+cYWPiJfB0rzDCCVkVMQ/zf
         QdDRdt4Z7yZdUz4lElCI9gTxSm0AyAep4alrd9l0Ey5BUfB4t+bZYrCb/eelyz75y9vp
         aFo1tD2QsIMLhIyLa3OtUucNAWvlu98iY9wrId6VGnbNEgD8RaPsqK55Yy6OS4xjTpHz
         e5gLntE6OvqGAbyLJL6ybg8UP679lU+C/+avH1+iCTyJfRHKDxSNpVHIc5nLv+Rnyl63
         EVvQ==
X-Received: by 10.60.63.116 with SMTP id f20mr17844029oes.29.1381561981408;
        Sat, 12 Oct 2013 00:13:01 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm101371455oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236006>

Instead of showing the total involvement, show it per role: author, or
signer.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related    | 18 +++++++++++++-----
 contrib/related/test-related.t | 30 +++++++++++++++---------------
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 3cac925..04c56f5 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -16,10 +16,12 @@ class Person
     @name = name
     @email = email
     @commits = {}
+    @roles = Hash.new(0)
   end
 
-  def add_role(commit)
+  def add_role(commit, role)
     @commits[commit] = true
+    @roles[role] += 1
   end
 
   def <=>(b)
@@ -64,20 +66,20 @@ class Commit
   end
 
   def parse(data)
-    in_body = nil
+    in_body = author = nil
     data.each_line do |line|
       if not in_body
         case line
         when /^author ([^<>]+) <(\S+)> (.+)$/
           author = Persons.get($1, $2)
-          author.add_role(@id)
+          author.add_role(@id, :author)
         when /^$/
           in_body = true
         end
       else
         if line =~ /^(Signed-off-by|Reviewed-by|Acked-by|Cc): ([^<>]+) <(\S+?)>$/
           person = Persons.get($2, $3)
-          person.add_role(@id)
+          person.add_role(@id, :signer) if person != author
         end
       end
     end
@@ -204,5 +206,11 @@ persons = Persons.new
 persons.sort.reverse.each do |person|
   percent = person.size.to_f * 100 / commits.size
   next if percent < $min_percent
-  puts '%s (involved: %u%%)' % [person, percent]
+
+  roles = person.roles.map do |role, role_count|
+    role_percent = role_count.to_f * 100 / commits.size
+    '%s: %u%%' % [role, role_percent]
+  end
+
+  puts '%s (%s)' % [person, roles.join(', ')]
 end
diff --git a/contrib/related/test-related.t b/contrib/related/test-related.t
index ec2680a..90cc516 100755
--- a/contrib/related/test-related.t
+++ b/contrib/related/test-related.t
@@ -34,8 +34,8 @@ test_expect_success "basic" "
 	git format-patch --stdout -1 basic > patch &&
 	git related patch | sort > actual &&
 	cat > expected <<-EOF &&
-	Jon Stewart <jon@stewart.com> (involved: 50%)
-	Pablo Escobar <pablo@escobar.com> (involved: 50%)
+	Jon Stewart <jon@stewart.com> (author: 50%)
+	Pablo Escobar <pablo@escobar.com> (author: 50%)
 	EOF
 	test_cmp expected actual
 "
@@ -44,9 +44,9 @@ test_expect_success "others" "
 	git format-patch --stdout -1 master > patch &&
 	git related patch | sort > actual &&
 	cat > expected <<-EOF &&
-	John Doe <john@doe.com> (involved: 33%)
-	John Poppins <john@doe.com> (involved: 33%)
-	Jon Stewart <jon@stewart.com> (involved: 66%)
+	John Doe <john@doe.com> (author: 33%)
+	John Poppins <john@doe.com> (author: 33%)
+	Jon Stewart <jon@stewart.com> (signer: 33%, author: 33%)
 	EOF
 	test_cmp expected actual
 "
@@ -56,10 +56,10 @@ test_expect_success "multiple patches" "
 	git format-patch --stdout -1 master^ > patch2 &&
 	git related patch1 patch2 | sort > actual &&
 	cat > expected <<-EOF &&
-	John Doe <john@doe.com> (involved: 25%)
-	John Poppins <john@doe.com> (involved: 25%)
-	Jon Stewart <jon@stewart.com> (involved: 50%)
-	Pablo Escobar <pablo@escobar.com> (involved: 25%)
+	John Doe <john@doe.com> (author: 25%)
+	John Poppins <john@doe.com> (author: 25%)
+	Jon Stewart <jon@stewart.com> (signer: 25%, author: 25%)
+	Pablo Escobar <pablo@escobar.com> (author: 25%)
 	EOF
 	test_cmp expected actual
 "
@@ -67,9 +67,9 @@ test_expect_success "multiple patches" "
 test_expect_success "from committish" "
 	git related -1 master | sort > actual &&
 	cat > expected <<-EOF &&
-	John Doe <john@doe.com> (involved: 33%)
-	John Poppins <john@doe.com> (involved: 33%)
-	Jon Stewart <jon@stewart.com> (involved: 66%)
+	John Doe <john@doe.com> (author: 33%)
+	John Poppins <john@doe.com> (author: 33%)
+	Jon Stewart <jon@stewart.com> (signer: 33%, author: 33%)
 	EOF
 	test_cmp expected actual
 "
@@ -77,9 +77,9 @@ test_expect_success "from committish" "
 test_expect_success "from single rev committish" "
 	git related -1 master | sort > actual &&
 	cat > expected <<-EOF &&
-	John Doe <john@doe.com> (involved: 33%)
-	John Poppins <john@doe.com> (involved: 33%)
-	Jon Stewart <jon@stewart.com> (involved: 66%)
+	John Doe <john@doe.com> (author: 33%)
+	John Poppins <john@doe.com> (author: 33%)
+	Jon Stewart <jon@stewart.com> (signer: 33%, author: 33%)
 	EOF
 	test_cmp expected actual
 "
-- 
1.8.4-fc
