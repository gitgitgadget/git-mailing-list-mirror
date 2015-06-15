From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 2/5] am: teach StGit patch parser how to read from stdin
Date: Mon, 15 Jun 2015 19:08:10 +0800
Message-ID: <1434366493-27155-3-git-send-email-pyokagan@gmail.com>
References: <1434366493-27155-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 13:08:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4SGA-0002jV-PV
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 13:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbbFOLIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 07:08:51 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35027 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbbFOLIs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 07:08:48 -0400
Received: by pdbnf5 with SMTP id nf5so70929484pdb.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 04:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1i38C+NU8yD39MoF7xfDVFlqoUzyhrdqhqiINO81Xhw=;
        b=YL6pzg6f60tl0UD4Q6gnFJ4FhhsQSa11+9yfeoKswlI0XLGMz/UfrASWyBX2ei5avG
         UDLVTbFq/Z1H6Dv0KjdF96QX1jt0VrkchsBDmPZT5PRW0XEjo8h/i2dRZE2InrqF95PW
         xACSc+2deJwbT62MLAXg8VKvZctyO+1HmvjrRwhKGajnkcnP327+rMtvQn1Bb9YFqdjR
         acCyJqDDOIxsYcjYGWcocwi5Rz4/Fa4XjQY+9alb+zO975g0KsmkM7TXKp2WRMsnZKjm
         98Vyb+wgz/kYmpj373iD/xarcBNgJWxr92uEbCfTh0f1vNbW0aDGuuiyHioK+KKeGetQ
         Sm+A==
X-Received: by 10.66.150.169 with SMTP id uj9mr46725830pab.125.1434366527753;
        Mon, 15 Jun 2015 04:08:47 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id jt2sm11886795pbc.21.2015.06.15.04.08.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Jun 2015 04:08:46 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434366493-27155-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271675>

git-mailsplit, which splits mbox patches, will read the patch from stdin
when the filename is "-" or there are no files listed on the
command-line.

To be consistent with this behavior, teach the StGit patch parser to
read from stdin if the filename is "-" or no files are listed on the
command-line.

Based-on-patch-by: Chris Packham <judge.packham@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v2
    
    * Just pass the filename directly to perl. Hmm, I think we should add a
      "--" in front so that filenames that start with a dash won't be
      interpreted as a command-line switch by perl?

 git-am.sh     |  3 ++-
 t/t4150-am.sh | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index 761befb..5ea2e4d 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -297,6 +297,7 @@ split_patches () {
 		;;
 	stgit)
 		this=0
+		test 0 -eq "$#" && set -- -
 		for stgit in "$@"
 		do
 			this=$(expr "$this" + 1)
@@ -318,7 +319,7 @@ split_patches () {
 					print "Subject: ", $_ ;
 					$subject = 1;
 				}
-			' < "$stgit" > "$dotest/$msgnum" || clean_abort
+			' -- "$stgit" >"$dotest/$msgnum" || clean_abort
 		done
 		echo "$this" > "$dotest/last"
 		this=
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 0ead529..51962e4 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -209,6 +209,16 @@ test_expect_success 'am applies stgit patch' '
 	test_cmp_rev second^ HEAD^
 '
 
+test_expect_success 'am --patch-format=stgit applies stgit patch' '
+	rm -fr .git/rebase-apply &&
+	git checkout -f first &&
+	git am --patch-format=stgit <patch1-stgit.eml &&
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
