From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/9] t4203: demonstrate loss of uppercase characters in canonical email
Date: Mon, 15 Jul 2013 02:54:07 -0400
Message-ID: <1373871253-96480-4-git-send-email-sunshine@sunshineco.com>
References: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 08:54:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UycgL-0003xn-7X
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 08:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120Ab3GOGyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 02:54:44 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36388 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3GOGyo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 02:54:44 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so23798871ief.26
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 23:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=eaJONzC+kkuxPezTzzJHw78rRBjUhAWnDqm8Tf1UbnE=;
        b=PqBPz5o3LP9jhmlS/RETMazIheeVDLElpsa3o8JedLovPcYfwYleHFu8qE0iwiwRZv
         nI/mGTezZp3uR3TB/NXmEA8kBRh49kDoLa1r6fzKSPcNnkuuKDEBFjsLcvkRQdU2Z4nO
         j5wUiCjtm9MuaPSnS8OBdTbnDAmFgJBV0DcvZVZTpYGEj86lDaxfsLiFe1b4aDSnqvPo
         rMfXBoyHZPZeQRWth+d8dVzPOQ+RNRBgBC9YtTj09LSeaQo5cnCt33+XS/HwN4AndYMX
         5Ynpc6QvoYfWajObtZyVgSnQ5jOqu3TaXCF2W/77q60MvE4oQqdAyCApcQR4qZFxR/WV
         Qbcw==
X-Received: by 10.43.133.70 with SMTP id hx6mr17314290icc.34.1373871283587;
        Sun, 14 Jul 2013 23:54:43 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id y9sm16781487iga.9.2013.07.14.23.54.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 23:54:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.804.g0da7a53
In-Reply-To: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230428>

The email addresses read from .mailmap are downcased before being
inserted into the mailmap data structure, which undesirably loses
information.  It is impossible, for instance, to map <first.last@host>
to <First.Last@host>. Demonstrate this problem.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4203-mailmap.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 8583724..ffe6a11 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -256,6 +256,15 @@ test_expect_success 'single-character name' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'preserve canonical email case' '
+	echo "     1	A U Thor <AUTHOR@example.com>" >expect &&
+	echo "     1	nick1 <bugs@company.xx>" >>expect &&
+	echo "<AUTHOR@example.com> <author@example.com>" >.mailmap &&
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
