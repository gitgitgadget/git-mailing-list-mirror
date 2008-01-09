From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sideband.c: Use xmalloc() instead of variable-sized arrays.
Date: Tue, 08 Jan 2008 23:53:04 -0800
Message-ID: <7vk5mjmo4f.fsf@gitster.siamese.dyndns.org>
References: <4783A3B2.3060801@viscovery.net>
	<alpine.LFD.1.00.0801081154460.3054@xanadu.home>
	<4784791F.6090904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 09 08:53:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCVl3-0005mn-Vu
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 08:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbYAIHx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 02:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbYAIHx0
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 02:53:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbYAIHxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 02:53:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 965543DA5;
	Wed,  9 Jan 2008 02:53:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 81CE03DA4;
	Wed,  9 Jan 2008 02:53:16 -0500 (EST)
In-Reply-To: <4784791F.6090904@viscovery.net> (Johannes Sixt's message of
	"Wed, 09 Jan 2008 08:34:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69960>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Having said that, I'd actually prefer to stay with variable-sized arrays
> if they prove portable enough because we don't need the handful of free()s
> on function exits. Junio, if you like I can resend patch 2/2 using
> variable-sized arrays.

As an old fashoned git myself, and given the fact that the
possible prefix and suffix are small number of short constant
strings, I actually prefer a simpler-and-more-stupid approach.

 sideband.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/sideband.c b/sideband.c
index 756bbc2..24f7f12 100644
--- a/sideband.c
+++ b/sideband.c
@@ -13,14 +13,22 @@
  */
 
 #define PREFIX "remote:"
-#define SUFFIX "\033[K"  /* change to "        " if ANSI sequences don't work */
 
 int recv_sideband(const char *me, int in_stream, int out, int err)
 {
 	unsigned pf = strlen(PREFIX);
-	unsigned sf = strlen(SUFFIX);
-	char buf[pf + LARGE_PACKET_MAX + sf + 1];
+	unsigned sf;
+	char buf[LARGE_PACKET_MAX + 100]; /* for marker slop */
+	char *suffix, *term;
+
 	memcpy(buf, PREFIX, pf);
+	term = getenv("TERM");
+	if (term && strcmp(term, "dumb"))
+		suffix = "\033[K";
+	else
+		suffix = "        ";
+	sf = strlen(suffix);
+
 	while (1) {
 		int band, len;
 		len = packet_read_line(in_stream, buf + pf, LARGE_PACKET_MAX);
@@ -59,10 +67,10 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 				 * line data actually contains something.
 				 */
 				if (brk > pf+1 + 1) {
-					char save[sf];
+					char save[100]; /* enough slop */
 					memcpy(save, buf + brk, sf);
 					buf[brk + sf - 1] = buf[brk - 1];
-					memcpy(buf + brk - 1, SUFFIX, sf);
+					memcpy(buf + brk - 1, suffix, sf);
 					safe_write(err, buf, brk + sf);
 					memcpy(buf + brk, save, sf);
 				} else
