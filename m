From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mailsplit and mailinfo: gracefully handle NUL
 characters
Date: Sat, 17 May 2008 00:59:15 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805170058160.30431@racer>
References: <482BE5F7.2050108@thorn.ws>  <alpine.DEB.1.00.0805161139530.30431@racer>  <alpine.DEB.1.00.0805161148010.30431@racer>  <alpine.DEB.1.00.0805161403130.30431@racer>  <32541b130805160703r27a55b91xbad03eb1d107a176@mail.gmail.com> 
 <alpine.DEB.1.00.0805161529390.30431@racer> <32541b130805160756h5a8fc4d7x313f9bfde4760568@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tommy Thorn <tommy-git@thorn.ws>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 02:00:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx9qK-0002tw-E4
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 02:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbYEPX7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 19:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752837AbYEPX7T
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 19:59:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:48819 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752587AbYEPX7R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 19:59:17 -0400
Received: (qmail invoked by alias); 16 May 2008 23:59:13 -0000
Received: from R2eb4.r.pppool.de (EHLO racer.local) [89.54.46.180]
  by mail.gmx.net (mp050) with SMTP; 17 May 2008 01:59:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18LsLhfpCILmDcsFFOf+XeGMlbP2jwAbO/Rp6RMzV
	bwX0dLy22h9qAE
X-X-Sender: gene099@racer
In-Reply-To: <32541b130805160756h5a8fc4d7x313f9bfde4760568@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82320>

Hi,

On Fri, 16 May 2008, Avery Pennarun wrote:

> On 5/16/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hmpf.  I hoped to get more definitive information here.  Especially given
> >  that fgetc() is nothing more than a glorified fread() into a buffer, and
> >  then access the buffer.
> >
> >  Well, at least you kind of pointed me to the _unlocked() function family.
> 
> Point taken.
> 
> /tmp $ for d in test1 test2 test3 test3u; do echo -n "$d: ";
> /usr/bin/time ./$d </dev/zero; done
> test1: 0.09user 0.05system 0:00.14elapsed 94%CPU
> test2: 2.50user 0.05system 0:02.54elapsed 100%CPU
> test3: 2.48user 0.06system 0:02.53elapsed 100%CPU
> test3u: 1.05user 0.05system 0:01.10elapsed 99%CPU
> 
> fread is about 18x faster than fgetc().  getc() is the same speed as
> fgetc().  getc_unlocked() is definitely faster than getc, but still at
> least 7x slower than fread().

Well, my question was more about fgetc() vs fgets().

If you feel like it, you might benchmark this patch:

-- snipsnap --
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 021dc16..5d8defd 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -45,13 +45,32 @@ static int is_from_line(const char *line, int len)
 /* Could be as small as 64, enough to hold a Unix "From " line. */
 static char buf[4096];
 
+/*
+ *  This is an ugly hack to avoid fgetc(), which is slow, as it is locking.
+ *  The argument "in" must be the same for all calls to this function!
+ */
+static int fast_fgetc(FILE *in)
+{
+	static char buf[4096];
+	static int offset = 0, len = 0;
+
+	if (offset >= len) {
+		len = fread(buf, 1, sizeof(buf), in);
+		offset = 0;
+		if (!len && feof(in))
+			return EOF;
+	}
+
+	return buf[offset++];
+}
+
 /* We cannot use fgets() because our lines can contain NULs */
 int read_line_with_nul(char *buf, int size, FILE *in)
 {
 	int len = 0, c;
 
 	for (;;) {
-		c = fgetc(in);
+		c = fast_fgetc(in);
 		buf[len++] = c;
 		if (c == EOF || c == '\n' || len + 1 >= size)
 			break;
