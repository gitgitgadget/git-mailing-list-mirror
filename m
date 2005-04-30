From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sat, 30 Apr 2005 09:02:54 +0100
Message-ID: <1114848175.24014.35.camel@localhost.localdomain>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
	 <42730061.5010106@zytor.com>
	 <Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>
	 <87zmvganq9.fsf@windlord.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 09:59:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRmsz-0006Lv-MK
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 09:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVD3IFD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 04:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVD3IFD
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 04:05:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55469 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262547AbVD3IEo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2005 04:04:44 -0400
Received: from shinybook.infradead.org ([81.187.226.99])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DRmxn-0005zP-Qt; Sat, 30 Apr 2005 09:04:39 +0100
To: Russ Allbery <rra@stanford.edu>
In-Reply-To: <87zmvganq9.fsf@windlord.stanford.edu>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-04-29 at 21:32 -0700, Russ Allbery wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> > It also seems to do so in a particularly stupid way, and David
> > Woodhouses suggestion of just using mktime() on Jan 1st, 1970, seems to
> > be much simpler than what curl does.
> 
> Because of daylight savings time, this doesn't actually work.  I know from
> personal experience; this is the tactic that I took at first when writing
> INN's date parser and was educated by test failures.

Eww. The time functions we have to play with _really_ suck, don't they?
How about this...

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

commit-tree.c: needs update
Index: commit-tree.c
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/commit-tree.c  (mode:100644 sha1:23de13361944ad7ba7c5320cf7cdd04e81842c60)
+++ uncommitted/commit-tree.c  (mode:100644)
@@ -213,10 +213,18 @@
 	if (*(skipfws(p + 5)))
 		return;
 
-	then = mktime(&tm); /* mktime appears to ignore the GMT offset, stupidly */
+	tm.tm_gmtoff = 0;
+	tm.tm_isdst = -1;
+
+	then = mktime(&tm);
 	if (then == -1)
 		return;
 
+	/* mktime always uses localtime, regardless of the tm_gmtoff field.
+	   It does, however, honour 'tm_isdst'; stupidly. Thankfully, it does
+	   at least tell us the offset it decided to use, so we can compensate
+	   for it */
+	then += tm.tm_gmtoff;
 	then -= offset;
 
 	snprintf(result, maxlen, "%lu %5.5s", then, p);

-- 
dwmw2

