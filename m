From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t9020: use configured Python to run test helper
Date: Tue, 18 Dec 2012 20:49:09 -0800
Message-ID: <7vip7yd4u2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 05:49:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlBb5-0008BR-Sk
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 05:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859Ab2LSEtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 23:49:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64140 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781Ab2LSEtR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 23:49:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 499CFABA6;
	Tue, 18 Dec 2012 23:49:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=A
	DM1i4c0omlZHzcGQEX1V89z6OM=; b=kBCpB6HpqqRlIHqK9gsQSN8ouzB4Q8q7T
	cUy1Ive592mlWSyxzT982V/grCJHrdOlkLcFQNeuT93HEegENvT53vBY0Q3Lh+73
	efk85dx893OIk+otDQS7X/yl0XS92rclk1YN0YpZwbR1qEUqBLi8amU1+hr2h0Je
	3MA69fUmP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=vXG
	0Jiue0ULKI6+Y+c0UKCXvqfjKm3zydiULLwrTZ/By142LyZMZnIRzmzysjYFminx
	jZ4LE7V68YEaezGJWtyN20B4FFkNIYAz1yOLwYsSZzW+OvT1VYvaozv2+6fNtw3b
	aBea6hmbgVXgSdjzjOqZ3PMiREFM+sZEk2hW6ops=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3456BABA5;
	Tue, 18 Dec 2012 23:49:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA90AABA1; Tue, 18 Dec 2012
 23:49:13 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FB780FC-4997-11E2-8E33-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211802>

The test helper svnrdump_sim.py is used as "svnrdump" during the
execution of this test, but the arrangement had a few undesirable
things:

 - it relied on symbolic links;
 - unportable "export VAR=VAL" was used;
 - GIT_BUILD_DIR variable was not quoted correctly;
 - it assumed that the Python interpreter is in /usr/bin/ and
   called "python" (i.e. not "python2.7" etc.)

Rework this by writing a small shell script that spawns the right
Python interpreter, using the right quoting.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The analysis above counts more bugs than the number of lines that
   are deleted in this section of the code...

 t/t9020-remote-svn.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
index 4f2dfe0..d7be66a 100755
--- a/t/t9020-remote-svn.sh
+++ b/t/t9020-remote-svn.sh
@@ -12,9 +12,13 @@ then
 	test_done
 fi
 
-# We override svnrdump by placing a symlink to the svnrdump-emulator in .
-export PATH="$HOME:$PATH"
-ln -sf $GIT_BUILD_DIR/contrib/svn-fe/svnrdump_sim.py "$HOME/svnrdump"
+# Override svnrdump with our simulator
+PATH="$HOME:$PATH"
+export PATH PYTHON_PATH GIT_BUILD_DIR
+
+write_script "$HOME/svnrdump" <<\EOF
+exec "$PYTHON_PATH" "$GIT_BUILD_DIR/contrib/svn-fe/svnrdump_sim.py" "$@"
+EOF
 
 init_git () {
 	rm -fr .git &&
-- 
1.8.1.rc2.196.g90926c8
