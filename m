From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] t7006: guard cleanup with test_expect_success
Date: Wed, 14 Apr 2010 19:38:07 -0500
Message-ID: <20100415003803.GB14151@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
 <20100413021355.GA4118@progeny.tock>
 <7v4ojdpxls.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 02:38:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2D6N-0007v8-QR
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 02:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633Ab0DOAiY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Apr 2010 20:38:24 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50929 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755454Ab0DOAiL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 20:38:11 -0400
Received: by gwaa18 with SMTP id a18so397742gwa.19
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 17:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KKg/QQ3n/y0SvNrpb5mOiHpfv1JXuYVD/ubQp64Zo6s=;
        b=SlLKinweBYKrEfDHgEYcmgoCwSaTV/BG7dzm3StrSWqv4IsuZZrGPqaOOFWNkJ8BgW
         hrJB7JxaQyUYvSkgfZCSSet7hpZTkn2X7vypL7lQ8mKfiKxNu5euAdF2/sO5so8/iIIw
         s/6kEsEtLtZIXdtclSIYeJDVPipk+Bzxs0yqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VfnGcrXdYhUNBQCgmabGgKFVdAdWugAIcpqzyqTO2pxG3FOxgzksM1db4h2D0Rdqkv
         uQ1QFgS4uZasbkSR9H75SyrJs9DEDPjieznTU5gW90VYlIoC+FYEaeFFUgDC8vB3ZVr0
         BwJdmUSfmmyyqRynBD9T+GQItJrdsPXagQ/So=
Received: by 10.151.29.11 with SMTP id g11mr7258883ybj.162.1271291890898;
        Wed, 14 Apr 2010 17:38:10 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id ha13sm463309ibb.15.2010.04.14.17.38.09
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 17:38:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4ojdpxls.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144932>

Most of these tests are removing files, environment variables, and
configuration that might interfere outside the test.  Putting these
clean-up commands in the test (in the same spirit as v1.7.1-rc0~59,
2010-03-20) means that errors during setup will be caught quickly and
non-error text will be suppressed without -v.

While at it, apply some other minor fixes:

 - do not rely on the shell to export variables defined with the same
   command as a function call

 - avoid whitespace immediately after the > redirection operator, for
   consistency with the style of other tests

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> They are reasonable clean-up steps to start the real test (starting f=
rom
> setting and exporting the pager) in a known good state, and as long a=
s you
> write them not to fail I don't see any reason to have them outside th=
e
> test.

Good catch, thanks.  Here=E2=80=99s a patch for the existing test (agai=
nst master).

 t/t7006-pager.sh |  149 ++++++++++++++++++++++++++++++++++++----------=
-------
 t/test-lib.sh    |   16 ++++++
 2 files changed, 117 insertions(+), 48 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index d9202d5..62595ab 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -4,17 +4,24 @@ test_description=3D'Test automatic use of a pager.'
=20
 . ./test-lib.sh
=20
-rm -f stdout_is_tty
+cleanup_fail() {
+	echo >&2 cleanup failed
+	exit 1
+}
+
 test_expect_success 'set up terminal for tests' '
+	rm -f stdout_is_tty ||
+	cleanup_fail &&
+
 	if test -t 1
 	then
-		: > stdout_is_tty
+		>stdout_is_tty
 	elif
 		test_have_prereq PERL &&
 		"$PERL_PATH" "$TEST_DIRECTORY"/t7006/test-terminal.perl \
 			sh -c "test -t 1"
 	then
-		: > test_terminal_works
+		>test_terminal_works
 	fi
 '
=20
@@ -32,53 +39,68 @@ else
 	say no usable terminal, so skipping some tests
 fi
=20
-unset GIT_PAGER GIT_PAGER_IN_USE
-git config --unset core.pager
-PAGER=3D'cat > paginated.out'
-export PAGER
-
 test_expect_success 'setup' '
