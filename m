From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] t6200-fmt-merge-msg: Exercise 'merge.log' to configure shortlog length
Date: Sat, 28 Aug 2010 16:05:33 +0530
Message-ID: <1282991734-3368-3-git-send-email-artagnon@gmail.com>
References: <1282991734-3368-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 28 12:38:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpIo3-0003rS-Jh
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 12:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674Ab0H1Ki0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 06:38:26 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35444 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab0H1KiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 06:38:25 -0400
Received: by pvg2 with SMTP id 2so1421844pvg.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 03:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZwZGsZgsUaffu4F3UxPhLYEG7QPaQdw0MIFZoZmHnXw=;
        b=B4rdgCYx2aM1LVBrBSPSeZfasaoHQX0unZdnw++pnQapVnaSfZTIA7GIKcS8jTU+Op
         GJbJxXMkdYJslDdO9vZPrMJru4d/JL1i9cH4kJbA3419lsgtdOJvW7kiG7YfAFAYfF5K
         IapebIjppb1TDg0AvHOnqMSnSNq5Np1fjlVto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jszz0PuFb7ul29o4pqh1t1SbATniFhxMbHgLNTmUviiifSj1qAcQkWpWFemXpWcpai
         uBFsQnJ79sZBLcYXxrazgQTDj4noJ5dXruQmFKi8a6PN+RGlk52YJofkkGluV6OZK7MC
         hIqM0IAw5QId3cJy6Tlb4xCpbfDlycmJoltM8=
Received: by 10.142.170.10 with SMTP id s10mr2264078wfe.240.1282991905009;
        Sat, 28 Aug 2010 03:38:25 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id t11sm5855798wfc.4.2010.08.28.03.38.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 03:38:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282991734-3368-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154638>

Add a test to exercise the 'merge.log' configuration option of 'git
fmt-merge-msg'. It controls the number of shortlog entries to display
in merge commit messages.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t6200-fmt-merge-msg.sh |   64 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 71f6cad..528fdf9 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -129,6 +129,70 @@ test_expect_success '[merge] summary/log configuration' '
 	test_cmp expected actual2
 '
 
+test_expect_success 'setup: clear [merge] configuration' '
+	test_might_fail git config --unset-all merge.log &&
+	test_might_fail git config --unset-all merge.summary
+'
+
+test_expect_success 'setup FETCH_HEAD' '
+	git checkout master &&
+	test_tick &&
+	git fetch . left
+'
+
+test_expect_success 'merge.log=3 limits shortlog length' '
+	cat >expected <<-EOF &&
+	Merge branch ${apos}left${apos}
+
+	* left: (5 commits)
+	  Left #5
+	  Left #4
+	  Left #3
+	  ...
+	EOF
+
+	git -c merge.log=3 fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'merge.log=5 shows all 5 commits' '
+	cat >expected <<-EOF &&
+	Merge branch ${apos}left${apos}
+
+	* left:
+	  Left #5
+	  Left #4
+	  Left #3
+	  Common #2
+	  Common #1
+	EOF
+
+	git -c merge.log=5 fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'merge.log=0 disables shortlog' '
+	echo "Merge branch ${apos}left${apos}" >expected
+	git -c merge.log=0 fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'merge.log=-1 does something sane' '
+	cat >expected <<-EOF &&
+	Merge branch ${apos}left${apos}
+
+	* left:
+	  Left #5
+	  Left #4
+	  Left #3
+	  Common #2
+	  Common #1
+	EOF
+
+	git -c merge.log=-1 fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'fmt-merge-msg -m' '
 	echo "Sync with left" >expected &&
 	cat >expected.log <<-EOF &&
-- 
1.7.2.2.409.gdbb11.dirty
