From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 1/2] tests: move code to run completion tests under bash
	into a helper library
Date: Tue, 17 Apr 2012 00:09:35 +0200
Message-ID: <1334614176-2963-1-git-send-email-szeder@ira.uka.de>
References: <20120416160124.GL5813@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 00:10:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJu8B-0007pA-AO
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 00:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135Ab2DPWJx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 18:09:53 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:49272 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab2DPWJw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 18:09:52 -0400
Received: from localhost6.localdomain6 (p5B130635.dip0.t-ipconnect.de [91.19.6.53])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0Mg0KT-1Sf8Qu3s6X-00NSzy; Tue, 17 Apr 2012 00:09:46 +0200
X-Mailer: git-send-email 1.7.10.216.gb52c0
In-Reply-To: <20120416160124.GL5813@burratino>
X-Provags-ID: V02:K0:evtx/uWAFXPFMCuB2h4OibdwcVL6vW5zEPJf55iIHfc
 Bgq4C7seK0Y+vDWG6w3v2XHfN148dh31XZcvrnM7y9jXgQXZCc
 5eo0WIhrl1k+uPXPkfNXvtqZDHjd4RaUmPBcjiNwsZUX+fdyhV
 3aTzQUBncfuYJ3cxgfw/A3KV5aCqPNtPCCGwIW4NxxutwiC93e
 WVzVWdvnT2ursmTtpQhZLZo7s+t0t6VQ5dPzWOBKxNP8Q7cyxY
 YgOSNl7icAWs3wpZfTC+fbngR7BU2pKfA5K2Zex5MbHSTFteZZ
 REn3h/yHCbG8nt61myrEDCrfdQ8OB7lAV1GG793el6R6Ptv2N5
 M08kUkBOUCb6Tb1euPmvIzmga59xPLYHKYcJq/rW/VjW6vUumj
 5fXiLSNurqltA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195711>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

On Mon, Apr 16, 2012 at 11:01:24AM -0500, Jonathan Nieder wrote:
> SZEDER G=C3=A1bor wrote:
>=20
> > I thought about that briefly but decided against it to avoid
> > duplicating the bash-specific checks at the beginning, but I don't
> > care that much either way.
>=20
> Maybe a t/lib-completion.sh would take care of that.

Here you go.  I put only the conditionals to run the test script under
Bash and the sourcing of test-lib.sh into t/lib-completion.sh, because
that's the common part that is required by the prompt tests, too.  So i=
n
the end I'm not sure that t/lib-completion.sh is the right name for thi=
s
file.

This patch could probably be squashed into the first commit of
fc/completion-tests, i.e. 5c293a6b (tests: add initial bash completion
tests, 2012-04-12).

 t/lib-completion.sh   |   17 +++++++++++++++++
 t/t9902-completion.sh |   14 +-------------
 2 files changed, 18 insertions(+), 13 deletions(-)
 create mode 100644 t/lib-completion.sh

diff --git a/t/lib-completion.sh b/t/lib-completion.sh
new file mode 100644
index 00000000..3d85feb2
--- /dev/null
+++ b/t/lib-completion.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+#
+# Ensures that tests of the completion script are run under Bash.
+
+if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
+	# we are in full-on bash mode
+	true
+elif type bash >/dev/null 2>&1; then
+	# execute in full-on bash mode
+	unset POSIXLY_CORRECT
+	exec bash "$0" "$@"
+else
+	echo '1..0 #SKIP skipping bash completion tests; bash not available'
+	exit 0
+fi
+
+. ./test-lib.sh
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a6eaa15c..90b2f22e 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -3,21 +3,9 @@
 # Copyright (c) 2012 Felipe Contreras
 #
=20
-if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
-	# we are in full-on bash mode
-	true
-elif type bash >/dev/null 2>&1; then
-	# execute in full-on bash mode
-	unset POSIXLY_CORRECT
-	exec bash "$0" "$@"
-else
-	echo '1..0 #SKIP skipping bash completion tests; bash not available'
-	exit 0
-fi
-
 test_description=3D'test bash completion'
=20
-. ./test-lib.sh
+. ./lib-completion.sh
=20
 complete ()
 {
--=20
1.7.10.216.gb52c0
