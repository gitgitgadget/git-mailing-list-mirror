From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Trailing whitespace and no newline fix
Date: Sat, 25 Jul 2009 01:37:35 -0700
Message-ID: <7vy6qdupio.fsf@alter.siamese.dyndns.org>
References: <1248308678-23280-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Jul 25 10:37:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUclR-0007sD-Ur
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 10:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbZGYIht convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Jul 2009 04:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752870AbZGYIht
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 04:37:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59228 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbZGYIhs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 04:37:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C6AC10EBA;
	Sat, 25 Jul 2009 04:37:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E30EA10EB9; Sat, 25 Jul 2009
 04:37:40 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6EA5330A-78F6-11DE-A6C7-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123995>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> If a patch adds a new line to the end of a file and this line ends wi=
th
> one trailing whitespace character and has no newline, then
> '--whitespace=3Dfix' currently does not remove that trailing whitespa=
ce.
>
> This patch fixes this by removing the check for trailing whitespace a=
t
> the end of the line at a hardcoded offset which does not take the
> eventual absence of newline into account.

This patch does a lot more than what it claims it does.

Try to apply Jakub's 10 patch series with this, with --whitespace=3Dfix=
, and
notice that the 9th patch gets all the blank lines removed, claiming th=
at
114 lines had whitespace errors, even though there is only one trailing
whitespace.=20

Here is a fix.  I am pissed at myself not spotting this earlier.  The
worst part is that it is part of 'maint' and all integration branches
needs fixing.

-- >8 --
=46rom: Junio C Hamano <gitster@pobox.com>
Date: Sat, 25 Jul 2009 01:29:20 -0700
Subject: [PATCH] Fix severe breakage in "git-apply --whitespace=3Dfix"

735c674 (Trailing whitespace and no newline fix, 2009-07-22) completely
broke --whitespace=3Dfix, causing it to lose all the empty lines in a p=
atch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4124-apply-ws-rule.sh |   10 +++++++---
 ws.c                     |    4 ++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 5698a9a..fac2093 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -154,7 +154,9 @@ create_patch () {
 		index e69de29..8bd6648 100644
 		--- a/target
 		+++ b/target
-		@@ -0,0 +1 @@
+		@@ -0,0 +1,3 @@
+		+An empty line follows
+		+
 		+A line with trailing whitespace and no newline_
 		\ No newline at end of file
 	EOF
@@ -162,8 +164,10 @@ create_patch () {
=20
 test_expect_success 'trailing whitespace & no newline at the end of fi=
le' '
 	>target &&
-	create_patch | git apply --whitespace=3Dfix - &&
-	grep "newline$" target
+	create_patch >patch-file &&
+	git apply --whitespace=3Dfix patch-file &&
+	grep "newline$" target &&
+	grep "^$" target
 '
=20
 test_done
diff --git a/ws.c b/ws.c
index 8d855b7..59d0883 100644
--- a/ws.c
+++ b/ws.c
@@ -262,10 +262,10 @@ int ws_fix_copy(char *dst, const char *src, int l=
en, unsigned ws_rule, int *erro
 	 * Strip trailing whitespace
 	 */
 	if (ws_rule & WS_TRAILING_SPACE) {
-		if (1 < len && src[len - 1] =3D=3D '\n') {
+		if (0 < len && src[len - 1] =3D=3D '\n') {
 			add_nl_to_tail =3D 1;
 			len--;
-			if (1 < len && src[len - 1] =3D=3D '\r') {
+			if (0 < len && src[len - 1] =3D=3D '\r') {
 				add_cr_to_tail =3D !!(ws_rule & WS_CR_AT_EOL);
 				len--;
 			}
--=20
1.6.4.rc2.19.gfa5c0
