From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH] Add failing test: "fsck survives inflate errors"
Date: Sun, 20 Jul 2014 00:43:03 -0400
Message-ID: <1405831383-22477-1-git-send-email-naesten@gmail.com>
Cc: Samuel Bronson <naesten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 06:45:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8j0H-00053o-Nd
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 06:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbaGTEo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2014 00:44:58 -0400
Received: from mail-qa0-f45.google.com ([209.85.216.45]:33510 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbaGTEo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 00:44:58 -0400
Received: by mail-qa0-f45.google.com with SMTP id cm18so4086224qab.4
        for <git@vger.kernel.org>; Sat, 19 Jul 2014 21:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=S9KKNyseieOCUXApNsrg4NHcxcBbqNfTBF+7mmYZMzA=;
        b=JLiahbtMojC6UHNizc8sZlWVh6vqx69n0khuVBZR5SRn+cuYuV1xtiZgCw9v7g9XKs
         Q1ChRGXfPrNy/JH4XjoDET4Yr7KKblrlz1L0DDuodC48V7rdOdcMFTCUawmjcWZflj3C
         Lklp5oN4vryk1K4+0w9XLFQEzm8iR/oC9YkXFOiJocmkdO/m3vgBLlt2W9RwlVrvb9Fv
         B4RRfjP/Wb91xdo73knMrdGm2J35HOjEY9juHFKu/nZlqJVQCmdr38nW6U/A8D9eydjq
         2pGMsP+WbdK+/vwFJK/moTm6OotF+z1VHyXJtS+ez899bkEYcysJiKK1EFinMQ0VRR1p
         w6xA==
X-Received: by 10.229.53.133 with SMTP id m5mr25361879qcg.19.1405831497276;
        Sat, 19 Jul 2014 21:44:57 -0700 (PDT)
Received: from hydrogen (naesten-pt.tunnel.tserv4.nyc4.ipv6.he.net. [2001:470:1f06:57::2])
        by mx.google.com with ESMTPSA id k7sm18688600qas.24.2014.07.19.21.44.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 19 Jul 2014 21:44:55 -0700 (PDT)
Received: from naesten by hydrogen with local (Exim 4.82)
	(envelope-from <naesten@gmail.com>)
	id 1X8izU-0005rm-6l; Sun, 20 Jul 2014 00:44:52 -0400
X-Mailer: git-send-email 2.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253910>

While inflate errors are obviously NOT GOOD, and should perhaps be
fatal for most commands, git fsck is something of a special case
because it is useful to have *it* report as many corrupt objects as
possible in one run.

Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 t/t1450-fsck.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 8c739c9..6dcc4b2 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -53,6 +53,23 @@ test_expect_success 'setup: helpers for corruption tests' '
 	}
 '
 
+# git fsck should be able to detect more than one corrupt object per run
+test_expect_failure 'fsck survives inflate errors' '
+	hash1=ffffffffffffffffffffffffffffffffffffffff &&
+	hash2=fffffffffffffffffffffffffffffffffffffffe &&
+	mkdir -p .git/objects/ff &&
+	echo not-zlib >$(sha1_file $hash1) &&
+	test_when_finished "remove_object $hash1" &&
+	echo not-zlib >$(sha1_file $hash2) &&
+	test_when_finished "remove_object $hash2" &&
+
+	# Return value is not documented
+	test_might_fail git fsck 2>out &&
+	cat out && echo ====== &&
+	grep "$hash1.*corrupt" out &&
+	grep "$hash2.*corrupt" out
+'
+
 test_expect_success 'object with bad sha1' '
 	sha=$(echo blob | git hash-object -w --stdin) &&
 	old=$(echo $sha | sed "s+^..+&/+") &&
-- 
2.0.1
