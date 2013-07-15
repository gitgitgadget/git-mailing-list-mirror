From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/9] t4203: demonstrate loss of single-character name in mailmap entry
Date: Mon, 15 Jul 2013 02:54:05 -0400
Message-ID: <1373871253-96480-2-git-send-email-sunshine@sunshineco.com>
References: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 08:54:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uycg8-0003od-PU
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 08:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103Ab3GOGyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 02:54:32 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:44181 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3GOGyb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 02:54:31 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so25323290ieb.30
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 23:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=X0cWqu2kAKkzoPNc8+iDWsqHsXTsiD1c4s9b03QL7Lo=;
        b=p4nLweO9D28PQ24FQZ9ReIR2/ZDT2hjaZ171HGTiNaSimsfkyNxyrTPO8moaVjvw6R
         ykWGrll5Ew1Gbdc3X4w4ZGpXIXI7AZij4NDtZMM4KiZQHz/1UsPL/kZUEOGjhlgyBitq
         5aTCdSynDWKdE+UgjVnwJUFMdPuu2RfVDsFc9aG+fnuuqDHiJRD3KB5o4DUDTS5eKMnA
         QcpzrUMyWZiuMrlIyhMlD6craE4ixokrvwRj7I0s7xs4RmbCxSt6Tr4SIOw0zCsXhH0Q
         Dw8ppyjIIvVu3+OqpAII6E3od5HWxCR3k5WZPLAmT4TcBGdiEKv7HdaY1lsMvjLCTvFH
         NW2Q==
X-Received: by 10.50.154.106 with SMTP id vn10mr6347325igb.0.1373871271016;
        Sun, 14 Jul 2013 23:54:31 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id y9sm16781487iga.9.2013.07.14.23.54.29
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 23:54:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.804.g0da7a53
In-Reply-To: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230426>

A bug in mailmap.c:parse_name_and_email() causes it to overlook the
single-character name in "A <user@host>" and parse it only as
"<user@host>". Demonstrate this problem.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4203-mailmap.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 842b754..27f8f86 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -247,6 +247,15 @@ test_expect_success 'cleanup after mailmap.blob tests' '
 	rm -f .mailmap
 '
 
+test_expect_failure 'single-character name' '
+	echo "     1	A <author@example.com>" >expect &&
+	echo "     1	nick1 <bugs@company.xx>" >>expect &&
+	echo "A <author@example.com>" >.mailmap &&
+	test_when_finished "rm .mailmap" &&
+	git shortlog -es HEAD >actual &&
+	test_cmp expect actual
+'
+
 # Extended mailmap configurations should give us the following output for shortlog
 cat >expect <<\EOF
 A U Thor <author@example.com> (1):
-- 
1.8.3.2.804.g0da7a53
