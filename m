From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] xdiff-interface.c: strip newline (and cr) from line before
 pattern matching
Date: Wed, 01 Oct 2008 14:28:26 -0500
Message-ID: <o5dqpNECJusQHKCTvRWiIqN2ZJ7w-fyC-0vM99FajJIgLsOwP3RNug@cipher.nrlssc.navy.mil>
References: <mJtumbyBuR0sRaFjwb6O5_D_ps0fVfz6APTAAjYMixV0MvzP8nEZRw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 21:30:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl7PH-0005wm-Lq
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 21:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbYJAT3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 15:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbYJAT3b
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 15:29:31 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60550 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408AbYJAT3a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 15:29:30 -0400
Received: by mail.nrlssc.navy.mil id m91JSQBX013297; Wed, 1 Oct 2008 14:28:26 -0500
In-Reply-To: <mJtumbyBuR0sRaFjwb6O5_D_ps0fVfz6APTAAjYMixV0MvzP8nEZRw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 01 Oct 2008 19:28:26.0806 (UTC) FILETIME=[E08FE560:01C923FB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97254>

POSIX doth sayeth:

   "In the regular expression processing described in IEEE Std 1003.1-2001,
    the <newline> is regarded as an ordinary character and both a period and
    a non-matching list can match one. ... Those utilities (like grep) that
    do not allow <newline>s to match are responsible for eliminating any
    <newline> from strings before matching against the RE."

Thus far git has not been removing the trailing newline from strings matched
against regular expression patterns. This has the effect that (quoting
Jonathan del Strother) "... a line containing just 'FUNCNAME' (terminated by
a newline) will be matched by the pattern '^(FUNCNAME.$)' but not
'^(FUNCNAME$)'", and more simply not '^FUNCNAME$'.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


This could be a little simpler if I knew what was guaranteed from xdiff.
Such as whether the len elements of line were guaranteed to be newline
terminated, or be greater than zero. But, the code in def_ff() in xemit.c
is wrapped in 'if (len > 0)', so..

-brandon


 xdiff-interface.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 8bab82e..61f5dab 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -191,12 +191,22 @@ struct ff_regs {
 static long ff_regexp(const char *line, long len,
 		char *buffer, long buffer_size, void *priv)
 {
-	char *line_buffer = xstrndup(line, len); /* make NUL terminated */
+	char *line_buffer;
 	struct ff_regs *regs = priv;
 	regmatch_t pmatch[2];
 	int i;
 	int result = -1;
 
+	/* Exclude terminating newline (and cr) from matching */
+	if (len > 0 && line[len-1] == '\n') {
+		if (len > 1 && line[len-2] == '\r')
+			len -= 2;
+		else
+			len--;
+	}
+
+	line_buffer = xstrndup(line, len); /* make NUL terminated */
+
 	for (i = 0; i < regs->nr; i++) {
 		struct ff_reg *reg = regs->array + i;
 		if (!regexec(&reg->re, line_buffer, 2, pmatch, 0)) {
-- 
1.6.0.2.323.g7c850
