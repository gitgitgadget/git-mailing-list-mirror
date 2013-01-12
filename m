From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t/lib-cvs: cvsimport no longer works without Python >= 2.7
Date: Sat, 12 Jan 2013 00:40:14 -0800
Message-ID: <7vip72iykx.fsf_-_@alter.siamese.dyndns.org>
References: <1357875152-19899-1-git-send-email-gitster@pobox.com>
 <7v62339du4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 09:45:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttwi4-0000Z9-56
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 09:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216Ab3ALIkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 03:40:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38207 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951Ab3ALIkR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 03:40:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 772CF990D;
	Sat, 12 Jan 2013 03:40:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X5Or2vyTs+LuNiewniNRl6w+m5M=; b=jO3jV+
	TtcEzty+BWBTGaMQGTuCmdCMULsyGdaikwMRx3LPFEKjSqCqhCsXX1A5eFmdFt+H
	Q5zJfcwj5nvAk+gkQl0LnMihu8dka+jZaG2fI4FcIoDKG1EcHERM4bX6p5V6oAN4
	Mg16K6KVNntQDSG60Fj4nhh/zKjUlUDAIoBco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AoJZIAo6oBBB1xshuxIQMq+VqOoUZj0E
	o73O/2KcNKGN8Xg2f3VGwRkEuPghwOG0ST94HKiEZGM2SPd7vlmw8pouuSmo/6xc
	D0U4vZyOuKdEgmXzQHtHddMFQlyhZ36wamk3UtG4XOyMWIB6td69VvOWiCO2hngS
	+QtVaWUiaFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CEAF990C;
	Sat, 12 Jan 2013 03:40:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7EFD990A; Sat, 12 Jan 2013
 03:40:15 -0500 (EST)
In-Reply-To: <7v62339du4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 11 Jan 2013 21:20:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B00F32D0-5C93-11E2-89A8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213277>

The new cvsimport requires at least Python 2.7 to work; do not fail
the cvsimport tests on platforms without one.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Junio C Hamano <gitster@pobox.com> writes:

 > http://docs.python.org/2/library/subprocess.html tells me that
 > check_output has first become available in 2.7.
 >
 > So... does this mean that we now set the minimum required version of
 > Python to 2.7?  I dunno.

 Even if we were to rip out the fallback code that uses the 2.7-only
 subprocess.check_output() on "cvsps -V", the function is also used
 for doing the real work interacting with cvsps-3.x, so I think this
 patch will be necessary.  Unless new cvsimport is tweaked not to
 use the method, that is.

 A suggestion for a better alternative is of course very much
 appreciated.

 I do not want to keep pushing integration results that do not pass
 tests even for myself for too many integration cycles, so I'll keep
 this patch at the tip of the topic, at least for now.

 t/lib-cvs.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
index b55e861..4e890ea 100644
--- a/t/lib-cvs.sh
+++ b/t/lib-cvs.sh
@@ -27,6 +27,21 @@ case "$cvsps_version" in
 	;;
 esac
 
+if ! test_have_prereq PYTHON
+then
+	skipall='skipping cvsimport tests, no python'
+	test_done
+fi
+
+python -c '
+import sys
+if sys.hexversion < 0x02070000:
+	sys.exit(1)
+' || {
+	skip_all='skipping cvsimport tests, python too old (< 2.7)'
+	test_done
+}
+
 setup_cvs_test_repository () {
 	CVSROOT="$(pwd)/.cvsroot" &&
 	cp -r "$TEST_DIRECTORY/$1/cvsroot" "$CVSROOT" &&
-- 
1.8.1.421.g6236851
