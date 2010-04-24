From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] tests for request-pull
Date: Sat, 24 Apr 2010 07:11:51 -0500
Message-ID: <20100424121151.GA12312@progeny.tock>
References: <20100424120437.GA12237@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 24 14:11:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5eCk-00053E-OK
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 14:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023Ab0DXMLV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 08:11:21 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44637 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab0DXMLT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 08:11:19 -0400
Received: by gyg13 with SMTP id 13so5552240gyg.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 05:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=aXSCagLzShGx7AcwTFKy7RO0O/h+LZV9u+Xw2tTzuzI=;
        b=DQhQQnTmu7w4NI6r4EK+Zop7WExbqWLcHm7FCouiZ/Lp7Ni91f383qAnaq8+NaRTbz
         /8Pkd885grT4RHVuSrF/NEEIo5TaD2wXM7SVQzRRGVy+FZhEuLFYuYuV9WRZ9OyeYFA7
         CjMtK2sqiB2bkNo2cEESkTp3vcGMl+DuhFKuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tzs0JNkXxpkHwDlNqJ1CG6YaGI4eEpktyBG64fRbLRa6ttJsLg1pN6bonjcsmDDN61
         /CrhGEGTFoFs7H/ZJj/E24VuJrfdgZWPxbrZce6dVUDMs7yGQ7eHfuSLa3eedIEJZl5y
         q4eY57wsfsmmXdULNzAjuiKRwd0rqiaVzkBG4=
Received: by 10.101.144.27 with SMTP id w27mr1622084ann.197.1272111079094;
        Sat, 24 Apr 2010 05:11:19 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm1459422iwn.9.2010.04.24.05.11.18
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 05:11:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100424120437.GA12237@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145669>

Test that request-pull handles failure to push cleanly, writes
pull requests that produce the correct effect when followed, and
uses a predictable format.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t5150-request-pull.sh |  214 +++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 214 insertions(+), 0 deletions(-)
 create mode 100644 t/t5150-request-pull.sh

diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
new file mode 100644
index 0000000..e012a36
--- /dev/null
+++ b/t/t5150-request-pull.sh
@@ -0,0 +1,214 @@
+#!/bin/sh
+
+test_description=3D'Test workflows involving pull request.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	git init --bare upstream.git &&
+	git init --bare downstream.git &&
+	git clone upstream.git upstream-private &&
+	git clone downstream.git local &&
+
+	trash_url=3D"file://$TRASH_DIRECTORY" &&
+	downstream_url=3D"$trash_url/downstream.git/" &&
+	upstream_url=3D"$trash_url/upstream.git/" &&
+
+	(
+		cd upstream-private &&
+		cat <<-\EOT >mnemonic.txt &&
+		Thirtey days hath November,
+		Aprile, June, and September:
+		EOT
+		git add mnemonic.txt &&
+		test_tick &&
+		git commit -m "\"Thirty days\", a reminder of month lengths" &&
+		git tag -m "version 1" -a initial &&
+		git push --tags origin master
+	) &&
+	(
+		cd local &&
+		git remote add upstream "$trash_url/upstream.git" &&
+		git fetch upstream &&
+		git pull upstream master &&
+		cat <<-\EOT >>mnemonic.txt &&
+		Of twyecescore-eightt is but eine,
+		And all the remnante be thrycescore-eine.
+		O=E2=80=99course Leap yare comes an=E2=80=99pynes,
+		Ev=E2=80=99rie foure yares, gote it ryghth.
+		An=E2=80=99twyecescore-eight is but twyecescore-nyne.
+		EOT
+		git add mnemonic.txt &&
+		test_tick &&
+		git commit -m "More detail" &&
+		git tag -m "version 2" -a full &&
+		git checkout -b simplify HEAD^ &&
+		mv mnemonic.txt mnemonic.standard &&
+		cat <<-\EOT >mnemonic.clarified &&
+		Thirty days has September,
+		All the rest I can=E2=80=99t remember.
+		EOT
+		git add -N mnemonic.standard mnemonic.clarified &&
+		git commit -a -m "Adapt to use modern, simpler English
+
+But keep the old version, too, in case some people prefer it." &&
+		git checkout master
+	)
+
+'
+
+test_expect_success 'setup: two scripts for reading pull requests' '
+
+	downstream_url_for_sed=3D$(
+		printf "%s\n" "$downstream_url" |
+		sed -e '\''s/\\/\\\\/g'\'' -e '\''s/[[/.*^$]/\\&/g'\''
+	) &&
+
+	cat <<-\EOT >read-request.sed &&
+	#!/bin/sed -nf
+	/ in the git repository at:$/! d
+	n
+	/^$/! q
+	n
+	s/^[ 	]*\(.*\) \([^ ]*\)/please pull\
+	\1\
+	\2/p
+	q
+	EOT
+
+	cat <<-EOT >fuzz.sed
+	#!/bin/sed -nf
+	s/$_x40/OBJECT_NAME/g
+	s/A U Thor/AUTHOR/g
+	s/        [^ ].*/        SUBJECT/g
+	s/$downstream_url_for_sed/URL/g
+	s/for-upstream/BRANCH/g
+	s/mnemonic.txt/FILENAME/g
+	/^ FILENAME | *[0-9]* [-+]*\$/ b diffstat
+	/^AUTHOR ([0-9]*):\$/ b shortlog
+	p
+	b
+	: diffstat
+	n
+	/ [0-9]* files changed/ {
+		a\
+	DIFFSTAT
+		b
+	}
+	b diffstat
+	: shortlog
+	/^        [a-zA-Z]/ n
+	/^[a-zA-Z]* ([0-9]*):\$/ n
+	/^\$/ N
+	/^\n[a-zA-Z]* ([0-9]*):\$/! {
+		a\
+	SHORTLOG
+		D
+	}
+	n
+	b shortlog
+	EOT
+
+'
+
+test_expect_success 'pull request when forgot to push' '
+
+	rm -fr downstream.git &&
+	git init --bare downstream.git &&
+	(
+		cd local &&
+		git checkout initial &&
+		git merge --ff-only master &&
+		test_must_fail git request-pull initial "$downstream_url" \
+			2>../err
+	) &&
+	grep "No branch of.*is at:\$" err &&
+	grep "Are you sure you pushed" err
+
+'
+
+test_expect_success 'pull request after push' '
+
+	rm -fr downstream.git &&
+	git init --bare downstream.git &&
+	(
+		cd local &&
+		git checkout initial &&
+		git merge --ff-only master &&
+		git push origin master:for-upstream &&
+		git request-pull initial origin >../request
+	) &&
+	sed -nf read-request.sed <request >digest &&
+	cat digest &&
+	{
+		read task &&
+		read repository &&
+		read branch
+	} <digest &&
+	(
+		cd upstream-private &&
+		git checkout initial &&
+		git pull --ff-only "$repository" "$branch"
+	) &&
+	test "$branch" =3D for-upstream &&
+	test_cmp local/mnemonic.txt upstream-private/mnemonic.txt
+
+'
+
+test_expect_success 'request names an appropriate branch' '
+
+	rm -fr downstream.git &&
+	git init --bare downstream.git &&
+	(
+		cd local &&
+		git checkout initial &&
+		git merge --ff-only master &&
+		git push --tags origin master simplify &&
+		git push origin master:for-upstream &&
+		git request-pull initial "$downstream_url" >../request
+	) &&
+	sed -nf read-request.sed <request >digest &&
+	cat digest &&
+	{
+		read task &&
+		read repository &&
+		read branch
+	} <digest &&
+	{
+		test "$branch" =3D master ||
+		test "$branch" =3D for-upstream
+	}
+
+'
+
+test_expect_success 'pull request format' '
+
+	rm -fr downstream.git &&
+	git init --bare downstream.git &&
+	cat <<-\EOT >expect &&
+	The following changes since commit OBJECT_NAME:
+	  AUTHOR (1):
+	        SUBJECT
+
+	are available in the git repository at:
+
+	  URL BRANCH
+
+	SHORTLOG
+
+	DIFFSTAT
+	EOT
+	(
+		cd local &&
+		git checkout initial &&
+		git merge --ff-only master &&
+		git push origin master:for-upstream &&
+		git request-pull initial "$downstream_url" >../request
+	) &&
+	<request sed -nf fuzz.sed >request.fuzzy &&
+	test_cmp expect request.fuzzy
+
+'
+
+test_done
--=20
1.7.1.rc1
