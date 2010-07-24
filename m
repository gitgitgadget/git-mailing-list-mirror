From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/9] tests: try git apply from subdir of toplevel
Date: Sat, 24 Jul 2010 06:18:38 -0500
Message-ID: <20100724111838.GB16054@burratino>
References: <1279886651-14590-1-git-send-email-pclouds@gmail.com>
 <20100724111505.GC7150@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 13:19:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Occle-0003ma-IM
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 13:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685Ab0GXLTm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 07:19:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43182 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733Ab0GXLTl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 07:19:41 -0400
Received: by iwn7 with SMTP id 7so1093691iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1Wavj5Ydi1VbDFSrZcYugaSc02bLMus2vI9qQ8aBC+E=;
        b=Zp5UAphpelenTOsIR/tbac+Ut0YLzv9TkW2FcWAJcnZHpaIaQ7RXvBgBkk6bSJ61Tq
         1W01p4z5rVSqNoPh227bMnUhIG1HjZML1TVoZjpW/inC9HntxBLyxLbw/s9jRfy5tBdD
         LK9OrRkO3JVH++dpeJ77La1sieNPkOFo7E3aE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=vebBXSXSnwkF6ylf8A6Oca40JqqxxCLdUrPPaASr123yxoz8KlFgWdXtqiITZy87zv
         FB1EHhWv/v+NR8qYyyHmhAKko22nWKXt8Pi71IV36xHMnwG1f9XYsZWkrU9PR846axto
         UHugUZoqgydgusk4YiFFYUzZqPfTy/G5hI00Y=
Received: by 10.231.167.196 with SMTP id r4mr5491534iby.29.1279970380079;
        Sat, 24 Jul 2010 04:19:40 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm1256855ibi.0.2010.07.24.04.19.38
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 04:19:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100724111505.GC7150@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151613>

Make sure git apply can apply patches with paths relative to the
toplevel of a work tree, a subdirectory, or within the repository
metadata directory.

Relative paths are broken for most commands when run from a
subdirectory of $GIT_DIR, "git apply" being no exception.  The other
tests are meant to keep the demonstration of that company.

Based on a test by Duy.

Cc: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4111-apply-subdir.sh |  141 +++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 141 insertions(+), 0 deletions(-)
 create mode 100755 t/t4111-apply-subdir.sh

diff --git a/t/t4111-apply-subdir.sh b/t/t4111-apply-subdir.sh
new file mode 100755
index 0000000..60c2237
--- /dev/null
+++ b/t/t4111-apply-subdir.sh
@@ -0,0 +1,141 @@
+#!/bin/sh
+
+test_description=3D'patching from inconvenient places'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	cat >patch <<-\EOF &&
+	diff file.orig file
+	--- a/file.orig
+	+++ b/file
+	@@ -1 +1,2 @@
+	 1
+	+2
+	EOF
+	patch=3D"$(pwd)/patch" &&
+
+	echo 1 >preimage &&
+	printf "%s\n" 1 2 >postimage &&
+	echo 3 >other &&
+
+	test_tick &&
+	git commit --allow-empty -m basis
+'
+
+test_expect_success 'setup: subdir' '
+	reset_subdir() {
+		git reset &&
+		mkdir -p sub/dir/b &&
+		mkdir -p objects &&
+		cp "$1" file &&
+		cp "$1" objects/file &&
+		cp "$1" sub/dir/file &&
+		cp "$1" sub/dir/b/file &&
+		git add file sub/dir/file sub/dir/b/file objects/file &&
+		cp "$2" file &&
+		cp "$2" sub/dir/file &&
+		cp "$2" sub/dir/b/file &&
+		cp "$2" objects/file
+	}
+'
+
+test_expect_success 'apply from subdir of toplevel' '
+	cp postimage expected &&
+	reset_subdir other preimage &&
+	(
+		cd sub/dir &&
+		git apply "$patch"
+	) &&
+	test_cmp expected sub/dir/file
+'
+
+test_expect_success 'apply --cached from subdir of toplevel' '
+	cp postimage expected &&
+	cp other expected.working &&
+	reset_subdir preimage other &&
+	(
+		cd sub/dir &&
+		git apply --cached "$patch"
+	) &&
+	git show :sub/dir/file >actual &&
+	test_cmp expected actual &&
+	test_cmp expected.working sub/dir/file
+'
+
+test_expect_success 'apply --index from subdir of toplevel' '
+	cp postimage expected &&
+	reset_subdir preimage other &&
+	(
+		cd sub/dir &&
+		test_must_fail git apply --index "$patch"
+	) &&
+	reset_subdir other preimage &&
+	(
+		cd sub/dir &&
+		test_must_fail git apply --index "$patch"
+	) &&
+	reset_subdir preimage preimage &&
+	(
+		cd sub/dir &&
+		git apply --index "$patch"
+	) &&
+	git show :sub/dir/file >actual &&
+	test_cmp expected actual &&
+	test_cmp expected sub/dir/file
+'
+
+test_expect_success 'apply from .git dir' '
+	cp postimage expected &&
+	cp preimage .git/file &&
+	cp preimage .git/objects/file
+	(
+		cd .git &&
+		git apply "$patch"
+	) &&
+	test_cmp expected .git/file
+'
+
+test_expect_failure 'apply from subdir of .git dir' '
+	cp postimage expected &&
+	cp preimage .git/file &&
+	cp preimage .git/objects/file
+	(
+		cd .git/objects &&
+		git apply "$patch"
+	) &&
+	test_cmp expected .git/objects/file
+'
+
+test_expect_success 'apply --cached from .git dir' '
+	cp postimage expected &&
+	cp other expected.working &&
+	cp other .git/file &&
+	reset_subdir preimage other &&
+	(
+		cd .git &&
+		git apply --cached "$patch"
+	) &&
+	git show :file >actual &&
+	test_cmp expected actual &&
+	test_cmp expected.working file &&
+	test_cmp expected.working .git/file
+'
+
+test_expect_success 'apply --cached from subdir of .git dir' '
+	cp postimage expected &&
+	cp preimage expected.subdir &&
+	cp other .git/file &&
+	cp other .git/objects/file &&
+	reset_subdir preimage other &&
+	(
+		cd .git/objects &&
+		git apply --cached "$patch"
+	) &&
+	git show :file >actual &&
+	git show :objects/file >actual.subdir &&
+	test_cmp expected actual &&
+	test_cmp expected.subdir actual.subdir
+'
+
+test_done
--=20
1.7.2.rc3
