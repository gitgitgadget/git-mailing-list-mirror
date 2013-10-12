From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v10 09/15] contrib: related: add support for more roles
Date: Sat, 12 Oct 2013 02:06:17 -0500
Message-ID: <1381561584-20529-9-git-send-email-felipe.contreras@gmail.com>
References: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtNg-00059v-Tg
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227Ab3JLHMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:12:48 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:61405 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169Ab3JLHMq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:46 -0400
Received: by mail-ob0-f180.google.com with SMTP id wn1so3396481obc.25
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6go4evqludPHnJZJLg3b14plUJJVivAcr4/GVeGBBdU=;
        b=BdxH4OMuIhWeTHWtB9ExGJF7GoZTcQ1u1rZikRmtaTtuvsx1N+nQWeLDS9QBKxjS77
         UFwaenVH68jKbtWGnRnej5Saoyk6Am4EiSTa2cxI84rb/eMSSeJEHhX4RFtX7IOx/iEe
         gLmjeqjstbA4GxrKXsW5e/7baFb+3LlhKlANr9ntgG7tUyQAfCsuRE6acbAJNcCUlUyc
         p/2B/pJ58AOsrTX4uVhvOB/qW8INqTpJJrJnd7OTxSWKdrnpvbFEAnRVg4jHNxlRiZmc
         /fsohXcGujbVfzDelcrcH2Ri+vTzwiwBCLDicP5VH/ZUPcZsedincdcV2HOtPLkMvB0h
         HSOQ==
X-Received: by 10.182.81.41 with SMTP id w9mr17811692obx.18.1381561966417;
        Sat, 12 Oct 2013 00:12:46 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm28672912obi.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235999>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related    | 14 ++++++++++++--
 contrib/related/test-related.t |  8 ++++----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 04c56f5..f94f5f4 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -8,6 +8,13 @@ $min_percent = 10
 $files = []
 $rev_args = []
 
+KNOWN_ROLES = {
+  'Signed-off-by' => :signer,
+  'Reviewed-by' => :reviewer,
+  'Acked-by' => :acker,
+  'Cc' => :cced,
+}
+
 class Person
 
   attr_reader :roles
@@ -77,9 +84,12 @@ class Commit
           in_body = true
         end
       else
-        if line =~ /^(Signed-off-by|Reviewed-by|Acked-by|Cc): ([^<>]+) <(\S+?)>$/
+        role_regex = KNOWN_ROLES.keys.join('|')
+        if line =~ /^(#{role_regex}): ([^<>]+) <(\S+?)>$/
           person = Persons.get($2, $3)
-          person.add_role(@id, :signer) if person != author
+          role = KNOWN_ROLES[$1]
+          next if role == :signer and person == author
+          person.add_role(@id, role)
         end
       end
     end
diff --git a/contrib/related/test-related.t b/contrib/related/test-related.t
index 90cc516..9da2693 100755
--- a/contrib/related/test-related.t
+++ b/contrib/related/test-related.t
@@ -46,7 +46,7 @@ test_expect_success "others" "
 	cat > expected <<-EOF &&
 	John Doe <john@doe.com> (author: 33%)
 	John Poppins <john@doe.com> (author: 33%)
-	Jon Stewart <jon@stewart.com> (signer: 33%, author: 33%)
+	Jon Stewart <jon@stewart.com> (reviewer: 33%, author: 33%)
 	EOF
 	test_cmp expected actual
 "
@@ -58,7 +58,7 @@ test_expect_success "multiple patches" "
 	cat > expected <<-EOF &&
 	John Doe <john@doe.com> (author: 25%)
 	John Poppins <john@doe.com> (author: 25%)
-	Jon Stewart <jon@stewart.com> (signer: 25%, author: 25%)
+	Jon Stewart <jon@stewart.com> (reviewer: 25%, author: 25%)
 	Pablo Escobar <pablo@escobar.com> (author: 25%)
 	EOF
 	test_cmp expected actual
@@ -69,7 +69,7 @@ test_expect_success "from committish" "
 	cat > expected <<-EOF &&
 	John Doe <john@doe.com> (author: 33%)
 	John Poppins <john@doe.com> (author: 33%)
-	Jon Stewart <jon@stewart.com> (signer: 33%, author: 33%)
+	Jon Stewart <jon@stewart.com> (reviewer: 33%, author: 33%)
 	EOF
 	test_cmp expected actual
 "
@@ -79,7 +79,7 @@ test_expect_success "from single rev committish" "
 	cat > expected <<-EOF &&
 	John Doe <john@doe.com> (author: 33%)
 	John Poppins <john@doe.com> (author: 33%)
-	Jon Stewart <jon@stewart.com> (signer: 33%, author: 33%)
+	Jon Stewart <jon@stewart.com> (reviewer: 33%, author: 33%)
 	EOF
 	test_cmp expected actual
 "
-- 
1.8.4-fc
