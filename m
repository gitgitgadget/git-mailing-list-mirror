From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 5/5] am: teach mercurial patch parser how to read from stdin
Date: Mon,  8 Jun 2015 23:48:51 +0800
Message-ID: <1433778531-18260-6-git-send-email-pyokagan@gmail.com>
References: <1433778531-18260-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Chris Packham <judge.packham@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 17:50:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1zJs-0001R1-Cn
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 17:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbbFHPuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 11:50:16 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35449 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbbFHPuG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 11:50:06 -0400
Received: by pdbnf5 with SMTP id nf5so107716187pdb.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oh+5ILjfUVaFkutA3NubrYbpYBuJWN69auDR+ah8RQo=;
        b=fwbLxWuFHzjrG4Ta/9lw/Y0kfRnNAJAowDWzYuY4sjnH/pgAZlHtJFaJQcG2Mh9cNt
         1PRXzuIpFRE+ZY/E3xYbAVjUVPIyJBj3Kwu0VHAcyr2d4xa1XepC4cU5c+VV4dkxBHHr
         jZ8GSKSfn3wK6L6uRhOgs9ChjkpHyO8j5pBsSrL2+zRv2LSh0pSjhAglZKkBZ9u2+dJY
         Ll+Ip8mw22fXfOmx53F0RwiEAQdJTean8uzeHGbramfKQpvSzGJnDYTRxZazwUf/tHX/
         p/69tl4p7Y5fuZvat7OOJDwXnmU7v68eacfJwGfG5kgAk3x9AUlcy2r5R4x7J6t9yrMm
         wPmg==
X-Received: by 10.70.38.170 with SMTP id h10mr30432693pdk.20.1433778605378;
        Mon, 08 Jun 2015 08:50:05 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id vn7sm2998792pab.26.2015.06.08.08.50.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Jun 2015 08:50:04 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433778531-18260-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271058>

git-mailsplit, which splits mbox patches, will read the patch from stdin
when the filename is "-" or there are no files listed on the
command-line.

To be consistent with this behavior, teach the mercurial patch parser to
read from stdin if the filename is "-" or no files are listed on the
command-line.

Based-on-patch-by: Chris Packham <judge.packham@gmail.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-am.sh     |  4 +++-
 t/t4150-am.sh | 10 ++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index d97da85..0a40d46 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -327,6 +327,7 @@ split_patches () {
 		;;
 	hg)
 		this=0
+		test 0 -eq "$#" && set -- -
 		for hg in "$@"
 		do
 			this=$(( $this + 1 ))
@@ -338,6 +339,7 @@ split_patches () {
 			# Since we cannot guarantee that the commit message is in
 			# git-friendly format, we put no Subject: line and just consume
 			# all of the message as the body
+			cat "$hg" |
 			LANG=C LC_ALL=C @@PERL@@ -M'POSIX qw(strftime)' -ne 'BEGIN { $subject = 0 }
 				if ($subject) { print ; }
 				elsif (/^\# User /) { s/\# User/From:/ ; print ; }
@@ -353,7 +355,7 @@ split_patches () {
 					print "\n", $_ ;
 					$subject = 1;
 				}
-			' <"$hg" >"$dotest/$msgnum" || clean_abort
+			' >"$dotest/$msgnum" || clean_abort
 		done
 		echo "$this" >"$dotest/last"
 		this=
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 4beb4b3..3ebafd9 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -259,6 +259,16 @@ test_expect_success 'am applies hg patch' '
 	test_cmp_rev second^ HEAD^
 '
 
+test_expect_success 'am --patch-format=hg applies hg patch' '
+	rm -fr .git/rebase-apply &&
+	git checkout -f first &&
+	git am --patch-format=hg <patch1-hg.eml &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code second &&
+	test_cmp_rev second HEAD &&
+	test_cmp_rev second^ HEAD^
+'
+
 test_expect_success 'setup: new author and committer' '
 	GIT_AUTHOR_NAME="Another Thor" &&
 	GIT_AUTHOR_EMAIL="a.thor@example.com" &&
-- 
2.1.4
