From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH V2] test: Add check-non-portable-shell.pl
Date: Thu, 3 Jan 2013 00:20:19 +0100
Message-ID: <201301030020.31307.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: peff@peff.net, gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 00:21:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqXcT-00013h-Na
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 00:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743Ab3ABXUw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 18:20:52 -0500
Received: from mout.web.de ([212.227.15.3]:55652 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206Ab3ABXUu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2013 18:20:50 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MMW2M-1Twcgl0v9C-007umC; Thu, 03 Jan 2013 00:20:47 +0100
X-Provags-ID: V02:K0:f+6z2z1f/wgheO/nx24Wfc8eU9/WwdftcPSfUPfRnRs
 yFqmFzN4NRIpACjGOEgTktF2QqQ4oIijBYMVoIJR26YlX0tb4F
 UdFhRFFq96NeLVAmBA9An1cmdO6rxUfizwRaVDwgy55LOyzp7N
 BD/w4u9EpfSdWEgF5XaovzxxKRzTjPrdG2fWWVCRU6M2Qg/XSh
 dOxQZhBGDI1Uwa+m6GnKQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212556>

Add the perl script "check-non-portable-shell.pl" to detect non-portabl=
e
shell syntax

"echo -n" is an example of a shell command working on Linux,
but not on Mac OS X.

These shell commands are checked and reported as error:
- "echo -n" (printf should be used)
- "sed -i" (Use a temp file)
- arrays in shell scripts (declare statement)
- "which" (type should be used)
- "=3D=3D" (bash style for =3D)

"make test-lint-shell-syntax" can be used to run only the check.

"make" will run check-non-portable-shell.pl followed by t0000.sh -- t99=
99.sh

"TEST_LINT=3D make" will only run t0000.sh -- t9999.sh

Helped-By: Jeff King <peff@peff.net>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---

Thanks for reviewing & suggestions
Changes since v1:

Makefile:
- "$TEST_LINT=3D make" will disable the check
check-non-portable-shell.pl:
- Much more perl style (instead of C-Code in perl language)
Hopefuly better commit message

 t/Makefile                    |  6 +++++-
 t/check-non-portable-shell.pl | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100755 t/check-non-portable-shell.pl

diff --git a/t/Makefile b/t/Makefile
index 88e289f..fd239cb 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -13,6 +13,7 @@ TAR ?=3D $(TAR)
 RM ?=3D rm -f
 PROVE ?=3D prove
 DEFAULT_TEST_TARGET ?=3D test
+TEST_LINT ?=3D test-lint-shell-syntax
=20
 # Shell quote;
 SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))
@@ -43,7 +44,7 @@ clean-except-prove-cache:
 clean: clean-except-prove-cache
 	$(RM) .prove
=20
-test-lint: test-lint-duplicates test-lint-executable
+test-lint: test-lint-duplicates test-lint-executable test-lint-shell-s=
yntax
=20
 test-lint-duplicates:
 	@dups=3D`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` &&=
 \
@@ -55,6 +56,9 @@ test-lint-executable:
 		test -z "$$bad" || { \
 		echo >&2 "non-executable tests:" $$bad; exit 1; }
=20
+test-lint-shell-syntax:
+	$(PERL_PATH) check-non-portable-shell.pl $(T)
+
 aggregate-results-and-cleanup: $(T)
 	$(MAKE) aggregate-results
 	$(MAKE) clean
diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell=
=2Epl
new file mode 100755
index 0000000..49d7291
--- /dev/null
+++ b/t/check-non-portable-shell.pl
@@ -0,0 +1,27 @@
+#!/usr/bin/perl
+
+# Test t0000..t9999.sh for non portable shell scripts
+# This script can be called with one or more filenames as parameters
+
+use strict;
+use warnings;
+
+my $exit_code=3D0;
+
+sub err {
+	my $msg =3D shift;
+	print "$ARGV:$.: error: $msg: $_\n";
+	$exit_code =3D 1;
+}
+
+while (<>) {
+	chomp;
+	/^\s*sed\s+-i/ and err 'sed -i is not portable';
+	/^\s*echo\s+-n/ and err 'echo -n is not portable (please use printf)'=
;
+	/^\s*declare\s+/ and err 'arrays/declare not portable';
+	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)=
';
+	/test\s+[^=3D]*=3D=3D/ and err '=3D=3D is not portable (please use =3D=
)';
+	# this resets our $. for each file
+	close ARGV if eof;
+}
+exit $exit_code;
--=20
1.8.0.197.g5a90748
