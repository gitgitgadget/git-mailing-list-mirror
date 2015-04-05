From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] strbuf_getwholeline: use getc_unlocked
Date: Sun, 5 Apr 2015 01:27:33 -0400
Message-ID: <20150405052732.GA14771@peff.net>
References: <20150405010611.GA15901@peff.net>
 <20150405011110.GC30127@peff.net>
 <20150405045614.GA12053@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 07:27:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yed5y-0003ms-Dx
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 07:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbbDEF1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 01:27:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:42574 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750759AbbDEF1f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 01:27:35 -0400
Received: (qmail 5684 invoked by uid 102); 5 Apr 2015 05:27:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Apr 2015 00:27:35 -0500
Received: (qmail 3099 invoked by uid 107); 5 Apr 2015 05:27:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Apr 2015 01:27:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Apr 2015 01:27:33 -0400
Content-Disposition: inline
In-Reply-To: <20150405045614.GA12053@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266797>

On Sun, Apr 05, 2015 at 12:56:14AM -0400, Jeff King wrote:

> The big downside is that our input strings are no longer NUL-clean
> (reading "foo\0bar\n" would yield just "foo". I doubt that matters in
> the real world, but it does fail a few of the tests (e.g., t7008 tries
> to read a list of patterns which includes NUL, and we silently truncate
> the pattern rather than read in the NUL and barf).

So there is this trick:

diff --git a/strbuf.c b/strbuf.c
index f319d8d..5ceebb7 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -445,12 +445,13 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 	strbuf_reset(sb);
 
 	if (term == '\n') {
+		long pos = ftell(fp);
 		strbuf_grow(sb, 256);
 		if (!fgets(sb->buf, sb->alloc - 1, fp)) {
 			strbuf_release(sb);
 			return EOF;
 		}
-		sb->len = strlen(sb->buf);
+		sb->len = ftell(fp) - pos;
 		if (sb->buf[sb->len - 1] == '\n')
 			return 0;
 	}

but much to my surprise it actually runs slower than the strlen version!
It also has a 32-bit overflow issue. There's fgetpos() as an
alternative, but fpos_t is an opaque type, and we might not be able to
do arithmetic on it (for that matter, I am not sure if arithmetic is
strictly guaranteed on ftell() results). POSIX gives us ftello(), which
returns an off_t. That would probably be fine.

The ftello() version seems slower than the strlen, but faster than
ftell(). Puzzling.

-Peff
