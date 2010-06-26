From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] t7006 (pager): introduce helper for parameterized tests
Date: Sat, 26 Jun 2010 14:23:02 -0500
Message-ID: <20100626192302.GA20051@burratino>
References: <20100626192203.GA19973@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 21:23:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSayI-0007iy-Jh
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 21:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415Ab0FZTXS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 15:23:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46481 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab0FZTXR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 15:23:17 -0400
Received: by iwn41 with SMTP id 41so3105491iwn.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 12:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=AZPx+uYLfOwZcsgonLrPyv+nUDgkK2Wz6ZHEkGNyi8E=;
        b=rDNHUKUujn7JtatqS+sxBhpM2ZiRSC1vl8/+C5dW8ubckJe8nM/rALGDdKrYbB5D5c
         GcHnCnuX2ruEpmmN/2P+PrJ6DfeGIhyQn0sEn58Tiphn7wG7+ZrlRQbK89FHU0iI8q55
         sDGUyTShSV3pybjtvfuyanY9j4/63BlMYXeFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=CzRP1oggX4cTCWNrk6Q7r5047u+rOa+gz2WVLcdaGzowMWfPrrsINPAWoJr0p6zohs
         J4SerfQ8xcSWVZ61+6UDARwGoFBuR0TfsT8+Vd5yGS0mrO5Z4Zs0NbYBv/gXujrbaJ1s
         7aOx/k3PgiBE79gi9jHor29rHgbk3uQw0Wlis=
Received: by 10.231.39.201 with SMTP id h9mr2712632ibe.113.1277580197052;
        Sat, 26 Jun 2010 12:23:17 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id u6sm53076446ibu.0.2010.06.26.12.23.16
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 12:23:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100626192203.GA19973@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149772>

The current tests test pager configuration for =E2=80=98git log=E2=80=99=
, but other
commands use a different setup procedure and should therefore be
tested separately.  Add a helper to make this easier.

This patch introduces the helper and changes some existing tests to
use it.  The only functional change should be the introduction of =E2=80=
=98git
log - =E2=80=99 to a few test descriptions.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7006-pager.sh |   72 ++++++++++++++++++++++++++++++++++++++++------=
-------
 1 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 9a83241..b117ebb 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -172,58 +172,94 @@ then
 	test_set_prereq SIMPLEPAGER
 fi
=20
-test_expect_success SIMPLEPAGER 'default pager is used by default' '
+# Use this helper to make it easy for the caller of your
+# terminal-using function to specify whether it should fail.
+# If you write
+#
+#	your_test() {
+#		parse_args "$@"
+#
+#		$test_expectation "$cmd - behaves well" "
+#			...
+#			$full_command &&
+#			...
+#		"
+#	}
+#
+# then your test can be used like this:
+#
+#	your_test expect_(success|failure) [test_must_fail] 'git foo'
+#
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
+
+parse_args expect_success 'git log'
+$test_expectation SIMPLEPAGER "$cmd - default pager is used by default=
" "
 	unset PAGER GIT_PAGER;
 	test_might_fail git config --unset core.pager &&
 	rm -f default_pager_used ||
 	cleanup_fail &&
=20
-	cat >$less <<-\EOF &&
+	cat >\$less <<-\EOF &&
 	#!/bin/sh
 	wc >default_pager_used
 	EOF
-	chmod +x $less &&
+	chmod +x \$less &&
 	(
-		PATH=3D.:$PATH &&
+		PATH=3D.:\$PATH &&
 		export PATH &&
-		test_terminal git log
+		$full_command
 	) &&
 	test -e default_pager_used
-'
+"
=20
-test_expect_success TTY 'PAGER overrides default pager' '
+parse_args expect_success 'git log'
+$test_expectation TTY "$cmd - PAGER overrides default pager" "
 	unset GIT_PAGER;
 	test_might_fail git config --unset core.pager &&
 	rm -f PAGER_used ||
 	cleanup_fail &&
=20
-	PAGER=3D"wc >PAGER_used" &&
+	PAGER=3D'wc >PAGER_used' &&
 	export PAGER &&
-	test_terminal git log &&
+	$full_command &&
 	test -e PAGER_used
-'
+"
=20
-test_expect_success TTY 'core.pager overrides PAGER' '
+parse_args expect_success 'git log'
+$test_expectation TTY "$cmd - core.pager overrides PAGER" "
 	unset GIT_PAGER;
 	rm -f core.pager_used ||
 	cleanup_fail &&
=20
 	PAGER=3Dwc &&
 	export PAGER &&
-	git config core.pager "wc >core.pager_used" &&
-	test_terminal git log &&
+	git config core.pager 'wc >core.pager_used' &&
+	$full_command &&
 	test -e core.pager_used
-'
+"
=20
-test_expect_success TTY 'GIT_PAGER overrides core.pager' '
+parse_args expect_success 'git log'
+$test_expectation TTY "$cmd - GIT_PAGER overrides core.pager" "
 	rm -f GIT_PAGER_used ||
 	cleanup_fail &&
=20
 	git config core.pager wc &&
-	GIT_PAGER=3D"wc >GIT_PAGER_used" &&
+	GIT_PAGER=3D'wc >GIT_PAGER_used' &&
 	export GIT_PAGER &&
-	test_terminal git log &&
+	$full_command &&
 	test -e GIT_PAGER_used
-'
+"
=20
 test_done
--=20
1.7.1.579.ge2549