+	unset GIT_PAGER GIT_PAGER_IN_USE &&
+	test_might_fail git config --unset core.pager &&
+
+	PAGER=3D"cat >paginated.out" &&
+	export PAGER &&
+
 	test_commit initial
 '
=20
-rm -f paginated.out
 test_expect_success TTY 'some commands use a pager' '
+	rm -f paginated.out ||
+	cleanup_fail &&
+
 	test_terminal git log &&
 	test -e paginated.out
 '
=20
-rm -f paginated.out
 test_expect_success TTY 'some commands do not use a pager' '
+	rm -f paginated.out ||
+	cleanup_fail &&
+
 	test_terminal git rev-list HEAD &&
 	! test -e paginated.out
 '
=20
-rm -f paginated.out
 test_expect_success 'no pager when stdout is a pipe' '
+	rm -f paginated.out ||
+	cleanup_fail &&
+
 	git log | cat &&
 	! test -e paginated.out
 '
=20
-rm -f paginated.out
 test_expect_success 'no pager when stdout is a regular file' '
-	git log > file &&
+	rm -f paginated.out ||
+	cleanup_fail &&
+
+	git log >file &&
 	! test -e paginated.out
 '
=20
-rm -f paginated.out
 test_expect_success TTY 'git --paginate rev-list uses a pager' '
+	rm -f paginated.out ||
+	cleanup_fail &&
+
 	test_terminal git --paginate rev-list HEAD &&
 	test -e paginated.out
 '
=20
-rm -f file paginated.out
 test_expect_success 'no pager even with --paginate when stdout is a pi=
pe' '
+	rm -f file paginated.out ||
+	cleanup_fail &&
+
 	git --paginate log | cat &&
 	! test -e paginated.out
 '
=20
-rm -f paginated.out
 test_expect_success TTY 'no pager with --no-pager' '
+	rm -f paginated.out ||
+	cleanup_fail &&
+
 	test_terminal git --no-pager log &&
 	! test -e paginated.out
 '
@@ -86,88 +108,119 @@ test_expect_success TTY 'no pager with --no-pager=
' '
 # A colored commit log will begin with an appropriate ANSI escape
 # for the first color; the text "commit" comes later.
 colorful() {
-	read firstline < $1
+	read firstline <$1
 	! expr "$firstline" : "^[a-zA-Z]" >/dev/null
 }
=20
-rm -f colorful.log colorless.log
 test_expect_success 'tests can detect color' '
-	git log --no-color > colorless.log &&
-	git log --color > colorful.log &&
+	rm -f colorful.log colorless.log ||
+	cleanup_fail &&
+
+	git log --no-color >colorless.log &&
+	git log --color >colorful.log &&
 	! colorful colorless.log &&
 	colorful colorful.log
 '
=20
-rm -f colorless.log
-git config color.ui auto
 test_expect_success 'no color when stdout is a regular file' '
-	git log > colorless.log &&
+	rm -f colorless.log &&
+	git config color.ui auto ||
+	cleanup_fail &&
+
+	git log >colorless.log &&
 	! colorful colorless.log
 '
=20
-rm -f paginated.out
-git config color.ui auto
 test_expect_success TTY 'color when writing to a pager' '
-	TERM=3Dvt100 test_terminal git log &&
+	rm -f paginated.out &&
+	git config color.ui auto ||
+	cleanup_fail &&
+
+	(
+		TERM=3Dvt100 &&
+		export TERM &&
+		test_terminal git log
+	) &&
 	colorful paginated.out
 '
=20
-rm -f colorful.log
-git config color.ui auto
 test_expect_success 'color when writing to a file intended for a pager=
' '
-	TERM=3Dvt100 GIT_PAGER_IN_USE=3Dtrue git log > colorful.log &&
+	rm -f colorful.log &&
+	git config color.ui auto ||
+	cleanup_fail &&
+
+	(
+		TERM=3Dvt100 &&
+		GIT_PAGER_IN_USE=3Dtrue &&
+		export TERM GIT_PAGER_IN_USE &&
+		git log >colorful.log
+	) &&
 	colorful colorful.log
 '
