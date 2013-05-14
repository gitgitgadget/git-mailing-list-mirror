From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 35/47] remote-hg: add test for failed double push
Date: Mon, 13 May 2013 23:36:58 -0500
Message-ID: <1368506230-19614-36-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:41:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc733-000504-4f
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047Ab3ENElA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:41:00 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:57698 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab3ENEkf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:40:35 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so93694obc.40
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=888N7uAU15NGomCcZ23RK3/01d+HawTKhayaAPRHBeE=;
        b=ipOJJr4mLVDIgQrFzHcoZXTiikHYeOdV+tv5DLPl3Ph6F3kIzAz9yFkcoxhmGbM6u8
         tXpdwIE05H6xAb2k+0uG5iUZddy3PdZA46TXArFbbvNXMSC5bDSTjAuZY0w+7SHSYxcq
         sNL2QZDe36Vh3LuxcevylYw5dVrsJ7FRMML0koqTclQKK30ydE8X03mw2n5hhCoJvf/c
         D87/8huBBz8oNDByKVemH72tUlbXFcRdfan3qNFQu3DGGqHzNd64R/XIgnlvwfW/xwur
         JPWus7XTxoEKRpWB6/ayCvnVH9nTV6YJsVAXFX+NGjpJ8yIEF4gXzveQbK4fn8OawDLO
         jUJQ==
X-Received: by 10.60.47.111 with SMTP id c15mr15331553oen.127.1368506434547;
        Mon, 13 May 2013 21:40:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id p9sm20480287oeq.7.2013.05.13.21.40.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:40:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224273>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index d98c7a7..9d62e26 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -426,4 +426,28 @@ test_expect_failure 'remote big push' '
 	check_bookmark hgrepo new_bmark ''
 '
 
+test_expect_failure 'remote double failed push' '
+	test_when_finished "rm -rf hgrepo gitrepo*" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo zero > content &&
+	hg add content &&
+	hg commit -m zero &&
+	echo one > content &&
+	hg commit -m one
+	) &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git reset --hard HEAD^ &&
+	echo two > content &&
+	git commit -a -m two &&
+	test_expect_code 1 git push &&
+	test_expect_code 1 git push
+	)
+'
+
 test_done
-- 
1.8.3.rc1.579.g184e698
