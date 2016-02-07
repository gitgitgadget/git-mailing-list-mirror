From: John Keeping <john@keeping.me.uk>
Subject: Test failures with GNU grep 2.23
Date: Sun, 7 Feb 2016 16:25:40 +0000
Message-ID: <20160207162540.GK29880@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 07 17:31:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSSF5-00080z-At
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 17:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450AbcBGQbO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2016 11:31:14 -0500
Received: from mta1-jackal.aluminati.org ([72.9.247.211]:36211 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754445AbcBGQbL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2016 11:31:11 -0500
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Feb 2016 11:31:11 EST
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id DA32ACDA555
	for <git@vger.kernel.org>; Sun,  7 Feb 2016 16:25:47 +0000 (GMT)
X-Quarantine-ID: <rQ6G1R4wwD9q>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rQ6G1R4wwD9q for <git@vger.kernel.org>;
	Sun,  7 Feb 2016 16:25:45 +0000 (GMT)
Received: from serenity.lan (griffin.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 33371CDA56C
	for <git@vger.kernel.org>; Sun,  7 Feb 2016 16:25:42 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285733>

It seems that binary file detection has changed in GNU grep 2.23 as a
result of commit 40ed879 (grep: fix bug with with invalid unibyte
sequence).

This causes a couple of test failures in t8005 and t9200 (the t9200 cas=
e
is less obvious so I'm only including t8005 here):

-- >8 --
$ ./t8005-blame-i18n.sh -v -i
[snip]
expecting success:=20
        git blame --incremental file | \
                egrep "^(author|summary) " > actual &&
        test_cmp actual expected

--- actual      2016-02-07 16:14:55.372510307 +0000
+++ expected    2016-02-07 16:14:55.359510341 +0000
@@ -1 +1,6 @@
-Binary file (standard input) matches
+author =EF=BF=BDR=EF=BF=BDc =EF=BF=BD=EF=BF=BD=EF=BF=BDY
+summary =EF=BF=BDu=EF=BF=BD=EF=BF=BD=EF=BF=BD[=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=CC=83e=EF=BF=BDX=EF=BF=BDg=EF=BF=BD=C5=82=EF=BF=BD=EF=BF=BDB
+author =EF=BF=BDR=EF=BF=BDc =EF=BF=BD=EF=BF=BD=EF=BF=BDY
+summary =EF=BF=BDu=EF=BF=BD=EF=BF=BD=EF=BF=BD[=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=CC=83e=EF=BF=BDX=EF=BF=BDg=EF=BF=BD=C5=82=EF=BF=BD=EF=BF=BDB
+author =EF=BF=BDR=EF=BF=BDc =EF=BF=BD=EF=BF=BD=EF=BF=BDY
+summary =EF=BF=BDu=EF=BF=BD=EF=BF=BD=EF=BF=BD[=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=CC=83e=EF=BF=BDX=EF=BF=BDg=EF=BF=BD=C5=82=EF=BF=BD=EF=BF=BDB
not ok 2 - blame respects i18n.commitencoding
#
#               git blame --incremental file | \
#                       egrep "^(author|summary) " > actual &&
#               test_cmp actual expected
#
-- 8< --

The following patch fixes the tests for me, but I wonder if "-a" is
supported on all target platforms (it's not in POSIX, which specifies
that the "input files shall be text files") or whether we should do
something more comprehensive to provide sane_{e,f,}grep which guarantee
to treat input as text.

I also tried setting POSIXLY_CORRECT but that doesn't affect the
text/binary decision.

-- >8 --
diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
index 847d098..3b6e697 100755
--- a/t/t8005-blame-i18n.sh
+++ b/t/t8005-blame-i18n.sh
@@ -36,7 +36,7 @@ EOF
 test_expect_success !MINGW \
 	'blame respects i18n.commitencoding' '
 	git blame --incremental file | \
-		egrep "^(author|summary) " > actual &&
+		egrep -a "^(author|summary) " > actual &&
 	test_cmp actual expected
 '
=20
@@ -53,7 +53,7 @@ test_expect_success !MINGW \
 	'blame respects i18n.logoutputencoding' '
 	git config i18n.logoutputencoding eucJP &&
 	git blame --incremental file | \
-		egrep "^(author|summary) " > actual &&
+		egrep -a "^(author|summary) " > actual &&
 	test_cmp actual expected
 '
=20
@@ -69,7 +69,7 @@ EOF
 test_expect_success !MINGW \
 	'blame respects --encoding=3DUTF-8' '
 	git blame --incremental --encoding=3DUTF-8 file | \
-		egrep "^(author|summary) " > actual &&
+		egrep -a "^(author|summary) " > actual &&
 	test_cmp actual expected
 '
=20
@@ -85,7 +85,7 @@ EOF
 test_expect_success !MINGW \
 	'blame respects --encoding=3Dnone' '
 	git blame --incremental --encoding=3Dnone file | \
-		egrep "^(author|summary) " > actual &&
+		egrep -a "^(author|summary) " > actual &&
 	test_cmp actual expected
 '
=20
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcomm=
it.sh
index 5cfb9cf..f05578a 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -35,7 +35,7 @@ exit 1
=20
 check_entries () {
 	# $1 =3D=3D directory, $2 =3D=3D expected
-	grep '^/' "$1/CVS/Entries" | sort | cut -d/ -f2,3,5 >actual
+	grep -a '^/' "$1/CVS/Entries" | sort | cut -d/ -f2,3,5 >actual
 	if test -z "$2"
 	then
 		>expected
