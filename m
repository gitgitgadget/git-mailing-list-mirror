From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Date handling.
Date: Sun, 24 Apr 2005 16:38:49 +1000
Message-ID: <1114324729.3419.78.camel@localhost.localdomain>
References: <1113466592.12012.192.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0504140153230.7211@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504140212100.7211@ppc970.osdl.org>
	 <1113500316.27227.8.camel@hades.cambridge.redhat.com>
	 <20050424030416.GE16751@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 08:35:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPahm-0005LX-Eg
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 08:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVDXGjq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 02:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVDXGjq
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 02:39:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25325 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261516AbVDXGjn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 02:39:43 -0400
Received: from [203.53.50.91] (helo=[172.18.240.72])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DPamI-0002L5-G8; Sun, 24 Apr 2005 07:39:39 +0100
To: Jan Harkes <jaharkes@cs.cmu.edu>
In-Reply-To: <20050424030416.GE16751@delft.aura.cs.cmu.edu>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-23 at 23:04 -0400, Jan Harkes wrote:
> I noticed that some commit timestamps seemed to be off, looking into it
> a bit more it seems like mktime is influenced by the setting of the
> local TZ environment.

Ewww. I missed that in the documentation. I suppose I should have worked
it out having empirically determined that it ignores the tm_gmtoff
field.

> The question is, do we want to just calculate the time_t offset
> ourselves without using mktime, or force the TZ environment to UTC.

I don't think we want to be in the business of counting leap seconds; we
need to let the system do it. I don't much like setting TZ to UTC though
-- how about we use your test case to find the offset and subtract that?

Does this work?

Index: commit-tree.c
===================================================================
--- 31e9af73983d640090508b06784ef7db4816c957/commit-tree.c  (mode:100644 sha1:c0b07f89286c3f6cceae8122b4c3142c8efaf8e1)
+++ uncommitted/commit-tree.c  (mode:100664)
@@ -138,10 +138,14 @@
 	struct tm tm;
 	char *p;
 	int i, offset;
-	time_t then;
+	time_t then, localofs;
 
 	memset(&tm, 0, sizeof(tm));
 
+	tm.tm_mday = 1;
+	tm.tm_year = 70;
+	localofs = mktime(&tm);
+
 	/* Skip day-name */
 	p = skipfws(date);
 	if (!isdigit(*p)) {
@@ -246,7 +250,9 @@
 	if (*(skipfws(p + 5)))
 		return;
 
-	then = mktime(&tm); /* mktime appears to ignore the GMT offset, stupidly */
+	/* No way to convert to a time_t and honour tm_gmtoff; we have to
+	   do the evil trick by subtracting the local offset */
+	then = mktime(&tm) - localofs;
 	if (then == -1)
 		return;
 


-- 
dwmw2

