From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: [PATCH/RFC] sideband: remove line padding (was: Re: [PATCH]
 progress: use \r as EOL only if isatty(stderr) is true)
Date: Wed, 29 Jun 2011 19:42:20 +0200
Message-ID: <20110629174220.GA36658@sherwood.local>
References: <1309272009-23076-1-git-send-email-sdaoden@gmail.com>
 <7vwrg5u7oz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@cam.org>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 19:42:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbymY-0002uG-Gl
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 19:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757351Ab1F2Rma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 13:42:30 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:42868 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756746Ab1F2Rm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 13:42:29 -0400
Received: by fxd18 with SMTP id 18so1445030fxd.11
        for <git@vger.kernel.org>; Wed, 29 Jun 2011 10:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Sfxsoby2NiP9ekpfVk3TT/tkN6082ch6ng7GLxPI7iI=;
        b=e8WMa+rGJNXWF1RtMU8Ozn5JeczRyt9WnZoeSVDPv0uMdZ6kJ9FED756oxOzTx+MMY
         HozpiGWpOE6qlmj40SgcwzXE4oNvqhGFc64U3662HU6dn1nU/sxdI2g4vYTfg/wylt9h
         NORZ9sZ0SXL2lJsJyHM1pwwAoj8gTUUI5oDQA=
Received: by 10.223.85.155 with SMTP id o27mr1550057fal.109.1309369348109;
        Wed, 29 Jun 2011 10:42:28 -0700 (PDT)
Received: from sherwood.local ([82.113.99.186])
        by mx.google.com with ESMTPS id g12sm1006764fai.8.2011.06.29.10.42.24
        (version=SSLv3 cipher=OTHER);
        Wed, 29 Jun 2011 10:42:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwrg5u7oz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176453>

I desperately tried to reproduce the 'xy  ^Mxy  ^M' case, but i
can't.  In fact i cannot even find a piece of code which would do
it.  :-/  Such a shame.
Still: i insist on having that seen in my arena-manager.log.

While searching around i stumbled over fetch-pack output with an
ANSI escape sequence after a '(xy) 2>&1 | tee LOG'.
--
Ciao, Steffen
sdaoden(*)(gmail.com)
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments

-- >8 --
Subject: [PATCH/RFC] sideband: remove line padding

For formatting purposes recv_sideband() sofar appended a suffix to
band #2 (informative) messages: dependent on getenv("TERM") lines
may have been space-filled ("dumb") or padded with an ANSI escape
sequence (ANSI EL, mode 0: clear from cursor to end of line).  This
patch removes handling of terminal specifics and any pad suffixes.

It also fixes two 'signed/unsigned comparison' compiler warnings.

Signed-off-by: Steffen Daode Nurpmeso <sdaoden@gmail.com>
---
I believe that users of fetch-pack, send-pack and archive, the three
affected operations, will ensure that lines are refreshed as approbiate,
even if 'brk-1' == CR.  But even if not: i would move handling of
"TERM" and dumb/non-dumb terminals out of this packet handler and
into some terminal encapsulator, which can only be color.* as far
as i see.  The question would be how this should be done.  Maybe
term_fprintf_padln(?, desired-line-length-or--1)?  Such a thing would
surely find other users in the codebase.  A second approach would
be to only use the "dumb" pad, as in

    fprintf(stderr, "%.*s        %c", brk - 1, b, b[brk - 1]);

What do you think of that?

 sideband.c |   35 +++++------------------------------
 1 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/sideband.c b/sideband.c
index d5ffa1c..17e1793 100644
--- a/sideband.c
+++ b/sideband.c
@@ -14,26 +14,13 @@
 
 #define PREFIX "remote:"
 
-#define ANSI_SUFFIX "\033[K"
-#define DUMB_SUFFIX "        "
-
-#define FIX_SIZE 10  /* large enough for any of the above */
-
 int recv_sideband(const char *me, int in_stream, int out)
 {
-	unsigned pf = strlen(PREFIX);
-	unsigned sf;
-	char buf[LARGE_PACKET_MAX + 2*FIX_SIZE];
-	char *suffix, *term;
+	unsigned pf = sizeof(PREFIX) - 1;
+	char buf[LARGE_PACKET_MAX + 2*sizeof(PREFIX)];
 	int skip_pf = 0;
 
 	memcpy(buf, PREFIX, pf);
-	term = getenv("TERM");
-	if (term && strcmp(term, "dumb"))
-		suffix = ANSI_SUFFIX;
-	else
-		suffix = DUMB_SUFFIX;
-	sf = strlen(suffix);
 
 	while (1) {
 		int band, len;
@@ -82,20 +69,8 @@ int recv_sideband(const char *me, int in_stream, int out)
 						break;
 				}
 
-				/*
-				 * Let's insert a suffix to clear the end
-				 * of the screen line if a line break was
-				 * found.  Also, if we don't skip the
-				 * prefix, then a non-empty string must be
-				 * present too.
-				 */
-				if (brk > (skip_pf ? 0 : (pf+1 + 1))) {
-					char save[FIX_SIZE];
-					memcpy(save, b + brk, sf);
-					b[brk + sf - 1] = b[brk - 1];
-					memcpy(b + brk - 1, suffix, sf);
-					fprintf(stderr, "%.*s", brk + sf, b);
-					memcpy(b + brk, save, sf);
+				if ((unsigned)brk > (skip_pf ? 0 : (pf+1 +1))) {
+					fprintf(stderr, "%.*s", brk, b);
 					len -= brk;
 				} else {
 					int l = brk ? brk : len;
@@ -133,7 +108,7 @@ ssize_t send_sideband(int fd, int band, const char *data, ssize_t sz, int packet
 		char hdr[5];
 
 		n = sz;
-		if (packet_max - 5 < n)
+		if ((unsigned)packet_max - 5 < n)
 			n = packet_max - 5;
 		if (0 <= band) {
 			sprintf(hdr, "%04x", n + 5);
-- 
1.7.6.1.ge79e.dirty
