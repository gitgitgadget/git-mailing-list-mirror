From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 1/2] t5524: test --log=1 limits shortlog length
Date: Wed, 13 May 2015 17:17:40 +0800
Message-ID: <1431508661-21729-2-git-send-email-pyokagan@gmail.com>
References: <1431508661-21729-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:18:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsSnx-0006yM-Mp
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933343AbbEMJSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:18:11 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32807 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933291AbbEMJSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:18:09 -0400
Received: by pacwv17 with SMTP id wv17so44829354pac.0
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GTkrpwUf7M8NqaJDS8GPL8oHDB/JagtqwfsKilHS2NY=;
        b=R6W6oypEq0Olq2c/rBleLOYZ9Zjcg4W1oeTIHWGwfGi8AMiLTLHDo2NVmllI6RduEh
         GY9JvxgUa5SZBrggpLRPLvd4EskSKY5LVdzKK78iu3G2sqvTEighPkKDE9a+MAt82nR6
         VgP2E9DNQlYIfXNhPQ0C4fnyw1zYNLM08YZaS+sCPrkksS8A4jO5jNbu1lAWcz0eul9E
         XazI1LMxEhGCeCyC7uT2iij6JvwQ5f0adP9XaeHsBKM3gne3QM7gkFuK32Ix5uaejpCf
         Vnjm08IHMNaGwoFlKWrR0r55hNTej/vFNtTEl1cYj+uJstmaprXMyBk0T8TjwR0lLD6l
         3d2w==
X-Received: by 10.67.3.3 with SMTP id bs3mr35573949pad.51.1431508688075;
        Wed, 13 May 2015 02:18:08 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kh6sm18632898pbc.50.2015.05.13.02.18.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 02:18:06 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431508661-21729-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268962>

Since efb779f (merge, pull: add '--(no-)log' command line option,
2008-04-06) git-pull supported the (--no-)log switch and would pass it
to git-merge.

96e9420 (merge: Make '--log' an integer option for number of shortlog
entries, 2010-09-08) implemented support for the --log=<n> switch, which
would explicitly set the number of shortlog entries. However, git-pull
does not recognize this option, and will instead pass it to git-fetch,
leading to "unknown option" errors.

Implement a failing test that demonstrates this.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t5524-pull-msg.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
index 8cccecc..593405d 100755
--- a/t/t5524-pull-msg.sh
+++ b/t/t5524-pull-msg.sh
@@ -17,6 +17,9 @@ test_expect_success setup '
 		git commit -m "add bfile"
 	) &&
 	test_tick && test_tick &&
+	echo "second" >afile &&
+	git add afile &&
+	git commit -m "second commit" &&
 	echo "original $dollar" >afile &&
 	git add afile &&
 	git commit -m "do not clobber $dollar signs"
@@ -32,4 +35,18 @@ test_expect_success pull '
 )
 '
 
+test_expect_failure '--log=1 limits shortlog length' '
+(
+	cd cloned &&
+	git reset --hard HEAD^ &&
+	verbose test "$(cat afile)" = original &&
+	verbose test "$(cat bfile)" = added &&
+	git pull --log=1 &&
+	git log -3 &&
+	git cat-file commit HEAD >result &&
+	verbose grep Dollar result &&
+	verbose grep -v "second commit" result
+)
+'
+
 test_done
-- 
2.1.4
