From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] t9302: Protect against OS X normalization
Date: Mon,  8 Feb 2010 23:07:25 -0500
Message-ID: <1265688445-46137-1-git-send-email-brian@gernhardtsoftware.com>
References: <7vfx5bt6nn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 05:07:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NehNu-0005cw-VA
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 05:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab0BIEH3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 23:07:29 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:50712 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab0BIEH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 23:07:29 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 2BB021FFC1CE; Tue,  9 Feb 2010 04:07:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-67-240-172-169.rochester.res.rr.com [67.240.172.169])
	by silverinsanity.com (Postfix) with ESMTPA id C20FE1FFC146;
	Tue,  9 Feb 2010 04:07:16 +0000 (UTC)
X-Mailer: git-send-email 1.7.0.rc1.49.gd2d66
In-Reply-To: <7vfx5bt6nn.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vfx5bt6nn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139360>

8424981: "Fix invalid read in quote_c_style_counted" introduced a test
that used "caract=C3=A8re sp=C3=A9cial" as a directory name.

Git creates it as "caract\303\250re sp\303\251cial"
OS X stores it as "caracte\314\200re spe\314\201cial"

To work around this problem, use the already introduced $FN as the
directory name.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---

 Junio C Hamano wrote:
 > How about using $FN as the directory name instead?

 I knew there was a clever answer I was missing.

 t/t3902-quoted.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index 14da45f..29103f6 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -25,7 +25,7 @@ for_each_name () {
 	for name in \
 	    Name "Name and a${LF}LF" "Name and an${HT}HT" "Name${DQ}" \
 	    "$FN$HT$GN" "$FN$LF$GN" "$FN $GN" "$FN$GN" "$FN$DQ$GN" \
-	    "With SP in it" "caract=C3=A8re sp=C3=A9cial/file"
+	    "With SP in it" "$FN/file"
 	do
 		eval "$1"
 	done
@@ -33,7 +33,7 @@ for_each_name () {
=20
 test_expect_success setup '
=20
-	mkdir "caract=C3=A8re sp=C3=A9cial" &&
+	mkdir "$FN" &&
 	for_each_name "echo initial >\"\$name\""
 	git add . &&
 	git commit -q -m Initial &&
@@ -51,11 +51,11 @@ Name
 "Name and an\tHT"
 "Name\""
 With SP in it
-"caract\303\250re sp\303\251cial/file"
 "\346\277\261\351\207\216\t\347\264\224"
 "\346\277\261\351\207\216\n\347\264\224"
 "\346\277\261\351\207\216 \347\264\224"
 "\346\277\261\351\207\216\"\347\264\224"
+"\346\277\261\351\207\216/file"
 "\346\277\261\351\207\216\347\264\224"
 EOF
=20
@@ -65,11 +65,11 @@ Name
 "Name and an\tHT"
 "Name\""
 With SP in it
-caract=C3=A8re sp=C3=A9cial/file
 "=E6=BF=B1=E9=87=8E\t=E7=B4=94"
 "=E6=BF=B1=E9=87=8E\n=E7=B4=94"
 =E6=BF=B1=E9=87=8E =E7=B4=94
 "=E6=BF=B1=E9=87=8E\"=E7=B4=94"
+=E6=BF=B1=E9=87=8E/file
 =E6=BF=B1=E9=87=8E=E7=B4=94
 EOF
=20
--=20
1.7.0.rc1.49.gd2d66