=20
-unset PAGER GIT_PAGER
-git config --unset core.pager
 test_expect_success 'determine default pager' '
+	unset PAGER GIT_PAGER &&
+	test_might_fail git config --unset core.pager ||
+	cleanup_fail &&
+
 	less=3D$(git var GIT_PAGER) &&
 	test -n "$less"
 '
=20
-if expr "$less" : '^[a-z]*$' > /dev/null && test_have_prereq TTY
+if expr "$less" : '^[a-z][a-z]*$' >/dev/null && test_have_prereq TTY
 then
 	test_set_prereq SIMPLEPAGER
 fi
=20
-unset PAGER GIT_PAGER
-git config --unset core.pager
-rm -f default_pager_used
 test_expect_success SIMPLEPAGER 'default pager is used by default' '
-	cat > $less <<-EOF &&
-	#!$SHELL_PATH
-	wc > default_pager_used
+	unset PAGER GIT_PAGER &&
+	test_might_fail git config --unset core.pager &&
+	rm -f default_pager_used ||
+	cleanup_fail &&
+
+	cat >$less <<-\EOF &&
+	#!/bin/sh
+	wc >default_pager_used
 	EOF
 	chmod +x $less &&
-	PATH=3D.:$PATH test_terminal git log &&
+	(
+		PATH=3D.:$PATH &&
+		export PATH &&
+		test_terminal git log
+	) &&
 	test -e default_pager_used
 '
=20
-unset GIT_PAGER
-git config --unset core.pager
-rm -f PAGER_used
 test_expect_success TTY 'PAGER overrides default pager' '
-	PAGER=3D"wc > PAGER_used" &&
+	unset GIT_PAGER &&
+	test_might_fail git config --unset core.pager &&
+	rm -f PAGER_used ||
+	cleanup_fail &&
+
+	PAGER=3D"wc >PAGER_used" &&
 	export PAGER &&
 	test_terminal git log &&
 	test -e PAGER_used
 '
=20
-unset GIT_PAGER
-rm -f core.pager_used
 test_expect_success TTY 'core.pager overrides PAGER' '
+	unset GIT_PAGER &&
+	rm -f core.pager_used ||
+	cleanup_fail &&
+
 	PAGER=3Dwc &&
 	export PAGER &&
-	git config core.pager "wc > core.pager_used" &&
+	git config core.pager "wc >core.pager_used" &&
 	test_terminal git log &&
 	test -e core.pager_used
 '
=20
-rm -f GIT_PAGER_used
 test_expect_success TTY 'GIT_PAGER overrides core.pager' '
+	rm -f GIT_PAGER_used ||
+	cleanup_fail &&
+
 	git config core.pager wc &&
-	GIT_PAGER=3D"wc > GIT_PAGER_used" &&
+	GIT_PAGER=3D"wc >GIT_PAGER_used" &&
 	export GIT_PAGER &&
 	test_terminal git log &&
 	test -e GIT_PAGER_used
diff --git a/t/test-lib.sh b/t/test-lib.sh
index c582964..f807625 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -516,6 +516,22 @@ test_must_fail () {
 	test $? -gt 0 -a $? -le 129 -o $? -gt 192
 }
=20
+# Similar to test_must_fail, but tolerates success, too.  This is
+# meant to be used in contexts like:
+#
+#	test_expect_success 'some command works without configuration' '
+#		test_might_fail git config --unset all.configuration &&
+#		do something
+#	'
+#
+# Writing "git config --unset all.configuration || :" would be wrong,
+# because we want to notice if it fails due to segv.
+
+test_might_fail () {
+	"$@"
+	test $? -ge 0 -a $? -le 129 -o $? -gt 192
+}
+
 # test_cmp is a helper function to compare actual and expected output.
 # You can use it like:
 #
--=20
1.7.1.rc1.18.g08771.dirty
