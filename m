From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH 10/12] MINGW: compat/poll/poll.c: undef NOGDI
Date: Mon, 5 May 2014 09:35:47 +0200
Organization: <)><
Message-ID: <20140505073547.GB20599@camelia.ucw.cz>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org> <1398762726-22825-11-git-send-email-marat@slonopotamus.org> <20140430114125.GA23046@camelia.ucw.cz> <20140503070050.GA8580@seldon> <20140504185244.GA17183@camelia.ucw.cz> <20140504205552.GA15590@seldon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Tue May 06 18:12:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whhtm-0005Yp-CM
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838AbaEEHfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 03:35:50 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:60007 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635AbaEEHfu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 03:35:50 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 12B051C01D2;
	Mon,  5 May 2014 09:35:49 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s457ZmMs020752;
	Mon, 5 May 2014 09:35:48 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s457ZlOs020751;
	Mon, 5 May 2014 09:35:47 +0200
Content-Disposition: inline
In-Reply-To: <20140504205552.GA15590@seldon>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248119>

Hello,

On Mon, May 05, 2014 at 12:55:52AM +0400, Marat Radchenko wrote:
> On Sun, May 04, 2014 at 08:52:44PM +0200, Stepan Kasal wrote:
> > is really a work around: it would be in effect only for MinGW-W64,
> > and the comment would explain that this is a hack to work around the
> > bug.  
> 
> Workarounds do not have to be ugly and full of #ifdef's.

I'm afraid they have to.  If you just select one of the reasonable
variants, without noting that the other ones would trigger a bug, you
are lying a trap for future contributors.

> > If you manage to change the defs for poll.c without changing its
> > content, no one could tell you to report to gnulib first.
> 
> v1 does exactly this.

Yes, but it changes the define for other configurations as well
(MSVC, mingw 32bit).  I would suggest something along the change
below.

What do you think?

Stepan

diff --git a/config.mak.uname b/config.mak.uname
index 82b8dff..446dd41 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -508,7 +508,11 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
 	NO_D_INO_IN_DIRENT = YesPlease
-	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
+	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -Icompat -Icompat/win32
+ifneq ($(uname_M),x86_64)
+	# MinGW-W64 < x.y headers do not provide MsgWaitForMultipleObjects with NOGDI
+	COMPAT_CFLAGS += -DNOGDI
+endif
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
diff --git a/git-compat-util.h b/git-compat-util.h
index e6de32c..29a8afd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -92,6 +92,9 @@
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
 #include <windows.h>
+/* We cannot define NOGDI on MinGW-W64, so we unfortunately include
+   wingdi.h.  It then defines ERROR=0, undef it to avoid conflicts */
+#undef ERROR
 #define GIT_WINDOWS_NATIVE
 #endif
 
