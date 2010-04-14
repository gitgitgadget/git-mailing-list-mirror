From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/9 v2] t7006: test pager configuration for several git
 commands
Date: Tue, 13 Apr 2010 20:26:33 -0500
Message-ID: <20100414012632.GA7121@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
 <20100413021734.GB4118@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 14 03:27:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1rNd-0001zr-Tg
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 03:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353Ab0DNB0k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Apr 2010 21:26:40 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41303 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042Ab0DNB0j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 21:26:39 -0400
Received: by gwaa18 with SMTP id a18so922099gwa.19
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 18:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QEyxO/HPvy4f6tRLCVzetaeJBecPsF2/XmxDuKb52/U=;
        b=m0XgfN7pgYIH4h5ICYBw76pc4jbvJyPE2hF/mI0hkDzUziFUWYwDj118NST6wIvDgV
         ekhujW1vIimgRc/7MXyq8xo6bl0pSXtk5yHXpQd7AsSfKYO7ls5UevSGeNOgw7azE++w
         YpKPRAMcxvPQ+KyfSSlwkhK3O97Mo4oZvSsH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=oPJecnld+56UejLPQ3V+/Esf/BM8vHsIzS7FAaRMESR3n5a8jePpnH6needpGYiPNA
         fOs1tBqUkc+jjcfjuHiVBVsppj6w/Mjof7RAGlIZlyJ8Wr1RzLVaxWzYu9m/A9aAllIv
         XTLUlp4VLbJMYFAEiJzuZG6AD4l5KZzkyRBfo=
Received: by 10.151.92.9 with SMTP id u9mr4581666ybl.336.1271208398339;
        Tue, 13 Apr 2010 18:26:38 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 9sm1645041ywf.5.2010.04.13.18.26.36
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 18:26:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100413021734.GB4118@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144840>

Test choice of pager at several stages of repository setup.  Some
patches under consideration will produce different results for
different commands, so it should be useful to have examples like this
in mind to illustrate their effect.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Improved-by: Johannes Sixt <j6t@kdbg.org>
---
Changes from v1:
 - Use /bin/sh instead of $SHELL_PATH to simplify quoting issues
 - Split the test_pager_choice function into single-test pieces to
   make the test easier to understand.

I=E2=80=99ll resend the patches 3 and 9 with corresponding adjustments =
in a
moment.

Thanks to Hannes for the feedback.

 t/t7006-pager.sh |  192 +++++++++++++++++++++++++++++++++++-----------=
--------
 1 files changed, 124 insertions(+), 68 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 4f804ed..d5f8a18 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -131,78 +131,134 @@ then
 	test_set_prereq SIMPLEPAGER
 fi
