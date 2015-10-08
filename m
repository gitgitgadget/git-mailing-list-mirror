From: James McCoy <vega.james@gmail.com>
Subject: [PATCH] filter-branch: strip pgp signature in commit messages
Date: Thu, 8 Oct 2015 01:01:22 -0400
Message-ID: <20151008050122.GA21369@freya.jamessan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 07:01:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk3Kh-0008WV-NJ
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 07:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbbJHFBV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Oct 2015 01:01:21 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36344 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbbJHFBU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 01:01:20 -0400
Received: by qgx61 with SMTP id 61so33236237qgx.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 22:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=pPbzO4h7WoBI+BCPsM8HVlAE4TmiP8tNRN9kbTVfrS0=;
        b=NEx8UFkwwjg6YKccEH65q5z4xJyBnB9fqHsDahzjjeLcETOfM4UYZMzJhxWjsRZX16
         oEKob4AFzks3GdMMQqgFuoUGJdWoegpRyMpcdtaDSeSyblAQSXiXP/9BKPTfukyGm9IE
         0Ho/N2uv2GpTjkuMBrEshh0pHVtp+FHpvVk2qsvjsAaDrWo7xUYgd1YqHXUS8tDgVaO/
         GLDb7l3jLb/3jez6cZkoD0BusLML7lTXntjSNer+STMI5Wa4dXuI781t/NdHqemzQDHS
         Zwm8HcdGACHyHudehIwcO6JHCd4LYkuyJPBPhuCZtZv0Xo8wPGI/9WYZCggFWpaxfSsq
         Oc3g==
X-Received: by 10.140.147.146 with SMTP id 140mr6305883qht.68.1444280479679;
        Wed, 07 Oct 2015 22:01:19 -0700 (PDT)
Received: from freya.jamessan.com (pool-71-162-119-45.bstnma.fios.verizon.net. [71.162.119.45])
        by smtp.gmail.com with ESMTPSA id f61sm17882498qga.44.2015.10.07.22.01.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2015 22:01:18 -0700 (PDT)
Received: from jamessan by freya.jamessan.com with local (Exim 4.86)
	(envelope-from <vega.james@gmail.com>)
	id 1Zk3KU-0003aU-Hk; Thu, 08 Oct 2015 01:01:22 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279216>

df062010 (filter-branch: avoid passing commit message through sed)
introduced a regression when filtering gpg signed commits.  The gpgsig
header is multi-line and contains an empty line.  Although the signatur=
e
is indented, making the line a whitespace only line, this still results
in $header_line being empty, causing the =E2=80=9Cskip header lines=E2=80=
=9D loop to
exit.

The rest of the commit object is then re-used as the rewritten commit
message, causing the new message to include the signature of the
original commit.

Signed-off-by: James McCoy <vega.james@gmail.com>
---
 git-filter-branch.sh     | 14 +++++++++++---
 t/t7003-filter-branch.sh | 14 ++++++++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 5b3f63d..dd49b13 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -347,10 +347,18 @@ while read commit parents; do
 	fi
=20
 	{
-		while read -r header_line && test -n "$header_line"
+		while read -r header_line &&
+			( test -n "$header_line" || test -n "$gpg_signature" )
 		do
-			# skip header lines...
-			:;
+			# skip header lines... but track whether we are in a
+			# PGP signature, since it will have a whitespace only
+			# line which causes $header_line to be empty
+			if [ "${header_line#gpgsig}" !=3D "$header_line" ]; then
+				gpg_signature=3D1
+			elif test -n "$gpg_signature" &&
+				expr "$header_line" : ".*END PGP" >/dev/null; then
+				gpg_signature=3D
+			fi
 		done
 		# and output the actual commit message
 		cat
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 855afda..377c648 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git filter-branch'
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
=20
 test_expect_success 'setup' '
 	test_commit A &&
@@ -292,6 +293,19 @@ test_expect_success 'Tag name filtering strips gpg=
 signature' '
 	test_cmp expect actual
 '
=20
+test_expect_success GPG 'Filtering retains message of gpg signed commi=
t' '
+	mkdir gpg &&
+	touch gpg/foo &&
+	git add gpg &&
+	test_tick &&
+	git commit -S -m "Adding gpg" &&
+
+	git log -1 --format=3D"%s" > expect &&
+	git filter-branch -f --msg-filter "cat" &&
+	git log -1 --format=3D"%s" > actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'Tag name filtering allows slashes in tag names' '
 	git tag -m tag-with-slash X/1 &&
 	git cat-file tag X/1 | sed -e s,X/1,X/2, > expect &&
--=20
2.6.1


--=20
James
GPG Key: 4096R/331BA3DB 2011-12-05 James McCoy <vega.james@gmail.com>
