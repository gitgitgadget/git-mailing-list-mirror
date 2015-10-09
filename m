From: James McCoy <vega.james@gmail.com>
Subject: [PATCH v2] filter-branch: remove multi-line headers in msg filter
Date: Thu, 8 Oct 2015 20:21:13 -0400
Message-ID: <20151009002113.GA329@freya.jamessan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 02:27:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkLWp-0004Wr-4R
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 02:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757572AbbJIA1O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Oct 2015 20:27:14 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33751 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758992AbbJIAVL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 20:21:11 -0400
Received: by qkas79 with SMTP id s79so26487633qka.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 17:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=5+0STthtAHmPwzY5c+Dq03Zq1BIOuP5rxB7DM8Tc7KM=;
        b=Nemc8I5K5+dvjc5UTtWkyjnJ4KSoJEDzNI75s3xSsSYWrsxrpkAP60Vy6nElUtCnsN
         iOrJdiS8Rkzvp8JwJ8CGLqLp4tySnuaR/vsOCrQcTnWevON90c8NokO39aG8ye5xF3kG
         4jAumeTb7A783TAgh40vjucqHm2uBJ6jyIFiPsdv8wBYt8aS1DMlCXMYTEmS+3GQMwmp
         BdAgT6/EK8FoYWarhhZCyPLlrQ7t9ayNZDXh8Bed89PJyg/0aMsjbQ+dw5Lq/xOJwhAt
         uZq2CUbH2F56w6jY1dumyHOFkQXxRaAhYlDTeSCa5M4qWpTy7lHFB3bvPSgOGm15R8yx
         2NBA==
X-Received: by 10.55.24.193 with SMTP id 62mr11829461qky.63.1444350070675;
        Thu, 08 Oct 2015 17:21:10 -0700 (PDT)
Received: from freya.jamessan.com (pool-71-162-119-45.bstnma.fios.verizon.net. [71.162.119.45])
        by smtp.gmail.com with ESMTPSA id f31sm17119928qkh.24.2015.10.08.17.21.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Oct 2015 17:21:10 -0700 (PDT)
Received: from jamessan by freya.jamessan.com with local (Exim 4.86)
	(envelope-from <vega.james@gmail.com>)
	id 1ZkLQv-00008E-HZ; Thu, 08 Oct 2015 20:21:13 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279280>

df062010 (filter-branch: avoid passing commit message through sed)
introduced a regression when filtering commits with multi-line headers,
if the header contains a blank line.  An example of this is a gpg-signe=
d
commit:

  $ git cat-file commit signed-commit
  tree 3d4038e029712da9fc59a72afbfcc90418451630
  parent 110eac945dc1713b27bdf49e74e5805db66971f0
  author A U Thor <author@example.com> 1112912413 -0700
  committer C O Mitter <committer@example.com> 1112912413 -0700
  gpgsig -----BEGIN PGP SIGNATURE-----
   Version: GnuPG v1

   iEYEABECAAYFAlYXADwACgkQE7b1Hs3eQw23CACgldB/InRyDgQwyiFyMMm3zFpj
   pUsAnA+f3aMUsd9mNroloSmlOgL6jIMO
   =3D0Hgm
   -----END PGP SIGNATURE-----

  Adding gpg

As a consequence, "filter-branch --msg-filter cat" (which should leave =
the
commit message unchanged) spills the signature (after the internal blan=
k
line) into the original commit message.

The reason is that although the signature is indented, making the line =
a
whitespace only line, the =E2=80=9Cread=E2=80=9D call is splitting the =
line based on
the shell's IFS, which defaults to <space><tab><newline>.  The leading
space is consumed and $header_line is empty, causing the =E2=80=9Cskip =
header
lines=E2=80=9D loop to exit.

The rest of the commit object is then re-used as the rewritten commit
message, causing the new message to include the signature of the
original commit.

Set IFS to an empty string for the =E2=80=9Cread=E2=80=9D call, thus di=
sabling the word
splitting, which causes $header_line to be set to the non-empty value '
'.  This allows the loop to fully consume the header lines before
emitting the original, intact commit message.

Signed-off-by: James McCoy <vega.james@gmail.com>
---
 git-filter-branch.sh     |  2 +-
 t/t7003-filter-branch.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 5b3f63d..fff8093 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -347,7 +347,7 @@ while read commit parents; do
 	fi
=20
 	{
-		while read -r header_line && test -n "$header_line"
+		while IFS=3D'' read -r header_line && test -n "$header_line"
 		do
 			# skip header lines...
 			:;
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
GPG Key: 4096R/331BA3DB 2011-12-05 James McCoy <jamessan@debian.org>
