From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach approxidate() to understand "never"
Date: Tue, 24 Jul 2007 19:18:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241917130.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 24 20:19:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDOyY-0000gy-Ea
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 20:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbXGXSS4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 14:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbXGXSS4
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 14:18:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:56868 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750847AbXGXSSz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 14:18:55 -0400
Received: (qmail invoked by alias); 24 Jul 2007 18:18:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 24 Jul 2007 20:18:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19OKSB5JkhOsWjtJqqri4m/IiCCj1F5Fjt3zBikvP
	VQPSdVeg5z543D
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53623>


If you want to keep the reflogs around for a really long time, you should be
able to say so:

	$ git config gc.reflogExpire never

Now it works, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Guess how surprised I was when "gc.reflogExpire = never" triggered 
	a pruning of _all_ reflogs!  Happily, this was only in a test 
	environment.

	Another strange thing there is this:  As an alternative, I set
	reflogExpire to "1970", which git interpreted as "now" (just like 
	"never", before this patch).  Another alternative was even worse: 
	"1 Jan 1970".  Because I am at +0100 right now, the debugger said 
	this:

	Breakpoint 1, cmd_reflog_expire (argc=1, argv=0xbfb92968, prefix=0x0)
	    at builtin-reflog.c:307
	307             if (!default_reflog_expire_unreachable)
	(gdb) p show_date(default_reflog_expire, 0, 0)
	$3 = 0x8113560 "Wed Dec 31 23:00:00 1969 +0000"
	(gdb) p default_reflog_expire
	$4 = 4294963696

	IOW, if I had not looked at the timestamp, I would have thunk 
	everything is fine, while "git reflog expire" again would have 
	merrily removed _every_ reflog.

 date.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/date.c b/date.c
index 45b0b1d..59fe4f8 100644
--- a/date.c
+++ b/date.c
@@ -660,6 +660,12 @@ static void date_am(struct tm *tm, int *num)
 	tm->tm_hour = (hour % 12);
 }
 
+static void date_never(struct tm *tm, int *num)
+{
+	tm->tm_year = tm->tm_mon = tm->tm_mday = tm->tm_wday = tm->tm_yday
+		= tm->tm_hour = tm->tm_min = tm->tm_sec = 0;
+}
+
 static const struct special {
 	const char *name;
 	void (*fn)(struct tm *, int *);
@@ -670,6 +676,7 @@ static const struct special {
 	{ "tea", date_tea },
 	{ "PM", date_pm },
 	{ "AM", date_am },
+	{ "never", date_never },
 	{ NULL }
 };
 
-- 
1.5.3.rc2.42.gda8d