=20
-unset PAGER GIT_PAGER
-git config --unset core.pager
-rm -f default_pager_used
-test_expect_success SIMPLEPAGER 'default pager is used by default' '
-	cat > $less <<-EOF &&
-	#!$SHELL_PATH
-	wc > default_pager_used
-	EOF
-	chmod +x $less &&
-	PATH=3D.:$PATH test_terminal git log &&
-	test -e default_pager_used
-'
+# Tests for pager choice.
=20
-unset GIT_PAGER
-git config --unset core.pager
-rm -f PAGER_used
-test_expect_success TTY 'PAGER overrides default pager' '
-	PAGER=3D"wc > PAGER_used" &&
-	export PAGER &&
-	test_terminal git log &&
-	test -e PAGER_used
-'
+# Usage:
+#	parse_args expect_(success|failure) [test_must_fail] git whatever
+#	$test_expectation "$cmd - behaves well" "
+#		...
+#		$full_command &&
+#		...
+#	"
+parse_args() {
+	test_expectation=3D"test_$1"
+	shift
+	if test "$1" =3D test_must_fail
+	then
+		full_command=3D"test_must_fail test_terminal "
+		shift
+	else
+		full_command=3D"test_terminal "
+	fi
+	cmd=3D$1
+	full_command=3D"$full_command $1"
+}
=20
-unset GIT_PAGER
-rm -f core.pager_used
-test_expect_success TTY 'core.pager overrides PAGER' '
-	PAGER=3Dwc &&
-	export PAGER &&
-	git config core.pager "wc > core.pager_used" &&
-	test_terminal git log &&
-	test -e core.pager_used
-'
+# usage: test_default_pager expect_(success|failure) [test_must_fail] =
command
+test_default_pager() {
+	parse_args "$@"
=20
-unset GIT_PAGER
-rm -f core.pager_used
-rm -fr sub
-test_expect_success TTY 'core.pager in subdir' '
-	PAGER=3Dwc &&
-	stampname=3D$(pwd)/core.pager_used &&
-	export PAGER stampname &&
-	git config core.pager "wc > \"\$stampname\"" &&
-	mkdir sub &&
-	(
-		cd sub &&
-		test_terminal git log
-	) &&
-	test -e "$stampname"
-'
+	unset PAGER GIT_PAGER
+	git config --unset core.pager
+	rm -f default_pager_used
+	$test_expectation SIMPLEPAGER "$cmd - default pager is used by defaul=
t" "
+		cat >$less <<-\EOF &&
+			#!/bin/sh
+			wc > default_pager_used
+		EOF
+		chmod +x $less &&
+		(
+			PATH=3D.:$PATH &&
+			export PATH &&
+			$full_command
+		) &&
+		test -e default_pager_used
+	"
+}
=20
-unset GIT_PAGER
-rm -f core.pager_used
-rm -fr sub
-test_expect_failure TTY 'core.pager in subdir with --paginate' '
-	PAGER=3Dwc &&
-	stampname=3D$(pwd)/core.pager_used &&
-	export PAGER stampname &&
-	git config core.pager "wc > \"\$stampname\"" &&
-	mkdir sub &&
-	(
-		cd sub &&
-		test_terminal git --paginate log
-	) &&
-	test -e "$stampname"
-'
+test_PAGER_overrides() {
+	parse_args "$@"
=20
-rm -f GIT_PAGER_used
-test_expect_success TTY 'GIT_PAGER overrides core.pager' '
-	git config core.pager wc &&
-	GIT_PAGER=3D"wc > GIT_PAGER_used" &&
-	export GIT_PAGER &&
-	test_terminal git log &&
-	test -e GIT_PAGER_used
-'
+	unset GIT_PAGER
+	git config --unset core.pager
+	rm -f PAGER_used
+	$test_expectation TTY "$cmd - PAGER overrides default pager" "
+		PAGER=3D'wc > PAGER_used' &&
+		export PAGER &&
+		$full_command &&
+		test -e PAGER_used
+	"
+}
+
+test_core_pager_overrides() {
+	parse_args "$@"
+
+	unset GIT_PAGER
+	rm -f core.pager_used
+	$test_expectation TTY "$cmd - core.pager overrides PAGER" "
+		PAGER=3Dwc &&
+		export PAGER &&
+		git config core.pager 'wc > core.pager_used' &&
+		$full_command &&
+		test -e core.pager_used
+	"
+}
+
+test_core_pager_subdir() {
+	parse_args "$@"
+
+	unset GIT_PAGER
+	rm -f core.pager_used
+	rm -fr sub
+	$test_expectation TTY "$cmd - core.pager from subdirectory" "
+		stampname=3D\$(pwd)/core.pager_used &&
+		PAGER=3Dwc &&
+		export PAGER stampname &&
+		git config core.pager 'wc > \"\$stampname\"' &&
+		mkdir sub &&
+		(
+			cd sub &&
+			$full_command
+		) &&
+		test -e \"\$stampname\"
+	"
+}
+
+test_GIT_PAGER_overrides() {
+	parse_args "$@"
+
+	rm -f GIT_PAGER_used
+	$test_expectation TTY "$cmd - GIT_PAGER overrides core.pager" "
+		git config core.pager wc &&
+		GIT_PAGER=3D'wc > GIT_PAGER_used' &&
+		export GIT_PAGER &&
+		$full_command &&
+		test -e GIT_PAGER_used
+	"
+}
+
+test_default_pager        expect_success 'git log'
+test_PAGER_overrides      expect_success 'git log'
+test_core_pager_overrides expect_success 'git log'
+test_core_pager_subdir    expect_success 'git log'
+test_GIT_PAGER_overrides  expect_success 'git log'
+
+test_default_pager        expect_success 'git -p log'
+test_PAGER_overrides      expect_success 'git -p log'
+test_core_pager_overrides expect_success 'git -p log'
+test_core_pager_subdir    expect_failure 'git -p log'
+test_GIT_PAGER_overrides  expect_success 'git -p log'
+
+test_default_pager        expect_success test_must_fail 'git -p'
+test_PAGER_overrides      expect_success test_must_fail 'git -p'
+test_core_pager_overrides expect_success test_must_fail 'git -p'
+test_core_pager_subdir    expect_failure test_must_fail 'git -p'
+test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p'
+
+test_default_pager        expect_success test_must_fail 'git -p nonsen=
se'
+test_PAGER_overrides      expect_success test_must_fail 'git -p nonsen=
se'
+test_core_pager_overrides expect_success test_must_fail 'git -p nonsen=
se'
+test_core_pager_subdir    expect_failure test_must_fail 'git -p nonsen=
se'
+test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p nonsen=
se'
=20
 test_done
--=20
1.7.0.4
