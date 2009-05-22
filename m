From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t8005: use more portable character encoding names
Date: Fri, 22 May 2009 10:25:04 -0500
Message-ID: <WnZxv4G_GKTN4oHhxHO_HuQt0cTqurrqXf2HHDiHLAzdp7wC70aKuqDot7xQ1nG9C8_NASCL1_Q@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 22 17:25:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Wce-0001vb-E3
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 17:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756778AbZEVPZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 11:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756619AbZEVPZQ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 11:25:16 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34764 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756303AbZEVPZP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 11:25:15 -0400
Received: by mail.nrlssc.navy.mil id n4MFPDAI012151; Fri, 22 May 2009 10:25:14 -0500
X-OriginalArrivalTime: 22 May 2009 15:25:13.0185 (UTC) FILETIME=[8055CD10:01C9DAF1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119733>

Some platforms do not have an extensive list of alternate names for
character encodings.

On IRIX 6.5 cp1251 is unknown, but WIN1251 (which seems to be a
non-standard name) is known.  On Solaris 10, the opposite is true.  Solaris
also knows cp1251 as WINDOWS-1251, but this too is not recognized on IRIX.
I could not find a name that both platforms recognized for this character
set.

Solaris 7 does not know about shift-jis, but does know SJIS.  It also does
not know that utf-8 and UTF-8 refer to the same encoding.

With the above in mind, and the impression that upper-case code names are
more portable than lower-case, the following conversions were performed:

      utf-8 --> UTF-8
     cp1251 --> CP1251
  shift-jis --> SJIS

The UTF-8 and SJIS conversions allow 2 of the 3 elements of test 4 to succeed
on Solaris 7, but alas, my Solaris 7 does not have CP1251.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Here's another patch in an attempt to make the character encoding names
more portable.  I hesitate to send it since it does not actually allow any
tests to pass which were previously failing for me.  At least the utf-8 to
UTF-8 shouldn't cause any harm.  The shift-jis to SJIS seems to be commonly
supported?  at least IRIX 6.5 and Solaris as old as 7 recognize it, but the
evidence is only empirical.  Modern Solaris, and of course Linux recognize
either.

-brandon


 t/t8005-blame-i18n.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
index fcd5c26..9c930a5 100755
--- a/t/t8005-blame-i18n.sh
+++ b/t/t8005-blame-i18n.sh
@@ -15,12 +15,12 @@ test_expect_success 'setup the repository' '
 
 	echo "CP1251 LINE" >> file &&
 	git add file &&
-	git config i18n.commitencoding cp1251 &&
+	git config i18n.commitencoding CP1251 &&
 	git commit --author "$CP1251_NAME <cp1251@localhost>" -m "$CP1251_MSG" &&
 
 	echo "SJIS LINE" >> file &&
 	git add file &&
-	git config i18n.commitencoding shift-jis &&
+	git config i18n.commitencoding SJIS &&
 	git commit --author "$SJIS_NAME <sjis@localhost>" -m "$SJIS_MSG"
 '
 
@@ -51,7 +51,7 @@ EOF
 
 test_expect_success \
 	'blame respects i18n.logoutputencoding' '
-	git config i18n.logoutputencoding cp1251 &&
+	git config i18n.logoutputencoding CP1251 &&
 	git blame --incremental file | \
 		egrep "^(author|summary) " > actual &&
 	test_cmp actual expected
@@ -67,8 +67,8 @@ summary $UTF8_MSG
 EOF
 
 test_expect_success \
-	'blame respects --encoding=utf-8' '
-	git blame --incremental --encoding=utf-8 file | \
+	'blame respects --encoding=UTF-8' '
+	git blame --incremental --encoding=UTF-8 file | \
 		egrep "^(author|summary) " > actual &&
 	test_cmp actual expected
 '
-- 
1.6.3.1.24.g152f4
