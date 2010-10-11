From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH next] don't let mailmap provoke use of freed memory
Date: Mon, 11 Oct 2010 11:21:53 -0500
Message-ID: <20101011162153.GG25842@burratino>
References: <87tyksd9er.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Oct 11 18:25:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5LBh-0005Yc-IO
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 18:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275Ab0JKQZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 12:25:11 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53835 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568Ab0JKQZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 12:25:09 -0400
Received: by yxm8 with SMTP id 8so269578yxm.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Zq7pyqyRhSWzqN8PzVcpFiDdEhWPPAAnAnZIH0vRsDE=;
        b=wTjI0awLzkAK5DLMdCNzY9cfuWxr2Dq7UrkIw3z8W87SqzLiSAUJ2mFkYPwiI2FFXG
         VGrnuR/VVF3yy25nD0VF11VqxZe/OryqV+7mLEDEBvy+TmmdxR13K2pz1CQV9qH4I5nD
         kAcnM9lI8pXgvMEyv0Vsd7c2hwGNIyf1/QDZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bcML+Al6LR9agInpFnjdaUQMvhc65ram8sCrWzEog0BplMI0rFlymByaqKiK/5B2VU
         hyGOVOkBWL/70shdQwy16OzGMIUvm10v3ANeOeuh1oBfS52rSUjxV1K0KNa0cpZ+j1YQ
         b/Ab/rrfF1fcxPd3eDFCj9zbhjRZ2h46SWxXE=
Received: by 10.236.108.44 with SMTP id p32mr12168192yhg.12.1286814309372;
        Mon, 11 Oct 2010 09:25:09 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id x21sm4730775yhc.35.2010.10.11.09.25.08
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 09:25:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87tyksd9er.fsf@meyering.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158777>

Jim Meyering wrote:

> Signed-off-by: Jim Meyering <meyering@redhat.com>

Applies to maint, too --- confirmed with the tests below
(both fail before, pass after).

Thanks.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4203-mailmap.sh |   40 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 9a7d1b4..3c5188f 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -54,7 +54,7 @@ Repo Guy (1):
 
 EOF
 test_expect_success 'mailmap.file set' '
-	mkdir internal_mailmap &&
+	mkdir -p internal_mailmap &&
 	echo "Internal Guy <bugs@company.xx>" > internal_mailmap/.mailmap &&
 	git config mailmap.file internal_mailmap/.mailmap &&
 	git shortlog HEAD >actual &&
@@ -93,6 +93,40 @@ test_expect_success 'mailmap.file non-existant' '
 '
 
 cat >expect <<\EOF
+Internal Guy (1):
+      second
+
+Repo Guy (1):
+      initial
+
+EOF
+
+test_expect_success 'name entry after email entry' '
+	mkdir -p internal_mailmap &&
+	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap &&
+	echo "Internal Guy <bugs@company.xx>" >>internal_mailmap/.mailmap &&
+	git shortlog >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<\EOF
+Internal Guy (1):
+      second
+
+Repo Guy (1):
+      initial
+
+EOF
+
+test_expect_success 'name entry after email entry, case-insensitive' '
+	mkdir -p internal_mailmap &&
+	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap &&
+	echo "Internal Guy <BUGS@Company.xx>" >>internal_mailmap/.mailmap &&
+	git shortlog >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<\EOF
 A U Thor (1):
       initial
 
@@ -101,7 +135,7 @@ nick1 (1):
 
 EOF
 test_expect_success 'No mailmap files, but configured' '
-	rm .mailmap &&
+	rm -f .mailmap internal_mailmap/.mailmap &&
 	git shortlog HEAD >actual &&
 	test_cmp expect actual
 '
@@ -153,7 +187,7 @@ test_expect_success 'Shortlog output (complex mapping)' '
 	test_tick &&
 	git commit --author "CTO <cto@coompany.xx>" -m seventh &&
 
-	mkdir internal_mailmap &&
+	mkdir -p internal_mailmap &&
 	echo "Committed <committer@example.com>" > internal_mailmap/.mailmap &&
 	echo "<cto@company.xx>                       <cto@coompany.xx>" >> internal_mailmap/.mailmap &&
 	echo "Some Dude <some@dude.xx>         nick1 <bugs@company.xx>" >> internal_mailmap/.mailmap &&
-- 
1.7.2.3
