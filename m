From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 15/21] remote-hg: add basic author tests
Date: Thu, 11 Apr 2013 07:23:11 -0500
Message-ID: <1365682997-11329-16-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:25:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGZ7-000826-2L
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161509Ab3DKMZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:25:14 -0400
Received: from mail-qa0-f54.google.com ([209.85.216.54]:45872 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161312Ab3DKMZN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:25:13 -0400
Received: by mail-qa0-f54.google.com with SMTP id o13so233380qaj.20
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=emA9Qe+nVFHD7DLs92H9idb/KkCvUVK7HeKnWwuB1Ss=;
        b=e9Xxqt2eP1GcqOeJx7OGDyy8njgJrU4Rn3w+RV0gFxkR+RdHcUKKvBpJbNtJK08lR2
         2T23jy+If3G4ExUBqckN+WtgsXccO3eo0kcA6vofXi+jclLXkdEY9VJc/9VMuXW0wo1H
         gRAXHh/EmJVuC23JEvKZSdZ/jRrZg3Mv50nW0Pl9K65MBSpvw1lZhEbqelrpozhMjMCL
         YSfl+fOPqVA2ZVg2MMMhCtxj9G6iE7gnI6e3iy1MwBBFVpoqtmT7iIR+HpjGrLa3+vM8
         17ehy71Jmr6lNB6+uVX9utqEkn0Uc5C7If/dXy89cgcu99ILJM9icGvUH9rBf0nEjJn4
         eotQ==
X-Received: by 10.224.173.65 with SMTP id o1mr6783679qaz.83.1365683112529;
        Thu, 11 Apr 2013 05:25:12 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id g6sm6989723qav.6.2013.04.11.05.25.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:25:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220866>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 5f81dfa..62e3a47 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -118,4 +118,39 @@ test_expect_success 'update bookmark' '
   hg -R hgrepo bookmarks | grep "devel\s\+3:"
 '
 
+author_test () {
+  echo $1 >> content &&
+  hg commit -u "$2" -m "add $1" &&
+  echo "$3" >> ../expected
+}
+
+test_expect_success 'authors' '
+  mkdir -p tmp && cd tmp &&
+  test_when_finished "cd .. && rm -rf tmp" &&
+
+  (
+  hg init hgrepo &&
+  cd hgrepo &&
+
+  touch content &&
+  hg add content &&
+
+  author_test alpha "" "H G Wells <wells@example.com>" &&
+  author_test beta "test" "test <unknown>" &&
+  author_test beta "test <test@example.com> (comment)" "test <unknown>" &&
+  author_test gamma "<test@example.com>" "Unknown <test@example.com>" &&
+  author_test delta "name<test@example.com>" "name <test@example.com>" &&
+  author_test epsilon "name <test@example.com" "name <unknown>" &&
+  author_test zeta " test " "test <unknown>" &&
+  author_test eta "test < test@example.com >" "test <test@example.com>" &&
+  author_test theta "test >test@example.com>" "test <unknown>" &&
+  author_test iota "test < test <at> example <dot> com>" "test <unknown>"
+  ) &&
+
+  git clone "hg::$PWD/hgrepo" gitrepo &&
+  git --git-dir=gitrepo/.git log --reverse --format="%an <%ae>" > actual &&
+
+  test_cmp expected actual
+'
+
 test_done
-- 
1.8.2.1
