From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] t4205: don't rely on en_US.UTF-8 locale existing
Date: Wed,  3 Jul 2013 21:18:08 +0100
Message-ID: <f607decdc65b86b1759438e375ddf77fd5b91042.1372882590.git.john@keeping.me.uk>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 03 22:18:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuTVV-0006lg-6R
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 22:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933282Ab3GCUSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 16:18:24 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:56220 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933202Ab3GCUSX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 16:18:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 8EAA7CDA5A9;
	Wed,  3 Jul 2013 21:18:22 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wLfB7tOSyhoo; Wed,  3 Jul 2013 21:18:22 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 6979ACDA5DD;
	Wed,  3 Jul 2013 21:18:21 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 5D20F161E4D4;
	Wed,  3 Jul 2013 21:18:21 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hG1ItzuhvwRe; Wed,  3 Jul 2013 21:18:20 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 4B32C161E040;
	Wed,  3 Jul 2013 21:18:13 +0100 (BST)
X-Mailer: git-send-email 1.8.3.1.747.g77f7d3a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229522>

My system doesn't have the en_US.UTF-8 locale (or plain en_US), which
causes t4205 to fail by counting bytes instead of UTF-8 codepoints.

Instead of using sed for this, use Perl which behaves predictably
whatever locale is in use.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
This patch is on top of 'as/log-output-encoding-in-user-format'.

 t/t4205-log-pretty-formats.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 3cfb744..5864f5b 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -20,9 +20,7 @@ commit_msg () {
 		# cut string, replace cut part with two dots
 		# $2 - chars count from the beginning of the string
 		# $3 - "trailing" chars
-		# LC_ALL is set to make `sed` interpret "." as a UTF-8 char not a byte
-		# as it does with C locale
-		msg=$(echo $msg | LC_ALL=en_US.UTF-8 sed -e "s/^\(.\{$2\}\)$3/\1../")
+		msg=$(echo $msg | "$PERL_PATH" -CIO -pe "s/^(.{$2})$3/\1../")
 	fi
 	echo $msg
 }
@@ -205,7 +203,7 @@ test_expect_success 'left alignment formatting with ltrunc' "
 ..sage two
 ..sage one
 add bar  Z
-$(commit_msg "" "0" ".\{11\}")
+$(commit_msg "" "0" ".{11}")
 EOF
 	test_cmp expected actual
 "
@@ -218,7 +216,7 @@ test_expect_success 'left alignment formatting with mtrunc' "
 mess.. two
 mess.. one
 add bar  Z
-$(commit_msg "" "4" ".\{11\}")
+$(commit_msg "" "4" ".{11}")
 EOF
 	test_cmp expected actual
 "
-- 
1.8.3.1.747.g77f7d3a
