From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] t7006: test pager configuration for several git
 commands
Date: Sat, 26 Jun 2010 14:24:50 -0500
Message-ID: <20100626192450.GB20051@burratino>
References: <20100626192203.GA19973@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 21:25:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSb06-0008Lh-Cq
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 21:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575Ab0FZTZH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 15:25:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49866 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab0FZTZF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 15:25:05 -0400
Received: by iwn41 with SMTP id 41so3106298iwn.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 12:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HNNW7NarlK8vTS4AECbBgeFvJd9z/t6oDlPmL77QUIQ=;
        b=Rz5rqfE2K6nJY1VqwRhMN5wZ+iHmLbA5kAY5PVRxLVSEwhkI1Nw6reFsH0Fl9AFADy
         W0WVbae+3K/jBmgx19n4Un9C4PgnmWzCDYZ+BE88mQJXuH0VJuIuSB0h1//17eeyNhWE
         u/+bA9OgBaz2DJ1MEtDwomY9zPS7TH5BOIXSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=V2FQ+bPxV73NPupyTDGXdsaOa9j3Cee6s4KMGoJu5zJowD4G8FfUel5o5Kr9XL4dEF
         K0XtJpTfgQYmU0OX9VYoPn0YiNGa2pg0rtJvA/emkVkTATJLX2+Vx1CdUZzDzVaoT9a6
         GHg/GoAmlYbUb3tpvjsPZH4k1qDRSjX42hIxo=
Received: by 10.231.35.195 with SMTP id q3mr2505085ibd.14.1277580304217;
        Sat, 26 Jun 2010 12:25:04 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 35sm5953027ibs.4.2010.06.26.12.25.03
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 12:25:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100626192203.GA19973@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149773>

Test choice of pager at several stages of repository setup.  This
provides some (admittedly uninteresting) examples to keep in mind when
considering changes to the setup procedure.

Improved-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The patch from =E2=80=98diff -w=E2=80=99 should be easier to review.  I=
=E2=80=99ll send it as
a reply.

Thanks to both Junio and Hannes for improvements.

 t/t7006-pager.sh |  146 +++++++++++++++++++++++++++++++++-------------=
--------
 1 files changed, 89 insertions(+), 57 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index b117ebb..4420f91 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -204,62 +204,94 @@ parse_args() {
 	full_command=3D"$full_command $1"
 }
=20
-parse_args expect_success 'git log'
-$test_expectation SIMPLEPAGER "$cmd - default pager is used by default=
" "
-	unset PAGER GIT_PAGER;
-	test_might_fail git config --unset core.pager &&
-	rm -f default_pager_used ||
-	cleanup_fail &&
-
-	cat >\$less <<-\EOF &&
-	#!/bin/sh
-	wc >default_pager_used
-	EOF
-	chmod +x \$less &&
-	(
-		PATH=3D.:\$PATH &&
-		export PATH &&
-		$full_command
-	) &&
-	test -e default_pager_used
-"
-
-parse_args expect_success 'git log'
-$test_expectation TTY "$cmd - PAGER overrides default pager" "
-	unset GIT_PAGER;
-	test_might_fail git config --unset core.pager &&
-	rm -f PAGER_used ||
-	cleanup_fail &&
-
-	PAGER=3D'wc >PAGER_used' &&
-	export PAGER &&
-	$full_command &&
-	test -e PAGER_used
-"
-
-parse_args expect_success 'git log'
-$test_expectation TTY "$cmd - core.pager overrides PAGER" "
-	unset GIT_PAGER;
-	rm -f core.pager_used ||
-	cleanup_fail &&
-
-	PAGER=3Dwc &&
-	export PAGER &&
-	git config core.pager 'wc >core.pager_used' &&
-	$full_command &&
-	test -e core.pager_used
-"
-
-parse_args expect_success 'git log'
-$test_expectation TTY "$cmd - GIT_PAGER overrides core.pager" "
-	rm -f GIT_PAGER_used ||
-	cleanup_fail &&
-
-	git config core.pager wc &&
-	GIT_PAGER=3D'wc >GIT_PAGER_used' &&
-	export GIT_PAGER &&
-	$full_command &&
-	test -e GIT_PAGER_used
-"
+test_default_pager() {
+	parse_args "$@"
+
+	$test_expectation SIMPLEPAGER "$cmd - default pager is used by defaul=
t" "
+		unset PAGER GIT_PAGER;
+		test_might_fail git config --unset core.pager &&
+		rm -f default_pager_used ||
+		cleanup_fail &&
+
+		cat >\$less <<-\EOF &&
+		#!/bin/sh
+		wc >default_pager_used
+		EOF
+		chmod +x \$less &&
+		(
+			PATH=3D.:\$PATH &&
+			export PATH &&
+			$full_command
+		) &&
+		test -e default_pager_used
+	"
+}
+
+test_PAGER_overrides() {
+	parse_args "$@"
+
+	$test_expectation TTY "$cmd - PAGER overrides default pager" "
+		unset GIT_PAGER;
+		test_might_fail git config --unset core.pager &&
+		rm -f PAGER_used ||
+		cleanup_fail &&
+
+		PAGER=3D'wc >PAGER_used' &&
+		export PAGER &&
+		$full_command &&
+		test -e PAGER_used
+	"
+}
+
+test_core_pager_overrides() {
+	parse_args "$@"
+
+	$test_expectation TTY "$cmd - core.pager overrides PAGER" "
+		unset GIT_PAGER;
+		rm -f core.pager_used ||
+		cleanup_fail &&
+
+		PAGER=3Dwc &&
+		export PAGER &&
+		git config core.pager 'wc >core.pager_used' &&
+		$full_command &&
+		test -e core.pager_used
+	"
+}
+
+test_GIT_PAGER_overrides() {
+	parse_args "$@"
+
+	$test_expectation TTY "$cmd - GIT_PAGER overrides core.pager" "
+		rm -f GIT_PAGER_used ||
+		cleanup_fail &&
+
+		git config core.pager wc &&
+		GIT_PAGER=3D'wc >GIT_PAGER_used' &&
+		export GIT_PAGER &&
+		$full_command &&
+		test -e GIT_PAGER_used
+	"
+}
+
+test_default_pager        expect_success 'git log'
+test_PAGER_overrides      expect_success 'git log'
+test_core_pager_overrides expect_success 'git log'
+test_GIT_PAGER_overrides  expect_success 'git log'
+
+test_default_pager        expect_success 'git -p log'
+test_PAGER_overrides      expect_success 'git -p log'
+test_core_pager_overrides expect_success 'git -p log'
+test_GIT_PAGER_overrides  expect_success 'git -p log'
+
+test_default_pager        expect_success test_must_fail 'git -p'
+test_PAGER_overrides      expect_success test_must_fail 'git -p'
+test_core_pager_overrides expect_success test_must_fail 'git -p'
+test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p'
+
+test_default_pager        expect_success test_must_fail 'git -p nonsen=
se'
+test_PAGER_overrides      expect_success test_must_fail 'git -p nonsen=
se'
+test_core_pager_overrides expect_success test_must_fail 'git -p nonsen=
se'
+test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p nonsen=
se'
=20
 test_done
--=20
1.7.1.579.ge2549
