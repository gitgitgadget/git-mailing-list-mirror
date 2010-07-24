From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] tests: Test how well "git apply" copes with weird
 filenames
Date: Fri, 23 Jul 2010 20:11:14 -0500
Message-ID: <20100724011114.GC13670@burratino>
References: <20100724010618.GA13670@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
	Giuseppe Iuculano <iuculano@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 03:12:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcTHn-0000wi-Ix
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 03:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756720Ab0GXBMO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 21:12:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49353 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756582Ab0GXBMO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 21:12:14 -0400
Received: by iwn7 with SMTP id 7so745588iwn.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 18:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=F23TdM5bulJvud1JpeWazRnR8fNWbqqilbiNSiTl7/w=;
        b=SXPkaxoQ4bTq6FfQHNTokIq2IosG7eDrFxNgp2zne+ojDqtu1PwgRwnJUALLedEg83
         QLBBXpbhliqbXRxFNohU+7D9RNjaAsJz9MYkB4WN1pSo8zJVNhrTTskZvE8iYNGJjZsv
         1HNfDQbBRFazaJedWHlYtaaPGEgvjD6W1yglk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Te3B3yhcNJ0xbaj3E2gzwDAnNOuRM4cnyEb4sOJ3Dw5/S8VRLO5UbFU5QK+RLdBtqh
         K6Zx0CyJNPMJlx/HGUhPgu7ODKtdcLyUzL76Zr/zcuPnhs9JGX4S8PwrwRnaz3m1Uo2S
         dTEE7GxOdZQjPzby4zq0np3X6pywiairAZmIE=
Received: by 10.231.33.202 with SMTP id i10mr4471329ibd.50.1279933933587;
        Fri, 23 Jul 2010 18:12:13 -0700 (PDT)
Received: from burratino ([64.134.164.56])
        by mx.google.com with ESMTPS id 34sm767445ibi.6.2010.07.23.18.12.13
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 18:12:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100724010618.GA13670@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151592>

The tests assume a reasonably well-behaved =E2=80=9Cdiff -u=E2=80=9D an=
d =E2=80=9Cpr=E2=80=9D
to produce the (possibly whitespace-damaged) patches.  On platforms
without those commands, skip the tests.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4135-apply-weird-filenames.sh |  119 ++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 119 insertions(+), 0 deletions(-)
 create mode 100755 t/t4135-apply-weird-filenames.sh

diff --git a/t/t4135-apply-weird-filenames.sh b/t/t4135-apply-weird-fil=
enames.sh
new file mode 100755
index 0000000..2dcb040
--- /dev/null
+++ b/t/t4135-apply-weird-filenames.sh
@@ -0,0 +1,119 @@
+#!/bin/sh
+
+test_description=3D'git apply with weird postimage filenames'
+
+. ./test-lib.sh
+
+test_expect_success 'setup: empty commit' '
+	test_tick &&
+	git commit --allow-empty -m preimage &&
+	git tag preimage
+'
+
+test_expect_success 'setup: clean-up functions' '
+	reset_preimage() {
+		git checkout -f preimage^0 &&
+		git read-tree -u --reset HEAD &&
+		git update-index --refresh
+	} &&
+
+	reset_subdirs() {
+		rm -fr a b &&
+		mkdir a b
+	}
+'
+
+test_expect_success 'setup: test prerequisites' '
+	echo one >1 &&
+	echo one >2 &&
+	if diff -u 1 2
+	then
+		test_set_prereq UNIDIFF
+	fi &&
+
+	if diff -pruN 1 2
+	then
+		test_set_prereq FULLDIFF
+	fi &&
+
+	echo "tab ->  ." >expected &&
+	echo "tab ->	." >with-tab &&
+
+	pr -tT -e8 with-tab >actual &&
+	if test_cmp expected actual
+	then
+		test_set_prereq PR
+	fi
+'
+
+try_filename() {
+	desc=3D$1
+	postimage=3D$2
+	exp1=3D${3:-success}
+	exp2=3D${4:-success}
+	exp3=3D${5:-success}
+
+	test_expect_$exp1 "$desc, git-style file creation patch" "
+		reset_preimage &&
+		echo postimage >'$postimage' &&
+		git add -N '$postimage' &&
+		git diff HEAD >'git-$desc.diff' &&
+
+		git rm -f --cached '$postimage' &&
+		mv '$postimage' postimage.saved &&
+		git apply -v 'git-$desc.diff' &&
+
+		test_cmp postimage.saved '$postimage'
+	"
+
+	test_expect_$exp2 UNIDIFF "$desc, traditional patch" "
+		reset_preimage &&
+		echo preimage >'$postimage.orig' &&
+		echo postimage >'$postimage' &&
+		! diff -u '$postimage.orig' '$postimage' >'diff-$desc.diff' &&
+
+		mv '$postimage' postimage.saved &&
+		mv '$postimage.orig' '$postimage' &&
+		git apply -v 'diff-$desc.diff' &&
+
+		test_cmp postimage.saved '$postimage'
+	"
+
+	test_expect_$exp3 FULLDIFF "$desc, traditional file creation patch" "
+		reset_preimage &&
+		reset_subdirs &&
+		echo postimage >b/'$postimage' &&
+		! diff -pruN a b >'add-$desc.diff' &&
+
+		rm -f '$postimage' &&
+		mv b/'$postimage' postimage.saved &&
+		git apply -v 'add-$desc.diff' &&
+
+		test_cmp postimage.saved '$postimage'
+	"
+}
+
+try_filename 'plain'            'postimage.txt'
+try_filename 'with spaces'      'post image.txt' success failure failu=
re
+try_filename 'with tab'         'post	image.txt' success failure failu=
re
+try_filename 'with backslash'   'post\image.txt'
+try_filename 'with quote'       '"postimage".txt' success failure succ=
ess
+
+if test_have_prereq FULLDIFF && test_have_prereq PR
+then
+	test_set_prereq FULLDIFFPR
+fi
+test_expect_success FULLDIFFPR 'whitespace-damaged traditional patch' =
'
+	reset_preimage &&
+	reset_subdirs &&
+	echo postimage >b/postimage.txt &&
+	! diff -pruN a b >diff-plain.txt &&
+	pr -tT -e8 diff-plain.txt >damaged.diff &&
+
+	mv postimage.txt postimage.saved &&
+	git apply -v damaged.diff &&
+
+	test_cmp postimage.saved postimage.txt
+'
+
+test_done
--=20
1.7.2.rc3
