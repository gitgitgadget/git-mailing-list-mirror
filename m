From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] mingw: make mingw_signal return the correct handler
Date: Mon, 10 Jun 2013 07:48:17 +0200
Message-ID: <51B568A1.9090409@viscovery.net>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <51AEE1C3.9020507@viscovery.net> <20130605071206.GC14427@sigill.intra.peff.net> <51B02D81.3000700@viscovery.net> <20130606063754.GA20050@sigill.intra.peff.net> <CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com> <20130606064409.GA20334@sigill.intra.peff.net> <7vy5anyx1w.fsf@alter.siamese.dyndns.org> <20130606174032.GB32174@sigill.intra.peff.net> <CABPQNSYLmFWkdgph6W7MwaSTe+zrU0AaJpj_v9z=cmvWu64HNA@mail.gmail.com> <51B1B4DF.90705@viscovery.net> <CABPQNSYE=Mvrmc44dZmKnB14KLh4A=HxWo2-xgnJRyj1Q+BJLg@mail.gmail.com> <51B1CFD4.3030908@viscovery.net> <CABPQNSasTdkmpeGWb7_wZK2cQhiOyF7bX5ObcBg5kHm0KBGS5w@mail.gmail.com> <51B1DB2A.2060306@viscovery.net> <CABPQNSa1-dna_b+q-U6jgYy7p6zeiT7dAwu1Mw47QAezSNYKqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Jun 10 07:49:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uluyh-0005h1-3f
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 07:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab3FJFtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 01:49:06 -0400
Received: from so.liwest.at ([212.33.55.13]:56647 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997Ab3FJFtF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 01:49:05 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UluyU-0006UL-E0; Mon, 10 Jun 2013 07:49:02 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2F3291660F;
	Mon, 10 Jun 2013 07:49:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CABPQNSa1-dna_b+q-U6jgYy7p6zeiT7dAwu1Mw47QAezSNYKqA@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227241>

From: Erik Faye-Lund <kusmabite@gmail.com>

Returning the SIGALRM handler for SIGINT is not very useful.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 6/7/2013 16:20, schrieb Erik Faye-Lund:
> On Fri, Jun 7, 2013 at 3:07 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> BTW, isn't mingw_signal() bogus in that it returns the SIGALRM handler
>> even if a SIGINT handler is installed?
> 
> Yep, that's a bug. Thanks for noticing.

This is your patch to address it.

> I've pushed out a branch here that tries to address these issues, but
> I haven't had time to test them. I'll post the series when I have. In
> the mean time:
> 
> https://github.com/kusma/git/tree/win32-signal-raise

Concerning the other two patches:

* SIGINT: perhaps handle only the SIG_DFL case (for the exit code) and
forward all other cases to MSVCRT?

* SIGTERM: it papers only over a general issue and should be dropped.

IMO.

-- Hannes

 compat/mingw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index b295e2f..bb92c43 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1677,14 +1677,16 @@ int sigaction(int sig, struct sigaction *in,
struct sigaction *out)
 #undef signal
 sig_handler_t mingw_signal(int sig, sig_handler_t handler)
 {
-	sig_handler_t old = timer_fn;
+	sig_handler_t old;

 	switch (sig) {
 	case SIGALRM:
+		old = timer_fn;
 		timer_fn = handler;
 		break;

 	case SIGINT:
+		old = sigint_fn;
 		sigint_fn = handler;
 		break;

-- 
1.8.3.1504.g78dbf7a
