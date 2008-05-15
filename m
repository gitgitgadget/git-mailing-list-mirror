From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] graph.c: fix padding
Date: Thu, 15 May 2008 09:50:05 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805150947060.30431@racer>
References: <alpine.DEB.1.00.0805141522060.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Adam Simpkins <adam@adamsimpkins.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 10:51:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwZAv-00011M-1c
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 10:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbYEOIuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 04:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753656AbYEOIuG
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 04:50:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:47810 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753375AbYEOIuF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 04:50:05 -0400
Received: (qmail invoked by alias); 15 May 2008 08:50:03 -0000
Received: from R33f0.r.pppool.de (EHLO racer.local) [89.54.51.240]
  by mail.gmx.net (mp016) with SMTP; 15 May 2008 10:50:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xorx0lrLxKl0qZIcsmPjnlpqSH7doy7llIzTdwJ
	xupZxTCeLUUCsz
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0805141522060.30431@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82189>

Hi,

On Wed, 14 May 2008, Johannes Schindelin wrote:

> There were two instances of "%*s" which want to be "%.*s" instead.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  graph.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

I am a moron.

Remember when I implemented a custom strbuf_vaddf() implementation that 
did not suffer these workarounds we have for "broken vaddf()" on AIX and 
Windows?

Well, I completely forgot about it, but I still have it in my personal 
tree.

And this implementation did not support "%*s", since there was no user for 
it before the addition of the --graph stuff.

So I have this in my tree now instead of the "fix" I am replying to:

-- snipsnap --
[PATCH] strbuf_vaddf(): support %*s, too

The recent addition of graph.c broke things with our custom implementation
of strbuf_vaddf(), because "%*s" was not yet supported (because it did not
have any users before).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 strbuf.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 466f999..8c11f15 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -155,6 +155,12 @@ void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap)
 			fill = *p++;
 		if (isdigit(*p))
 			size = (int)strtol(p, &p, 10);
+		else if (*p == '*') {
+			size = va_arg(ap, int);
+			if (!fill)
+				fill = ' ';
+			p++;
+		}
 		else if (!prefixcmp(p, ".*")) {
 			max_size = va_arg(ap, int);
 			p += 2;
-- 
1.5.5.1.375.g1becb
