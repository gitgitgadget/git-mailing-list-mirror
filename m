From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Tue, 4 Sep 2007 13:46:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709041324420.28586@racer.site>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
 <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com>
 <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com>
 <46DD0C16.70101@eudaptics.com> <Pine.LNX.4.64.0709041145230.28586@racer.site>
 <46DD433A.5040604@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 14:46:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISXnz-0005Fh-5m
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 14:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbXIDMqv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 08:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753293AbXIDMqv
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 08:46:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:52781 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753275AbXIDMqu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 08:46:50 -0400
Received: (qmail invoked by alias); 04 Sep 2007 12:46:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 04 Sep 2007 14:46:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Tw+1A93jTK9OYNk/kvBlHBTtRjNGTMSWtpB7jry
	avjFGI15tzGEGD
X-X-Sender: gene099@racer.site
In-Reply-To: <46DD433A.5040604@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57559>

Hi,

On Tue, 4 Sep 2007, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > On Tue, 4 Sep 2007, Johannes Sixt wrote:
> > > Therefore, I've pushed out a fixup patch at the top of mingw.git's devel
> > > branch that converts mtime to local time
> > 
> > On Linux, we compare to UTC to begin with, right?  We should do that here,
> > too...  So if time(NULL) does not return UTC on MinGW, we have to wrap that
> > function, too.
> 
> According to MSDN, time(NULL) returns "the number of seconds elapsed since
> [epoch] according to the system clock". Please don't ask me what "the system
> clock" is.

I think I know.  From my QEmu adventures I know that DOS/Windows expects 
the system clock to be set to local time, in contrast to _all_ other 
operating systems.

> Reading the implementation of time(), it starts with GetLocalTime(), 
> determines whether daylight saving is in effect, and continues with 
> another round of timezone adjustment - mind you: _not_ a timezone 
> reversal (!!). Doesn't this look extremely bogus?
> 
> It seems we really need a wrapper for time().

I absolutely concur.  Something like this (most of it is blatantly copied 
from Marius' patch)?

-- snip --
diff --git a/git-compat-util.h b/git-compat-util.h
index 172e828..2984319 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -470,6 +470,17 @@ static inline int git_unlink(const char *pathname) 
{
 #include <time.h>
 struct tm *gmtime_r(const time_t *timep, struct tm *result);
 struct tm *localtime_r(const time_t *timep, struct tm *result);
+static inline time_t mingw_time(void *dummy)
+{
+	FILETIME ft;
+	GetSystemTimeAsFileTime(&ft);
+	long long winTime = ((long long)ft.dwHighDateTime << 32) + 
ft.dwLowDateTime;
+	winTime -= 116444736000000000LL; /* Windows to Unix Epoch 
conversion */
+	winTime /= 10000000;		 /* Nano to seconds resolution 
*/
+	return (time_t)winTime;
+
+}
+#define time mingw_time
 #define hstrerror strerror
 
 char *mingw_getcwd(char *pointer, int len);
-- snap --

Ciao,
Dscho
