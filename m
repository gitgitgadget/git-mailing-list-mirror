From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] Add a testcase for checking case insensitivity of mail map
Date: Fri, 12 Jul 2013 23:13:13 +0200
Message-ID: <1373663593-20346-1-git-send-email-stefanbeller@googlemail.com>
References: <7v4nbzjyel.fsf@alter.siamese.dyndns.org>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 23:13:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxkeX-0002zr-Hi
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 23:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757832Ab3GLVNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 17:13:17 -0400
Received: from mail-ea0-f176.google.com ([209.85.215.176]:59586 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757816Ab3GLVNO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 17:13:14 -0400
Received: by mail-ea0-f176.google.com with SMTP id z15so6529048ead.21
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 14:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=X61hVEmB2hi0kHfFhFpQySujIkwhvNZmPZsEii74Hb4=;
        b=Zm/2DL2IhlZrsdpWMdgYNXUvdOM/NXJhM6E6QDUswxM/kkHk/Oij+vIMTsLVTPclgb
         hQFzHPyx7D/XT64FJt+xgnCQEOwMHiS7J5IwCGkN/q0rzMPA5cbQ77LamopyYctI0vVc
         hJcKUoJcCF8PQ49+A+dOULYQald4GYNzUc2qMhOQeq3avkQ7LT2I24O2HnfGvi2QFPs2
         MwRWNdSM3eHAkuHKPzStddUUmLkgP60baMXH4aTKWVntESLnvfuHHyOxcIdEgCC7cCw+
         uYMdbfDpFnP0QudlmDctAdYRxTW+388MSyn1K66OBd+9/lJCsnp/QjGWOr+N2aQ4+Oh3
         QUvA==
X-Received: by 10.14.178.134 with SMTP id f6mr48287989eem.91.1373663593071;
        Fri, 12 Jul 2013 14:13:13 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id i2sm81868398eeu.4.2013.07.12.14.13.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 14:13:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.776.gfcf213d
In-Reply-To: <7v4nbzjyel.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230256>

Your patch seems to do it.
I added a test case which doesn't fail, if your patch is added.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>

---
 t/t4203-mailmap.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 842b754..07152e9 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -409,4 +409,37 @@ test_expect_success 'Blame output (complex mapping)' '
 	test_cmp expect actual.fuzz
 '
 
+test_expect_success 'cleanup after mailmap.blob tests' '
+	rm -f .mailmap
+'
+
+cat >expect <<\EOF
+     2	A <A@example.org>
+     2	Other Author <other@author.xx>
+     2	Santa Claus <santa.claus@northpole.xx>
+     1	A U Thor <author@example.com>
+     1	CTO <cto@company.xx>
+     1	Some Dude <some@dude.xx>
+EOF
+
+test_expect_success 'Test case sensitivity of Names' '
+	# do a commit:
+	echo "asdf" > test1
+	git add test1
+	git commit -a --author="A <A@example.org>" -m "add test1"
+
+	# commit with same name, but different email
+	# (different capitalization does the trick already,
+	# but here I am going to use a different mail)
+	echo "asdf" > test2
+	git add test2
+	git commit -a --author="A <changed_email@example.org>" -m "add test2"
+
+	# Adding the line to the mailmap should make life easy, so we know
+	# it is the same person
+	echo "A <A@example.org> <changed_email@example.org>" > .mailmap
+
+	git shortlog -sne HEAD >actual && test_cmp expect actual
+'
+
 test_done
-- 
1.8.3.2.776.gfcf213d
