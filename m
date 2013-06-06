From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] t0005: skip signal death exit code test on Windows
Date: Thu, 06 Jun 2013 08:34:41 +0200
Message-ID: <51B02D81.3000700@viscovery.net>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <51AEE1C3.9020507@viscovery.net> <20130605071206.GC14427@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 06 08:34:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkTmi-0004su-2s
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 08:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167Ab3FFGeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 02:34:50 -0400
Received: from so.liwest.at ([212.33.55.13]:28981 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753969Ab3FFGeu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 02:34:50 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UkTmU-0005Rd-K1; Thu, 06 Jun 2013 08:34:42 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 442541660F;
	Thu,  6 Jun 2013 08:34:41 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <20130605071206.GC14427@sigill.intra.peff.net>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226479>

From: Johannes Sixt <j6t@kdbg.org>

The test case depends on that test-sigchain can commit suicide by a call
to raise(SIGTERM) in a way that run-command.c::wait_or_whine() can detect
as death through a signal. There are no POSIX signals on Windows, and a
sufficiently close emulation is not available in the Microsoft C runtime
(and probably not even possible).

The particular deficiency is that when a signal is raise()d whose SIG_DFL
action will cause process death (SIGTERM in this case), the
implementation of raise() just calls exit(3).

We could check for exit code 3 in addition to 143, but that would miss
the point of the test entirely. Hence, just skip it on Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t0005-signals.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index ad9e604..981437b 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -20,7 +20,7 @@ test_expect_success 'sigchain works' '
 	test_cmp expect actual
 '
 
-test_expect_success 'signals are propagated using shell convention' '
+test_expect_success !MINGW 'signals are propagated using shell convention' '
 	# we use exec here to avoid any sub-shell interpretation
 	# of the exit code
 	git config alias.sigterm "!exec test-sigchain" &&
-- 
1.8.3.1489.g15123b5
