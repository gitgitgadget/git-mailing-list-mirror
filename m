From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/2] sideband.c: Use xmalloc() instead of variable-sized
 arrays.
Date: Wed, 09 Jan 2008 14:14:55 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801091412000.3054@xanadu.home>
References: <4783A3B2.3060801@viscovery.net>
 <alpine.LFD.1.00.0801081154460.3054@xanadu.home>
 <4784791F.6090904@viscovery.net> <7vk5mjmo4f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 20:15:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCgOt-0000Qi-7d
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 20:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbYAITO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 14:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754126AbYAITO6
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 14:14:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34289 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985AbYAITO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 14:14:57 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JUE004E55GVHW80@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 09 Jan 2008 14:14:56 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vk5mjmo4f.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70004>

On Tue, 8 Jan 2008, Junio C Hamano wrote:

> As an old fashoned git myself, and given the fact that the
> possible prefix and suffix are small number of short constant
> strings, I actually prefer a simpler-and-more-stupid approach.

OK.  However I think the following on top of your patch would look 
cleaner:

diff --git a/sideband.c b/sideband.c
index 91e462c..b677781 100644
--- a/sideband.c
+++ b/sideband.c
@@ -14,19 +14,24 @@
 
 #define PREFIX "remote:"
 
+#define ANSI_SUFFIX "\033[K"
+#define DUMB_SUFFIX "        "
+
+#define FIX_SIZE 10  /* large enough for any of the above */
+
 int recv_sideband(const char *me, int in_stream, int out, int err)
 {
 	unsigned pf = strlen(PREFIX);
 	unsigned sf;
-	char buf[LARGE_PACKET_MAX + 100]; /* for marker slop */
+	char buf[LARGE_PACKET_MAX + 2*FIX_SIZE];
 	char *suffix, *term;
 
 	memcpy(buf, PREFIX, pf);
 	term = getenv("TERM");
 	if (term && strcmp(term, "dumb"))
-		suffix = "\033[K";
+		suffix = ANSI_SUFFIX;
 	else
-		suffix = "        ";
+		suffix = DUMB_SUFFIX;
 	sf = strlen(suffix);
 
 	while (1) {
@@ -67,7 +72,7 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 				 * line data actually contains something.
 				 */
 				if (brk > pf+1 + 1) {
-					char save[100]; /* enough slop */
+					char save[FIX_SIZE];
 					memcpy(save, buf + brk, sf);
 					buf[brk + sf - 1] = buf[brk - 1];
 					memcpy(buf + brk - 1, suffix, sf);
