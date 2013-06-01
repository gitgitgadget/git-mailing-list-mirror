From: Jeff King <peff@peff.net>
Subject: [PATCH] t0005: test git exit code from signal death
Date: Sat, 1 Jun 2013 13:24:41 -0400
Message-ID: <20130601172441.GB19234@sigill.intra.peff.net>
References: <1370094715-2684-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8Df-O=D5LQBXCbiVLB=uHfn6ETbAxADWq3hd-9pPX4+mg@mail.gmail.com>
 <CAMP44s0L1M+_s2eDM=Ogy=rxLhpZYwSb8qWTuEe30pB4KGDVtA@mail.gmail.com>
 <CACsJy8BFv7kJkymJ_rj9dwaN-zMcHtS9sjmqDSpLWB5TsUU_kg@mail.gmail.com>
 <CAMP44s2cBGc+uKH0t-KZko-5GYkZUK54+7wiYbWim55B7KGaGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"John J. Franey" <jjfraney@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 19:25:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UipY5-0003MT-Ku
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 19:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333Ab3FARYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 13:24:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:42535 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751881Ab3FARYn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 13:24:43 -0400
Received: (qmail 23003 invoked by uid 102); 1 Jun 2013 17:25:26 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 01 Jun 2013 12:25:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Jun 2013 13:24:41 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s2cBGc+uKH0t-KZko-5GYkZUK54+7wiYbWim55B7KGaGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226141>

On Sat, Jun 01, 2013 at 10:01:49AM -0500, Felipe Contreras wrote:

> Anyway, if you care so much about the current behavior, why isn't
> there any tests that check for this?
> 
> My patch passes *all* the tests.

The test suite has never been (and probably never will be) a complete
specification of git's behavior. Noticing that a desired behavior is not
in the test suite is an opportunity to improve its coverage, not argue
that a change which breaks the desired behavior must therefore be
acceptable.

We could do something like the patch below, with two caveats:

  1. The test immediately before it checks for exit codes other than
     "143" on various platforms. I do not know to what degree we need to
     deal with that here. Git is doing the interpretation here rather
     than the shell, so the ksh case should not matter. But I do not
     know what part of Windows converts the exit code to 3. Do we need
     to be looking for 3? Or 131 (128+3)?

  2. The test detects a total breakage of the exit code, like the one
     caused by your patch. But I do not know if it would reliably detect
     us failing to convert the code at all, as the shell running the
     test harness would presumably convert it to shell-convention
     itself. Getting around that would require a custom C program
     checking the status returned by waitpid().

     On the other hand, perhaps it is not the conversion we care about;
     as long as we end up with 143, we are fine. We just want to make
     sure that signal death is recorded in _one_ of the potential signal
     formats. So we do not care if git or the shell did the conversion,
     as long as we end up with 143. The real breakage is exiting with
     code 15, which is losing information.

-- >8 --
Subject: [PATCH] t0005: test git exit code from signal death

When a sub-process dies with a signal, we convert the exit
code to the shell convention of 128+sig. Callers of git may
be relying on this behavior, so let's make sure it does not
break.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0005-signals.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index 93e58c0..63f9764 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -20,4 +20,11 @@ test_expect_success 'sigchain works' '
 	test_cmp expect actual
 '
 
+test_expect_success 'signals are propagated using shell convention' '
+	# we use exec here to avoid any sub-shell interpretation
+	# of the exit code
+	git config alias.sigterm "!exec test-sigchain" &&
+	test_expect_code 143 git sigterm
+'
+
 test_done
-- 
1.8.3.rc1.2.g12db477
