From: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
Subject: [PATCH v2 7/7] format-patch tests: check quoting/encoding in To: and Cc: headers
Date: Thu, 18 Oct 2012 16:43:34 +0200
Message-ID: <1350571414-17907-8-git-send-email-schnhrr@cs.tu-berlin.de>
References: <1350571414-17907-1-git-send-email-schnhrr@cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <schnhrr@cs.tu-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 16:51:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOrRQ-0004eY-Qg
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 16:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222Ab2JROvJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2012 10:51:09 -0400
Received: from mail.eecsit.tu-berlin.de ([130.149.17.13]:38497 "EHLO
	mail.cs.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932158Ab2JROvG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 10:51:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost-12225.cs.tu-berlin.de (Postfix) with ESMTP id 6A81F6405
	for <git@vger.kernel.org>; Thu, 18 Oct 2012 16:51:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cs.tu-berlin.de (including SpamAssassin)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
	by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 12224)
	with ESMTP id nFnU5oCzyQJQ 02389-17;
	Thu, 18 Oct 2012 16:50:42 +0200 (CEST) 13776
Received: from asahi.kbs.tu-berlin.de (asahi.kbs.tu-berlin.de [130.149.91.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: schnhrr)
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTPSA;
	Thu, 18 Oct 2012 16:50:42 +0200 (CEST)
X-Mailer: git-send-email 1.7.12
In-Reply-To: <1350571414-17907-1-git-send-email-schnhrr@cs.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208014>

=46rom: Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de>

git-format-patch does currently not parse user supplied extra header
values (e. g., --cc, --add-header) and just replays them. That forces
users to add them RFC 2822/2047 conform in encoded form, e. g.

--cc '=3D?UTF-8?q?Jan=3D20H=3D2E=3D20Sch=3DC3=3DB6nherr?=3D <...>'

which is inconvenient. We would want to update git-format-patch to
accept human-readable input

--cc 'Jan H. Sch=C3=B6nherr <...>'

and handle the encoding, wrapping and quoting internally in the future,
similar to what is already done in git-send-email. The necessary code
should mostly exist in the code paths that handle the From: and Subject=
:
headers.

Whether we want to do this only for the git-format-patch options
--to and --cc (and the corresponding config options) or also for
user supplied headers via --add-header, is open for discussion.

=46or now, add test_expect_failure tests for To: and Cc: headers as a
reminder and fix tests that would otherwise fail should this get
implemented.

Signed-off-by: Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de>
---
This patch is RFC material. There are a few reasons, why this
is a good idea and also a few, why it is bad:

Pro:
- current git-format-patch behavior differs from git-send-email
- we should be able to use the address format that git uses
  elsewhere (e. g., author and committer info)
- necessary code mostly exists

Con:
- changes current behavior
- make code more complex

(Feel free to add more.)

The first drawback can be mitigated by checking whether the
input is already properly encoded, so that we do not accidentally
double-encode things. git-send-email does that, but that's written
in Perl, so we would need even more code.

=46or now, this is only about _addresses_ supplied to git-format-patch,
not _headers_. We could also validate/encode/wrap user supplied headers=
=2E
RFC 2822/2047 is specific enough to allow that. But there is no point
thinking about that without the intention of encoding addresses.

v2:
- updated commit message as suggested by Junio C Hamano
---
 t/t4014-format-patch.sh | 98 +++++++++++++++++++++++++++++++++--------=
--------
 1 Datei ge=C3=A4ndert, 66 Zeilen hinzugef=C3=BCgt(+), 32 Zeilen entfer=
nt(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index e024eb8..ad9f69e 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -110,73 +110,107 @@ test_expect_success 'replay did not screw up the=
 log message' '
=20
 test_expect_success 'extra headers' '
=20
-	git config format.headers "To: R. E. Cipient <rcipient@example.com>
+	git config format.headers "To: R E Cipient <rcipient@example.com>
 " &&
-	git config --add format.headers "Cc: S. E. Cipient <scipient@example.=
com>
+	git config --add format.headers "Cc: S E Cipient <scipient@example.co=
m>
 " &&
 	git format-patch --stdout master..side > patch2 &&
 	sed -e "/^\$/q" patch2 > hdrs2 &&
-	grep "^To: R. E. Cipient <rcipient@example.com>\$" hdrs2 &&
-	grep "^Cc: S. E. Cipient <scipient@example.com>\$" hdrs2
+	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs2 &&
+	grep "^Cc: S E Cipient <scipient@example.com>\$" hdrs2
=20
 '
=20
 test_expect_success 'extra headers without newlines' '
=20
-	git config --replace-all format.headers "To: R. E. Cipient <rcipient@=
example.com>" &&
-	git config --add format.headers "Cc: S. E. Cipient <scipient@example.=
com>" &&
+	git config --replace-all format.headers "To: R E Cipient <rcipient@ex=
ample.com>" &&
+	git config --add format.headers "Cc: S E Cipient <scipient@example.co=
m>" &&
 	git format-patch --stdout master..side >patch3 &&
 	sed -e "/^\$/q" patch3 > hdrs3 &&
-	grep "^To: R. E. Cipient <rcipient@example.com>\$" hdrs3 &&
-	grep "^Cc: S. E. Cipient <scipient@example.com>\$" hdrs3
+	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs3 &&
+	grep "^Cc: S E Cipient <scipient@example.com>\$" hdrs3
=20
 '
=20
 test_expect_success 'extra headers with multiple To:s' '
=20
-	git config --replace-all format.headers "To: R. E. Cipient <rcipient@=
example.com>" &&
-	git config --add format.headers "To: S. E. Cipient <scipient@example.=
com>" &&
+	git config --replace-all format.headers "To: R E Cipient <rcipient@ex=
ample.com>" &&
+	git config --add format.headers "To: S E Cipient <scipient@example.co=
m>" &&
 	git format-patch --stdout master..side > patch4 &&
 	sed -e "/^\$/q" patch4 > hdrs4 &&
-	grep "^To: R. E. Cipient <rcipient@example.com>,\$" hdrs4 &&
-	grep "^ *S. E. Cipient <scipient@example.com>\$" hdrs4
+	grep "^To: R E Cipient <rcipient@example.com>,\$" hdrs4 &&
+	grep "^ *S E Cipient <scipient@example.com>\$" hdrs4
 '
=20
-test_expect_success 'additional command line cc' '
+test_expect_success 'additional command line cc (ascii)' '
=20
-	git config --replace-all format.headers "Cc: R. E. Cipient <rcipient@=
example.com>" &&
+	git config --replace-all format.headers "Cc: R E Cipient <rcipient@ex=
ample.com>" &&
+	git format-patch --cc=3D"S E Cipient <scipient@example.com>" --stdout=
 master..side | sed -e "/^\$/q" >patch5 &&
+	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch5 &&
+	grep "^ *S E Cipient <scipient@example.com>\$" patch5
+'
+
+test_expect_failure 'additional command line cc (rfc822)' '
+
+	git config --replace-all format.headers "Cc: R E Cipient <rcipient@ex=
ample.com>" &&
 	git format-patch --cc=3D"S. E. Cipient <scipient@example.com>" --stdo=
ut master..side | sed -e "/^\$/q" >patch5 &&
-	grep "^Cc: R. E. Cipient <rcipient@example.com>,\$" patch5 &&
-	grep "^ *S. E. Cipient <scipient@example.com>\$" patch5
+	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch5 &&
+	grep "^ *"S. E. Cipient" <scipient@example.com>\$" patch5
 '
=20
 test_expect_success 'command line headers' '
=20
 	git config --unset-all format.headers &&
-	git format-patch --add-header=3D"Cc: R. E. Cipient <rcipient@example.=
com>" --stdout master..side | sed -e "/^\$/q" >patch6 &&
-	grep "^Cc: R. E. Cipient <rcipient@example.com>\$" patch6
+	git format-patch --add-header=3D"Cc: R E Cipient <rcipient@example.co=
m>" --stdout master..side | sed -e "/^\$/q" >patch6 &&
+	grep "^Cc: R E Cipient <rcipient@example.com>\$" patch6
 '
=20
 test_expect_success 'configuration headers and command line headers' '
=20
-	git config --replace-all format.headers "Cc: R. E. Cipient <rcipient@=
example.com>" &&
-	git format-patch --add-header=3D"Cc: S. E. Cipient <scipient@example.=
com>" --stdout master..side | sed -e "/^\$/q" >patch7 &&
-	grep "^Cc: R. E. Cipient <rcipient@example.com>,\$" patch7 &&
-	grep "^ *S. E. Cipient <scipient@example.com>\$" patch7
+	git config --replace-all format.headers "Cc: R E Cipient <rcipient@ex=
ample.com>" &&
+	git format-patch --add-header=3D"Cc: S E Cipient <scipient@example.co=
m>" --stdout master..side | sed -e "/^\$/q" >patch7 &&
+	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch7 &&
+	grep "^ *S E Cipient <scipient@example.com>\$" patch7
 '
=20
-test_expect_success 'command line To: header' '
+test_expect_success 'command line To: header (ascii)' '
=20
 	git config --unset-all format.headers &&
+	git format-patch --to=3D"R E Cipient <rcipient@example.com>" --stdout=
 master..side | sed -e "/^\$/q" >patch8 &&
+	grep "^To: R E Cipient <rcipient@example.com>\$" patch8
+'
+
+test_expect_failure 'command line To: header (rfc822)' '
+
 	git format-patch --to=3D"R. E. Cipient <rcipient@example.com>" --stdo=
ut master..side | sed -e "/^\$/q" >patch8 &&
-	grep "^To: R. E. Cipient <rcipient@example.com>\$" patch8
+	grep "^To: "R. E. Cipient" <rcipient@example.com>\$" patch8
+'
+
+test_expect_failure 'command line To: header (rfc2047)' '
+
+	git format-patch --to=3D"R =C3=84 Cipient <rcipient@example.com>" --s=
tdout master..side | sed -e "/^\$/q" >patch8 &&
+	grep "^To: =3D?UTF-8?q?R=3D20=3DC3=3D84=3D20Cipient?=3D <rcipient@exa=
mple.com>\$" patch8
 '
=20
-test_expect_success 'configuration To: header' '
+test_expect_success 'configuration To: header (ascii)' '
+
+	git config format.to "R E Cipient <rcipient@example.com>" &&
+	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
+	grep "^To: R E Cipient <rcipient@example.com>\$" patch9
+'
+
+test_expect_failure 'configuration To: header (rfc822)' '
=20
 	git config format.to "R. E. Cipient <rcipient@example.com>" &&
 	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
-	grep "^To: R. E. Cipient <rcipient@example.com>\$" patch9
+	grep "^To: "R. E. Cipient" <rcipient@example.com>\$" patch9
+'
+
+test_expect_failure 'configuration To: header (rfc2047)' '
+
+	git config format.to "R =C3=84 Cipient <rcipient@example.com>" &&
+	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
+	grep "^To: =3D?UTF-8?q?R=3D20=3DC3=3D84=3D20Cipient?=3D <rcipient@exa=
mple.com>\$" patch9
 '
=20
 # check_patch <patch>: Verify that <patch> looks like a half-sane
@@ -190,11 +224,11 @@ check_patch () {
 test_expect_success '--no-to overrides config.to' '
=20
 	git config --replace-all format.to \
-		"R. E. Cipient <rcipient@example.com>" &&
+		"R E Cipient <rcipient@example.com>" &&
 	git format-patch --no-to --stdout master..side |
 	sed -e "/^\$/q" >patch10 &&
 	check_patch patch10 &&
-	! grep "^To: R. E. Cipient <rcipient@example.com>\$" patch10
+	! grep "^To: R E Cipient <rcipient@example.com>\$" patch10
 '
=20
 test_expect_success '--no-to and --to replaces config.to' '
@@ -212,21 +246,21 @@ test_expect_success '--no-to and --to replaces co=
nfig.to' '
 test_expect_success '--no-cc overrides config.cc' '
=20
 	git config --replace-all format.cc \
-		"C. E. Cipient <rcipient@example.com>" &&
+		"C E Cipient <rcipient@example.com>" &&
 	git format-patch --no-cc --stdout master..side |
 	sed -e "/^\$/q" >patch12 &&
 	check_patch patch12 &&
-	! grep "^Cc: C. E. Cipient <rcipient@example.com>\$" patch12
+	! grep "^Cc: C E Cipient <rcipient@example.com>\$" patch12
 '
=20
 test_expect_success '--no-add-header overrides config.headers' '
=20
 	git config --replace-all format.headers \
-		"Header1: B. E. Cipient <rcipient@example.com>" &&
+		"Header1: B E Cipient <rcipient@example.com>" &&
 	git format-patch --no-add-header --stdout master..side |
 	sed -e "/^\$/q" >patch13 &&
 	check_patch patch13 &&
-	! grep "^Header1: B. E. Cipient <rcipient@example.com>\$" patch13
+	! grep "^Header1: B E Cipient <rcipient@example.com>\$" patch13
 '
=20
 test_expect_success 'multiple files' '
--=20
1.7.12
