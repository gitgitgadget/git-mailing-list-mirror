From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 02/11] tests: at-combinations: check ref names directly
Date: Tue,  7 May 2013 16:55:02 -0500
Message-ID: <1367963711-8722-3-git-send-email-felipe.contreras@gmail.com>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 23:56:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZpsO-00083T-Or
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 23:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761Ab3EGV4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 17:56:46 -0400
Received: from mail-gg0-f175.google.com ([209.85.161.175]:35887 "EHLO
	mail-gg0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718Ab3EGV4o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 17:56:44 -0400
Received: by mail-gg0-f175.google.com with SMTP id k6so244144ggd.6
        for <git@vger.kernel.org>; Tue, 07 May 2013 14:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=pqY0eQ4XUPNte+GQJbRLEgUP0HrziCuXRPgESN8EvE8=;
        b=K7b0PjvZzbznHhqXOFBiGLmqTiC+Uu1EZ6pQVJWPIjbFuaAy3FqNI67o6/7HzA8bHO
         3meofCqnVvjSjNFuVgui5stH+msOm3hpKWuL6Qs/H8LVe5X9f4R/1XmX2uxtXgYAseIt
         /sa1BemybmsegmlCs8B+0KBkQP+XuY8cpL7P5pLNE1vcBtDMIG4YyTE4IohVYqOwcMdI
         3cNPlqM5/OTqO2hsxhMlDCp6+YJhSsW/mWaQb+X/MqViVTH0Im58Mq0mnkqG8jNC+SI3
         1YTTQ6ZfYSKpqaae+qYHfwZsKIVQqNEdYAq78HUC2DZ93ESLe9IN1RCu5+nMZZ0Z6ayA
         3W5w==
X-Received: by 10.236.115.70 with SMTP id d46mr3715611yhh.119.1367963803672;
        Tue, 07 May 2013 14:56:43 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c18sm33413273yho.13.2013.05.07.14.56.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 14:56:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223607>

Some committishes might point to the same commit, but through a
different ref, that's why it's better to check directly for the ref,
rather than the commit message.

We can do that by calling rev-parse --symbolic-full-name, and to
differentiate the old from the new behavior we add an extra argument to
the check() helper.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t1508-at-combinations.sh | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 46e3f16..bd2d2fe 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -4,9 +4,14 @@ test_description='test various @{X} syntax combinations together'
 . ./test-lib.sh
 
 check() {
-test_expect_${3:-success} "$1 = $2" "
-	echo '$2' >expect &&
-	git log -1 --format=%s '$1' >actual &&
+test_expect_${4:-success} "$1 = $3" "
+	if [ '$2' == 'commit' ]; then
+		echo '$3' >expect &&
+		git log -1 --format=%s '$1' >actual
+	else
+		echo '$3' >expect &&
+		git rev-parse --symbolic-full-name '$1' >actual
+	fi &&
 	test_cmp expect actual
 "
 }
@@ -35,14 +40,14 @@ test_expect_success 'setup' '
 	git branch -u upstream-branch new-branch
 '
 
-check HEAD new-two
-check "@{1}" new-one
-check "@{-1}" old-two
-check "@{-1}@{1}" old-one
-check "@{u}" upstream-two
-check "@{u}@{1}" upstream-one
-check "@{-1}@{u}" master-two
-check "@{-1}@{u}@{1}" master-one
+check HEAD ref refs/heads/new-branch
+check "@{1}" commit new-one
+check "@{-1}" ref refs/heads/old-branch
+check "@{-1}@{1}" commit old-one
+check "@{u}" ref refs/heads/upstream-branch
+check "@{u}@{1}" commit upstream-one
+check "@{-1}@{u}" ref refs/heads/master
+check "@{-1}@{u}@{1}" commit master-one
 nonsense "@{u}@{-1}"
 nonsense "@{1}@{u}"
 
-- 
1.8.3.rc0.401.g45bba44
