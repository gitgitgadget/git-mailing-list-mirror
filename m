From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-archive and core.eol
Date: Sat, 08 Jan 2011 14:35:55 +0100
Message-ID: <4D28683B.4020400@lsrfire.ath.cx>
References: <AANLkTi=kfE88F7dY5F_xtbEuh9DyUcN+ymeXqLMWztGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>, eyvind.bernhardsen@gmail.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 08 14:36:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbYxr-00013H-NT
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 14:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547Ab1AHNgG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jan 2011 08:36:06 -0500
Received: from india601.server4you.de ([85.25.151.105]:41932 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab1AHNgF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 08:36:05 -0500
Received: from [10.0.1.100] (p4FFDA751.dip.t-dialin.net [79.253.167.81])
	by india601.server4you.de (Postfix) with ESMTPSA id CA0B52F8003;
	Sat,  8 Jan 2011 14:36:01 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Newsgroups: gmane.comp.version-control.git,gmane.comp.version-control.msysgit
In-Reply-To: <AANLkTi=kfE88F7dY5F_xtbEuh9DyUcN+ymeXqLMWztGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164820>

Am 15.12.2010 23:32, schrieb Erik Faye-Lund:
> I recently tried the following on Windows:
>=20
> $ git init
> Initialized empty Git repository in c:/Users/kusma/test/.git/
> $ echo "foo
> bar" > test.txt
> $ git -c core.autocrlf=3Dtrue add test.txt
> warning: LF will be replaced by CRLF in test.txt.
> The file will have its original line endings in your working director=
y.
> $ git commit -m.
>  1 files changed, 2 insertions(+), 0 deletions(-)
>  create mode 100644 test.txt
> $ git -c core.autocrlf=3Dtrue -c core.eol=3Dlf archive --format=3Dtar=
 HEAD > test.tar
> $ tar xvf test.tar
> $ od -c test.txt
> 0000000   f   o   o  \r  \n   b   a   r  \r  \n
> 0000012
>=20
> Just to be sure, I checked this:
>=20
> $ git show HEAD:test.txt | od -c
> 0000000   f   o   o  \n   b   a   r  \n
> 0000010
>=20
> Yep, the file has LF in the repo, as expected... the warning from
> git-add is a bit confusing, but OK.
>=20
> Hmm, so git-archive writes CRLF even if I said I wanted LF. But then =
I
> tried this on Linux:
>=20
> $ git init
> Initialized empty Git repository in /home/kusma/src/test/.git/
> $ echo "foo
> bar" > test.txt
> $ git add test.txt
> $ git commit -m.
> [master (root-commit) c6f195e] .
>  1 files changed, 2 insertions(+), 0 deletions(-)
>  create mode 100644 test.txt
> $ git -c core.autocrlf=3Dtrue -c core.eol=3Dcrlf archive --format=3Dt=
ar HEAD
>> test.tar
> $ tar xvf test.tar
> test.txt
> $ od -c test.txt
> 0000000   f   o   o  \r  \n   b   a   r  \r  \n
> 0000012
>=20
> This leaves me a bit puzzled. On Linux, I can override the default
> new-line style CRLF for git-archive, but I can't override it to LF on
> Windows?
>=20
> I expected it to work because sha1_file_to_archive calls
> convert_to_working_tree. I've tried stepping through the code, but I
> don't quite understand where it goes wrong. Or even how the code is
> supposed to work :P
>=20
> Does anyone have any clue what's going on? I'm running with the
> current master, git version 1.7.3.3.585.g74f6e.

I can't seem to replicate this (1.7.4-rc1); see below for the test scri=
pt
I tried to come up with.  It should test all combinations of the releva=
nt
config variables and the text attribute.  I cheated by simply setting t=
he
expectations to match the results on Linux; I didn't check if these are
indeed the correct results.  The test passes for me on MinGW, too, thou=
gh.

Did I miss a variable or are some of the expectations wrong?

Thanks,
Ren=E9


 t/t5002-archive-eol.sh |   86 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/t/t5002-archive-eol.sh b/t/t5002-archive-eol.sh
new file mode 100755
index 0000000..50f80f7
--- /dev/null
+++ b/t/t5002-archive-eol.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+
+test_description=3D'git archive EOL tests'
+
+. ./test-lib.sh
+
+prepare() {
+	tfile=3D"autocrlf_$1-eol_$2.tar"
+	dir=3D"autocrlf_$1-eol_$2.d"
+	test_expect_success "archive with autocrlf=3D$1 eol=3D$2" "
+		git -c core.autocrlf=3D$1 -c core.eol=3D$2 archive HEAD >$tfile &&
+		(mkdir $dir && cd $dir && \"$TAR\" xf -) <$tfile
+	"
+}
+
+expect_success() {
+	file=3D"autocrlf_$2-eol_$3.d/autocrlf_$1/$4"
+	desc=3D"add autocrlf=3D$1, archive autocrlf=3D$2 eol=3D$3"
+	test_expect_success "$desc: $4 =3D> $5" "test_cmp $5 $file"
+}
+
+test_expect_success 'setup' '
+	printf "1\\n2\\n" >lf &&
+	printf "1\\r\\n2\\r\\n" >crlf &&
+
+	echo "*.txt text" >.gitattributes &&
+	git add .gitattributes &&
+
+	mkdir autocrlf_false &&
+	cp lf crlf autocrlf_false/ &&
+	cp lf autocrlf_false/lf.txt &&
+	cp crlf autocrlf_false/crlf.txt &&
+	git -c core.autocrlf=3Dfalse add autocrlf_false/ &&
+
+	mkdir autocrlf_true &&
+	cp lf crlf autocrlf_true/ &&
+	cp lf autocrlf_true/lf.txt &&
+	cp crlf autocrlf_true/crlf.txt &&
+	git -c core.autocrlf=3Dtrue add autocrlf_true/ &&
+
+	git commit -m.
+'
+
+#	core.autocrlf	core.eol
+prepare	false		crlf
+prepare	true		crlf
+prepare	false		lf
+prepare	true		lf
+
+#		core.autocrlf	core.eol	original	expect
+#		(add)	(archive)
+expect_success	false	false	crlf		crlf		crlf
+expect_success	false	false	crlf		lf		lf
+expect_success	false	false	lf		crlf		crlf
+expect_success	false	false	lf		lf		lf
+expect_success	false	true	crlf		crlf		crlf
+expect_success	false	true	crlf		lf		crlf
+expect_success	false	true	lf		crlf		crlf
+expect_success	false	true	lf		lf		crlf
+expect_success	true	false	crlf		crlf		lf
+expect_success	true	false	crlf		lf		lf
+expect_success	true	false	lf		crlf		lf
+expect_success	true	false	lf		lf		lf
+expect_success	true	true	crlf		crlf		crlf
+expect_success	true	true	crlf		lf		crlf
+expect_success	true	true	lf		crlf		crlf
+expect_success	true	true	lf		lf		crlf
+
+expect_success	false	false	crlf		crlf.txt	crlf
+expect_success	false	false	crlf		lf.txt		crlf
+expect_success	false	false	lf		crlf.txt	lf
+expect_success	false	false	lf		lf.txt		lf
+expect_success	false	true	crlf		crlf.txt	crlf
+expect_success	false	true	crlf		lf.txt		crlf
+expect_success	false	true	lf		crlf.txt	crlf
+expect_success	false	true	lf		lf.txt		crlf
+expect_success	true	false	crlf		crlf.txt	crlf
+expect_success	true	false	crlf		lf.txt		crlf
+expect_success	true	false	lf		crlf.txt	lf
+expect_success	true	false	lf		lf.txt		lf
+expect_success	true	true	crlf		crlf.txt	crlf
+expect_success	true	true	crlf		lf.txt		crlf
+expect_success	true	true	lf		crlf.txt	crlf
+expect_success	true	true	lf		lf.txt		crlf
+
+test_done
