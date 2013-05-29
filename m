From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] prompt: fix for simple rebase
Date: Wed, 29 May 2013 01:21:28 -0500
Message-ID: <1369808488-16977-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Zoltan Klinger <zoltan.klinger@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 08:23:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhZn1-0005eM-H9
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 08:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759505Ab3E2GXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 02:23:11 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:46153 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756378Ab3E2GXK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 02:23:10 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so523325obc.10
        for <git@vger.kernel.org>; Tue, 28 May 2013 23:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=2AXb4bLzn1qks7MQ82znNEeILVWS6KyTfGVcEF8ELUw=;
        b=jEBicak6sG2o/1P6gTzn/H5y/xIhkv8LRABDjEkJ6oa5TWmEjo0oXeZlZkkICxYJej
         dicfVfVlyUnTS0eewj1nUrnbLMY2NHR0m8XAKbWYOenw9vNd445oOv0Bq/C2eXXW7Ml/
         1pJ9xDeUVAL4M06vabcarlazlMBY6vgMcffnxReY2S4XnuF9JEYDWOrGEkh4F8byu9zh
         hfqOGIB0ucWMMFhxSXDjWTdEVUKBvRyelL0W3CPk20jLE0NBmN9cHnmn4zKVmitwH8Ti
         3Va1rDXF2M+SGQUotxgORQIj4HB3slgjmsWLzdIF//zupz6qcr0V12MIT8SG3LWRIDLd
         QAxA==
X-Received: by 10.60.58.33 with SMTP id n1mr793912oeq.3.1369808589325;
        Tue, 28 May 2013 23:23:09 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jt9sm38769259obc.0.2013.05.28.23.23.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 23:23:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225753>

When we are rebasing without options ('am' mode), the head rebased lives
in '$g/rebase-apply/head-name', so lets use that information so it's
reported the same way as if we were doing other rebases (-i or -m).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-prompt.sh | 2 ++
 t/t9903-bash-prompt.sh           | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index eaf5c36..bbf7657 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -279,6 +279,7 @@ __git_ps1 ()
 				step=$(cat "$g/rebase-apply/next")
 				total=$(cat "$g/rebase-apply/last")
 				if [ -f "$g/rebase-apply/rebasing" ]; then
+					b="$(cat "$g/rebase-apply/head-name")"
 					r="|REBASE"
 				elif [ -f "$g/rebase-apply/applying" ]; then
 					r="|AM"
@@ -295,6 +296,7 @@ __git_ps1 ()
 				r="|BISECTING"
 			fi
 
+			test -n "$b" ||
 			b="$(git symbolic-ref HEAD 2>/dev/null)" || {
 				detached=yes
 				b="$(
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 083b319..15521cc 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -276,7 +276,7 @@ test_expect_success 'prompt - rebase merge' '
 '
 
 test_expect_success 'prompt - rebase' '
-	printf " ((t2)|REBASE 1/3)" > expected &&
+	printf " (b2|REBASE 1/3)" > expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
 	test_must_fail git rebase b1 b2 &&
-- 
1.8.3.rc3.312.g47657de
