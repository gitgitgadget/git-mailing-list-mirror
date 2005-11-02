From: Alex Riesen <raa.lkml@gmail.com>
Subject: remove CR/LF from .gitignore
Date: Wed, 2 Nov 2005 14:05:45 +0100
Message-ID: <81b0412b0511020505u1b6b7649l924e252d561b8e9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2433_4094156.1130936745547"
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Nov 02 14:11:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXIJk-000100-4r
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 14:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbVKBNFs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 08:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbVKBNFs
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 08:05:48 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:54938 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932681AbVKBNFr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 08:05:47 -0500
Received: by nproxy.gmail.com with SMTP id q29so29163nfc
        for <git@vger.kernel.org>; Wed, 02 Nov 2005 05:05:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=LCBqmkTIbKy5jh/HGtHcVCsUWbmCsgQ/1/syhgp3cxmBcYn5ZvqzUX1F1uiCvF62xyiQ5BLdyHbzfp71jIP4NbFlebuq0rCtZ1jJBzhg8aFoK+mDPTfQ7kv9T94AOKYIlbeiGAyIMQKMDQfWPTMJZjOpqMzmTra6mwR/m9isGxk=
Received: by 10.48.80.4 with SMTP id d4mr478534nfb;
        Wed, 02 Nov 2005 05:05:46 -0800 (PST)
Received: by 10.48.49.13 with HTTP; Wed, 2 Nov 2005 05:05:45 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11024>

------=_Part_2433_4094156.1130936745547
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

For everyone cursed by dos/windows line endings (aka CRLF):

The code reading the .gitignore files (excludes and excludes per
directory) leaves \r in the patterns, which causes fnmatch to fail for
no obvious reason. Just remove a "\r" preceding a "\n"
unconditionally.

---

Junio, sorry for attachments. Have no other way to it on gmail here at
work. The other patch is just the test.

------=_Part_2433_4094156.1130936745547
Content-Type: application/xxxxx; name=msdos-excludes.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="msdos-excludes.patch"

diff --git a/ls-files.c b/ls-files.c
index 6b95214..b22ae2e 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -97,7 +97,7 @@ static int add_excludes_from_file_1(cons
 	for (i = 0; i < size; i++) {
 		if (buf[i] == '\n') {
 			if (entry != buf + i && entry[0] != '#') {
-				buf[i] = 0;
+				buf[i - (i && buf[i-1] == '\r')] = 0;
 				add_exclude(entry, base, baselen, which);
 			}
 			entry = buf + i + 1;

------=_Part_2433_4094156.1130936745547
Content-Type: application/xxxxx; name=msdos-excludes-test.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="msdos-excludes-test.patch"

diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 5beaaa3..fde2bb2 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -67,4 +67,16 @@ test_expect_success \
        >output &&
      diff -u expect output'
 
+# Test \r\n (MSDOS-like systems)
+echo -ne '*.1\r\n/*.3\r\n!*.6\r\n' >.gitignore
+
+test_expect_success \
+    'git-ls-files --others with \r\n line endings.' \
+    'git-ls-files --others \
+       --exclude=\*.6 \
+       --exclude-per-directory=.gitignore \
+       --exclude-from=.git/ignore \
+       >output &&
+     diff -u expect output'
+
 test_done

------=_Part_2433_4094156.1130936745547--
